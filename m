Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A80E32F77B
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625209; cv=none; b=gGc9DO8Vi2uo89TrI+76uteHEMOLQyBcZRCYdUG3AEffvctKx9ac3FYwdOsWIDXNT0g7GmjD4lgEodAUtz1LIKTw/PkRE7JYHbn34eaBQOxA5zmurdoccMMVeIMF5UhSeXN0LfPf7wFJf+lVy6vzCGuxHmZ+BFkrGAcMWH2sc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625209; c=relaxed/simple;
	bh=ruqo6N7j+MpPiMwjXCRkoThpJA0pZSKOxHQ+6D80cj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfUpnqc36RhXPAKoS3ITMNE6jd4sFWA32i6N/KmpZeqKVma54TiBBg6J5f9uHXVjHm6Yc4CBDr0cL+TKhHKg6dBhxSaqaRId7U/h5U8NgIG5ScwkyfR4s5T4Fo5NeH5aktFZ+DVWAHc9dZWyE6iJYRTwpiRMyXsf88HvfDeqqEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b+shw7zW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZ/LGgcf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b+shw7zW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZ/LGgcf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6ADF91D0013D;
	Mon,  5 Jan 2026 10:00:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 10:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767625206; x=1767711606; bh=Qe2nkY2Cou
	gZJcNuSdwTMylfDpBm90LaShaYocujJMg=; b=b+shw7zW8WVGIuvtoP8lvMhT74
	K5MgbybxQkeqCvBqQ5tufl9Pu7X73cGxrh1HWZUAlhs4EOp49eub41utSKQlh6jK
	ciqXvOf1z/kf+VGArhRxzIKUX+NBCZMOAgsm6rMLsH4F1qSY+Vm49TWnWBnIvdbH
	RaQUcNEDavWBmpZGSNG4M9lJS2aRReuxExWBLZGxx6r+KdRrK9Ij5CD8hjfwEzXx
	NCvE7R/ZUSXMElLxBnfkOQw1mYk90z0CKJHW2wbnGsGk4r5greoMZUSz2TGfQlfV
	4P4F9FTwPTRWXA0j0cI77CjIAfD3feovs3I0t14MSCbRBfUT2BF5IZluvZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767625206; x=1767711606; bh=Qe2nkY2CougZJcNuSdwTMylfDpBm90LaSha
	YocujJMg=; b=RZ/LGgcfa7NnNIpfuLG1dHkOs3dSzIAXsHm7Qo9c+Vd/nnU+eLW
	pCjuC2g5AekBhRjH5Vy3fM5fDwaiZjPdAk4MU+09z9Y/PDQHX/NahFUuMVKcaduq
	53fQz6KlTMXQr0ZW8G0G4XLN2reKzMmIKojZEAja60pW8pPSR2K26AuEjORB6Elm
	bO2ezAGPH5AT4CNg09Um8HySLPXzE2Coj4GQIhaH62pJFvFCRZnqeJYAC8MN4IF5
	yY0ZaKew/5CBZeuKeGtb+KtweSNPBjfz+klmfk8L2Gi9WqPtW5LyTiGOqnjpTYoB
	WUmfI2GcwlxMVsG1P5rF8NEqRIzpJUf8PtQ==
X-ME-Sender: <xms:9tFbaZbH1T1VmCN2r06LsvrsgIYkeTWPyKI4hy_teWXvKnvRe0KM7g>
    <xme:9tFbaWZeMlATqKn0h5f75EwTFm6bCOeYvrz4bjaEOxz7GhM677w8hUzBNBRAykd4S
    pL2O0agkuDu5MySLl25Ld4kVfZSLXI5Y_TmeNvwey1tGbacAYffPA>
X-ME-Received: <xmr:9tFbaZnLkhRMjHWUSlS7xYcC5mYwFnPGTIW90P5hLCn513JODjrqMl3oN0l3kMneXYOFOpJVlKbxiXz5XJj2zyWaRyvUwfe_KtFdaBqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffleeghfeufeetueetvdffkeeggffgteevjedvvdekiefgvdeiueduvdekveekteenucff
    ohhmrghinhepvhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgrhhhirdgvlhhkrgihrghmse
    hprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:9tFbaSxvUixA2K6LNfgmhaYb9JM2FPJk2_Ud3QkNz6TyEG5VK_BXfw>
    <xmx:9tFbaXNbUX2hYNBue7P1JoT2ggNjBWAluo5DVrVkUtCxe-CZ6HSEVQ>
    <xmx:9tFbaWQtaRm_GJEdUiCazlHlhnqWczkRTSx7OWHLUDCK_-b_etCCxw>
    <xmx:9tFbaVbeVLw-7nZ8VxPSXp_f-MKnTynAxHSJ7pKDlK_gS09Ux6YhXw>
    <xmx:9tFbacxYhKRXWkhJa03FQXMNLkQiXBOcf_KIH8tvrOlc1-dGSydS8204>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 10:00:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id abed2b11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 15:00:02 +0000 (UTC)
