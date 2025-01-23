Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269B88BF8
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666047; cv=none; b=nW0qAnDvNUXLWbv0tOUetu4SkonqvW3WJT2Gd2nRD9pyqJmjLssOTnhZmEsPvnVGZhcw+fD8+Ss4Zb2X95nkrhV+aw4uiyTBEioPjkUUOHODTCQyO3dzDK2ohAfVozav6c4TyywWkU96u26UYG4UsNEAGfS4JpiBQjKBbma4yik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666047; c=relaxed/simple;
	bh=FwR7JJYUvYv15wKUQ4hGQ6RWT5RkGi2VSU8M+LgdJho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rE3VYq/QA/bYNfmtKOVGmpzXuqO+6NyXC7j6HYI92j+AvGht3zW3tDpGTLLDMoAorXRdSiZuGOdBvoOVG9eYkJPmOAbApXXQQCBllNwWhMQRjqXVCs++MD485c+O4YrcI4hmoVIwHkfAN2ZdGaRgDk0SkRlrdcyYrFxD1JL9NWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bMiKCt7i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mg9ZCSLy; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bMiKCt7i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mg9ZCSLy"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D667625401C2;
	Thu, 23 Jan 2025 16:00:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jan 2025 16:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737666043; x=1737752443; bh=OcZjGTiQf8
	diVptL4z5rtOwzbJ1WIe4TcyrWGu/EKn8=; b=bMiKCt7ixvC5L2uDEJeVqPvlU2
	9xlSPFO8Mq3Y1dGwn/WsfkWw9eOeIqbXj8uIKuQqpz1WMWXNNgiCB2jCK/WLz2at
	XyL5d7elUX4984X6JO7KYFHg6VKRH7ntOa9F19kZm4zVlykAQTkt1MQJdDO+7seM
	hCUwOc4HB+0STQmHNpcPqK2pQi0PXtAjAe72q05GWHVmycurNR5WxTjI33MWNlKL
	+47DfiSPXIWdo2MKP4fQDefju9bvZ4OJHiTPv/o6uMR96gMJLTEtgco6kqsa5Gnc
	NYYxstjfvYCDzhlKQZAFKROQ0q+vBBcjd9GFcCJGfmGt7ztXfucbTJO0v/lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737666043; x=1737752443; bh=OcZjGTiQf8diVptL4z5rtOwzbJ1WIe4Tcyr
	WGu/EKn8=; b=mg9ZCSLy66FWvt6yLnPy/9MwwL2ie40VfNzsJYeZoD+ltQtNd05
	aOJwNuAylGp3PjeNO/ROTkPVwnuxbxU90c0NrlzY33ofdKO2z0lB+pyYHb4NQ9O5
	yCxLKBskn1+P9FVSu33ZdTZePJjquEqvALiLRB5oitKyoG7vVZN6Gn8y1pXhuGEM
	LP7fn8kVXXKOWfbBpN5cDvIy19I9Ac13fDX3vZgpwfD5o4VQ+/rHxKKTNxoK7wbN
	MYDYE6bBdnBoZbqzVPLA35C6gvJYoQ9Wuy+Ff/7VeuVPOTJBqanfQQ/mr4KTdhPO
	9I6m8UCPc883UWPBrrOebs1ns2lQm5ncgcQ==
X-ME-Sender: <xms:-62SZ1wsJ1zlX2tJOKujQj7Gti1hlAH-27vGrv5MV2YAi0Z9Yj9HLg>
    <xme:-62SZ1SnTmMx3ezpVtteHTuB7y-pWAuygEp2wgr5dIwbs26jtpDUPM7yXFV4bhyhU
    CGL_STz1Ppo3oHffA>
X-ME-Received: <xmr:-62SZ_UOowNI08abbAIWDPRLDafqvY5VGfBavhS_2e30xmcXOzsUfyHMLAXFZ8yfWlRGotjofeKIG7JDpzzkpOSxS9TWZzzEkX75>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghilhesvgifoh
    hrmhdruggvpdhrtghpthhtoheplhhishhtsegvfihorhhmrdguvgdprhgtphhtthhopegs
    vghntggvsehfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:-62SZ3jonJBr7OHy2nG1yulaYQA2_JViLcNPWNr8GrgYVMI_e-ZEtg>
    <xmx:-62SZ3CPjibciOxT6dcJ9MAg0zye5HFIiAL8xECqORW8vgyD7XDiHA>
    <xmx:-62SZwJPuFsmxfPvVb7OreVF8jr7KLw75fbP2uEb-0xDxDmvkSHe8w>
    <xmx:-62SZ2AB66j4sz_jublcun8WnTAYeKsh76Qq7-jpE3ZXWK8Gsh8y4A>
    <xmx:-62SZy5wwT6nZoNf7FAGumuIK4E0F3r7X-kYyVb3yqvJv5a8gvY9dCip>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 16:00:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Hesse <mail@eworm.de>, 	"Christian Hesse" <list@eworm.de>,
 Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare
 repositories
In-Reply-To: <20250112165125.130400-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Sun, 12 Jan 2025 17:51:22 +0100")
References: <20250111202628.0e5894e4@leda.eworm.net>
	<20250112165125.130400-1-bence@ferdinandy.com>
Date: Thu, 23 Jan 2025 13:00:41 -0800
Message-ID: <xmqqr04tqm86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> In b1b713f722 (fetch set_head: handle mirrored bare repositories,
> 2024-11-22) it was implicitly assumed that all remotes will be mirrors
> in a bare repository, thus fetching a non-mirrored remote could lead to
> HEAD pointing to a non-existent reference. Make sure we only overwrite
> HEAD if we are in a bare repository and fetching from a mirror.
> Otherwise, proceed as normally, and create
> refs/remotes/<nonmirrorremote>/HEAD instead.
>
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> Reported-by: Christian Hesse <list@eworm.de>

These should be chronological; somebody reports an issue, the patch
gets written, and finally it is sent out with a Sign-off to certify
that the patch is not a stolen property.

> ---
>  builtin/fetch.c   | 15 ++++++++-------
>  t/t5505-remote.sh | 10 ++++++++++
>  t/t5510-fetch.sh  | 13 +++++++++++++
>  3 files changed, 31 insertions(+), 7 deletions(-)

We haven't heard from Chritian; has this been tested OK?

What the patch does does look sensible.  Thanks.
