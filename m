Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841832E739
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054073; cv=none; b=h4z/CBI7b9wLfho33C9zZ2JWgEy4rcVmxN/auHcd4C1Zz2eJ9W5Pfvx7OMbRTfrk11oQ9vG18BwcTSyPcJsOMcJsnijUE096Y5CmHMYtIclB9KIVs5RcrHpmn7ppDagA/HH5cSrPqxQxsn6IeRCt3/kcqEGU7Ci2Z9vMfPRCcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054073; c=relaxed/simple;
	bh=xcUiasWhO03Iduheoh4boTeOIGBjj15Zm6YPHpYVPuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TiAoBXzRi5Am8VzPb9H9g1mJU1cfgLs/HmdgPOmRSiPk58nMCR7/qey2lUd1X/ua9/JIfFg3ZtBgU/3pVqPz3Hk3eTu9vq8FgwObHpnO5XT8B3cma33gHozXZp2TfxepopD/tosfrOt4N/gzH9eLURsTCUjKix262UvePu4JaYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZlbEWR1U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdlJ9QlL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZlbEWR1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdlJ9QlL"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FE521D000C4;
	Tue, 21 Oct 2025 09:41:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 21 Oct 2025 09:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761054068; x=1761140468; bh=nB1cnskgSZ
	vIN7ZfKDg4FFQaz4yiOI1CP1/voa/AE+o=; b=ZlbEWR1UTQCBWtD+LeNRG4aP3M
	G2nPzHdcgilzJUJ/X65O2XgZ7QGlts8NjJ4ftgIDWccFbDTp7KDM+flQr/jk7ppr
	A8lkSKFCFEiAT5lk0ydwhJULX14ufmpnrU4m8NlgC/cdULpHvGWXO66+05MHumVg
	2AJ14RkRzARKNb0R8XsNvIx1qHfVr244KhCmF7VGQ9yH/GoHQ+pT07Q6hM7lDeZi
	BBLD/QmrHBRfdKp7XGNMAMuHTsEn3HBB0wOAmR36h+OZ0bfsOKT6guGsHCye94ni
	HAEFP5+9avBeQ4L1emDkv66AFp1uc9xuwOkKpdSEp0cyhCYvy2DqidMw3AjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761054068; x=1761140468; bh=nB1cnskgSZvIN7ZfKDg4FFQaz4yiOI1CP1/
	voa/AE+o=; b=HdlJ9QlLP+TUBYCHv7GW39tDna842AUWv0HhlGnfi0/nz4yZGc8
	ZtfUfOkqAZo/IdI8ZYUmPgCYSC+ducXkpcAsNSR4zOJmEUwkL5M18eov05lQLyxE
	n6VL4ExWxLYuLxt+i9tTarE5of1JiFxrIyOLTR7RhW/Zv7sQqn3pJM8E/be0o8hJ
	wrnEZwGh6FiA1XIeNgMseRfumDJoMFrznjQ/RCA82gf3FkBbuZHhaI/6B4GFgq0P
	QzS0HCerHWJDMxF5nK1Aq6+3NOzIlu9nAg/zDjjVAHPVQhWOqC05iXmQJBG9xNGk
	z6zl/LpfPnjKOa9bmuFaV2HKE7oyGomSAjw==
X-ME-Sender: <xms:c433aOvgKS7Nvr2sZr_6527eh2KoeZMRVixzkXoCN5Zbqvpbva-BGQ>
    <xme:c433aHIn_WFI5Xsfcp3UM8DRC6IpkY9TFJRbtrNxlvHTuJ22DBTBAP7sd5m2S8jIn
    z4bFqMdVJXVgn7iJI2QAX_zi6fQPaD9bu8UJO-hovikvKZlsSk>
X-ME-Received: <xmr:c433aDmSFawcI9Mn7imOo_h5SdRDVomj_7QaEf7B1mkCwWlH2ShSVEMwEqyIcAUDKg7Pw-A1SOW7AzIggpnai9DWVwEmaQ_Hx-3O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvg
    iivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:c433aALoB8WpHxN1ePoEW9b33eI5kvyXP6xR8XYqCoFq7-aBgL0GDw>
    <xmx:c433aA5kHQOaesyn-8y-EPRTSJp5pvO97bQN1DATcNhNg0QW07UPKw>
    <xmx:c433aM1MgKtSbucXJjFJUK6R8v54QPMyztg3gtpFo0I7vQVuEegqsQ>
    <xmx:c433aOdXpeu8eSUijfjwnsZ5US8-0raDs-PCsNsKhAKVisI4tVAzkw>
    <xmx:dI33aLRlOXTPvAmVElzoNxoe2O8M5H8ZArXIQim9CuSoK8iVFi0SQ7x8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 09:41:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/9] Xdiff cleanup part2
In-Reply-To: <93ec3dbf-ad98-4038-84e9-9ca12b7481a0@gmail.com> (Phillip Wood's
	message of "Tue, 21 Oct 2025 14:28:32 +0100")
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
	<93ec3dbf-ad98-4038-84e9-9ca12b7481a0@gmail.com>
Date: Tue, 21 Oct 2025 06:41:06 -0700
Message-ID: <xmqqqzuwxthp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Given that this series changes the types of all the "long" struct 
> members to "size_t" I was surprised to see that it adds so many "(long)" 
> casts. At the end of this series there are 38 lines in xdiff/ that 
> contain "(long)" compared to just 4 in master. I had expected that as 
> we'd converted all the members to "size_t" there would be no need to 
> keep using "long" in the code. As rust is going to be optional for quite 
> a while I think we should clean up the C code to avoid casting between 
> "long" and "size_t"

Either we cast here or have existing code that used to use long to
use another type, that needs to be done carefully as we would be
moving code that used signed type to now use unsigned.  While I
agree with you in principle that we shouldn't try to interface
between code pieces with impedance mismatch (for which the need to
cast is an indication), we'd need to draw a line somewhere.

Thanks.

