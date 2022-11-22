Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD106C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 01:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKVBT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKVBTY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 20:19:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0D554EC
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 17:19:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gv23so32424072ejb.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 17:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh+HJwrLtWI0iG91CfCG8/6ajWnLqTSM31LsEaaooGw=;
        b=i/CpJFIa0SuW7Tn0RKGkcILK4OMZlOmlOoWcK8e6NTxKnBja5cSAdN9mIIBVnu1gfB
         FSf43io3vqy4Lpj+5x96P/aq2ZOybvHhta5OYceyveVcY5O24r26YN3fFYs1mBJGEBKb
         hQObfNhb0BvshMkutTsqFFc6j3Xo/sjVsx5U9uUotSbFT4t5G5560+0pRv9KABq5cuv2
         44NDBH0FvmBRhZwQmztLSMZBlJ09si3PwrPin6niW0BR5upo2spepmoakn3pLIm8LrhX
         GGJDEUE+RofJp2asBgk2tIqpQV5eofMJQVoaAhP3GgYNkBL9e1I3F1TIKvHynmNlxLoa
         wgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh+HJwrLtWI0iG91CfCG8/6ajWnLqTSM31LsEaaooGw=;
        b=6fkvU7D49W/MbA15jEI54QWoSwlK+bwaFYjd1f8cyz8nF1Q/PBBLYblcfQUHkr8aSf
         AjPV6A6Lho3+F2XLQkCphpLXojPAQ9v6l1UI2we08HaFjjfKrHxOcUKUGAzGNZTrr2xd
         AfRS+fOhKPy1H207nDfiQipLcMgwQz5Ph1dExCG4B5cgM5r0Mn/yf4TpE+H1pQfJ9F+g
         gm2pRpw5EDDfvCi/z5nAXPfSnhZ4/Ua9lOPQga8oHZnwYtWnHtCcM+Npa80602Zd1UWZ
         mqEDmHwuVeIfN0I54/LjQc3mnV5hxrueCELWkGfxC/Ek1IbHc25IOLao1XgKgK/aPS4f
         7L+Q==
X-Gm-Message-State: ANoB5pkZ5/OY36G5BQY8BdJWG5LUymH38UTQVs1D8k1coHbedqgri+Bo
        gPnGGrPrANOrhsr5bCQQ7qo=
X-Google-Smtp-Source: AA0mqf4QYTgCRlHrysaCY94OsKG3LNY13jEjuM/XfWN7O6QPJr5eBDjoa+MKkrxFXLo9xEVAF/hKrQ==
X-Received: by 2002:a17:906:3c4d:b0:78d:f2d8:4623 with SMTP id i13-20020a1709063c4d00b0078df2d84623mr18321455ejg.274.1669079961704;
        Mon, 21 Nov 2022 17:19:21 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906314b00b0078b83968ad4sm5484674eje.24.2022.11.21.17.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:19:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oxHwW-000WCW-2f;
        Tue, 22 Nov 2022 02:19:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
Date:   Tue, 22 Nov 2022 01:56:09 +0100
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com>
Message-ID: <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Glen Choo via GitGitGadget wrote:

> From: Glen Choo <chooglen@google.com>

Aside from some small nits this looks good to me.

>  object-file.c     | 12 ++++++------
>  t/t7700-repack.sh | 18 ++++++++++++++++++
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 957790098fa..ef2b762234d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  {
>  	struct object_directory *ent;
>  	struct strbuf pathbuf = STRBUF_INIT;
> +	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
>  
>  	if (!is_absolute_path(entry->buf) && relative_base) {
> @@ -516,12 +517,14 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
>  	}
>  	strbuf_addbuf(&pathbuf, entry);
>  
> -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
> +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
>  		error(_("unable to normalize alternate object path: %s"),
> -		      pathbuf.buf);
> +			pathbuf.buf);

This is a mis-indentation, it was OK in the pre-image, not now.

>  		strbuf_release(&pathbuf);

Doesn't this leak? I've just skimmed strbuf_realpath_1() but e.g. in the
"REALPATH_MANY_MISSING" case it'll have allocated the "resolved" (the
&tmp you pass in here) and then "does a "goto error_out".

It then *resets* the strbuf, but doesn't release it, assuming that
you're going to pass it in again. So in that case we'd leak here, no?

I.e. a NULL return value from strbuf_realpath() doesn't mean that it
didn't allocate in the scratch area passed to it, so we need to
strbuf_release(&tmp) here too.

