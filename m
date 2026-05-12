Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E72E413
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549928; cv=none; b=T8p9mvVCRpd5WXp2vK8aWIktrZp3+Vg0UEl9jZ5thIbq/34ngol+pS3k1fbf1JcaWctbXCtWJ/Vs2lgv1healLUBwT8UljhXjUrFrhLnYvsyHlnGLZMVYzZN1WouEFd4+/V5M78hKLqZKomK1h6VuilY0B4x+WoMwrJLR7fjAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549928; c=relaxed/simple;
	bh=bhYKVssR5gSu0o5viiGEHUrx6Ns21hUdtcUBHz09QKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jxo9ok1T2PVZqNL/hu6by1I8gsB9PKG2AwV/9An7lOn8pMSR80PuyAb3rh12WgY4Oa+P8rrJJVDsDognFaFUdmWcNfJEqHtwTWlnTZMVbUai3uKnt698qc7zxmrA7xeMWGNlEVNvqBQN8Ya/+8/zftKNGHgP7w1q6G81ubcipX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u5Pg1MWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YIjjdEZX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u5Pg1MWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YIjjdEZX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F2BC81D00115;
	Mon, 11 May 2026 21:38:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 11 May 2026 21:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778549925; x=1778636325; bh=asA+kebp/C
	EJqJ3KhqobJTrq6nZD+8NdXe8AH93i8Q4=; b=u5Pg1MWSykTkTT5MuRX+qgnUHD
	Vwn+3qYleXf18Pzyj89DkR0waA+BQzelkzpFaRPuqb5GjlNHV2h7fCBmCjR30hlW
	raf9/NNPISngJXZUD9XMK6TM8zumS+WvH4MUSpW/m4awZLFPqmYTzEHPqsQuPzl7
	4dX9WH92ulq9MtENbnnchGQ91m0UyuDwmanbEUS17SjNmp50CFX5UvJBX7WBMAmZ
	C/GS+72Gx+T25tFFnucBULKSTuCaYBi/ypva+Irwa7YGwfbR9mC43MFMlybVBve9
	Iy365XPHn++2uj4gLc0XyE1iSyTqznN1eGaX/QOBuR2qa1zhFDEOn4VRl2OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778549925; x=1778636325; bh=asA+kebp/CEJqJ3KhqobJTrq6nZD+8NdXe8
	AH93i8Q4=; b=YIjjdEZXJU3kbf3a8z/lVCwYRdafUgXy4xooEGYXQ7rcMLNlj6p
	IvgMaTr+TcGtG2CpfGx9k4Mq/x6oaIZlG4PEa7JmoAK2PDetAfvCmgAJj3QtKIHX
	+uh76YbRRYIOQzIq9QJMJxwKmlzkFEZ/XDKtzxIU8OVA2bl24kvoeq4Rxx93YEdo
	BRjVNJo/fs2Z3JhPnApzkTvnZvA8xSNFH/Q3PoJg8RCO/yD+8llUFgIkaKeoSn/z
	ydlQM5PDpxpX/oSko9albGLm3my6JzPJ5l3f+L5N72IJsJ9MzvmXT1SrNi1uDp/g
	YrsOzDe62j02mMVzx7ZHaOTeek27BmRgnKQ==
X-ME-Sender: <xms:pYQCaoOcm0Dvr9vatO-vwodFvzvFVHSKWTxda4DUr1NvJEB4qjOyvA>
    <xme:pYQCal080E6tKy20jgkv2Uvr9JUk1n2eIFVM9uRRLOMOZ1ySeugsO6LaEKUFz-iZF
    bpZlcTAO4unvxuzfEvHWwDav8IcvnCJ-Dga6LV8u-91LIiEZ2W2>
X-ME-Received: <xmr:pYQCannUs5MHi-VNgHAKc86-k3dT4ZVo8bpCMyYLWfv8kSRwTZpt9dFT-u64vk7M2tkpuSXuoxrVIxPB_lKds617helaqlT65w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pYQCasVXo8dA2rOmEfXNeZob0aGyNMa17dmXxPtr5heOK1RbANjK3g>
    <xmx:pYQCatsZGbaqMulD4pYjYhciS4zBAfGBG38sn4xtpUS9-mEWaD0Zgw>
    <xmx:pYQCavYdy9kmPfa-BfIW7gejveaZPupf9_DJdUYcM0oXlaD1JDm_Ag>
    <xmx:pYQCasUNaIHaZH_Fq6BIMwkmCaYr-vvmOKBtAiSAp-4I0765Ix5BkA>
    <xmx:pYQCao1HvHAxClJDPPLWyCNzKHaLJw22TBlDKEBzii_tbunU6i0OQn39>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 21:38:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 0/9] pack-bitmap: fix various pseudo-merge bugs
