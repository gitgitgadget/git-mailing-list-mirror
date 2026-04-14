Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745E4CB5B
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202149; cv=none; b=Yo9YPCpgIGFwrV/jB/vG4BT/t8Kjv8VcNgSCAV4K8cOcwZKUEtU+tIEmachBGmRWDV0Ubay8KUO7RGOpT0SCLvxjHymEsaYbcpB3edfwPUzUkMijex8tDTFbmMAQIEgv28I7uc6xggf0J/4TH08eyrxAuDzL1R5LEq+qA7GW+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202149; c=relaxed/simple;
	bh=ylIUNWrruUP0bfAWUB4iORsiZSQdM6YcR6y9xcaRAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxWDKIf72RTuSFA84NZsGTVTcCIH07Fp3g10+ZPS8m6mzcjKE7bXO/v3e5VdzyUQQEWRVuPbn+Vp5PiGRllPsBdRkzmrKPrYqwyKa+gmpXj+T2MYYYZnTMbZXgU8EdO7TAjcrgcMjVx6LHaAmVborjgs2443kPhGwder3ivk9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=R8+Anz6s; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="R8+Anz6s"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79885f4a8ffso63269807b3.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776202147; x=1776806947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpQ3XFEvPQmwSSxfVkGCmXv/zRBGIqTJs8ZKl38obGw=;
        b=R8+Anz6sXAdEK7I4bfOk3W0O6FzBmzQYN6PlmfQfmN34JYasd4cXTv/Jpv3xCCsi7U
         /5SS9NAg+Ln5Rq2SqXc8h92SCEfh9C+TMbLu/rtPea28U3NRh+nTPfR9rV1cOPzlWgQA
         pkemHgLTZwEIn9/pI845oQ0Rq3VAHRs+FggYOR3p48SP24ABNtSMNb4m1xbm4dufW7+I
         W/KZk22ubJPTJH2u5qY4QxcosPeoK1dUINRoAZQjkUVNJg9lQlzHaKhzEAs9LhhHCjdn
         RmiCIP/KyiOU7azb+/J3Y2HKqDKBBvhcFAbJbTsi9ag27ScirT0iCBIEVckrB1zw8d4u
         Nkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776202147; x=1776806947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpQ3XFEvPQmwSSxfVkGCmXv/zRBGIqTJs8ZKl38obGw=;
        b=jqXio1bNGjBs8b7fPvcrgNGNhBYEMZ6uce0x7P4T0u2gfGOiU9nhgztWYnacb1MQni
         8OwaoPhG/+RW3JdRmUnCr2gFaaLvJuZHwGySHBifObnlWOCLJ6qNLVt98BSzxkbA6H0+
         ev6sHRyxVcL4Deh/qmqb+9g4q3ETMbPUCPx4NiLTJLiVvDLPAAebGeMwRPK6bjOoj7t6
         e1/OLFceBK0nk0q+yt48Xji/hYkRazhHZoeoo6zuw5wMwt+E+dgTKBdWF6NtXCCSVUgN
         YCcVNvGobjvcFNjs7Rlm07pXwzTxGTOZNr56daX1798pQhhr+wUrz6XwGhzEYrnimW+y
         bnDA==
X-Gm-Message-State: AOJu0YwLV/Vq5nIcw9nf4e5D8e3WSMwmwkdSc9mQztNElcDOpQd6cBhq
	DiL/HMkXxkfZg/W72P8EBSz7DJLk3Bgj996AcvyUvvjx7WLZvGc4TtY5qvkcdaWQHzM=
X-Gm-Gg: AeBDiet14JL/4u6t9HkPVH73GaiUNXwo8h0WYv9gxEWBe/I7EQpVXPslI1E+z5Z6s5B
	adfxQj+u9S3GtGFwrBYCVG7WxpCHodNWDJHtZFFn7yi1879sYpg50x0JMlhaAgJzKY5IBICbdHg
	B8hOuvyNyL/pxNgnpbXNs1bHOb+cC098kDDe5L2zek4JtDbGCKEPHXkwaDNsAnR3n4VblEgnugm
	CF1azVLT0jEJ/jnK4kPOZMYjU4k3BEABbOwNd4DeMKSqh7NvnmtOZOtNP7ijfeHs8NEy561gQmy
	54kl/MGh+fv/KDp9j0pxZtnK/cjX6a1wocbr5lBidN5/27/DUcmsM75Q6qvUlflkdYt30UN2HGD
	z7mFGGWidiOnR0CrNNYqIPmZ2miBQQ/HIl6ZDGKED/IAOQeN4kcyN43dvkA49Rt2O05sTdSRlbj
	cWKjnnZJJabHHRqXc+zVrghpj0m8fYLs//EDTDkRtehEjzMqZdbqGnaWr88UBRgUEjycS/Y7VCp
	MBTgi/Y4SuVOw4REzKSHpYQa6FfSLNI1a/9f7mGiVzHJzW6JYUYJX2E1hKYWFU88jPcSn8O/EIV
	Wt+QLYm3pFfC2KLQH5HjfvQ00Ac=
