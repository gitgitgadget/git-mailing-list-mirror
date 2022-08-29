Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBD7ECAAD5
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH2MOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiH2MNX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:13:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F73C07
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 04:57:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j14so453199lfu.4
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+OOzg984B7mM4+XAnfjDTrXVWE7UU5jLjuSdC//DojU=;
        b=hveYIJRbWx8/H/i0GWDCS1WPsywwkbjB35TEg3WPyf8/WoPdnH3mDdyvCLMabQ3McT
         QpoE5n9T3ly5Ok7NIIHRG/+B2BpyWoOm9z7gHJDKCG1Gxoj99HYHSClFMH89keSCX2Ih
         ITmUi8fx0XAhhkqRY5IDHiTSoI5S5aLr8a5vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+OOzg984B7mM4+XAnfjDTrXVWE7UU5jLjuSdC//DojU=;
        b=svBUGb+BzS+C671i893RwlVkktvh5pRHGk63SZQvFnfgo3anNvwSu/6XOsUwZ5MUuj
         Qu1QoNyqknzIIBj0tqQI1bm278Lv4ufcitMZaylLfDuEMun7s87qsFRtekCxaUpVDY1H
         HOPtDAf2Gjv/AaF7ZYkyYcDUbqtMlO5OIWr1PwyDbHfLUMUv9LVEaF6toickugePvsN+
         OXjHx0rEcY0Es7srVaOKQm+cNzH+wxDSB5YDyBirTZVKaQcwzUd4A4XxGOPr+dbutbc+
         uT2Lx/YxJF3JMBtvBqHrh1OtqC0LacmGQSi04mfuDrbCdWRCLY7KmO8wfMz8XzYQuZfT
         M0rg==
X-Gm-Message-State: ACgBeo3k0BuQlDjhy4S7fxO7eyXlPh2+nPaPdPTTBoFQM+LeBr51LJ0V
        F+cVTTRZbqJGrFpujCY1LWnFzrbdu2r6QUy8
X-Google-Smtp-Source: AA6agR4T3ycpzGDGWjb+varidgSXjSKwkb3A8OLsvASsy8X0nyhJyo9mCdbLfwxfk5kPsszsD5kuDw==
X-Received: by 2002:ac2:5fad:0:b0:493:2ce:6938 with SMTP id s13-20020ac25fad000000b0049302ce6938mr5923074lfe.541.1661774221478;
        Mon, 29 Aug 2022 04:57:01 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512370e00b0048960b581e3sm279152lfr.8.2022.08.29.04.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 04:57:00 -0700 (PDT)
Message-ID: <f07a2387-dbbc-fd13-9817-069767c75165@rasmusvillemoes.dk>
Date:   Mon, 29 Aug 2022 13:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: forcing an in-body From header
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
 <20220826164828.cxsveqtjiyimdj7s@meerkat.local> <xmqqo7w6yl8y.fsf@gitster.g>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
In-Reply-To: <xmqqo7w6yl8y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/08/2022 19.20, Junio C Hamano wrote:
> Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
> 
>> I agree that it's a nice feature to have, though I would put this into the
>> sendemail config instead of using an env variable, something like:
>>
>>     [sendemail]
>>       in-body-headers = From
> 
> A change only for send-email does sound quite attractive.
> 
> I encourage folks to run format-patch first, make amends as needed
> in the output files, proofread the result once again, all before
> finally handing it to send-email for sending out. 

That's at least my usual workflow, yes.

 If a "force
> in-body headers" command line option plus a configuration variable
> added to "git send-email" would work for them, I would be OK with
> such a change.

It would work for me, except that if I am to rely on git send-email to
munge the body of the file(s) I pass to it, I'd really like a way for
--dry-run to reassure me that that will actually happen. Currently that
only prints the headers, which is quite useful to check that the To and
Cc are as expected (especially when one has some to-cmd or cc-cmd
configured).

> There may be folks who do not use "git send-email" to send out their
> patches, and a change to "git format-patch" may help them, though.

Maybe, yes. I also stumbled on this paragraph in git format-patch --help
which would probably need some adjustment

           Note that this option is only useful if you are actually
sending the
           emails and want to identify yourself as the sender, but
retain the
           original author (and git am will correctly pick up the in-body
           header). Note also that git send-email already handles this
           transformation for you, and this option should not be used if
you are
           feeding the result to git send-email.

I don't know how git send-email behaves if there already is an in-body
From, or if it is different than the one that send-email was about to
add itself.

Somehow I got the cover letter of the mini-series, but neither of the
two actual patches. I can't answer the big-picture question of whether
this belongs in format-patch, send-email or both, but:

> * Should it be "inbody" or "in-body"?

in-body, I think.

> * Should it have a corresponding configuration variable?

Most definitely yes, it's something I'd want to set for certain projects
in the local .git/config file, and not a command line option I want to
have to remember when doing the occasional contribution for those projects.

Thanks for the quick responses and initial draft work on this.

Rasmus
