Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10D1C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A500B63212
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhKOPR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhKOPQi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 10:16:38 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4568CC061207
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:13:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b15so73117666edd.7
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 07:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=k5hLNH4LUvj/p66KDI8/llJKvJaxLtuH5Cot8r73Yho=;
        b=Wbxk916g6lSg9JxhLojqpS/aV2MNIXzipCEu5pjxALx49jLwkNCcUePDV/JElyRE/8
         6pzjqgau0XczBAfiQWZ4D2FOcjQrJ1Uiin1S5I9sILHruJZU5kiKFdu2M6LBsemcvczj
         x0QIMexwP0W6Jh/ul7OWfupBCxDvzZwXim6Rs1kOxNgkF8aM2sU+RgrRWzWkTQ/8RNY3
         3CFFLBhPl8sfQVBdya9JKy0ozDtIVzj+DfQC6wTGM5Tohe+sRhuzbmb5sfc06u4ZRzot
         tohf1N2k3DWeFV3sIgiKO5nKrN48wNt6Lf/1qvlTNc7HEo7GUYVUFEubY4Rvrx+ap7Ep
         CtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=k5hLNH4LUvj/p66KDI8/llJKvJaxLtuH5Cot8r73Yho=;
        b=XTzPaZNuOTlc0SRUE2K46e344k04JpXqaJKTlVazhcpAw6ylRy6vMxs93GPSLrKynA
         Jr898woQfSWlvoVS7ahYvMh0VTedxQuDT2ocF4ouPBgYKz8Shn4A6sEHi9ov41EXaEjQ
         SLqOahsTb243xFCGzz2nUERzm113cLm46x8apoiNV0cRZaJJsSpA68OFFxl1vqUHURPH
         cvsvZ9PvPrMUowrroq/JSp7MBZq8GCOynAKt+n7hsI476z+vMDFuyCu/L6uIiEY6Rn2M
         NMW4CzYVh9Cq8+rxJo8ajZ8+gZz9DLYdjnibz0Tj8eLwGWdi85ZtzLRp4V2E295aGxPX
         JFtQ==
X-Gm-Message-State: AOAM530hjJta49h+REoSy5Uez1TrKbtRtVXkBlk7BlAqtzPL2p9HBlWC
        j+OgRXk2j1igJIDsqhHZyDE=
X-Google-Smtp-Source: ABdhPJwyQLTD0FJPbL4I/5wkdbyoCqs4nAFFwR4NhoM7EeD0LlV+Tb5SPH/mM+pAJnwgzKfENrp7/A==
X-Received: by 2002:a17:906:4fd0:: with SMTP id i16mr49239206ejw.277.1636989199738;
        Mon, 15 Nov 2021 07:13:19 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hw8sm6793158ejc.58.2021.11.15.07.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 07:13:19 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmdfa-00189R-Ks;
        Mon, 15 Nov 2021 16:13:18 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 1/3] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Mon, 15 Nov 2021 16:12:23 +0100
References: <20211115115153.48307-1-dyroneteng@gmail.com>
 <20211115115153.48307-2-dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211115115153.48307-2-dyroneteng@gmail.com>
Message-ID: <211115.86r1bhsb8x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


lorn Mon, Nov 15 2021, Teng Long wrote:

> This commit supply an option names `--oid-only` to let `git ls-tree`
> only print out the OID of the object. `--oid-only` and `--name-only`
> are mutually exclusive in use.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/ls-tree.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c7..1f82229649 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -20,6 +20,7 @@ static int line_termination = '\n';
>  #define LS_SHOW_TREES 4
>  #define LS_NAME_ONLY 8
>  #define LS_SHOW_SIZE 16
> +#define LS_OID_ONLY 32
>  static int abbrev;
>  static int ls_options;
>  static struct pathspec pathspec;
> @@ -90,6 +91,14 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  	else if (ls_options & LS_TREE_ONLY)
>  		return 0;
>  
> +	if ((ls_options & LS_NAME_ONLY) && (ls_options & LS_OID_ONLY))
> +		die(_("cannot specify --oid-only and --name-only at the same time"));

If you make these an OPT_CMDMODE you get this behavior for free. See
e.g. my
https://lore.kernel.org/git/patch-v2-06.10-d945fc94774-20211112T221506Z-avarab@gmail.com/