Perhaps this on top is simpler (but also see below)?:
	
	diff --git a/object-file.c b/object-file.c
	index ef2b762234d..d5d502504bb 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -510,6 +510,7 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
	 	struct strbuf pathbuf = STRBUF_INIT;
	 	struct strbuf tmp = STRBUF_INIT;
	 	khiter_t pos;
	+	int ret = -1;
	 
	 	if (!is_absolute_path(entry->buf) && relative_base) {
	 		strbuf_realpath(&pathbuf, relative_base, 1);
	@@ -520,11 +521,9 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
	 	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
	 		error(_("unable to normalize alternate object path: %s"),
	 			pathbuf.buf);
	-		strbuf_release(&pathbuf);
	-		return -1;
	+		goto error;
	 	}
	 	strbuf_swap(&pathbuf, &tmp);
	-	strbuf_release(&tmp);
	 
	 	/*
	 	 * The trailing slash after the directory name is given by
	@@ -533,10 +532,8 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
	 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
	 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
	 
	-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
	-		strbuf_release(&pathbuf);
	-		return -1;
	-	}
	+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
	+		goto error;
	 
	 	CALLOC_ARRAY(ent, 1);
	 	/* pathbuf.buf is already in r->objects->odb_by_path */
	@@ -552,7 +549,11 @@ static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
	 	/* recursively add alternates */
	 	read_info_alternates(r, ent->path, depth + 1);
	 
	-	return 0;
	+	ret = 0;
	+error:
	+	strbuf_release(&tmp);
	+	strbuf_release(&pathbuf);
	+	return ret;
	 }
	 
	 static const char *parse_alt_odb_entry(const char *string,
	
	

>  		return -1;
>  	}
> +	strbuf_swap(&pathbuf, &tmp);
> +	strbuf_release(&tmp);
>  
>  	/*
>  	 * The trailing slash after the directory name is given by
> @@ -596,10 +599,7 @@ static void link_alt_odb_entries(struct repository *r, const char *alt,
>  		return;
>  	}
>  
> -	strbuf_add_absolute_path(&objdirbuf, r->objects->odb->path);
> -	if (strbuf_normalize_path(&objdirbuf) < 0)
> -		die(_("unable to normalize object directory: %s"),
> -		    objdirbuf.buf);
> +	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
>  
>  	while (*alt) {
>  		alt = parse_alt_odb_entry(alt, sep, &entry);
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 5be483bf887..ce1954d0977 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -90,6 +90,24 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
>  	test_has_duplicate_object false
>  '
>  
> +test_expect_success '--local keeps packs when alternate is objectdir ' '
> +	git init alt_symlink &&
> +	(
> +		cd alt_symlink &&
> +		git init &&

The tests pass without this re-"git init", left over from development?

> +		echo content >file4 &&
> +		git add file4 &&
> +		git commit -m commit_file4 &&
> +		git repack -a &&
> +		ls .git/objects/pack/*.pack >../expect &&
> +		ln -s objects .git/alt_objects &&
> +		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
> +		git repack -a -d -l &&
> +		ls .git/objects/pack/*.pack >../actual
> +	) &&
> +	test_cmp expect actual
> +'
> +

I think this is better squashed in:
	
	diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
	index ce1954d0977..79eef5b4aa7 100755
	--- a/t/t7700-repack.sh
	+++ b/t/t7700-repack.sh
	@@ -91,13 +91,11 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
	 '
	 
	 test_expect_success '--local keeps packs when alternate is objectdir ' '
	-	git init alt_symlink &&
	+	test_when_finished "rm -rf repo" &&
	+	git init repo &&
	+	test_commit -C repo A &&
	 	(
	-		cd alt_symlink &&
	-		git init &&
	-		echo content >file4 &&
	-		git add file4 &&
	-		git commit -m commit_file4 &&
	+		cd repo &&
	 		git repack -a &&
	 		ls .git/objects/pack/*.pack >../expect &&
	 		ln -s objects .git/alt_objects &&

Because:

 * If it's not a setup for a later test let's call it "repo" and clean
   it up at the end.

 * The "file4" you're creating doesn't go with the existing pattern, the
   file{1..3} are created in the top-level .git, here you're making a
   file4 in another repo.

   This just calls it "A.t", and makes it with test_commit, since all
   you need is a dummy commit.

 * I think we typically use "find .. -type f", not "ls", see
   e.g. t5351-unpack-large-objects.sh, but I left it in-place. I think
   aside from that test there's some other "let's compare the packed
   before & after" in the test suite, but I can't remember offhand...