X-Received: by 2002:a05:690c:6009:b0:7a3:7f71:38ae with SMTP id 00721157ae682-7af72823485mr205669507b3.54.1776202147305;
        Tue, 14 Apr 2026 14:29:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b3bfd6a16fsm29051667b3.25.2026.04.14.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 14:29:06 -0700 (PDT)
Date: Tue, 14 Apr 2026 17:29:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/8] t/helper: add 'test-tool bitmap write' subcommand
Message-ID: <ad6xn6KmP3TsdpcH@nand.local>
References: <cover.1776124588.git.me@ttaylorr.com>
 <d5ef6b959fd7c05c73bd33aa2b394558320aceac.1776124588.git.me@ttaylorr.com>
 <xmqqik9t9vby.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqik9t9vby.fsf@gitster.g>

On Tue, Apr 14, 2026 at 12:48:49PM -0700, Junio C Hamano wrote:
> I haven't been paying attention at all to pseudo-merge stuff, so my
> comment may be too trivial and/or misses the point, but please bear
> with me.

It has been a while since I have thought about pseudo-merges since I
returned to the topic with this series, so bear with me just the same
;-).

> > +	git init bitmap-write-helper &&
> > +	test_when_finished "rm -fr bitmap-write-helper" &&
>
> A tangent but the above two lines may want to be swapped.  "rm -fr"
> does not fail when bitmap-write-helper directory does not yet exist,
> so "prepare to clear anytime it fails from now on and then create"
> would be a safer order than "create, and prepare to clear anytime it
> fails from now on".

I agree. I vaguely remember discussing this on the list with Ævar years
ago, but clearly we should register our cleanup handler before we do the
thing that needs to be cleaned up in case it fails part of the way
through.

> So we bulk-created 64 commits, repacked into one, and then
> [...]
> wrote the tip-commit in "commits".
> [...]
> And told the new tool to write a bitmap file, with only that HEAD
> commit and nothing else to get bitmap.
>
> > +		test-tool bitmap list-commits | sort >actual &&
> > +		sort commits >expect &&
> > +		test_cmp expect actual &&
>
> And compare the list of bitmapped commits with the singleton HEAD
> (it is puzzling to sort a single element list, though).

That's right.

> > +		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
> > +		git rev-list --count --objects HEAD >expect &&
> > +		test_cmp expect actual
> > +	)
> > +'
> > +
> >  test_done
>
> If we look at the implementation of bitmap_write() below, the object
> name for HEAD is fed to bitmap_write_push_commit() with pseudo bit
> off.  After reading the list (which has only one element), we call
> select_pseudo_merges().  What do we expect to happen in this call?
> Since no bitmap_write_push_commit() call is made with pseudo bit on,
> we will return immediately without doing anything?

In this particular instance, nothing should happen, and this test
isn't directly testing the pseudo-merge selection at all here. We don't
expect any pseudo-merges to be generated here, only for us to limit the
selection of which commits get bitmaps.

> After that bitmap_write_build() is called, and as this is expected
> to add bitmaps to the commits fed to bitmap_write_push_commit(), we
> are expecting to see bitmap given to HEAD (and nothing else)?

Yes.

> I said it is unclear what is being tested.  Putting it another way,
> what could go wrong to cause this test to fail?  We give commit A,
> B, and C to "bitmap write", and it somehow chooses other commits to
> also give bitmap, which will be reported by "bitmap list-commits"
> and we detect that as a failure?

That's right, and to the point of your original question, I think a
better name is warranted here, perhaps: "test-tool bitmap write limits
bitmap selection" or something.

To the question of what it's testing, it's testing only its basic
functionality of altering the selection of which commits receive
bitmaps. In that sense I view it as a smoke test of that basic
functionality more than anything else.

How about:

--- 8< ---
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 9489e59fa55..ea94735fd66 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -649,8 +649,8 @@ test_expect_success 'truncated bitmap fails gracefully (lookup table)' '
 '

 test_expect_success 'test-tool bitmap write' '
-	git init bitmap-write-helper &&
 	test_when_finished "rm -fr bitmap-write-helper" &&
+	git init bitmap-write-helper &&
 	(
 		cd bitmap-write-helper &&

@@ -659,12 +659,12 @@ test_expect_success 'test-tool bitmap write' '

 		pack="$(ls .git/objects/pack/pack-*.pack)" &&

-		git rev-parse HEAD >commits &&
-		test-tool bitmap write "$(basename $pack)" <commits &&
+		git rev-parse HEAD >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&

-		test-tool bitmap list-commits | sort >actual &&
-		sort commits >expect &&
-		test_cmp expect actual &&
+		test-tool bitmap list-commits >bitmaps.raw &&
+		sort bitmaps.raw >bitmaps &&
+		test_cmp in bitmaps &&

 		git rev-list --count --objects --use-bitmap-index HEAD >actual &&
 		git rev-list --count --objects HEAD >expect &&
--- >8 ---

Thanks,
Taylor
