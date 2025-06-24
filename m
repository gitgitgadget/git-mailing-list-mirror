Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3726CE13
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781150; cv=none; b=uXepdWZhWcNvIn1wpfAgSV2l+xJBBYP2XRFZauD4CcdHtT5hP9ubr+JcIYgu1MLbPGxiT600VaWURzKEqWJzX0bx4o8Q66k8fhdDpBJpUZcNDik3J0L79NANsEFPBCIITqUyIlvM/q8h1tSBuWMk8XU65NRmQwx2Hn8YFLAP1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781150; c=relaxed/simple;
	bh=mS+9+Y+g2P10B1PLviIv4nBkwNQX3eO0f/zS47QFHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmSrkyoFpkSGPnWgtWyCDLB4EdR3Z5HZ7gGyd5zaJsSyW4rxRNQLun2vHNBNG8zGFGXxUNI6CNButDIYp3FFeU+5nEuGbqtAGJfzqZd/NGzmr264lrvLUYsuEztnMN0LJ9qyiUh+TXvcsC6BRbVIvgwp8xOTPSLXGG5zykqpiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=BmZbB/mN; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="BmZbB/mN"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e812c817de0so3732911276.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750781147; x=1751385947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oy2dgBAW852oarlBoMWHjyPlrACJ18mjh+yauahy+C4=;
        b=BmZbB/mNst1xLXEPIXJ9/IcyalfsNJsRc0ajFGnV6grx39wAUeDv9wdE1DsCNWitqN
         Msd3V65GXQ/HkLQ3LcWG1TPz9ukSv62WUaHD2HheW1JFEoiY9+DWHM1x+9ghcJ7aSWT3
         djqVJy9PdhkLifuB5ZJBdl8dZ7SZC5aOvyu5ODH0deEbicGKjONuaMUdol9h1zb7GzOi
         W/W8Ab7gGsDDznRQjEBXGpX5jrEWOiqjjrCM2AnRwEZdVu4WmiWXPxMAOvcL3rrv/KZO
         iMT7c/IRYi2FRE5aryTK1J9yBLuMceOxmv0sACKgefBDAkMTfRQbLSLbFu0ku3DraG1v
         2RPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781147; x=1751385947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy2dgBAW852oarlBoMWHjyPlrACJ18mjh+yauahy+C4=;
        b=ce4W26LF7iW+SGQVMVoPuHIBiNQjMN84gmKCbEo4GA0ihaeuQlwSEHItDSsCeBGo/3
         8N7vJslQBwOcFriyQ1VSq/pKVl6nQqhhuxgATthKTLGAm8yVRx5YvvVnQQ/W9ox5Q9rN
         VDPY35zOH6seQZO8s6bqcAU5emUX4DWTNRoWxInWzAmaD6oQXAeyWZYmJnO3XSVq1CPX
         H3qafrOGKqiimoaP4MK4Bn0lo3Z/tQ8dZyhLuPCBC3WqJWG2c5I7JN8AFwq8ppQwZzGz
         9xIruvqzDHQMMScFGWsV8FkQBMqm8P4dnpakLO3g9rU+83o9FrR0gROPWW+wRAQZhdV5
         s2zA==
X-Gm-Message-State: AOJu0Yymz5MpSIsGpYIO0y7vzZWV8RSSpOZWKum0J3O0Fuw2p2+/Ov+o
	E7Y2Z5aufKRxKL5mp7OW1+8JgiasPLlltEkkySBlIZzqZ4jGSNi8XJ8uXkYY9Nz5R44HgMeBESl
	WLhHC
X-Gm-Gg: ASbGnct6+hOkCqW2nkW/sCQ/rRzeRUIxIOyfrSWOLJ2DHucwVXTThIus9bJ4f23aXM+
	AKVOFupqObqIxJZduuc+IrileWrFzP7CUyW22jt5+by9kKk60eMUcWySz+n4SDyN+VGPDm5XNQj
	6g4JnX/iIUn6XHupnVK1uGSAtGb2KkPO5DfKBiUx8LXZv5hOzBt7+xPavwrKRoPPRPZdzt4LkCI
	FzjUBya257hB7wjGG4RmViVsPvMXkQ5xqYK9Y+aeFW7rKeKwLevylgxuffVNkeFKmuaZYjFweCx
	DbPgT3KUhQ4dqkPKhF49SySZjXTK/UNkjiZHCGStQotRN2zHQAseH1Djzg0tm1JCHLTtSHopcxs
	Iv+wl07bomXf9J/KKJTq1SxgTnrGtVhgSqw==
