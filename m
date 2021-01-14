Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335AEC4332B
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044CC23A51
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 10:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbhANKkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 05:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbhANKke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 05:40:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC02C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:39:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i63so4092134wma.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 02:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a1dji1C/miYFNGYVt9FZps3yRiMyUltegdWFVLg4RbI=;
        b=dg5o+Y9xHK/Qurf0tWWqTno/ohroB27z+HMWVJ8RmFFoLDXXg0srMxeGtHPmQm+Sr4
         DBcVqfX86AWbpZ8E5dYP81BuW1Bghl3Qd9KNqGrSssFsimaZlpPcv19YcPHlpPYQ3rH8
         k9Vt4YuW26CnS1B9Jo4xKZ+hz6ivKsLwZjvckGlcKG55xGIfbwEu2oOLK3TZbh0IWQpc
         4zl1vxo3Hx7sMQOUgqwRVk50PK9Z07F70wgC8sga4FD7XbprJ3KLFlObPJxnre4OgbtA
         kEeJAojlASiPR5NeuI6NyDYvh0CF0z2Jz9Yhr776IazY9C8AweA9FWYSaS2S3A2OiYy2
         zkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a1dji1C/miYFNGYVt9FZps3yRiMyUltegdWFVLg4RbI=;
        b=eI9B1DYqdinq2c87Mq2/T2gV8n/Fr5KlapSIll9SfVSHkP2d0H5kplPFkLbXlxwGok
         LVeXyCH6tbxdnZkKQw7mZqtpnC9q3HNv0TNnjQRtog6cyCwuCcYFAN1F2ugJy6cn/lvS
         XWaW5IHgbUFLlUD0tTSWecqQoAFBMQtCZ8fzIjo1ULmfc53wfVZE60Suuqs01GGGl2CZ
         Fbuk3/qJ8ujkeUzTGN4YMGd9RD/hdIFya4MbM6VsLTl7+KBvSaly1dI9rDpVwFPA0tmW
         AfCiPFeTg3jPqLIUXuaQieHdfw9NwRP6JF3UEf16RUXvc/5BaF/r7brwBS5BhKKgvvRt
         yCXQ==
X-Gm-Message-State: AOAM530NhvMfNK50gYi4/7X5RP7bcbtxjaWIDTldJm7gjwb30NoukKkA
        /ukrXPnujzJ9b2rztIQyWKGk1NhSvSo=
X-Google-Smtp-Source: ABdhPJwiFwOvVwJGu6Hl9x2VWrD8xjfgCfbnhV10YSdbm0b1Mi0WKoz4v0nGQ+f6ahlv/II4oOJVSQ==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr3260785wmj.19.1610620792417;
        Thu, 14 Jan 2021 02:39:52 -0800 (PST)
Received: from [192.168.1.201] (112.16.7.51.dyn.plus.net. [51.7.16.112])
        by smtp.googlemail.com with ESMTPSA id 94sm9993560wrq.22.2021.01.14.02.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 02:39:51 -0800 (PST)
Subject: Re: How to implement the "amend!" commit ?
To:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
Date:   Thu, 14 Jan 2021 10:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've taken the liberty of adding some comments about the backwards 
compatibility of each option

On 13/01/2021 01:15, Charvi Mendiratta wrote:
> Hi Everyone,
> 
> Implementing "amend!" commit would be an alternative to the
> fixup!/squash! commit that addresses the issue as opened here[1]. Also
> the related patches[2], adds the options to `fixup` command in
> interactive rebase and supports the "amend!" commit upon
> `--autosquash`. Next, after discussing with Phillip and Christian,
> there could be 3 possibilities to implement the "amend!" commit (UI):
> 
> Firstly, the `--fixup=<commit>` to have option like,
> `--fixup=reword/amend:<commit>`
> 
> So, `git commit --fixup` can have 3 options:
> 
> a) `--fixup=<commit>`, work as of now, make fixup! commit.
> b) `--fixup=amend:<commit>`, make "amend!" commit, takes changes and
> also opens the editor for a new message (Here it adds a new message to
> amend! commit's message body and upon autosquash it will fixup up the
> content and reword the original commit message i.e replaces the
> original commit message with the "amend!" commit's message).
> c) `--fixup=reword:<commit>`, makes (empty) "amend!" commit, do not
> take changes and open the editor for a new message(Here, upon
> autosquash it will just reword the original commit message).

This is the only option that is backwards compatible. `--fixup=:/<text> 
` still works and can be used with the new syntax as 
`--fixup=amend::/<text>`. Note that we intend to allow accept any prefix 
of "amend" and "reword" so --fixup=a:<commit> would work.

> Secondly,
> As an alternative to above, we can use `--fixup=<commit> --amend` and
> `--fixup=<commit> --reword`.

This is not backwards compatible. At the moment If you create a fixup 
with `git commit --fixup=aaa` and then realize it should refer to commit 
bbb instead you can fix it with `git commit --amend --fixup=bbb`. That 
would no longer be possible. (You could still do `git commit --amend 
-m'fixup! bbb'` which works with `git rebase --autosquash` but is not 
very helpful when running `git log` or `git commit --amend -m"$(git log 
-1 --format=%s bbb)" which is a pain to type.)

> Next,
> To use only, `--fixup=<commit> --edit` to make the "amend!" commit.

This is not backwards compatible. At the moment this combination of 
options allows the user to add some comments to the fixup commit 
message. To do that in the future they'd have to change the subject line 
when editing the message.

Best Wishes

Phillip

> Also as discussed earlier[3] we are avoiding the use of additional
> options like `git commit --amend=<commit>` inorder to avoid confusion
> of doing similar things in different ways. So, I wonder which could be
> the best way to proceed with or if any other way to implement "amend!"
> commit ?
> 
> Thanks and Regards,
> Charvi
> 
> [1] https://github.com/gitgitgadget/git/issues/259
> [2] https://lore.kernel.org/git/20210108092345.2178-1-charvi077@gmail.com/
> [3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
> 

