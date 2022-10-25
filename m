Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575F6ECDFA1
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 23:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiJYXwJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 19:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJYXwH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 19:52:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57298C1D93
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:52:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v1so23676871wrt.11
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6C99n+ckzinnhCDunTrzhpe6/ECtPHoyYcOvZ+Nf/0=;
        b=YeK+SqH2zcqFylE/TIrCVsHleRtOAn6i5ThFq5vggehFeCoTwsmQY5PPwAvxPEqRiE
         iNk7l/VsaZNqo9+V3woBSaAFs4it5Tdi20dY2+TPhaYDHLYposV+IqKAOzXovmb1y8Vw
         SSfWjSgCtJRXvjxmZofN/CWT4W64twNbznvdPD1ikSOghblo0ZAxNKrgE/eZ2MTwpHVH
         3cOEQEVAaP9mgXHHV+6oyWwBo0eYJK/+HPYLoTiNpuTMlopSCi02I2CvsFjhowLsIlQU
         /EvAqCeUcqgfQRu8CFkvXOS17xxZb1/klxc3RC2mWbLkJZCVIADcRPeMkQtzx1wfBJws
         hqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6C99n+ckzinnhCDunTrzhpe6/ECtPHoyYcOvZ+Nf/0=;
        b=IXJZ0/AEzXd15v7iBxc4FLXeRSevTtXEZzKywg07TsbVBNB0vVSU/VcIYtmaMlC7xS
         aSvGraQVG6JLGH9iA4eKNQm1z1KRlNS5g7j9sBKLJs0RkfDX39KVUDCI0Q4VRn0UJ1hw
         Yecmrw2TLwjHJKRmMYF0gRihYsNuR8tkm9awII6hUHWAZ8FV6/JhDJAVAUCMOkz1/ya+
         X5oimP2aq+d1lyDagEW0ADK5K84G4hXZ3YDzBCzqo7pE0xWqH8o52eSE55jC+ggFog2L
         DrbKGLdOB/b61EfhogMvOSBdqgwe+HhML+UPW7qSO/IUONY8LMfA8GLz6lFa/nbrm0qC
         +EHA==
X-Gm-Message-State: ACrzQf2TpXBY625SRTaNeFsa7Z9g/ME4WLcm6ba+2e+f/rxLs9yaltFR
        EONsGKtg0qq9otZU/P4UkvwKPzy/rIY=
X-Google-Smtp-Source: AMsMyM7ZUY2UubsIo8VeEXogyvGHotCemYTfQBw6IO9R3Gxg5KjJNNLuK/2TBUm25oQEb8NRw3nnKA==
X-Received: by 2002:a5d:4441:0:b0:236:6c3e:efb4 with SMTP id x1-20020a5d4441000000b002366c3eefb4mr10351280wrr.539.1666741924307;
        Tue, 25 Oct 2022 16:52:04 -0700 (PDT)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c210400b003c409244bb0sm344966wml.6.2022.10.25.16.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 16:52:03 -0700 (PDT)
Subject: Re: [PATCH] branch: error and informative messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
 <xmqq5ygaul5k.fsf@gitster.g> <faf7a985-f6ef-f20a-3857-031396124d60@gmail.com>
 <xmqqzgdjn1ne.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <9ceaa13d-5ab3-a36f-b03d-003dbaf3f112@gmail.com>
Date:   Wed, 26 Oct 2022 01:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzgdjn1ne.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/22 21:28, Junio C Hamano wrote:

>>>>  - "%s" and "'%s'" was used to format a branch name in different
>>>>    messages.  "'%s'" has been used to normalize as it's the more
>>>>    frequently used in this file and very common in the rest of the
>>>>    codebase.  The opposite has been done for options: "-a" used vs
>>>>    "'-a'".
>> ...
>> Same reasoning as above.  It is a system-chosen term, but the message
>> has not a placeholder to put a value, we're using a literal.
> 
> I doubt that "same reasoning" is sensible. I'll welcome input from
> others, but 
> 
>     $ git grep '"[^"'\'']*'\''--[a-z]' \*.c
> 
> looked very reasonable, and after imagining the output with them
> losing the single quote around the option name, I would think they
> are better with the quotes around them.

The reasoning I do is:
- an option is a literal, cannot change in the message, with unexpected chars
  for example
- this makes it is well delimited.
- the dashes clearly differentiate from a simple word
- we do not use quotes for options other in places, like the documentation

But looks like we have a mix:

$ git grep '\(die\|error\|warning\).*"[^"'\'']*--[a-z]' \*.c | head -12

apply.c:                return error(_("options '%s' and '%s' cannot be used together"), "--reject", "--3way");
apply.c:                return error(_("'%s' outside a repository"), "--index");
apply.c:                        return error(_("'%s' outside a repository"), "--cached");
apply.c:                        error(_("No valid patches in input (allow with \"--allow-empty\")"));
archive.c:              die(_("Unexpected option --remote"));
archive.c:              die(_("the option '%s' requires '%s'"), "--exec", "--remote");
archive.c:              die(_("Unexpected option --output"));
archive.c:              die(_("options '%s' and '%s' cannot be used together"), "--add-file", "--remote");
blame.c:                die(_("--contents and --reverse do not blend well."));
blame.c:                die(_("cannot use --contents with final commit object name"));
blame.c:                        die(_("--reverse and --first-parent together require specified latest commit"));
blame.c:                        die(_("--reverse --first-parent together require range along first-parent chain"));

I prefer the unquoted form, because of the previous reasons.  But I don't
have a strong opinion on that, beyond using the same criteria in the
file :-). 

>>>> Finally, let's change the return code on error for --edit-description,
>>>> from -1 to 1.
>>>
>>> OK.  That last one may be better to be a separate patch, as these
>>> wording changes are subject to discussion and bikeshedding.
>>
>> Mmm, I thought about that.  This change is one that we've been delaying because
>> it might break something due to a change in the way we report errors.  We're
>> specifically changing this here and the change is small, so I found appropriate
>> to do it here.
> 
> Not really.  Nobody reads error messages, but programs can react to
> exit codes.  It is more important to get the latter right.

OK. I just sent a patch for this.

>>> This does not fall into any of the categories the proposed log
>>> message discussed.  Rather, it looks more like "the code
>>> subjectively looks better this way".  It happens to much my
>>> subjective taste, but that does not change the fact that we
>>> shouldn't distract reviewers with such an unrelated change in the
>>> same patch.
>>  
>> It certainly looks subjectively better, and in less lines...
> 
> As I said, it does not matter.  It is outside the scope of "improve
> error messages" and should be done outside the series, or at lesat
> as a separate step in the series.

OK. I will separate this in a preparatory step.

>>> And that should be a separate patch, that can be reviewed and
>>> applied regardless of the rest of "error messages cleanup" topic.
>>
>> Good point.  I didn't think about that and it also goes in the line of
>> the previous patches in this file.  I'll review that.  Also gives a good
>> opportunity to fix that repeated code /... if (copy) ... else if
>> (rename)/.
> 
> OK.  But again, that is outside the topic of "improve error
> messages".

OK. I just sent a patch for this.


I'll wait a few days before sending a new version, to give others time
to comment.

Thanks.
