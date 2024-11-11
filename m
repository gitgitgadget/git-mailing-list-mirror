Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5218E1F
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304505; cv=none; b=n9w9FBqPE/VImNBCFBeAe1X5gMULkkJjLLo9Fj9j6P7bIRbTOxY1Fr/udRO9W2m0avexeFre2e6ujfDSLPJxjYMWKXxkbYciH66Jk/jB/iR0tBGI3Gc6e9/TkXK4rY+XCP4eb7SaJgMOqodFyAVubWpxy8EyMUXOlo6T0Lg+x3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304505; c=relaxed/simple;
	bh=BLQxX9zM14DPklnV0ZbmOyHHt3YpPLutrcfAR8/kXIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kcflKdaa2XWuQrGE8tTn0l1e32xZjFCJ3GRW7utM6BF9SDdaBC2Zr3IjKdU6HdxcVwvVTC/uNkKR7TupGF01DyP8Re0A22HEun5VwtqV3XmxesvIbVjtGPgiY2cwCJjzB/UIj/2N6DKXyNwJXJQD8rzhjd17QiefZ95rnvP4Cvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X3LfQgUd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPomxfrj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X3LfQgUd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPomxfrj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 818DE2540188;
	Mon, 11 Nov 2024 00:55:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 00:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731304501; x=1731390901; bh=3zveUGQw2t
	0jmK0P0K1gqoSuBnfPA9FLDF7A2IopC1g=; b=X3LfQgUdIUaW4vZ8boJAjnxd9K
	bsLRdNvbZufDB6dtlTzOfJ3L1YcEqcOaz0rMN9InpTnWeAYYmbwngTZYkOu+iW/P
	rznk4qivkK9jTv9CiI6IAhJKRhlsLe+LoDXZ8jv0gFjqRq619eZs78lvPC5W14ce
	soTH8Pgeonk1Dk66pxIr6xmliSE/JGnqfybHC1cAjjYUdBRVWIboCbzaOrYZ6dFE
	lU0r9aT8jC9rAsxd24nov+Cgp/wXLy00iBYZd2qEDegEfvsmD51TcPMEN4Fhwq7J
	gWIjgxgdeDd03ZrLy19TAAcIY4FuyHl8lSLR57YJ+6YCCdJ0Z8QunM9gUoUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731304501; x=1731390901; bh=3zveUGQw2t0jmK0P0K1gqoSuBnfPA9FLDF7
	A2IopC1g=; b=FPomxfrj4Tuwm3v1ZCwu/K65fu+kimibxGJ3I4sZBxaCWNRM30Z
	zlots+Lpxo608gVOF//yMuViszfOA3dqNyCM2Hs1mkZJS4AvdkRPkOEMpE318sGj
	zs6VF7k4Dggs50HregKhZRUw+oKPhkqeFiZqXdIyob7OXbYPMAMOkMsQbnur+wTg
	k62K2qyet1PYs5PtX48nQphFtcEWWo98ZXVJGxcTwNBe3OIId6eCYQrjbCakeEhC
	kt3OLWqQoq6+ltm26rA0LnoqYMKaD9jdw4x/05cjd7PG0ZajYE29L2fl3Bby6GT/
	bdXiaLbXA+A4uzb3Q450N62ZX2HXQCZfCxA==
X-ME-Sender: <xms:NZwxZy0_P1GBuuWTJGpj5p3nvL-vS_MkC5p5Ny5JK9-4d9_p76L3pg>
    <xme:NZwxZ1FwIvb199zzUEqwWnhYLWvTEo5zr5HA9plcVRiBs7O10IfZtg4kNyAdtucln
    aM6kUjC1LBeX7R-ww>
X-ME-Received: <xmr:NZwxZ67wnn34JKErawxnguaMeANPhdGFIWoxMrwHu_9yRovP86S2oECmhvnnLhTUa2re9tIaM6qUuV7tMzZ24DlYGJXdnaud8i2L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohgsihgrshdrsghovghstghhse
    hmihgvlhgvrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NZwxZz06NFJmF_80j2igkaFoktAG3FKrYnBiXG7VMytP6EsXAdmj6w>
    <xmx:NZwxZ1FeD78-kmNHysMHYN8wucxUd1pkuR-_RjCFfzLbNt87n4eXzg>
    <xmx:NZwxZ8-K2tnixmhq3Ssf3d5b0wPUgR4FDumb4U-fKdHcpkJcACSlGQ>
    <xmx:NZwxZ6mlNAajVzASl_kGpsYwSjc4Bnj-miYGKkApWG5dA4USMaZGog>
    <xmx:NZwxZ-MmQDqz1kxasFFbtM1S1uhD1aaAArSm8a356cjK2ofeMRxIH4Im>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 00:55:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  ToBoMi
 <tobias.boesch@miele.com>,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [GIT PULL] git-gui pull request
In-Reply-To: <91307087-2934-4037-b4c3-9691f8540c12@kdbg.org> (Johannes Sixt's
	message of "Sat, 9 Nov 2024 14:50:53 +0100")
References: <91307087-2934-4037-b4c3-9691f8540c12@kdbg.org>
Date: Mon, 11 Nov 2024 14:54:59 +0900
Message-ID: <xmqqbjyme2mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 2864e855932540c3ec6c9bf41ee3fe027d85f642:
>
>   Merge branch 'os/catch-rename' (2024-07-07 14:14:59 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git 
>
> for you to fetch changes up to e5033898da23b6e2f6b77320bd0aa613595a50a1:
>
>   Merge branch 'ob/strip-comments-on-commit' (2024-11-09 14:37:45 +0100)

Thanks.


>
> ----------------------------------------------------------------
> Johannes Sixt (2):
>       Merge branch 'tb/mergetool-from-config'
>       Merge branch 'ob/strip-comments-on-commit'
>
> Oswald Buddenhagen (2):
>       git-gui: strip comments and consecutive empty lines from commit messages
>       git-gui: strip commit messages less aggressively
>
> Tobias Boesch (1):
>       git gui: add directly calling merge tool from configuration
>
>  lib/commit.tcl    | 11 ++++++++++-
>  lib/mergetool.tcl | 21 +++++++++++++++++++--
>  2 files changed, 29 insertions(+), 3 deletions(-)
