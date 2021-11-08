Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19458C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA968619EA
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhKHUjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhKHUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 15:39:51 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E193C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 12:37:06 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id k21so3147396ioh.4
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 12:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SElPSt0w3aQSgguK2eiV3NzeLba65rs5YK0iqjV6JSA=;
        b=yv/fUQemP7PYzmUKYpAa3/9mQ1acn1/y2T7HDZpwDWuAjw5L9qKLTGiNSI+z5cPwCv
         Vks/6HrmVp47HkvIGa/z/FequG0T1mvmg8y6/+nkh3Vl68t8JMk75bJtNeauUNUETAgX
         N1lwuqc1iO5rEU58TohxJWIWqatveQG79eivTE9WOHhPvDxBUZtXuMIjD9210givFA63
         MDDcqNCa0t8dhxNwrzwS+5OEjgQaInlDlGOlYWouIk/rwlKk7aC3qVsWY7lGGKJ3xjTo
         mJXq70iEMcIcjo7L8E/BEu7EgJ+iYL0i9JbVA7m3MEUADS4JISKdr60bgOyyF+TB/oae
         CP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SElPSt0w3aQSgguK2eiV3NzeLba65rs5YK0iqjV6JSA=;
        b=pgRputhdQlfva0LjX1P6jzzi8VaCfdZpP1cHTpwiEJ80GkJUWc/yH1GYfIELi/S15Y
         DxTNK6eKAXjQ2EUHhjt8PrBtTDoSTQ2hi7lAl6+3PRlXhXAbQVCwXvXxzYFBijcI1xWS
         a6is800XS5qCTB13HbY3fBf0CLTF8Rp8wKCCfVHM2hmb12K9FGr8BnusblewnVIZAf9k
         ifGkcLZyBhQzieqwxlREfbLaeBNFkAZ4bqc4gtHY1kB518p0YjXQdn2huM+CQOD12OTs
         H+551wFkm3rH1948ppn+/trlQxcQkRfK8tTfUjGKMgjjXklXQWLYFLoHm8FFDHwfQA4F
         NJDQ==
X-Gm-Message-State: AOAM532k48zS+oaNxk2Hxgeqj7lsZ1zOQ0xqXX1663Yv2y/MHbdOtAbY
        phNWaYKaCBdlvsFr7RJrm08IQQ==
X-Google-Smtp-Source: ABdhPJzKY3n1C5zr+4cO0nDkbTblEiQCIO1wXhIoxErP74kvn4490r9ZNw4VXV6S7RuQcJ6wifPYew==
X-Received: by 2002:a05:6638:268c:: with SMTP id o12mr1430648jat.93.1636403825653;
        Mon, 08 Nov 2021 12:37:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l4sm10815442ilv.46.2021.11.08.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 12:37:05 -0800 (PST)
Date:   Mon, 8 Nov 2021 15:37:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH 2/8] git.c & grep.c: assert that "prefix" is NULL or
 non-zero string
Message-ID: <YYmKcOHInPWtKrWh@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-2.8-244715e3497-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.8-244715e3497-20211106T210711Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 06, 2021 at 10:10:48PM +0100, Ævar Arnfjörð Bjarmason wrote:
> @@ -431,6 +430,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  			int nongit_ok;
>  			prefix = setup_git_directory_gently(&nongit_ok);
>  		}
> +		assert(!prefix || (prefix && *prefix));

Small nit, but the check to `prefix` (in `prefix && *prefix`) is
redundant with the left-hand side of the or.

>  		precompose_argv_prefix(argc, argv, NULL);
>  		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
>  		    !(p->option & DELAY_PAGER_CONFIG))
> diff --git a/grep.c b/grep.c
> index f6e113e9f0f..88ebc504630 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -145,7 +145,7 @@ void grep_init(struct grep_opt *opt, struct repository *repo, const char *prefix
>
>  	opt->repo = repo;
>  	opt->prefix = prefix;
> -	opt->prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
> +	opt->prefix_length = prefix ? strlen(prefix) : 0;

Looking around, ls-tree's initialization includes a conditional of the
form:

    if (prefix && *prefix)
      chomp_prefix = strlen(prefix);

So that could be cleaned up too. But honestly, the pre-image of this
patch (and the spot in ls-tree) doesn't make a lot of sense to me to
begin with.

Even if prefix were the empty string, calling strlen() on it will just
give us zero. So there is no difference between assigning `str && *str ?
strlen(str) : 0` and `str ? strlen(str) : 0`.

So I am confused why this needs hardening with an assertion when it
seems like the checks before calling strlen() were overly restrictive to
begin with. In other words: why not only include this hunk (either in
this patch, or squashed into another patch later on)?

Thanks,
Taylor
