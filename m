Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED82201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 17:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754967AbdBVRLx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 12:11:53 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36172 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754948AbdBVRLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 12:11:48 -0500
Received: by mail-pg0-f65.google.com with SMTP id z128so1256080pgb.3
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Z2LCrz9iOvR5P22apqrKUCY3JhLKHEYURLx1XZW9ieM=;
        b=Ii4Y8aLHMaPIMLsXK1/fSXhbjEELEWBdOYPahZ00s3XJX8hKGuo+PNVKAQJWC6Xj56
         Jp5bryTtybyqCmUZiM56jnOQbkxZiWvjQ50ueJmWHsUoUOOg9HhXzcDu2KLBSgwfc/UE
         KoEiZiyzwFQ16ZKQCOTdUoXM7VLqeV86rMVCih8Hbvup9mi7/1dLREzMjUQ9CBDtZGd7
         BJASQvtigTY26xo9ZXPN2C4L6koUhuj9JGIKpFaSFEmDN+VXHteVnoY/WNFcuNRaZphS
         hQlG4m3PvARhp6X1JVpfwlFk7vj1EvICmzu0K8KRhorX2wNVpLwwSxLzLVPcCjzuAotA
         bNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Z2LCrz9iOvR5P22apqrKUCY3JhLKHEYURLx1XZW9ieM=;
        b=PIQc6lh9g+QqLHGLDoesKKI9FCugVoWer2vp8360gdEhHrFZwAWUMuD9MVJoxFHNZc
         azoFgT31jsGmuJ89QnIcd6qxNDIruwbf23/9Yc9+nEsyEAmfnii1mRD7EyqAgw58TbKC
         +/s5VRSUDfkViq00CCxg/218cMohnuHQirlfQnbzyjgOn2MVfxBFbi52XwqHV1mB2c0/
         lT9KLlD/Iu/O1ktEgA5OgEwvpDBuzn/wbo6e/4vAzNBed2VpBqJLaOA5Fy/RHosXqgLM
         oXJkIsfCfpcvcY+VgaO9G0QvYum7b3uCeluHsiHkst2YGOW+Zakk/yY1iOWZlPtAroV9
         07mA==
X-Gm-Message-State: AMke39mfit2B4eBbZO0RMdst4WiUWiCvIkUxaFe3IxEuSTfYgaui9FU0d8nTvcPaXUG9UA==
X-Received: by 10.98.88.133 with SMTP id m127mr41465678pfb.155.1487783497219;
        Wed, 22 Feb 2017 09:11:37 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:21a0:716b:e013:d129])
        by smtp.gmail.com with ESMTPSA id a1sm4800287pgn.51.2017.02.22.09.11.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Feb 2017 09:11:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] fetch-pack: move code to report unmatched refs to a function
References: <xmqqvas4gie9.fsf@gitster.mtv.corp.google.com>
        <b9b52233e84a7f5bd0526f9625e4be06cbbd0ace.1487779910.git.matt@mattmccutchen.net>
Date:   Wed, 22 Feb 2017 09:11:35 -0800
Message-ID: <xmqqpoiacfqw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> We're preparing to reuse this code in transport.c for "git fetch".
>
> While I'm here, internationalize the existing error message.
> ---

Sounds good.  Please just say it is OK for me to forge your sign-off ;-)

> diff --git a/fetch-pack.h b/fetch-pack.h
> index c912e3d..fd4d80e 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -45,4 +45,13 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
>  		       struct sha1_array *shallow,
>  		       char **pack_lockfile);
>  
> +/*
> + * Print an appropriate error message for each sought ref that wasn't
> + * matched.  Return 0 if all sought refs were matched, otherwise 1.
> + *
> + * The type of "sought" should be "const struct ref *const *" but for
> + * http://stackoverflow.com/questions/5055655/double-pointer-const-correctness-warnings-in-c .
> + */

This is an unfinished sentence, but I wonder if we even need to have
it here?  I'd be surprised if this function was unique in the
codebase that takes an array pointer whose type is looser than
necessary because of well-known language rules.

