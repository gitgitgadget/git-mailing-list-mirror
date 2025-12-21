Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4961E5207
	for <git@vger.kernel.org>; Sun, 21 Dec 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766337221; cv=none; b=gxd9xJr7OJgOAI5u71kn5iwGDm50cn8xt95xvG/yZChUTrtj8YrdE7RZJfL9Ywu2sLrAEAp1ewb+GGL+uUoQ+vak/UqsRlPfktdalPG1v8A6S8UBA/IYC/pzQrxlJeqmeVQgUIy+VePp70+T5puBH7LvVR8SyfbcC3MlDE4CASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766337221; c=relaxed/simple;
	bh=QscFWGzI9nI7mSTRRLtHheLBy1xNjhyzkDjFjEceeSA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z9gWI0WDjEJ8Mudok2aOOs8HS08XzqPTvuOK0y2ZCMbXDws5maVVvAUckelAt/ttKWSyL5Pqhc6FNH6VBmFcOQ5uQbLesgouQqgLdduNA5yrNjLTDytN2UGCrJ8xfyu+lLJeNE1sMwVI5FuBLA7bdBbqaUt+Ct7p8tvOFXtSjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YKqjdkLk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GmMwM7n6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YKqjdkLk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GmMwM7n6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA5247A003E;
	Sun, 21 Dec 2025 12:13:38 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 12:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766337218;
	 x=1766423618; bh=QscFWGzI9nI7mSTRRLtHheLBy1xNjhyzkDjFjEceeSA=; b=
	YKqjdkLk3fmOM8jC7LBKvL2Im1PGAZnCW6nh7O6RBtSje1LsnBZnClwE20ERvhZg
	be+Bjzf/M0TXz1oSgz3MzqWil/BNuKC9qEN6X4NaSEazWXqbLiTbjYQ2e7w0QACY
	hsNJxBLfO6NZjJ/BrpO1YK2WCoGVElZSlvWTOMMEPk5ny/5EMh4SiKTY8XjzoUEp
	vOtiAkv8367jK5Ie7XqKUjXyAE8tVpPDOQ60xpXSNKoayZlc7FAyFDy64lHwfoLv
	Ukfszcu39iT79NGkIMC+yVGP9MlNP0sABfEnexui3moIcDAB+nQfEp8mCOMI6l4r
	ERL3lGw9Y16GpUX1Q67EEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766337218; x=
	1766423618; bh=QscFWGzI9nI7mSTRRLtHheLBy1xNjhyzkDjFjEceeSA=; b=G
	mMwM7n6/83w9HvfE1af0yV/XqiOq4FrJ0Yg3Fvi2TXG9XbPFqjB5mc9ff5DQAw9S
	Qy2aLceJH5rPk78JjYQJk9tKeASjtBnZVU1eDvUpsi46I3/FhKj65hndN67655uH
	4tmAQPtM0EFWOfkrEPvecVFP6wd2o45rPD4f4emdVFSGxBRcK/jmUQ1MBZ3/91Ua
	OymnR1YY06vO7xRJpvniCk16lVmLMRI9bBl45c/BxpDPZWu820KU5nGOAPenTtN8
	LqsAdHmTj4zRxnajRTkz0SHxcm2yGIC8TDGy5zbbJdA6sWyOTsJ09txJ92dZF1ST
	saaIK+qfZsvqojCHly1zw==
X-ME-Sender: <xms:wipIabnGo8wemuo3Npd4gVIdbQc40sfn_KHQv2QJohZE0_sb4pupxyI>
    <xme:wipIaZqmYMLqEP53cD1t5_OB9YRp0X2b1MDSeXDCEkfTXms_MNigUMfC1MPynzgmU
    k64cfaSvYAui2tSfeVHF_gcB2quBiK2qy3JKtMLRYog49Na978Ynw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wipIaYiEOM6310YKQsVyZ8HYCbkRWCsiXszurepKZSYe57Vk8sE3Uw>
    <xmx:wipIaYwhTZuriWm93Hnywv6T7Xkr8AoGsWYE2YCNVw82dvYP_WweMA>
    <xmx:wipIaTKMbCu3y-1rfp1KLtmuHvMkzJXeCr1qPNvVJvOnSdfy5sXQFQ>
    <xmx:wipIaXQe1qclwof4oEOoLU0o1Oyi4kcuq8jeCRV0o3ojmb6sJ1Vfxg>
    <xmx:wipIaQfCusPNFbkrS5X1xUvSGHnEj_kkVIcW3EQyAVFLlCBW63J04Fxw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 63B751EA0068; Sun, 21 Dec 2025 12:13:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A3zylCaKW64V
Date: Sun, 21 Dec 2025 18:13:18 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <80146290-bbe3-4da4-b951-04399bc2fd03@app.fastmail.com>
In-Reply-To: 
 <a3a76d448ac2871834576be6d79e4704aae11f35.1766170456.git.gitgitgadget@gmail.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <pull.2016.v2.git.1766170456.gitgitgadget@gmail.com>
 <a3a76d448ac2871834576be6d79e4704aae11f35.1766170456.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 2/2] doc: correct minor wording issues
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025, at 19:54, Jean-No=C3=ABl Avila via GitGitGadget wr=
ote:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> * use imperative mood for consistency in options descriptions
> * add missing parenthesis
> * reword verbose phrase in git-repack.adoc
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>

I have reviewed these changes in v1 since the changes are the same but
split into two commits instead of one.

Acked-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
