Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338212309AA
	for <git@vger.kernel.org>; Fri, 16 May 2025 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747435746; cv=none; b=NbGkVhX6aTbOjJ+XdFY7Ia+6A3RudOdEbteDlIEEInQCAh3lJGzI7tShtYExNUhM6R+HjzyGE8GsTKocp9eIiX227eTeJMQN70wSqJFslMwIw68Xxfz0usi1Zop0dRiScqC9vja8+PrvO3Yf2JWXg4V/jGJNp+ohpgOaB3Aho4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747435746; c=relaxed/simple;
	bh=2CdxQkyeprvqbxkysmo6GvwMpm6+Cf+WeOT6ALVk6o4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHE4YrEyXnV/fMIs4GzYLGJL60GhARLguP2p1o/o2bUWfZw3zLfkuWe6rDk4qp7QWoezREiQK/j/Ur0LGkPdA0dDc3AEyt+JyESqohWOBrj6zmdSfrCPP/8Y21JvEQLPnAQPEn/r9rTVcUCAPG27lzzoDmUpOZlC/dgKIlmtIFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VwGhfUyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YxEHdx9Q; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VwGhfUyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YxEHdx9Q"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CD84114011E;
	Fri, 16 May 2025 18:49:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 16 May 2025 18:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747435742; x=1747522142; bh=xKmAW+A9UG
	8IsAUsWUHuzP+GMm4jGl0tNrv7PzHw2Ug=; b=VwGhfUySHVElWW1spQUD/RehQO
	IQ4zQ0IiecLWPjwkqUj22Fxe2Fe7lwG1nR3mC6JkP+ebhfntbFYtI4vQCYR5PXR9
	4QJk64c0fEEHf/e/BRJ2Xx/X6/VfUUJ9RnwOhOq3tA0Est8uNZxLPnIAa2dVEY4h
	TWteTgiJq7/KLg7GppH9iOmvxKrr0TaIx3S73pzGOX58jZ0Bnmbp0qYSu0+dX/16
	TmTeI/pVcZg3ms2LgNtaM/2BEtg+HfouXYEPyfkbHK0tyBEHD+kH20E99teUW0NK
	B5U6oL/Nj1IpnGEZnWnXtPu4admIBGuV4N7Qx0V3z4/Ua5EbjkvyMLhXrPlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747435742; x=1747522142; bh=xKmAW+A9UG8IsAUsWUHuzP+GMm4jGl0tNrv
	7PzHw2Ug=; b=YxEHdx9QpKdoL48vPMe+f5FncqfGrog12mNKI8g44TEr/pqDDBC
	6YedSfxJyMmmOuw8p7ITtzmlZfGLEVCX3AEwgxn/6QqT0gKJUANQjRtPgSVvn6Y0
	M01idhLnPLzOS9y/8rMVgTst4g8zx0IqLaRWkWZ6kyuhOVJ9xTSyw3SuBia+PJ34
	eV0rvudbqAH9+nUJzUJ8k3QvhM4fOjKr7Snvues1M8USBkyJhoQ63MZOcf4SHh93
	BHtLgSHEa+bOED85BaDAYm/PPMqWyXArAMpf5E8uT2VEyQ9+8qgTz6QmgkPvsvOB
	etIO4HJe3zP/AWbDMjR2gsL3/Fxmz4NqcTA==
X-ME-Sender: <xms:3sAnaMzrXIdo_LtLVpVsQ_PYnZI9M4uak-UhMHLLi2RYwbCuF5JX8w>
    <xme:3sAnaATKb65-cSBWj3JHPOz_DxHic7szPxsduoXjVQoQL49iaaFcxGVzgO1IH5mfS
    9jemQor1z-9MOP-jg>
X-ME-Received: <xmr:3sAnaOXzKGCXyAcP_MM-gHkY7P618QaC62SmwtYLiz4ThqUUk_pM3uDMA41qkY4jZNm_2zlNY8OSKwjQG-GgEiuMoMGmgFVsuZVT24Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefhheekiefggfdvfefgueegueektddt
    gefhfedtieeitdeguddtgeegtdegtdegnecuffhomhgrihhnpehglhhosghsrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    elpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtoh
    hmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3sAnaKgCj24QTtBRSSyIRNzl46I0sCDA4QIJBJxH6a89EPi7wnIUlw>
    <xmx:3sAnaODVau6y2HiJSyNnhqvPy9O4G-h0yIqkNcd5vSCjxPu-VPJiOA>
    <xmx:3sAnaLLsCmur2gMwi5V1W35HRsHDCzrJQLwl9NpKcZbNp_QY_JzVQw>
    <xmx:3sAnaFBFBGeyJPKU3pJqzmN5yQkmzLOi-0dsdZ3DeWbZTeE-lsJ6VQ>
    <xmx:3sAnaN9QDQdycKjdyfvYkLlNFBgjFaN23O1Wy2DzT6_l0Hj5XsotzRlH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 May 2025 18:49:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Matthieu Moy <git@matthieu-moy.fr>,
  Eric Sunshine <sunshine@sunshineco.com>,  Todd Zullinger <tmz@pobox.com>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 04/11] contrib: remove "thunderbird-patch-inline"
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-4-32e151b0bfb0@pks.im>
	(Patrick Steinhardt's message of "Mon, 12 May 2025 11:19:54 +0200")
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
	<20250512-pks-contrib-spring-cleanup-v3-4-32e151b0bfb0@pks.im>
Date: Fri, 16 May 2025 15:49:00 -0700
Message-ID: <xmqqplg8rx2b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "thunderbird-patch-inline" directory in "contrib/" contains a script
> to send patch files via Thunderbird. This script depends on the
> ExternalEditor extension [1], which seems to be effectively unmaintained
> with the last update being in 2008. While the extension has eventually
> been maintained in [2], that fork hasn't received any updates since
> 2020, either.
>
> As such, the ExternalEditor extension does not work with modern versions
> of Thunderbird anymore, and as the "thunderbird-patch-inline" script
> depends on the ExternalEditor extension it likely doesn't work anymore,
> either. The fact that this script hasn't been touched for the last 10
> years outside of some global cleanup supports the idea that it is not
> useful anymore.
>
> Remove it.
>
> [1]: https://globs.org/articles.php?lng=en&pg=2
> [2]: https://github.com/exteditor/exteditor/releases
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/thunderbird-patch-inline/README  | 20 ------------
>  contrib/thunderbird-patch-inline/appp.sh | 55 --------------------------------
>  2 files changed, 75 deletions(-)

I've dropped this step out of 'next' for now, to give Phillip's
update a chance.

cf. <20250516135540.218937-1-phillip.wood123@gmail.com>
