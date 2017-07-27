Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F9382047F
	for <e@80x24.org>; Thu, 27 Jul 2017 00:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdG0ASS (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 20:18:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35283 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdG0ASQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 20:18:16 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so18719692pgc.2
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 17:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8haN/fD46JhKMmMDf4IOn9HFHO2FB+n8TGF70d0cP30=;
        b=DifbEFFN4/p/la98YrlAxbmqTabC3f/YmMhFozK2mjJtum1PvvFKnfWTv8Zxp6bn87
         g82CRd9/Zhih3MOZAsEsP0j/hVqOpUgj/JHp3n1a8iu0dQdgPQbQGXWgQVMocUfTsIrp
         Ds8ve9sor/C5sHe0qhUq0qgm1tp7s9Gj9MR/G5Q1xCNrOy4qbKR+PVUaZ7prdM90kVxo
         CRtxAVKl+w0+EyEyTzokZ6FZDDoE0Lsk3k19P+NxQTrp1/wpokA6MDPUOavL8E8SCodw
         onRK5Q2s5tCBJy522I0Cotte8aliSmdT7uFLiQt1bUmhiDRJnpJsmL2cm8WbKC98kJkg
         Ekdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8haN/fD46JhKMmMDf4IOn9HFHO2FB+n8TGF70d0cP30=;
        b=otOmGjlIPafyvmhPlTIYY5OFD8gLVJE6T5ntSFg3jiyEeOx9o7YBguGXMafvc9clbC
         5k/sX6i+IiAmh/7Rn+UZiEOTPmRR9gd0fKhmnj8rIZYftCwBIjBATdUrw3Wnj3LHp+5X
         y4EEExMWxQW4ip/5tbE6s63K/VkTlgaVaITngl7bNTKLvCxLZ3OvkBz3dlEQvMygkEea
         ala0P53X2G58iqq6fRc6C480DsSQA3jsX2lekIPvPt1NNgU7GoHKGWoMVv1NYbwEK8bU
         hIKbOhIA0Tlv8pkbiVvwZGHD2BCVIYigjj14mQ5qtMFpbahQw1etXeplA8UxYZma1q+U
         ipNQ==
X-Gm-Message-State: AIVw111jdi6I6sp0Tu76b3vwy1zEquR2Wy0hbiqihHqhBysybXREFZ+Q
        IzDi+Al7F59qcg==
X-Received: by 10.84.136.135 with SMTP id 7mr2661616pll.356.1501114695386;
        Wed, 26 Jul 2017 17:18:15 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:ec3c:b9b1:fb10:d6fa])
        by smtp.gmail.com with ESMTPSA id y2sm29191413pgy.60.2017.07.26.17.18.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 17:18:14 -0700 (PDT)
Date:   Wed, 26 Jul 2017 17:18:12 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Dave Walker <dawalker@google.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Message-ID: <20170727001812.GI13924@aiede.mtv.corp.google.com>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Michael Haggerty wrote:

> One of the tricks that `contrib/workdir/git-new-workdir` plays is to
> making `packed-refs` in the new workdir a symlink to the `packed-refs`
> file in the original repository. Before
> 42dfa7ecef ("commit_packed_refs(): use a staging file separate from
> the lockfile", 2017-06-23), a lockfile was used as the staging file,
> and because the `LOCK_NO_DEREF` was not used, the pointed-to file was
> locked and modified.
>
> But after that commit, the staging file was created using a tempfile,
> with the end result that rewriting the `packed-refs` file in the
> workdir overwrote the symlink rather than the original `packed-refs`
> file.
>
> Change `commit_packed_refs()` to use `get_locked_file_path()` to find
> the path of the file that it should overwrite. Since that path was
> properly resolved when the lockfile was created, this restores the
> pre-42dfa7ecef behavior.
>
> Also add a test case to document this use case and prevent a
> regression like this from recurring.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reported-by: Dave Walker <dawalker@google.com>

[...]
>  refs/packed-backend.c | 24 ++++++++++++++++++------
>  t/t3210-pack-refs.sh  | 15 +++++++++++++++
>  2 files changed, 33 insertions(+), 6 deletions(-)

The patch looks good, except for one nit marked below (*).  I'll apply
it locally and ask people to test it, probably tomorrow morning.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for writing it.  Patch left unsnipped for reference.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a28befbfa3..59e7d1a509 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -610,19 +610,27 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
>  	struct packed_ref_cache *packed_ref_cache =
>  		get_packed_ref_cache(refs);
>  	int ok;
> +	int ret = -1;
>  	struct strbuf sb = STRBUF_INIT;
>  	FILE *out;
>  	struct ref_iterator *iter;
> +	char *packed_refs_path;
>  
>  	if (!is_lock_file_locked(&refs->lock))
>  		die("BUG: commit_packed_refs() called when unlocked");
>  
> -	strbuf_addf(&sb, "%s.new", refs->path);
> +	/*
> +	 * If packed-refs is a symlink, we want to overwrite the
> +	 * symlinked-to file, not the symlink itself. Also, put the
> +	 * staging file next to it:
> +	 */
> +	packed_refs_path = get_locked_file_path(&refs->lock);
> +	strbuf_addf(&sb, "%s.new", packed_refs_path);
>  	if (create_tempfile(&refs->tempfile, sb.buf) < 0) {
>  		strbuf_addf(err, "unable to create file %s: %s",
>  			    sb.buf, strerror(errno));
>  		strbuf_release(&sb);
> -		return -1;
> +		goto out;
>  	}
>  	strbuf_release(&sb);
>  
> @@ -660,17 +668,21 @@ int commit_packed_refs(struct ref_store *ref_store, struct strbuf *err)
>  		goto error;
>  	}
>  
> -	if (rename_tempfile(&refs->tempfile, refs->path)) {
> +	if (rename_tempfile(&refs->tempfile, packed_refs_path)) {
>  		strbuf_addf(err, "error replacing %s: %s",
>  			    refs->path, strerror(errno));
> -		return -1;
> +		goto out;
>  	}
>  
> -	return 0;
> +	ret = 0;
> +	goto out;
>  
>  error:
>  	delete_tempfile(&refs->tempfile);
> -	return -1;
> +
> +out:
> +	free(packed_refs_path);
> +	return ret;
>  }
>  
>  /*
> diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
> index 2bb4b25ed9..0d8a03e2a9 100755
> --- a/t/t3210-pack-refs.sh
> +++ b/t/t3210-pack-refs.sh
> @@ -238,4 +238,19 @@ test_expect_success 'retry acquiring packed-refs.lock' '
>  	git -c core.packedrefstimeout=3000 pack-refs --all --prune
>  '
>  
> +test_expect_success 'pack symlinked packed-refs' '

(*) Does this need a SYMLINKS prereq to avoid trouble on Windows?

> +	# First make sure that symlinking works when reading:
> +	git update-ref refs/heads/loosy refs/heads/master &&
> +	git for-each-ref >all-refs-before &&
> +	mv .git/packed-refs .git/my-deviant-packed-refs &&
> +	ln -s my-deviant-packed-refs .git/packed-refs &&
> +	git for-each-ref >all-refs-linked &&
> +	test_cmp all-refs-before all-refs-linked &&
> +	git pack-refs --all --prune &&
> +	git for-each-ref >all-refs-packed &&
> +	test_cmp all-refs-before all-refs-packed &&
> +	test -h .git/packed-refs &&
> +	test "$(readlink .git/packed-refs)" = "my-deviant-packed-refs"
> +'
> +
>  test_done
