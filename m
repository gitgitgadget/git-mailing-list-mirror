Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0BE1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033695AbeCASA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:00:56 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33933 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033223AbeCASAy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:00:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so32185464wmd.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AqGo+5UEaHE0v2EtPPLtzM7tUK3RQ4JSyMWNNi5jb6I=;
        b=cv61uzQSFS5iRTbbCvV+3MJ0v9MpFrCuAV8fSTaNFYb0NsCM/ey1/UJQyF4x6nAq0e
         7T7aADvLYtChh2xFOz6yPCSxGveeN24QPdv/+LPRVzdMVo4uP1PayRstW0GYoW3ZrI/N
         rXjnAWqWjY9jvrRL3wtThtm5hcVWuMI0my/flVSCFtijragSJ1ms09cKryniV9IXzHtG
         AnYU5uEliYkqhm0yK3C/YOGm2Of1KSVKmM8cN6tmnvQr85RRF+bslYgJF+qfGzZ30Ypq
         7RJocUjasksQ0nhYeUQRYtqEK6pHXT3ZtMCph0aTpIlbYwsGDVP7DszcpVpyEhc26FYv
         K6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AqGo+5UEaHE0v2EtPPLtzM7tUK3RQ4JSyMWNNi5jb6I=;
        b=oMO4KrW4QzzpjidL3UmLjhcd4+Ycw/8acOxWsypQbhXsd/4RwEZJ5tlkZ0B3N4HqtD
         2nvnbQqjEl6AqbxG4jTNf5qF+KppI3hetQwrQ4A1083x/9J2Z2Ufm704oMoDOq+6vRGm
         jT9dT+W4/8Nf0RB7nw4zwF/7fgYR9BPWjRTvIO5yMROpdTt4LHxY2n5diKjcKpQZWFfC
         MI0TVFl1+f3Fs43LyC7OubTOFoE5uUZ+IiL2eiwvCuYgZvKe92R5wflBYIr2fl2Y5Nyo
         UP/ZtrP5Qbu3eX5bSytEyxjdnEnmytrbRbkrU84ca7Gx7T7yyGIdsNoHrUcG9CKe+cwJ
         U5mQ==
X-Gm-Message-State: AElRT7FQuLi9eZPVX6xBOdTisaDT+UQDzVBCELUJBvbtQN7p5dcMYSY5
        1RTwZVjeYXMGsQ7fJjb2ll8=
X-Google-Smtp-Source: AG47ELtD1NCZL+AZ/2vlDIRRgGYfr3ayqWWCC8JiHHKTZc1puKKN/Ouqtn+SWvseRJCa9sxtzaSv3g==
X-Received: by 10.28.111.145 with SMTP id c17mr2298115wmi.74.1519927252972;
        Thu, 01 Mar 2018 10:00:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l38sm8191136wrc.96.2018.03.01.10.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:00:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 04/11] pack-objects: use bitfield for object_entry::depth
References: <20180228092722.GA25627@ash>
        <20180301091052.32267-1-pclouds@gmail.com>
        <20180301091052.32267-5-pclouds@gmail.com>
Date:   Thu, 01 Mar 2018 10:00:52 -0800
In-Reply-To: <20180301091052.32267-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 1 Mar 2018 16:10:45 +0700")
Message-ID: <xmqq4llziskr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This does not give us any saving due to padding. But we will be able
> to save once we cut 4 bytes out of this struct in a subsequent patch.
>
> Because of struct packing from now on we can only handle max depth
> 4095 (or even lower when new booleans are added in this struct). This
> should be ok since long delta chain will cause significant slow down
> anyway.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

This should be marked as RFC/PATCH; I do not have objection to
limiting the delta depth to some reasonable length (rather than the
current 1<<31 or worse 1<<63), and 4k may be such a reasonable limit
(I'd actually think anything more than a few hundreds is probably a
bad idea), but it needs to be documented.

>  builtin/pack-objects.c | 4 ++++
>  pack-objects.h         | 6 ++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a4dbb40824..cfd97da7db 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3068,6 +3068,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (pack_to_stdout != !base_name || argc)
>  		usage_with_options(pack_usage, pack_objects_options);
>  
> +	if (depth > (1 << OE_DEPTH_BITS))
> +		die(_("delta chain depth %d is greater than maximum limit %d"),
> +		    depth, (1 << OE_DEPTH_BITS));
> +
>  	argv_array_push(&rp, "pack-objects");
>  	if (thin) {
>  		use_internal_rev_list = 1;
> diff --git a/pack-objects.h b/pack-objects.h
> index fca334ab4d..3941e6c9a6 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -2,6 +2,7 @@
>  #define PACK_OBJECTS_H
>  
>  #define OE_DFS_STATE_BITS 2
> +#define OE_DEPTH_BITS 12
>  
>  /*
>   * State flags for depth-first search used for analyzing delta cycles.
> @@ -43,10 +44,7 @@ struct object_entry {
>  	unsigned tagged:1; /* near the very tip of refs */
>  	unsigned filled:1; /* assigned write-order */
>  	unsigned dfs_state:OE_DFS_STATE_BITS;
> -
> -	/* XXX 20 bits hole, try to pack */
> -
> -	int depth;
> +	unsigned depth:OE_DEPTH_BITS;
>  
>  	/* size: 120, padding: 4 */
>  };
