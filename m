Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EB4C433FE
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiBVLOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBVLOb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:14:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F341B45A0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:14:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u1so32438217wrg.11
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bKIogpHs3E5vOpWuzAK/3JCW0eJBzJG0yWPEmOj0gDg=;
        b=e1cJK7+yeWENycoDep3k20e7A2hch33ocZjyynXlJcjFgtSo/kEUezZ36X3SDRhr1B
         xa2bKD5jNvv+rNWTOPYZzqv/vFJYrRAF/WlmarMbKh0R2THRnmT1IPKA2NtARaKRYhhy
         sWb/UPA+8tFOXOUHPuByNqTDZrtTlml0ZCsCNTPISAV97CyDSFky5QKxQrPo72ZNQ4Tl
         FwTrULnmoHhiFw8MRPGTMJySAGtEaLBCvBm7so7+pX/grM3/B77ftlpEAuSo/MSLeYUv
         dCotCydA5qHD3NlqmYPdGorOLj0g4dspV/taeCaBCrRhs0i0PHxpaZ3IvG/BLBUoZyPA
         vtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bKIogpHs3E5vOpWuzAK/3JCW0eJBzJG0yWPEmOj0gDg=;
        b=TjfihgKz777R9mcLq2X9vzA2gxTAibb8BeMNlz6A/xKknhmXZj5XWZGdXeKxLFw+sK
         ziq36jF3DyBwAUWxkySKV05CgA4bFJOrMUF1n3z/R1n0X/MHAaZbwrIkY1cBZ4fAYhEX
         dztM0a0WzJL8e/qJuDaV1Mh3rCD272hod7dcw11Z3JvdEuGZHZAdgdLzxRhU6I+6PbGW
         KdET/COH6gWDX/Y938gGFr40GY8roW471/YaJMRLXFwfu3gQ6fIeTP6gqpWsoS4PTlax
         aNKsiTp1jkq+T7/zrMVccJQzcg9zwHKq9Zto6f5ESlIh+h17rArJhbe5uev/8bVm26ko
         V8mg==
X-Gm-Message-State: AOAM530CMOJBMT6Qixrt3t7oC6yhERpExLqcMLxFasEXlIGH0uDCu0bW
        7/MxjDemIY1eJMV/N4g5hFn4ZeAfKnM=
X-Google-Smtp-Source: ABdhPJzwBpI83T4rhcvdCt1WRquz8YrtXgRtv+8dAagSkJqa2xDalvoBkeQD44q5oRXqg+GBbnVSMg==
X-Received: by 2002:a05:6000:178c:b0:1ea:7c28:d45d with SMTP id e12-20020a056000178c00b001ea7c28d45dmr3978116wrg.604.1645528444050;
        Tue, 22 Feb 2022 03:14:04 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id d14sm46158430wri.93.2022.02.22.03.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 03:14:03 -0800 (PST)
Message-ID: <e73c6746-9f8d-7e23-3764-18d01307278b@gmail.com>
Date:   Tue, 22 Feb 2022 11:14:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/1] xdiff: provide indirection to git functions
Content-Language: en-US
To:     Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20220217225218.GA7@edef91d97c94>
 <20220217225408.GB7@edef91d97c94>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220217225408.GB7@edef91d97c94>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/02/2022 22:54, Edward Thomson wrote:
> Provide an indirection layer into the git-specific functionality and
> utilities in `git-xdiff.h`, prefixing those types and functions with
> `xdl_` (and `XDL_` for macros).  This allows other projects that use
> git's xdiff implementation to keep up-to-date; they can now take all the
> files _except_ `git-xdiff.h`, which they have customized for their own
> environment.

The changes since V1 look good,

Best Wishes

Phillip

