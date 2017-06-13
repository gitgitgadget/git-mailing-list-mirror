Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75691FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbdFMWH3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:07:29 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37721 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMWH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:07:28 -0400
Received: by mail-it0-f54.google.com with SMTP id m47so45926707iti.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7tsqCY33ovnQe0h/R+gwwgvzpLH3Ad1+zZcigngQFE=;
        b=bHFEvoN8qHFxp4iYFcJPcfVdrk289+B27Bh91rj1wyYsf6xYmo8VHPGx/d3g59/X6b
         FbLw24y+4kre3g/X8mAcQQ0yYwV9ud7TnwoTTiiGmnsprS6BJW5Hw0gV8jaWyccB+SDU
         uS1nwl5mcUcCBThzLAGnJ7qbxfGxO2rQyvcCQVhdBLn+vaMafvgm0wXRUeOJ8oOhiX6V
         f4bQfeQidJJ8w1GU4G5d2/5Sg4qG70hFmb0AkE6xl/o04JCVjv29/7ZYLXZ7xtLXgnWi
         IGsqF0bpZJHSfyq7WK82b5yKO3ZsKL4IuTO6BEVnPsSBDTpxMDdGfhc09My4bOL48ybe
         IVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7tsqCY33ovnQe0h/R+gwwgvzpLH3Ad1+zZcigngQFE=;
        b=ePKGELDT1Y4k3t7EQDAspk94Oj+Egau2ARe/RTYJX7qWo8DI83VkmTYOMGkqya+eJ/
         gTWuI4T7a0Pjj2vP5uBA6NCWKDFfRPixPkWSLjlIHZwF+jxBM2tarp4U3PoH9X8NOzE/
         WvL57dgiTnMPC98JxBG09GV8QglntQ41cKWT5p1j+r54T4KFyNJstUS9Uc/pNZjMKSlc
         e+1Xut3fN7CPW+pRtQkQs4Pk528+7L7xRosnHwJXMsloWd2g79ypUMdM5p6SAfL8frEq
         bVEueYwe2ZaRbSrNzJEWkJ+HCjgINKbjgJZAsoNalTkZdHUGP0HOooGnKOwDwMFI17vK
         OuvQ==
X-Gm-Message-State: AKS2vOyZJn/JnlZ345Wd4iS/zePj62wcQif7wefxrDjcX4U4tplGHQ6C
        qUZKYncF4MoK8hFY
X-Received: by 10.36.74.148 with SMTP id k142mr17042400itb.94.1497391647841;
        Tue, 13 Jun 2017 15:07:27 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:85a0:52c1:8d73:eb63])
        by smtp.gmail.com with ESMTPSA id n103sm6916490ioe.48.2017.06.13.15.07.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 15:07:27 -0700 (PDT)
Date:   Tue, 13 Jun 2017 15:07:22 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, bmwill@google.com,
        jrnieder@gmail.com, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCHv5 16/17] diff: buffer all output if asked to
Message-ID: <20170613150722.0bd8fa56@twelve2.svl.corp.google.com>
In-Reply-To: <20170524214036.29623-17-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
        <20170524214036.29623-1-sbeller@google.com>
        <20170524214036.29623-17-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 24 May 2017 14:40:35 -0700
Stefan Beller <sbeller@google.com> wrote:

> diff --git a/diff.h b/diff.h
> index 85948ed65a..fad1258556 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -115,6 +115,42 @@ enum diff_submodule_format {
>  	DIFF_SUBMODULE_INLINE_DIFF
>  };
>  
> +/*
> + * This struct is used when we need to buffer the output of the diff output.
> + *
> + * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
> + * into the pre/post image file. This pointer could be a union with the
> + * line pointer. By storing an offset into the file instead of the literal line,
> + * we can decrease the memory footprint for the buffered output. At first we
> + * may want to only have indirection for the content lines, but we could also
> + * enhance the state for emitting prefabricated lines, e.g. the similarity
> + * score line or hunk/file headers would only need to store a number or path
> + * and then the output can be constructed later on depending on state.
> + */
> +struct diff_line {

Probably should be called diff_emission (or just emission), since these
may not be full lines.

Also, can this definition be in the .c file? Callers should use the
diff_emit_line() below, and not need to know how it is implemented
internally.

> +	const char *set;
> +	const char *reset;
> +	const char *line;
> +	int len;
> +	int sign;
> +	int add_line_prefix;
> +	enum {
> +		/*
> +		 * Emits [lineprefix][set][sign][reset] and then calls
> +		 * ws_check_emit which will output "line", marked up
> +		 * according to ws_rule.
> +		 */
> +		DIFF_LINE_WS,
> +
> +		/* Emits [lineprefix][set][sign] line [reset] */
> +		DIFF_LINE_ASIS,
> +
> +		/* Reloads the ws_rule; line contains the file name */
> +		DIFF_LINE_RELOAD_WS_RULE
> +	} state;
> +};
> +#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}

Should be DIFF_LINE_INIT (capitalization), and {NULL} is sufficient, I
think.
