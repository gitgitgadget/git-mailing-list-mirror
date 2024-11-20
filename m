Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80BA19D063
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095913; cv=none; b=fiQ3ULGLw19YFd1q0roaBmzPoCbwvyUgUM+ZrAp7O5KWGJfMh7NeQfzqePIEb/ksvxE+YrqOOjrI6Ak+zzPNBhXRamfp3yXLWluMHyiJwWQ/zNxwqPZQCoXhyeM49MtDgxi5ESAIRp4Cq+toZfZ/SQiyDQfdhuhTD3FP1Q/pa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095913; c=relaxed/simple;
	bh=BzXiOm7/Kr3qa/F2FTk+PAvQVqYIXUUKh7N8BPmUtdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEkpB+kOCbm5DdutHicexWcDa9mUNF+96cBti7gYSknUYEJ7u/nqK6Vd1hZgHblbXLeFyk1NJP21mNnCzRZzIDZlzrZpmHt4ObVfun7cFYPKCvgyGIXwia74W4or2E/rDwPpbm1T4KNzncNV8bmz9JO+2PkuzrUZIS0XZxfVMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HZEqImRl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uEaHo02f; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HZEqImRl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEaHo02f"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9F2B114020E;
	Wed, 20 Nov 2024 04:45:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 04:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1732095909; x=1732182309; bh=zZDC8zwPZv
	ly3GwXHuoQYqa2+/bxzX2EXK68K6kvELM=; b=HZEqImRlfKTzUwHyn4Bn5aYeYn
	yPU38+5RaCrP6aLqCKtEzfKs5NIYnfL8e8RGH8txccF1m+KJ3zy4fyi0CK5sXd5f
	xpylz8EAlu65yZr0H7s8OeFtjvxjkwpqYxYy5j7pXNGwiGa/M1TWzOC33QfbR91N
	5reQRAj8LkrpjaxEV5spTCHgUetX4Q3Am2mLlSurxJZKZMVhjDnHuVJ7BixKHlAg
	KLqBftwdjHuV8rNEj565nhrja5kiOaEpC7JsOExF81nVQkIz5odrwXLIy5/SpgMa
	1IZ98klyL2HBqKXIi7p5CnswJv13/2B+MTaZzBunJJTx3cETygC+907Wyi0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732095909; x=1732182309; bh=zZDC8zwPZvly3GwXHuoQYqa2+/bxzX2EXK6
	8K6kvELM=; b=uEaHo02fWoejtNm6fq8pejA+/qA+6qigbWnWVduGUc8o/QYxwk7
	Uy8+3rnBSxgTGMIsyZ8yu9hnltqa94fszbLZoVTjJs9w83xuYbk+KAQzkBsYrVim
	a9xyAo4K6OZ/6TytNX0msTU3n6PLDvtcSdXZWw6Fmsc1TTtNZ9AED8D5ttwxHtrO
	CHyXURYVBnxSknPHR5jsz0/hHajb3YIOL+YOr7qoxHb/X4yItjTdEUya3MDJ9Q0/
	+ylD0I999IO5aVhfQwf0H2TdUjO1vlXvILtbOs59S0yfUASDkNAS6pvRvKK7KmPe
	twz/f/eBCULE1Ri2UL2UpzHvNKX+8x3ScQA==
X-ME-Sender: <xms:pK89Z-CQZ-tE32Ti5hFCaWDNge7-VaKQ8KZzzqb19n_Qxx-4dSQ9ig>
    <xme:pK89Z4gLuF2gcWURouo0MKrrHsAALEygPxoFxeBtHcsIr3NqP6jKU4_MG9zBFNyt7
    qAIGSv8Ezi81kcCFw>
