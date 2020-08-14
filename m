Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB4C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0DD2078B
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 02:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fA1L1Hrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHNCVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNCVx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 22:21:53 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5438C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:21:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so5994221qth.5
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 19:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BDmRjM60fWhWtNFNbaz9Wz/iBrFLbZ6azYsBb4tpTjA=;
        b=fA1L1Hrm7RAe/ZO3f89iC0Jc2INyg3m9YsJsvn2UeY3Enjcr9UFXjEpZRwrHgdaRYU
         oEWx1KbgGJRXC7wgQMUh5bOQjwqRxfSci3qBVR1OCxpKTefMVnTJjd852wwpLhXkx9In
         /spsQfXovhbyNhy3NzR8c6Rk+cZfNqbd1TzpndJJZ+95LaiV0Bg5I1ku2laJhHeTYsZN
         tP1BzHF15DdxC9wl+1bgiHa2CV0JMPI3GD5lLnzcICmoJgNo8h/jrOhk+8mfMrIfMmZJ
         skwY6bHCrAEsDDZiJHzVczTgKyM9BCFdfvvD2xTWHLHp2+DU5Yfjf8AmPGPhxlcFtohU
         gwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDmRjM60fWhWtNFNbaz9Wz/iBrFLbZ6azYsBb4tpTjA=;
        b=V9efPD/SMn1TF8h8wK7EY7yx1GlcUKVJFk21wkkq8yD3GZ0/VBztieyxk1E1Url5Ff
         ifD6EyffwRNydW7jFHdONC3vbcRQ915PvkbbssVHmwyLfK4HJc1Gz5Elw1kytHW8nWK8
         LH2cTqCJNTRVt6bEI1bNGh1WW6sprSslsHHSSqiJ+x4hpWjyhpp1NUS3lAZEWAEfn8C6
         tc5qwdi3P+75IDI7M2RyFSETiTyca0JoyCvkqS3T1YAn8iLdoAPk+9PPFZ3NHFSl0eOL
         eMHLdwBFucLZb9CgEduOo0c2GCnY46algidFXWQhbKBg+OJHRm85AuZnznwlK3QcS4QX
         SE5g==
X-Gm-Message-State: AOAM531eJZoIIqLRQMC5m/QlvZofC0uALOJ1oSIrhAWlwF7MfVkYURLh
        KYYueAEZfxjviD3pvYS7fnRCHBB7k2s=
X-Google-Smtp-Source: ABdhPJzSdoyfcTNHtYftDRXWH2k7RHWUPaAK6CAJE0MAGSEsHI/Ch3G36D69ydaAjw8t1PlZphucRw==
X-Received: by 2002:ac8:480c:: with SMTP id g12mr203799qtq.257.1597371712848;
        Thu, 13 Aug 2020 19:21:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7dfc:cd76:faf5:aaad? ([2600:1700:e72:80a0:7dfc:cd76:faf5:aaad])
        by smtp.gmail.com with ESMTPSA id x50sm9292877qtb.10.2020.08.13.19.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 19:21:52 -0700 (PDT)
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
Date:   Thu, 13 Aug 2020 22:21:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2020 9:07 PM, Junio C Hamano wrote:
> There are still a handful mentions of SHA-1 when we meant the
> (hexadecimal) object names in end-user facing messages.  Rewrite
> them.
> 
> I was hoping that this can mostly be s/SHA-1/object name/, but
> a few messages needed rephrasing to keep the result readable.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/blame.c          | 2 +-
>  builtin/name-rev.c       | 2 +-
>  builtin/pack-objects.c   | 2 +-
>  parse-options.h          | 2 +-
>  t/t0040-parse-options.sh | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 94ef57c1cc..76ffdf11c6 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -842,7 +842,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	const char *contents_from = NULL;
>  	const struct option options[] = {


> N_("Show blank SHA-1 for boundary commits (Default: off)")),
> N_("Blank object names of boundary commits (Default: off)")),

Is there a reason you dropped "show" here? Perhaps your
intention is to use "blank" as a verb, but it read a bit
awkwardly to me.

> N_("print only names (no SHA-1)")),
> N_("print only ref-based names (no object names)")),

> die("not an SHA-1 '%s'", line + 10);
> die("not an object name '%s'", line + 10);

> N_("use <n> digits to display SHA-1s"),	\
> N_("use <n> digits to display object names"),	\

> use <n> digits to display SHA-1s
> use <n> digits to display object names

These all seem obviously correct.

Thanks,
-Stolee