In-Reply-To: <cover.1778546804.git.me@ttaylorr.com> (Taylor Blau's message of
	"Mon, 11 May 2026 20:46:44 -0400")
References: <cover.1776124588.git.me@ttaylorr.com>
	<cover.1778546804.git.me@ttaylorr.com>
Date: Tue, 12 May 2026 10:38:44 +0900
Message-ID: <xmqqse7xpftn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> [Note to the maintainer: this series has been rebased onto the current
> tip of master, which is 7760f83b597 (Merge branch
> 'jc/neuter-sideband-fixup', 2026-05-11) at the time of writing].

A note like this is very much appreciated, but please also state the
reason why the rebase was necessary.  "Because the current tip of
'master' has advanced" is not a good reason.  "The previous
synthetic base was made by merging topic X and topic Y on
then-current 'master', but both have graduated" is a so-so ok
reason.  "Because the updated implementation of this series uses
facilities that appeared in recent 'master' that come from topics A
and B, which the previous iteration did not use" and "Recent updates
to 'master' brings in conflicting changes from topic C" are
excellent reasons.

> Range-diff against v2:
>  1:  c0df35f8ebd =  1:  9c7a829cbeb t/helper: add 'test-tool bitmap write' subcommand
>  2:  11de3343726 =  2:  d1ed4aadf75 t5333: demonstrate various pseudo-merge bugs
>  3:  8d908ab415e =  3:  bf3a9a07e5f pack-bitmap-write: sort pseudo-merge commit lookup table in pack order
>  4:  07f70a07c20 !  4:  a1d341c92eb pack-bitmap: fix inverted binary search in `pseudo_merge_at()`
>     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'apply pseudo-merges during
>      +test_expect_success 'apply pseudo-merges from multiple groups during fill-in' '
>       	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
>       	git init pseudo-merge-fill-in-multi &&
>     -+	git init pseudo-merge-fill-in-multi &&

OK.

>       	(
>     - 		cd pseudo-merge-fill-in-multi &&
>     - 
>  5:  3ed0b39843f =  5:  06e3410d323 pack-bitmap: fix pseudo-merge lookup for shared commits
>  6:  95f847211f3 =  6:  78cf7e6d80d pack-bitmap: parse commits in `find_pseudo_merge_group_for_ref()`
>  7:  f8a01cfb893 =  7:  4dbf6686718 pack-bitmap: reject pseudo-merge "sampleRate" of 0
>  8:  c37156502c0 =  8:  46d0ee2f168 Documentation: fix broken `sampleRate` in gitpacking(7)
>  9:  b905fd5d0ae !  9:  9b17dab2cf7 pack-bitmap: prevent pattern leak on pseudo-merge re-assignment
>     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'sampleRate=0 does not caus
>       '
>       
>      +test_expect_success 'duplicate pseudo-merge pattern does not leak' '
>     -+	git init pseudo-merge-dup-pattern &&
>      +	test_when_finished "rm -fr pseudo-merge-dup-pattern" &&
>     -+
>     ++	git init pseudo-merge-dup-pattern &&
>      +	(
>      +		cd pseudo-merge-dup-pattern &&
>      +
>     @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'sampleRate=0 does not caus
>      +		git config bitmapPseudoMerge.test.threshold now &&
>      +		git config bitmapPseudoMerge.test.stableThreshold never &&
>      +
>     -+		git rev-parse HEAD~63 |
>     -+		test-tool bitmap write "$(basename $pack)" &&
>     ++		git rev-parse HEAD~63 >in &&
>     ++		test-tool bitmap write "$(basename $pack)" <in &&
>      +
>      +		test_pseudo_merges >merges &&
>      +		test_line_count = 1 merges
>
> base-commit: 7760f83b59750c27df653c5c46d0f80e44cfe02c

Queued.  Thanks.