X-ME-Received: <xmr:pK89ZxlxecrqCXFupoZMVNtlS065G6VhzaVrg8dO3pDqOgBLSobfQMQQY-ZCLfsexmuvkFcgrOigy1aegUjZ8Vg-h1CWKrIsR3lgO3TL6KbiSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhs
    rgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesth
    hugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:pK89Z8wJQYcLcp3sw5CsACbQGpvZ39Si4NNVPY5bnkpDWplnQUoXWQ>
    <xmx:pa89ZzQ40jG7SHstnsfPNj02WPPvgGU2g4NQDzC-ms99-1RUHpgLjw>
    <xmx:pa89Z3ZC130yWBnClpspMp9RdgVbE099K-QvgeGvj6pg3eFIjV0Jmw>
    <xmx:pa89Z8ThwgVedF_8DXQJw2l0K9luiTR00SQZPrG-SfwX7FqOVFBiSw>
    <xmx:pa89Z4I_x9JrIQdnsU9p1hKBoYW3kUC1C42aV-9FWWB3vYESL9M1oIm5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 04:45:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 58a2e78a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 09:44:13 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:44:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 03/23] Makefile: refactor GIT-VERSION-GEN to be
 reusable
Message-ID: <Zz2vkNtvoKayaZyT@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
 <20241119-pks-meson-v8-3-809bf7f042f3@pks.im>
 <xmqqjzcy7ehv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzcy7ehv.fsf@gitster.g>

On Wed, Nov 20, 2024 at 12:47:40PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +GIT_CEILING_DIRECTORIES="$SOURCE_DIR/.."
> > +export GIT_CEILING_DIRECTORIES
> 
> Interesting.  Presumably this is to prevent a foreign project having
> a tarball extract of us in its subdirectory, which would be a good
> protection.

Yup.

> >  # First see if there is a version file (included in release tarballs),
> >  # then try git-describe, then default.
> > -if test -f version
> > +if test -f "$SOURCE_DIR"/version
> >  then
> > -	VN=$(cat version) || VN="$DEF_VER"
> > -elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
> > -	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
> > +	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
> > +elif { test -d "$SOURCE_DIR/.git" || test -d "${GIT_DIR:-.git}" || test -f "$SOURCE_DIR"/.git; } &&
> 
> The line has grown a bit too long...

Fair. I wonder how this is supposed to be formatted in the first
place... I'll get creative.

> > +GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as')
> 
> This needs 2>/dev/null to squelch the case where we have no
> installed git.

Will fix.

> I suspect "%cs" is more in line with the spirit of GIT_DATE if I
> understand its purpose, i.e. "this is the time this version was
> recorded in the Git history, with the intention to give it the public"
> and better than "%as".

While I agree with you, I'll leave this one as-is for now because this
is preexisting logic. But I'll rearrange a bit so that required
placeholders are only wired up once they are actually used so that it
can be seen where they come from and that the rewrite is faithful to the
original logic.

> > +fi
> > +
> > +read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
> > +$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
> > +EOF
> 
> And because GIT_VERSION generation is safe above, this probably is
> safe, too.  In the ancient days, we had tags like "v0.99.9g" which
> may not match the above convention, but with the understanding that
> we establish an official convention going forward (i.e. we allow up
> to four numbers, the rest is discarded so do not use more than
> four), it is OK.
> 
> Who wants these broken-out versions and are they fine with
> up-to-four limitation?  Just being curious.

The only user is "git.rc", which is where the limitation originates
from.

> > diff --git a/contrib/buildsystems/git-version.in b/contrib/buildsystems/git-version.in
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9750505ae77685ebb31a38468caaf13501b6739d
> > --- /dev/null
> > +++ b/contrib/buildsystems/git-version.in
> > @@ -0,0 +1 @@
> > +@GIT_MAJOR_VERSION@.@GIT_MINOR_VERSION@.@GIT_MICRO_VERSION@
> 
> And this one seems to discard the fourth number, so those who
> prepares VN to contain the fourth digit to differenciate a new
> version with previous ones would be disappointed.  Similarly,
> because this requires the third number, we cannot change the
> versioning scheme at 3.0 boundary to say "3.1 is the next version
> after 3.0".
> 
> As this is merely setting the rule for our future, perhaps we want
> to be consistently allow and require N dot-separated numbers
> everywhere (e.g., we allow and require 3 numbers, not 2, not 4, but
> exactly 3 numbers)?

Yeah, being consistent would be nice indeed. But for now I'd prefer to
keep this as-is because we'd otherwise change the version schema used by
CMake builds. In theory we can use 4 numbers here, too, where the fourth
number would correspond to the `PROJECT_VERSION_TWEAK` CMake variable.

Patrick
