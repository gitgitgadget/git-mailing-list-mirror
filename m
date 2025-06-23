Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637846BF
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704453; cv=none; b=CXsbIrhJv9exbyBFKV6CXXGslwg2CWan1qynWYCewUcPkthPcuTt8pJJF24TUCA/tKrX9G3rIamr0eBBBuKRE4bvjfcaxSeHcapW5y+4l6gBgk0i29VO2H3pF1jq9WUC8d4A6X8LfpHqos/Me41/uWbwyjdigTwSLyJxb77NgL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704453; c=relaxed/simple;
	bh=6lwz+Ixf91OlyY0ke4XHOCdESoSWEGiHINj6u/Xaj3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBPUFuDw5/SzSICdz0T9DBbhnhHKnnmOQbIMNyoFkv8aQTWB6bUoKO3/0ySk4fKfMFSDhTGtNPb5i8dvoDPeiMVYbRdFmgdhJjIcRbPjEYHtQGn2y2vtdElvc2Wr513mgQ9I8xj8evnPQjo0eEV0TvvdPvJOLhtOdyF7l79xlEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=C12ihlGN; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="C12ihlGN"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso3830845276.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750704451; x=1751309251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huFx7UNK/Id32HAAY0jEy4dDHMTwSE3d98EG5g70uC4=;
        b=C12ihlGNDO6Z2QekNev2WFp2EJab/0TzHdtSWrdOpKq+62aD9E6jUS1ymdevA+a6ic
         4A2ka4u8oz09iPris2f/25bRiJvrprfSI+jF9mAfUIlL7gyO4oAPlxkx0IJWzvkezdtE
         RYLqUDUKeIwD+IDz3x+3m/d9zTIOSVKndwxzTB/N2n60SSZ+L4ZvoGjgGfU+KQWBTsM5
         CKjiSQWrWWcEutBzt+3dZH05fj7jEQhsryuSWa8+Q58WM0kBdMf9PAeigZvEZcw/1hBB
         ooNPv8fWgxIrVLBrEpGEykJsR1LJXwLy1yoGrBc9NZzjM7KYUlpg3LMdryAZPTFib2hg
         hrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704451; x=1751309251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huFx7UNK/Id32HAAY0jEy4dDHMTwSE3d98EG5g70uC4=;
        b=rK07BQXQJH7aiFppD9D9o5il9CUGeOnx/NrvQGifZCIMDH7OrryWUwxq3cA1gYF0pQ
         hBkBjBaWnLap1e1E/4xMXt1Wvk4acf1KNHao/TnIwI4nV1i0tQq5Mva9UEBzD1xBoJvP
         QDIwvoAmSyayXrVtsXfPHZoh2pdY/1SqEk2DEi3heNWU2xx8SoKy2B+jM75HQH/XFiV4
         aTwVosoXhRFn85TT7g8SoZx0aAy+CWphO+sgyD+rRh0qu4ZeBU+WScAiKp/bVorzyb2Z
         bExAq6REA6mQBLJ3Mtq7jOKzXnrf5LJvHSrUAeussxKfvj92fQ75pclcSHznFdWkWQtb
         43ew==
X-Gm-Message-State: AOJu0YwdYuIUDrmgXtQEJSN9qkYo3x8Y0Hg9g1qFB6budFOkNoIuH+1J
	z3tZZ4zRa4mTcvNcHWyhXzSt2GFjT4aSf8t3H3hDuio4BWlvHBfUnb4gQvZ+Lxqv+zI=
X-Gm-Gg: ASbGncsMNXFSMCaLE5TWvS7fQero81PK4UQWuAHtSS6mBHMMHh9qLW4taNmcvD0xPus
	ig0T9fcotuiaUma7MyIklC9IyAkDIX4Uk2b84QPhowDb6xzk4bComMAydqLCTL2fNZA0aB58AgE
	97HKypxPTw19JGg+niPxGevMk8ru98dWBi/h+bIgK8Tx6zETlKnI/7+mrwrgCuZNgu7IWil6eGO
	KXYbDHWb4jSXjlH92XPfbJXapl1AEtWltUeC+AVcrPIMJkzdiLglz7yu8yEEV7vF1sybsLqlkdR
	t8UyCxFz9VzHr5L6kJ8UHyV6SvfZZbN6ok+w0GU/JG13zRBHoHvHFBQnw601VSGGAuZGCu2CycJ
	L9kh89Nmvl5AHTbMaUNIAlsMR8mCAThrORA==
