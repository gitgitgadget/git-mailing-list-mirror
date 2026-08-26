Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA7470433
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762386; cv=none; b=rBpQHIXYNLO8PKNFWgNwfYfk8G31l53cEqisrzAyd6foQCVoEVWQkT56wNykcodvkV1fpyy6fMZ8lPavsKxcW4twNmDDqIqgWM+J4IBo1fkqq6JKOO9AoRMLda6oDXdegoC/K/3VR0ZfnC2pj9s/xmUpVVydMliaHhOeqsZexH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762386; c=relaxed/simple;
	bh=JbENSVki+Q72EdGC+0BC8N8K56Yrtl/v96HgdJhF+Qg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cotl/dLPfrGDkljIPzYCwjfwrDGgViUuA4WH4BYL3JtuwP5NepHgvm4Fi7KvlTsc/BMIK+V3pMFFS5ERcomPuba4PTBDy6mpaoxGe0Wo5HQ4IT0D6k/65rral/5+9lvGD05c9Cfig2TYIX7bp2i7GwMvwcvwwMEM69f+Tkrf+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=buQ22uNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WZVtluUe; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="buQ22uNf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WZVtluUe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 69B471D00116;
	Wed, 26 Aug 2026 12:39:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 12:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787762363; x=1787848763; bh=AMBcy+4tH7
	E/mVYhmpAWChvsPEPMFUmPghQY7vi/2ug=; b=buQ22uNf2rjFHaL4u6vvJQ1zGg
	WEbuvN7ivHzYQ45IEwswT3itLI4WpzxwOjfr8/fNUxWWO1qZkj0u9pQcbkBfhZbF
	Sjz3Hr+2CYfjqGhL2Mz4U3uzm8doLQ3Pozj0DPkHZeV4GSa1RILocTub//p4+xKY
	55/Mkekn2VfupsNnv9nIqqQCwT1i5NZzrqz5fyCkBSYY8kv3SQZAupr+Ku58Hczs
	GrP784+DGiUfcRVDfpU2NIufcm3wYoRl7dbwTei0fBjkZKEieWzpmDA5SZnTOINq
	KCKtt4dWxC13lraSkKYYjX8mdfjHPxj53caYwJQjAvVXQx7bgIRLzdnjO97A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787762363; x=1787848763; bh=AMBcy+4tH7E/mVYhmpAWChvsPEPMFUmPghQ
	Y7vi/2ug=; b=WZVtluUeIMaWC7GKl+ejJiznoaGc2gSNGbPPAnSaCPl5qmJz51u
	DQFDbOMiGl1Gz2g3Zn9IQJeSugoI7tVAhDi3x3/JmlDAb/6TTCGBbsOPvIrfrHjc
	zFbpixz2kMaZfVaN+4uA83UsAXtUNi7fvwjTQVr8bz44++qe0RKF+a7oGlv0uon4
	MCG1BjRhHFRT7x9M3cCdeh+GVt8bpo7+P5b2WBqBXOeKsMpKXYx+cOCskkAzWo3J
	aCsSWrXGDCpNh8jTGvW+pE98IvOlVCUXdpcLoBl5QMW6tpx79gdUOn0qbJtAiiRR
	fXVdymTucJpOokFXzZLdTUidDjuzYLjQDbw==
X-ME-Sender: <xms:uxaPalIxQQg96zXAghMjw534l9iL61BVe4eZGuEfC-laxNWDDKTMXA>
    <xme:uxaPairWSi8ktdbuPPI9OAvNlLXw41ZdKujvbvOBKY9txtSo_V1wcaUfxUmbjUC_e
    m_L0OcL-tEj9yPegTVqvGN48t9rsAWczdq9ePXvMaR1WRrtitnbtw>
X-ME-Received: <xmr:uxaPatyoFG8hB8KJwGF3dTjjqH1E77tEM7Gd46i17s4TqRJo9OCQYNgvhRGy2mMC7cMD4NIH6R-VG7-iKmF4N9JixFm6b0K_bw>
X-ME-Proxy-Cause: dmFkZTELBfJveR3664X5/Ef9DOsfavfnHpAJm8M1OUsrLqGp/u3PYr13fB6h1Y8VP9t8Mg
    VQwaa2OmqCrKkxPnVsLpRVaSz3MKoTHyoBO7fdGRRX1lyzqgWpyUp/xNiNvQoJPIr0KlWg
    sTMCYUBFGL8wFMzOoc7f0GK0nMZaM+koiQzftZDc/S+eIUDSGS4cbf/03Bu7c91IuFyXaR
    7E2jlLJada2bzkvEBrJj00F9Nu34nwnv1XN6nIfKnKe/spQuJj4vLG5W2cWr9uQfOTFLx/
    AoKsIG/yJ5uESbApS2fkiSGaYGTkKTfqiEzPzah2iFxeSYoNtz9wdgHLXWnWHfre16cfNZ
    0Q/vl3iQnERzhRQvLHKni9e08rZAKS/OTLEsnGJYkMmX+gmKvgrohgdlG7X4sMJl0BLZTf
    Vlgv8huBEPzRTvjgoSXDromafrKv61Sq2UaDFP067bDqeINhHccVLmAUXsQza/6kdyXsF1
    8vsjdSjYJXY7VH3K61KeYLDBE1HmA0mKluX4Wsp1ZTbZLWQ1hh+krPPJ5DG45kDhPcN7sp
    n/TVlNkYIkoXRRcJEFPUO1OPkjVDsywIydTFO31a7TOFLYKasOEHKTiTM9lsQ7E9nZYYWr
    CmUJ4fhrmka/Zs8grWQq3tVsBxHtQbXlcHqwbkz2EJrQE6cqkmlEfPjmU7vA
X-ME-Proxy: <xmx:uxaPamPnTVLNfJ3Rjjqec8C3nVBcLj4YHub6fiH2W0-KXlMaoWcmHg>
    <xmx:uxaPai6_i4h6OILouFdWPRsY8U20GIDDFiKywpbfGp_bMP9BAi3b9Q>
    <xmx:uxaPavn7HMsjVRgsZVSqMmqObXYH12T47Jhy0n-AOPaDIyKaPts7cA>
    <xmx:uxaParRZCAYJ4nial57SBcc6pHaoGWYMlJZaMc93vWT7MOhXHI33Ug>
    <xmx:uxaPajdG_LIZFpyJUc40jZtnC6D7U4eNhbRjpdbRQuEQl9uxv7X4JkYE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 12:39:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH] commit: refuse to amend during conflict resolution
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 26 Aug 2026 05:21:21
	+0000")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 09:39:21 -0700
Message-ID: <xmqqqzjkj0p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1336,6 +1337,46 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		else if (whence == FROM_REBASE_PICK)
>  			die(_("You are in the middle of a rebase -- cannot amend."));
>  	}

Let's make a mental note that the function receives these parameters:

static int parse_and_validate_options(int argc, const char *argv[],
				      const struct option *options,
				      const char * const usage[],
				      const char *prefix,
				      struct commit *current_head,
				      struct wt_status *s)

> +	if (amend && whence == FROM_COMMIT) {
> +		char *applying, *apply_dir, *stopped_sha, *amend_marker;
> +		int in_am, conflicted_stop;
> +
> +		/* Check middle of revert */
> +		if (refs_ref_exists(get_main_ref_store(the_repository),
> +				    "REVERT_HEAD"))
> +			die(_("You are in the middle of a revert -- cannot amend."));

"the_repository" can become "s->repo".  The same comment for other
checks in this block.