> Signed-off-by: Edward Thomson <ethomson@edwardthomson.com>
> ---
>   xdiff/git-xdiff.h | 16 ++++++++++++++++
>   xdiff/xdiff.h     |  8 +++-----
>   xdiff/xdiffi.c    | 20 ++++++++++----------
>   xdiff/xinclude.h  |  2 +-
>   xdiff/xmerge.c    |  4 ++--
>   5 files changed, 32 insertions(+), 18 deletions(-)
>   create mode 100644 xdiff/git-xdiff.h
> 
> diff --git a/xdiff/git-xdiff.h b/xdiff/git-xdiff.h
> new file mode 100644
> index 0000000000..664a7c1351
> --- /dev/null
> +++ b/xdiff/git-xdiff.h
> @@ -0,0 +1,16 @@
> +#ifndef GIT_XDIFF_H
> +#define GIT_XDIFF_H
> +
> +#include "git-compat-util.h"
> +
> +#define xdl_malloc(x) xmalloc(x)
> +#define xdl_free(ptr) free(ptr)
> +#define xdl_realloc(ptr,x) xrealloc(ptr,x)
> +
> +#define xdl_regex_t regex_t
> +#define xdl_regmatch_t regmatch_t
> +#define xdl_regexec_buf(p, b, s, n, m, f) regexec_buf(p, b, s, n, m, f)
> +
> +#define XDL_BUG(msg) BUG(msg)
> +
> +#endif
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 72e25a9ffa..fb47f63fbf 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -27,6 +27,8 @@
>   extern "C" {
>   #endif /* #ifdef __cplusplus */
> 
> +#include "git-xdiff.h"
> +
>   /* xpparm_t.flags */
>   #define XDF_NEED_MINIMAL (1 << 0)
> 
> @@ -82,7 +84,7 @@ typedef struct s_xpparam {
>   	unsigned long flags;
> 
>   	/* -I<regex> */
> -	regex_t **ignore_regex;
> +	xdl_regex_t **ignore_regex;
>   	size_t ignore_regex_nr;
> 
>   	/* See Documentation/diff-options.txt. */
> @@ -119,10 +121,6 @@ typedef struct s_bdiffparam {
>   } bdiffparam_t;
> 
> 
> -#define xdl_malloc(x) xmalloc(x)
> -#define xdl_free(ptr) free(ptr)
> -#define xdl_realloc(ptr,x) xrealloc(ptr,x)
> -
>   void *xdl_mmfile_first(mmfile_t *mmf, long *size);
>   long xdl_mmfile_size(mmfile_t *mmf);
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 69689fab24..af31b7f4b3 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -832,7 +832,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   			/* Shift the group backward as much as possible: */
>   			while (!group_slide_up(xdf, &g))
>   				if (group_previous(xdfo, &go))
> -					BUG("group sync broken sliding up");
> +					XDL_BUG("group sync broken sliding up");
> 
>   			/*
>   			 * This is this highest that this group can be shifted.
> @@ -848,7 +848,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   				if (group_slide_down(xdf, &g))
>   					break;
>   				if (group_next(xdfo, &go))
> -					BUG("group sync broken sliding down");
> +					XDL_BUG("group sync broken sliding down");
> 
>   				if (go.end > go.start)
>   					end_matching_other = g.end;
> @@ -873,9 +873,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   			 */
>   			while (go.end == go.start) {
>   				if (group_slide_up(xdf, &g))
> -					BUG("match disappeared");
> +					XDL_BUG("match disappeared");
>   				if (group_previous(xdfo, &go))
> -					BUG("group sync broken sliding to match");
> +					XDL_BUG("group sync broken sliding to match");
>   			}
>   		} else if (flags & XDF_INDENT_HEURISTIC) {
>   			/*
> @@ -916,9 +916,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
> 
>   			while (g.end > best_shift) {
>   				if (group_slide_up(xdf, &g))
> -					BUG("best shift unreached");
> +					XDL_BUG("best shift unreached");
>   				if (group_previous(xdfo, &go))
> -					BUG("group sync broken sliding to blank line");
> +					XDL_BUG("group sync broken sliding to blank line");
>   			}
>   		}
> 
> @@ -927,11 +927,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>   		if (group_next(xdf, &g))
>   			break;
>   		if (group_next(xdfo, &go))
> -			BUG("group sync broken moving to next group");
> +			XDL_BUG("group sync broken moving to next group");
>   	}
> 
>   	if (!group_next(xdfo, &go))
> -		BUG("group sync broken at end of file");
> +		XDL_BUG("group sync broken at end of file");
> 
>   	return 0;
>   }
> @@ -1011,11 +1011,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   }
> 
>   static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
> -	regmatch_t regmatch;
> +	xdl_regmatch_t regmatch;
>   	int i;
> 
>   	for (i = 0; i < xpp->ignore_regex_nr; i++)
> -		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +		if (!xdl_regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
>   				 &regmatch, 0))
>   			return 1;
> 
> diff --git a/xdiff/xinclude.h b/xdiff/xinclude.h
> index a4285ac0eb..75db1d8f35 100644
> --- a/xdiff/xinclude.h
> +++ b/xdiff/xinclude.h
> @@ -23,7 +23,7 @@
>   #if !defined(XINCLUDE_H)
>   #define XINCLUDE_H
> 
> -#include "git-compat-util.h"
> +#include "git-xdiff.h"
>   #include "xmacros.h"
>   #include "xdiff.h"
>   #include "xtypes.h"
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index fff0b594f9..433e2d7415 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -88,7 +88,7 @@ static int xdl_cleanup_merge(xdmerge_t *c)
>   		if (c->mode == 0)
>   			count++;
>   		next_c = c->next;
> -		free(c);
> +		xdl_free(c);
>   	}
>   	return count;
>   }
> @@ -456,7 +456,7 @@ static void xdl_merge_two_conflicts(xdmerge_t *m)
>   	m->chg1 = next_m->i1 + next_m->chg1 - m->i1;
>   	m->chg2 = next_m->i2 + next_m->chg2 - m->i2;
>   	m->next = next_m->next;
> -	free(next_m);
> +	xdl_free(next_m);
>   }
> 
>   /*
> --
> 2.35.1

