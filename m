Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739F256C88
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206780; cv=none; b=gsRiCtzekYNJu79ONC2lKMNWoB2P2tAMx2bW5v5JHCG+IQG+FqLyH/PGoeKoUM6cBMer3uNzIGm32DSnwmH//MeJ8Qw1ol+aDwkGWbFId4SSyCz7/zDdL5/s9wnxtqbQkifqwr/EzbypaHVA9INJmW/XiIgMaQKYpdnIFd9qqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206780; c=relaxed/simple;
	bh=dPo5J399z55Q2I+DAQqr/rl1pD78Cq/NzoQrMkeD7LM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCgaJ6CR295NQajhgajqH77U79ylefzMCYK9z5XGU59REFqRUNyz8MouFa45dgTgSmERPplWnNi213RvvJFDN5/TELVzpOhoH1xvOSaqo5F6Vzp2rsc7utsW2e7Pn37ioQ1Kihzz9UpgejN0EsLjUrC7VnHfoGMvWQYloWvNtCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JHhhVEYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0LbyA9Cg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JHhhVEYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0LbyA9Cg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B50EC1140219;
	Mon, 10 Feb 2025 11:59:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 10 Feb 2025 11:59:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739206777;
	 x=1739293177; bh=o21AdAD8jOO8niB9f/5SD8k5Y6jJc2FOFYrsROdebZI=; b=
	JHhhVEYZIYk8Jrs6VpMCxZ9By5579zAFFoZh+UWqxrQfNuFJe7NyDxoglsztzABe
	heNLm7Lk9W/rOadLxcNgFDWcjdOe349wLhsVlNBXfPWzHgssg9swkDG5l1Q2FEK8
	PXlV78DRq4dChZB1jHs9OVvrwYHehOD+uPDqXQwDnAmF7IWkJh2v5Kyo+ngBQ5/+
	uTm7c1yUNbGxk1iLJit2wJ3cMGQnFOIniIf1VHkrvatudHMbaju5++F0rDCkW3p1
	d4SvtuCM2zhaXv+G6rvOKJB0O8kpBohwDe8mucUsyu0gYQxH+XVlGCRO9FYvA5FE
	p5aOzM3D2U/JnsaHwlrZWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739206777; x=
	1739293177; bh=o21AdAD8jOO8niB9f/5SD8k5Y6jJc2FOFYrsROdebZI=; b=0
	LbyA9CgrseYwHj0ZoshQSk5xwVMz05adPh5F6AfFpc7xzx58+71HWNDE9pd1IjkW
	g78ySnu1t+JHUBWd2R1z5HAwY/6vFxDzGoOO4hxfu/OwxKjlNlh1E4+Dcnv7mbhf
	9Cymew2uXkL4uYh2mBSSt3MESpTiYHvNh0hqVqzeaD0+xsbhmARhpcSR3CQM3FN/
	OEKLlq5Ris4TBNzB7MFFdQM8vGCtUM2KsMvEhv8EfU00+ZrO5M7+N8GYpVbvGT74
	wHhloQRtVV2V1tnyCvaf9CWO+N+GDfZlhHgEirtmRMwFNKmAwQfsDVNFTu9etO6+
	R49rNih8TTzZeOvpmrY1A==
X-ME-Sender: <xms:eTCqZ212_qms20WZPlxn5MM6_mwLtufx9vlOsIXNfcyPzKwwqMT9oA>
    <xme:eTCqZ5F2MPo1RGiWbIjnw_Igu1iVju2zig0Chzdvlm8KQYo2yoZEEgAn27zZrR_B3
    xOcVAnWczx9s6D8Hg>
X-ME-Received: <xmr:eTCqZ-4ZNRTuq9zmSXUPnqV48KLZ6-VucCleBcqilSZpIHR7EhhrcBIGf3HmzKjAQ1P1NCkBUFBSsrI2yfI1KnB4Ox49sTex-Rnr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsjhhouhhrnhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:eTCqZ31KM-CS18dI85HYwTPtkLOIs0cV6peJyY3cXTsotDUgf_4N3Q>
    <xmx:eTCqZ5HJQtjh4V02YduIQh76Id_y8FURF21yvhc_u5vW5UW4j1GTEg>
    <xmx:eTCqZw-1GiZB_Kn8e2eL9QyQzfCs_K-2VbNosHEayUDbvzEn3VAsqA>
    <xmx:eTCqZ-kifJaTWPGyasAQ4f4VlZOrUYGvFomcf52tzzGcTdzNvpTWsg>
    <xmx:eTCqZ9jFTZc0dKaB-VhjVaFkEDgixO4JPoKm4Ab1zr6OJeA7z8UF-ScJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 11:59:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Bj=C3=B6rn?= Lindqvist <bjourne@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org
Subject: Re: git rebase --continue error message is misleading
In-Reply-To: <CALG+76erpDGFinXsockB8=+GPEoEtd+xw=xVN1HCzv7=aFymoA@mail.gmail.com>
	(=?utf-8?Q?=22Bj=C3=B6rn?= Lindqvist"'s message of "Mon, 10 Feb 2025
 11:19:47 +0100")
References: <CALG+76eJL5dC3o+yq7zreoRDQan1MPgfNXB42k5f2iq2bZEbNw@mail.gmail.com>
	<534e8534-a9bd-428b-87f9-a512c9378b19@gmail.com>
	<CALG+76erpDGFinXsockB8=+GPEoEtd+xw=xVN1HCzv7=aFymoA@mail.gmail.com>
Date: Mon, 10 Feb 2025 08:59:34 -0800
Message-ID: <xmqqv7thburt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Björn Lindqvist <bjourne@gmail.com> writes:

> Here, I don't think assuming the user has vi installed is correct.

Exporting GIT_EDITOR that points at the editor of your choice is
exactly for those who choose to use something else.  Instead of
erroring out with "You haven't told me what editor you want to use",
editor.c has a fallback default to use DEFAULT_EDITOR that can be
configured at the compile time, and if the builder does not configure
it, then it falls back to "vi".  We'd need to stop somewhere ;-)