X-Google-Smtp-Source: AGHT+IEOBmoPuVEXBtIwlwxWPiepSLlpIXyWbPwvaSbSpznfe3sXcWk1whJIFIxRLbYqfiSieOmHAw==
X-Received: by 2002:a05:6902:2504:b0:e85:eb80:2cf3 with SMTP id 3f1490d57ef6-e85eb802d92mr3796833276.29.1750704450725;
        Mon, 23 Jun 2025 11:47:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ac5bd22sm2528293276.31.2025.06.23.11.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:47:30 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:47:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <aFmhQZZnYyvxDelO@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
 <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>
 <20250621043551.GA3002138@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250621043551.GA3002138@coredump.intra.peff.net>

On Sat, Jun 21, 2025 at 12:35:51AM -0400, Jeff King wrote:
> On Thu, Jun 19, 2025 at 07:30:33PM -0400, Taylor Blau wrote:
>
> > +test_expect_success 'repack --write-midx excludes cruft where possible' '
> > +	setup_cruft_exclude_tests exclude-cruft-when-possible &&
> > +	(
> > +		cd exclude-cruft-when-possible &&
> > +
> > +		GIT_TEST_MULTI_PACK_INDEX=0 \
> > +		git repack -d --geometric=2 --write-midx --write-bitmap-index &&
> > +
> > +		test-tool read-midx --show-objects $objdir >midx &&
> > +		cruft="$(ls $packdir/*.mtimes)" &&
> > +		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
> > +
> > +		git rev-list --all --objects --no-object-names >reachable.raw &&
> > +		sort reachable.raw >reachable.objects &&
> > +		awk "/\.pack$/ { print \$1 }" <midx | sort >midx.objects &&
> > +
> > +		test_cmp reachable.objects midx.objects
> > +	)
> > +'
>
> This test (but none of the others) fails when run with:
>
>   GIT_TEST_MULTI_PACK_INDEX=1 \
>   GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1 \
>   ./t7704-repack-cruft.sh
>
> The culprit is the incremental flag, but you need the first one for the
> second to do anything. The issue is that the cruft pack unexpectedly
> appears in the midx:
>
> [...]
>
> I'm not sure if it's just a funky interaction with the hacky GIT_TEST_*
> variables, or if it's a real bug.

Thanks for spotting. This is definitely a real bug. The root cause here
is that our loop to gather the set of packs we know are in the MIDX does
not account for multi-layered / incremental MIDXs.

In our example, if there's a cruft pack in any other layer of a MIDX
besides the tip, the proposed implementation here won't realize it, and
thus (incorrectly) conclude that the cruft pack is not in the MIDX
already, so can thusly be omitted.

If we do this on top:

--- 8< ---
diff --git a/builtin/repack.c b/builtin/repack.c
index 346d44fbcd..8d1540a0fd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1614,13 +1614,16 @@ int cmd_repack(int argc,
 	string_list_sort(&names);

 	if (get_local_multi_pack_index(the_repository)) {
-		uint32_t i;
 		struct multi_pack_index *m =
 			get_local_multi_pack_index(the_repository);

-		ALLOC_ARRAY(midx_pack_names, m->num_packs);
-		for (i = 0; i < m->num_packs; i++)
-			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
+		ALLOC_ARRAY(midx_pack_names,
+			    m->num_packs + m->num_packs_in_base);
+
+		for (; m; m = m->base_midx)
+			for (uint32_t i = 0; i < m->num_packs; i++)
+				midx_pack_names[midx_pack_names_nr++] =
+					xstrdup(m->pack_names[i]);
 	}

 	close_object_store(the_repository->objects);
--- >8 ---

(Note that this assumes that 'tb/prepare-midx-pack-cleanup' has not
landed, this could be a little bit simplified with the
nth_midx_pack_names() function. I kept these two separate so they could
proceed independently.)

Things work as expected. I'll send out a new round with this fix
Incorporated as well as a style issue that Junio noted earlier in this
thread.

Thanks,
Taylor
