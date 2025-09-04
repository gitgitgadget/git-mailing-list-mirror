Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7841285069
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968475; cv=none; b=JDQnTgPStr3dLt4kwHNyiWtAfJ2xVm4pJcHy9XeijLlVz52/8+j2/7cP3lAA3+HkTgMjyeax1D7mN54B3oECEso4c+KQUozezsaUE3nsIgREyOnbbmvvM670kNqrPL52I6GQjt1MqLCwkiSHIWMadyxmil/0uoFmSlP+QrDiwXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968475; c=relaxed/simple;
	bh=iTcITB9QGz5JHWcSWqrFPwEDnlYKYzMIrTSK3TyHDdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cc4dJM+/Wg0//nwzkp5FlaZ060d/qHzZztscLZ7CJ3f184MdbHh+0CVEIBy7J2AyUq2Mfzi3raQgov42kVN1VwLUfZxAf280PO1lWg4bJkHTi1rb/O/BeGFTSS5PA3ifeOfKAIClkvbfzk9P1PYXOYNhVZ199YORMokFaf1r1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rp5Cvl4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bcFDdqvN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rp5Cvl4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bcFDdqvN"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B59AD1D0033C;
	Thu,  4 Sep 2025 02:47:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 04 Sep 2025 02:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756968471;
	 x=1757054871; bh=VYJq4/4yDeFmaam8plI52Hbiayk0ezARkhjv5ZBgOTU=; b=
	Rp5Cvl4LSb28dHcWjrPzf7gMrmHvPzRaKdP6zawJZ9acaA1NY5cbytnqrUK45TiC
	Bml0dXMmU8BFujhKWTR7WDx7swxANGSpmBwJ/ssUNXRg8LycMxosdAP+lh5IVhOx
	b2vDX5Bf3zB1CuLMa0hMV9rDa2gsy7fuBZ/+iQGwnO3QjdlEfgCGx/sH/3bol9yG
	RFBiMqiEfFNOD+1Qpxc84typI9vYox6+BrGfjvBam+jCKXBHHn3Xu0JeI4Uyqa9l
	gLDLEo+phzqCe4PxMLDsFmAsXLcML31p3asLNj/nCwowalKx+pHuLwd8CpBt90UZ
	p4C+LXm8ncyR6NgnYCDRow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756968471; x=
	1757054871; bh=VYJq4/4yDeFmaam8plI52Hbiayk0ezARkhjv5ZBgOTU=; b=b
	cFDdqvN8J/TDvTLG0j/BORfyReUlZd8SXhQu0Q5WJB34fXdzY8O3JToMzcAKFCxF
	1obtehkbu3Qx56q7eF6ee7k19aRGI/iJXUBUG8Fo4oqmTZCxbmCnHK507s45XAcx
	efxo27SJW52cIvHqTkvnx0PbZF0Noh9Cn6yBfZY+VHi5JvfGyDk6rlzMcvu6F0wB
	JkQOKRHOTuT0mODoXtRdJKeRjQ6eD5JUQkyDPrz7Tq6kaHLg8ZL4iyD4f9RAYTHA
	9Gi/m55+DanLJd2In6uMGc+lI5MoPOZb5VRrIKS9NrsuGQQybS8kZfrbRwt3dlXo
	UqPOQR6vgiMhuEp4+gNMQ==
X-ME-Sender: <xms:Fza5aNTLq-tEutsMZqiczCH--3MOY4A6aPJO_uaI9hHLkZdqCpugAQ>
    <xme:Fza5aBVPoN79olF0Uuwqv_Rr4_UGm1IShQ2jKGg8QQdlhezJ-ZJWyK9LnYeKW-PJW
    sWD4I7_xXO5XGX7iw>
X-ME-Received: <xmr:Fza5aPaXysepM-0iJoaMhzHxd1LWSnuH4GFPAApnUGgZQPF1wLKLvG75dvKikbu5C8GrYNzpOl-SCXcYuF0yisB9gxESqyG4cxJctPo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedtgfeh
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhrvghgrdhhuhhrrhgvlhhlsegurghtrgguohhghhhqrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Fza5aH3t0i38RmaQIGwWjiwDF6NQDpaLx0JD40x3t2Afd46qrd7WtQ>
    <xmx:Fza5aBi6_6eeiwi7dWReSW3IPhtdAJVyy0rVreXRVbBB7PUIKbAtYg>
    <xmx:Fza5aLbfHi8pelQ_3SDV7ErdW3O1JtkOl1YNRWy39mS5Tz7Ed2ofMQ>
    <xmx:Fza5aBSrF_jMPTe70iZEVgfKbu7mXWtPC7wwPkZncxRv-V85uWHWrg>
    <xmx:Fza5aH522n6VlkvIoOA1d0mN21uCW9J0ogYKnrGtJ4rEsUpfnkDqvFcn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 02:47:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] mailmap: consolidate multiple addresses into one
In-Reply-To: <pull.1966.git.1756816258606.gitgitgadget@gmail.com> (Greg
	Hurrell via GitGitGadget's message of "Tue, 02 Sep 2025 12:30:58
	+0000")
References: <pull.1966.git.1756816258606.gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 23:47:49 -0700
Message-ID: <xmqqldmubtnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Greg Hurrell via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Greg Hurrell <greg.hurrell@datadoghq.com>
>
> Merges contributions made from three different addresses:
>
> - win@wincent.com (old address, initial contributions in 2007–2009)
> - greg@hurrell.net (personal address matching full name, so this one is
>   the "forever" address; contributions made starting in 2018)
> - greg.hurrell@datadoghq.com (current work address, used for recent
>   contributions)

Consolidating to a single "forever" address is good.

It is a bit hard for us to convince ourselves that Wincent Colaiuta
and Greg Hurrel are the same person, though.  The only way I can
think of offhand is to leave this message in the mailing list
briefly and see if a different Wincent comes and complains ;-)
