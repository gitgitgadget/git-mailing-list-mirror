Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFA720DD4E
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363643; cv=none; b=Ak9bd3Br04OuHUE3nmGl72vII3C36ToULbXk1cN2gGVsvQl1pdKqeWK2ASYyJ/CQpgvRZKDkxLRZjMCr5gxGetvwE178i0GgQTgBKsUF2j6rye86sFkC+D8I82luy7rxk7zqRDR91AtB2+E1GCmKfeAaAI0LFE8s+QFGnPzEftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363643; c=relaxed/simple;
	bh=qjsgGvrorGDq6M3eNsPCJ9rQVt3ATVc34NB23cfyjf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwAdqXfbJbxjuDaO8TbZrdIMwqJRPAJmEyQLUnj170KhhXAToK9pBHmZr+WCNT3DPFE6d6KCIXQZ9ynBxKTn1NgQ60jvRdTZ7t3sPKzdjDmA+rEZTtdjs4T2xKSd2YsQJZq5iPkfjfcxAHnweoCzgdb38pBfXaxfiE6UC2OuJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhPPDWe7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZYg19f+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhPPDWe7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZYg19f+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E59D114029E;
	Fri, 11 Apr 2025 05:27:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Apr 2025 05:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363640;
	 x=1744450040; bh=/k0PnK4JwHv/Uj9djbk5w1CzxRNjm++dkouIWRBzTGc=; b=
	ZhPPDWe7Xg6nRQhygoXaEmTEu5LCodDywpJt2sfPG/Q+Km8iSMhP2XFFe0RNFndV
	XywpZsAwe0eMX1mMLVDxonqIiUvelGJ6YuaotEWqIsB/+lD9rNXbw/xsqO0sjbLX
	7gL1650EWRWogp014fWH9UcQSCP5JSM5WyNBEoQcIFM380mjcugPCV+5mVuzejTf
	9EDudTyH/Ofgmz5SuRhD+IKg1lCQ4l4+A1SFrh71kzou0L2JbtyxBTOsB0INHd9x
	4Jab/CqQzMx/2hasVODbuJCYftaYByjBUVit2+iSZsr4p9XVghfO16XVkPWM+kco
	loixXBa4Z1y+nKX8BGa0Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363640; x=
	1744450040; bh=/k0PnK4JwHv/Uj9djbk5w1CzxRNjm++dkouIWRBzTGc=; b=M
	ZYg19f+zaUSTSzWR9+LK+U+wc9HtYGAuSIbvxYInuLTVmsYMK3gyf08yJWLAaJds
	U3xucrYFdOpWrkFBxIs2JV39f1D2aJ/xPygUFRoi2T1ECNWmpx4nuQgGgPk/5mbo
	Tnd1phjN/+5xTnh1YlmnRwg3bBiqW3VjZPgIYYug+WFj6rAVLOMnogK94xDAPlhE
	zP6t7xNJyNYzEzf8dgJsePBcN3KFLvRCPDE0hJ7OG9yj+ySPx6A1yKITP7t3QjPt
	zAZjxQMTL8uBADFwpBaqv97IUs8IOllaGXJDlkQMY5t2QggVCNZYJKLTdz+qFCrz
	RvR2hpPCBwSjgqg5J8NNg==
X-ME-Sender: <xms:eOD4Z5Bdb0QtxasS9q4JxPaEsAYOARVnoyVeWdZvUaejXZXBERHy8Q>
    <xme:eOD4Z3hSMJpzmt1PPPWKqdM4QpwYJ0NSRPfmSZephiUNv6TVwW_ciCcwacQVmnuaH
    4iEXUzs8UHL_UagWw>
X-ME-Received: <xmr:eOD4Z0lFqx6RL36JEIYw4lT1Ym3gZHq3-sEAvvxl1HRU2dxD-q4GfSDJsX-WyLlOoTaoK_uxfL1tWZDNt-VXfLPwcaMMTF1855r1726IG_KfUAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eOD4ZzyCW2HN22ZqM5t6Dd1fy0oAnWSe43PloNTf0nN-lo5zw72aNw>
    <xmx:eOD4Z-QfjP7he--1_kl-gEBXjbRI2OoNaPnTfGICkFh5NCeq8OgXyQ>
    <xmx:eOD4Z2YIZ-Ug4nkeAeHGJ5tt5PP9ptX9oUdX8bCcTzhDLHfd-y8nZg>
    <xmx:eOD4Z_TID-M2PR_ekn908uTIqOSZ_PVznAsI0YXTJkospRsamSgo7A>
    <xmx:eOD4Z1uMMEcojG2PAIunSKJ6hHY6l10e5G4fWLMo4bwRMZGMyW4lgXPl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:27:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45d221ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:27:18 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:27:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] object-file: move
 `safe_create_leading_directories()` into "dir.c"
Message-ID: <Z_jgdV7Tkw0hkvgj@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <20250408-pks-split-object-file-v1-1-f1fd50191143@pks.im>
 <CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFpU5iLUN6Fh_+UG2Y593TWp4E+C_QQxLg6b=Cb-30F6A@mail.gmail.com>

On Wed, Apr 09, 2025 at 07:36:47AM -0700, Elijah Newren wrote:
> On Tue, Apr 8, 2025 at 3:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > The `safe_create_leading_directories()` function and its relatives
> 
> How is mkdir_in_gitdir() a relative of safe_create_leading_directories()?
> 
> I assumed the relation was "called by", but there is no such
> relationship.  The rest of the patch looked fine, but I was puzzled
> for a while trying to figure out what this relationship is.

It's more of a sibling than a child/parent in this case, true. I still
think it makes sense to move it around as it is rather generic in the
functionality it provides and doesn't have anything to do with objects.

Patrick