X-Google-Smtp-Source: AGHT+IG7K6NPDjj4GZLi04YV93WSUrXu4tiT0TG7bRtW0U1Be2S9vTpYUPe7sRNWbh1wOyg6F7nUVw==
X-Received: by 2002:a05:6902:2486:b0:e83:23ed:6a12 with SMTP id 3f1490d57ef6-e842bc72116mr23969453276.10.1750781147041;
        Tue, 24 Jun 2025 09:05:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e842ab0a8d7sm3104977276.25.2025.06.24.09.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:05:44 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:05:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 9/9] repack: exclude cruft pack(s) from the MIDX where
 possible
Message-ID: <aFrM1ngJfL0Ssc9F@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750375803.git.me@ttaylorr.com>
 <6487001f64653d1434890df39b4c4937ea4d0b2c.1750375803.git.me@ttaylorr.com>
 <20250621043551.GA3002138@coredump.intra.peff.net>
 <aFmhQZZnYyvxDelO@nand.local>
 <20250624105447.GA716990@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624105447.GA716990@coredump.intra.peff.net>

On Tue, Jun 24, 2025 at 06:54:47AM -0400, Jeff King wrote:
> > If we do this on top:
> >
> > --- 8< ---
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index 346d44fbcd..8d1540a0fd 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -1614,13 +1614,16 @@ int cmd_repack(int argc,
> >  	string_list_sort(&names);
> >
> >  	if (get_local_multi_pack_index(the_repository)) {
> > -		uint32_t i;
> >  		struct multi_pack_index *m =
> >  			get_local_multi_pack_index(the_repository);
> >
> > -		ALLOC_ARRAY(midx_pack_names, m->num_packs);
> > -		for (i = 0; i < m->num_packs; i++)
> > -			midx_pack_names[midx_pack_names_nr++] = xstrdup(m->pack_names[i]);
> > +		ALLOC_ARRAY(midx_pack_names,
> > +			    m->num_packs + m->num_packs_in_base);
> > +
> > +		for (; m; m = m->base_midx)
> > +			for (uint32_t i = 0; i < m->num_packs; i++)
> > +				midx_pack_names[midx_pack_names_nr++] =
> > +					xstrdup(m->pack_names[i]);
> >  	}
> >
> >  	close_object_store(the_repository->objects);
> > --- >8 ---
>
> And this fix looks reasonable to me. It is a bit unfortunate that the
> incremental midx concept bleeds all the way out to callers like this,
> because it means we might have the same problem in other spots. But that
> is nothing new, and I'm not sure of a good solution. If the
> public-facing API pretended as if "struct multi_pack_midx" contained the
> packs for all of the sub-midx entries of the chain, that would solve it.
> But then all of the internal parts of the code that look at the
> incremental entries would need a separate representation. And I suspect
> there's a lot more code in that latter group than the former (most
> callers won't be this intimate with the midx, and just want to convert
> an oid to a pack/offset pair).
>
> Would we want a test to cover this case? We do catch it in the
> linux-TEST-vars build, but it might be nice to have coverage in normal
> test runs. I'm not sure how much of a pain that would be.

I thought quite a bit about this and decided against it. The extra test
would really just be this on top:

--- 8< ---
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index aa2e2e6ad8..9b71387325 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -842,7 +842,9 @@ test_expect_success 'repack --write-midx includes cruft when already geometric'
 		# actually write a new object and subsequently a new
 		# pack to contain it.
 		git merge --no-ff $C &&
-		git repack -d &&
+		GIT_TEST_MULTI_PACK_INDEX=1 \
+		GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=1 \
+			git repack -d &&

 		ls $packdir/pack-*.idx | sort >packs.all &&
 		cruft="$(ls $packdir/pack-*.mtimes)" &&
--- >8 ---

, to force us to put the cruft pack in an earlier MIDX layer. But that
felt like making this test too-specific to incremental MIDXs when the
original test has very little to do with incremental- vs non-incremental
MIDXs.

I tried to write a smaller test case that demonstrates the problem but
couldn't find a straightforward way to minimize the reproduction. As an
alternative, we could duplicate and/or parameterize the test entirely,
but that felt like overkill.

Thanks,
Taylor