Date: Mon, 5 Jan 2026 15:59:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v2] reftable/iter: fix undefined behavior in
 indexed_table_ref_iter_next
Message-ID: <aVvR6U6EJ9wfKk8l@pks.im>
References: <iaPdageDbUKEIQVlnOugIRhoojxnFo3j-WJFWY0eC5el1Epu3sxEnto6Lrd3bhAYL0Ry8T3czP5UPhLHX_gfWCDiCoLuMofdRkqfOSYP-Jk=@protonmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iaPdageDbUKEIQVlnOugIRhoojxnFo3j-WJFWY0eC5el1Epu3sxEnto6Lrd3bhAYL0Ry8T3czP5UPhLHX_gfWCDiCoLuMofdRkqfOSYP-Jk=@protonmail.com>

On Sun, Jan 04, 2026 at 10:46:40AM +0000, Tsahi Elkayam wrote:
> The indexed_table_ref_iter_next() function accesses ref->value.val2
> without first checking the ref's value_type. This is undefined behavior
> when the ref is not of type REFTABLE_REF_VAL2.
> 
> The correct pattern is already used in filtering_ref_iterator_next()
> which checks value_type before accessing the appropriate union member.
> Apply the same pattern here:
> 
>  - Check for REFTABLE_REF_VAL2 before accessing val2 members
>  - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs

One missing bit is to explain what this is actually supposed to do. That
is, why do we even compare the data?

> This was marked with a "/* BUG */" comment indicating the issue was
> known but not yet fixed.

That's an indicator that something was wrong, true. But it doesn't
really say what the bug was. What puzzles me is that if the bug was so
easy to fix, then why didn't the original author already do it?
Unfortunately, blaming the line points to 46bc0e731a (reftable: read
reftable files, 2021-10-07), and that commit doesn't really provide much
context either.

> diff --git a/reftable/iter.c b/reftable/iter.c
> index 2ecc52b336..2eee65bb1e 100644
> --- a/reftable/iter.c
> +++ b/reftable/iter.c
> @@ -171,12 +171,15 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
>  			}
>  			continue;
>  		}
> -		/* BUG */
> -		if (!memcmp(it->oid.buf, ref->value.val2.target_value,
> -			    it->oid.len) ||
> -		    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
> +		if (ref->value_type == REFTABLE_REF_VAL2 &&
> +		    (!memcmp(it->oid.buf, ref->value.val2.target_value,
> +			     it->oid.len) ||
> +		     !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)))
> +			return 0;
> +
> +		if (ref->value_type == REFTABLE_REF_VAL1 &&
> +		    !memcmp(it->oid.buf, ref->value.val1, it->oid.len))
>  			return 0;
> -		}
>  	}
>  }

So let's take a step back -- what are we even trying to do here?

The indexed table is basically a table that provides reverse mappings.
Given an object ID, it allows us to quickly look up any reference that
points to this object ID. We don't make any use of that feature in Git
right now, but historically it was designed to speed up
"uploadpack.allowTipSHA1InWant". This setting is a lot less relevant
nowadays, as most forges set "uploadpack.allowAnySHA1InWant" to support
partial clones.

So this interface is somewhat confusingly named, as the term "index" is
overloaded: we have the "ref" and "log" indices that enable fast lookup
of those record types. But what this here refers to is the "obj" table.
Oh, well.

The iterator for those objects takes as input the object ID we're
searching for. Given that object ID, it is expected to yield only those
ref records that reference this object ID, either peeled or unpeeled in
case it is a tag.

In the `next()` function we essentially have a nested loop:

  - The outer loop iterates through the "obj" blocks. This gives us the
    offsets of the ref records that we need to look up and that contain.

  - The inner loop iterates through the records in the "ref" block that
    was referenced by the "obj" block.

Honestly, the whole logic doesn't really make any sense though, as we
never filter by the caller-provided object ID at all! So we still end up
churning through all references, which kind of destroys the purpose of
this whole "obj" reverse index. And that's also why we have the check:
we verify that the object ID of the reference we have looked up matches
the caller's query.

So the fix you have here is correct: we may end up with a "ref" record
that is unpeeled, and in that case it's wrong to treat it as a peeled
one. And if we fix that, the result should at least be correct and void
of any kind of undefined behaviour. But the whole infrastructure is
still quite broken. What we should be doing is to:

  1. Seek to the obj record that has the desired object ID prefix.

  2. For each obj record starting with the desired object ID prefix:

    1. Look up the respective "ref" block indicated by the offset.

    2. Iterate through all "ref" records and yield all those whose value
       or peeled value match.

  3. Abort once there are no more obj records matching the given prefix.

All of this is naturally outside the scope of this patch series. I'd
argue though that we shouldn't just remove the BUG comment, but instead
add some TODO comment that explains why the current logic is still very
suboptimal.

Thanks!

Patrick
