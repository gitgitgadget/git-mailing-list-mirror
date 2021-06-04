Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DD6C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638CE613AD
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhFDT7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:59:55 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:40541 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhFDT7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 15:59:54 -0400
Received: by mail-qt1-f181.google.com with SMTP id t9so1416160qtw.7
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KDgZTGjztt7aLekoiqfEwja4yID8YnhQuNbZzUjt1lo=;
        b=KrUbNlkbYyqbxbSGYsIb4dVOjLfdjGeAcPZCRCFX8+S54SGHZfecVYhioU7gP4LClY
         3nZ6AbTh12z1EVYqcQNhMsdqmH8Jgp8BMrMPJgg7nWT/paeo9dMBiyoMlCUn75o/qnN9
         nSwsGiYwapE2ud9aA0jirIly6x0bgfhGKZ3/IYgejc/164ShNMv5djYUTZ8qA1io6u9Z
         1elpcpceCwPUFEcMGPI+iLeWNP1H8NFqLGSN/lqitFlF5Z0bod+BIO9vQENek6BLQzo3
         zGiHQbh67cURsdvtMvP2gZWvLKq+Q+Gh++BPpn3qZloWv8c2x/GUKB4yrI9DHyAblbGw
         cEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KDgZTGjztt7aLekoiqfEwja4yID8YnhQuNbZzUjt1lo=;
        b=s3mBnSQxmVb12sc2x37UR2eI66Xw+BKDQIKSN2sp53g9hAaMdi741WPofzxqBQCEvX
         zopNs/LX15x2QCrUaVO8oMDNBLSqBHZohfmow9lFltO2V6Bao/R1S5TAhjVIJiL7mlAf
         g0Oj15MrWrgwAt6ZHFH6K4sZ9ISvAYtlldeJ+aN6HhxrpAUc2K+2G+HXc61cNxmaxYdZ
         4AiuY5QdraT3qihwCozk1QnoQdEeI40+gSCJB6/f92IcTTfrU3pkMK4lGCWjg8mNHlIx
         KuFvdSer+Pol7JcaIGSu9RPqLlD4EhsUJN6x4DBSQqDPjpuiDC1sRxVX4IaBV7nV+LsW
         EcZQ==
X-Gm-Message-State: AOAM5302hw78lj3JyqQ7fv8KqtG2phFTX5REsSGDRRer62BMMX4P9t4K
        4C8Y5wrMLRlV91eHmtGe31lGww==
X-Google-Smtp-Source: ABdhPJzEm8XeJ2DJXS3ihMafJZFJnsj1ro6xsF0bkwyyVyuR00ML3tXHr/6eHFRrr6EmT+0sBDwiGw==
X-Received: by 2002:ac8:678d:: with SMTP id b13mr6117164qtp.104.1622836611641;
        Fri, 04 Jun 2021 12:56:51 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e28c:b821:dd88:1fd1])
        by smtp.gmail.com with ESMTPSA id d1sm4291584qti.72.2021.06.04.12.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:56:51 -0700 (PDT)
Date:   Fri, 4 Jun 2021 15:56:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] promisor-remote: read partialClone config here
Message-ID: <YLqFgjEV8JoLzZSL@nand.local>
References: <cover.1622580781.git.jonathantanmy@google.com>
 <4a7ad9ffeb140c8b613c308280c2c234154ae2ab.1622580781.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4a7ad9ffeb140c8b613c308280c2c234154ae2ab.1622580781.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 01, 2021 at 02:34:16PM -0700, Jonathan Tan wrote:
> @@ -99,6 +94,11 @@ static int promisor_remote_config(const char *var, const char *value, void *data
>  	size_t namelen;
>  	const char *subkey;
>
> +	if (!strcmp(var, "extensions.partialclone")) {
> +		repository_format_partial_clone = xstrdup(value);

Can value ever be NULL here? I think the answer is "no, because we check
earlier in setup.c:handle_extension_v0()", but there is an implicit
conversion from xstrdup_or_null() to just xstrdup(), which would fault
if value were to be NULL.

Looking deeper, this path is a little confusing to me, since (in the
pre-image), handle_extension_v0() makes a copy of value and binds it to
data->partial_clone. But then check_repository_format_gently() makes
another copy of canidate->partial_clone (which is the same location as
data->partial_clone).

So, the extra copy is a little strange to me, because even though the
copy in handle_extension_v0() is definitely necessary, I'm not certain
that the one in set_repository_format_partial_clone() is. And this patch
removes the latter one, which I think is good. But we never free
repository_format_partial_clone.

Maybe that is added in a later patch, let's see...

Thanks,
Taylor
