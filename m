Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38200C43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 15:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF771208C7
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsxa1Ybo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgISPKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 11:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgISPKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 11:10:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC1C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 08:10:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z4so8440220wrr.4
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f1vM+uO1jAlO9pIswgC7gmzNhpZtnaE2i9MNQzjEbpI=;
        b=Fsxa1YboXSsZTINmeH4Uv8l/PlRS9RnUnLBrtdNPJgcW47/1R4wKwRAOw8cKlOwt8p
         UmRKokTxiyaq+ntKEGQLJpw5nX9NDgiiffESeCZfBKoBs0ijzVoLOOJuJkvD7BKSCDdk
         shuwCbwNmUr/kWCPRnZoZqwosv1Yb1qz9e3aY+9WF5sEef8sIUCGMykqFfAm6esaZVAf
         UXIAO87PgUMWHgNNgjOToZeB2WYyqJ4gkivRbJsSCD+8J/we0eREeOj/tlg/ecNGvExG
         b8p1ZZqLR/TIc3rkuJcaX4eTmVKEnWWewP0oWT+BpEdyCnkeWuhsGV9G7EbWP00Lk4DD
         MEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=f1vM+uO1jAlO9pIswgC7gmzNhpZtnaE2i9MNQzjEbpI=;
        b=mH4+GFrt0DRgEEOLVr1YyySRHlTwpD7X1ZloFsjFEngGxKn7uWcSiKxXXGwkZn71fQ
         FHBiM3QiOi6kZHbUHstjg12mTLaolwZQaNYWy3793BdIjYgIUXl8IdZW6az4MXMKkWgl
         TbBTtFyG9Or2cKbXky73qMJD8Qz84w3S9rL4U5rYvG1RDZ4J25XuyeZGp7FoCvMd35vb
         njaSafS4UD+Pr5RsQTGEtVCxEj2+y2FcHEOJ2enhtirHuFsQr4UTpiyWZAtocvnrXclt
         gtakMmhbRYrfGEaJJZPr5rTySjFYJT4InMp/e8k65EFBiTpXUe3qngcvXFObFC8cKxD7
         L2LQ==
X-Gm-Message-State: AOAM530603EcJy8xyHPommdkhqcCoD/f06aFKQN9ENcHlbgBsmGcz7JS
        Ur7gUxBV0SArVj4kGigcQoY=
X-Google-Smtp-Source: ABdhPJximdo0ZTC7V3NAAp+OV9G0XBSrMwFQQ5LcIfsmidAHZOxUcXwBWV0g7wQ17KMVb74xG5wKKQ==
X-Received: by 2002:adf:d845:: with SMTP id k5mr40437151wrl.285.1600528214935;
        Sat, 19 Sep 2020 08:10:14 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id h17sm12226093wro.27.2020.09.19.08.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 08:10:13 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <20200831180537.GC331156@google.com>
 <20200901125119.GA3250129@coredump.intra.peff.net>
 <20200903054126.GA2053272@coredump.intra.peff.net>
 <20200915173529.GA2859918@coredump.intra.peff.net>
 <CAP8UFD3NxmBDDr4yqhOjmdUNVZYe6w4vW-TnqbkUO_zuFvKvpw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c1fb4d61-2a7a-8c8e-f2e3-d0b4ca75ff82@gmail.com>
Date:   Sat, 19 Sep 2020 16:10:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3NxmBDDr4yqhOjmdUNVZYe6w4vW-TnqbkUO_zuFvKvpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/09/2020 09:12, Christian Couder wrote:
> On Tue, Sep 15, 2020 at 7:35 PM Jeff King <peff@peff.net> wrote:
>>
>> On Thu, Sep 03, 2020 at 01:41:26AM -0400, Jeff King wrote:
>>
>>> I'm still working out funding details, but in the meantime we're signed
>>> up. Potential mentors should propose projects here:
>>>
>>>    https://www.outreachy.org/communities/cfp/git/
>>>
>>> Sooner is better than later. We can technically submit projects up until
>>> the 24th, but student applications are open now, and have to be in by
>>> September 20th.
>>
>> [Adding everybody to the cc list who has been in the Outreachy
>> thread this year...]
>>
>> AFAICT we still have no proposed projects nor signed-up mentors.
> 
> It seems that we now have only the 2 projects I proposed and only 1
> signed-up mentor (me).

I've been accepted as a co-mentor on the rebase project now.

Best Wishes

Phillip

> It looks like Jonathan and Emily are reaching out to the Wireshark
> community to find a co-mentor which is great! So we might have another
> project and the associated mentors soon.
> 
> Outreachy organizers have extended the mentor project submission
> deadline though. The new deadline is Sept. 29, 2020 at 4pm UTC. They
> also say that this deadline is a hard deadline, as the contribution
> period opens October 1, and they cannot add new projects after that
> date.
> 
>> Interns are actively applying _now_, so we are likely missing out on (or
>> have already missed out on) applicants.
>>
>> If you're interested in mentoring, the time to propose is definitely
>> ASAP.
> 
> Sure. By the way if you are interested in mentoring or co-mentoring,
> then signing-up is not definitive, you can always decide not to mentor
> at all later for any reason as long as an intern has not been selected
> yet. (Intern selection deadline is Nov. 9, 2020.)
> 
