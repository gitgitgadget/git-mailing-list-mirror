Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBC638B
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735919175; cv=none; b=ZWEfnijkN258MMKHuztYJOpx/+VT0EY0TU3XZbF5m22vFXedFrknNnawvTG8Tducd1vYx+rR2TqaaqdCKgrnzjXiVgFjRcBq+s1aFKLuXfNVbWkH9aAe6Q47g7Ja0UIl8sM1IHTtn3TwwIRwrAQ3LZwwpMccZANIzF+azASJJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735919175; c=relaxed/simple;
	bh=9203uudWfk7OqD+aFZb9/9buz8W6pdE2T8rQu9LhlOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EHawge5ar/qo3GUOrXKlsSlRLzfXJLsDKmbhWgpIhA5wPaPu7BDGH5n509zQOghYuD8Hl4plzvnv+Xgm1SbOSd/eZ6Je0/kHRQvAgF9MOPtdH/sSBfIBog8sDOR6zznta0WhiF5iSRa6Rhp/1fbcmUIRNSVv0WN5a7nLnpk/tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iCl6na9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KuWKytga; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iCl6na9F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KuWKytga"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C17F254019D;
	Fri,  3 Jan 2025 10:46:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 10:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735919169; x=1736005569; bh=8xGA+RQTNt
	3eqnsQGXg3r49UBKdlPqvIIYpz5Tj5hdI=; b=iCl6na9F5XDwzPzcRvg2q/rjtu
	XIQtOrMIp19riRxqr2cJZBd7TrZHCc3vvc1KQlHgRN+Nad8iocggK46hJCo11/zy
	mtIP1J1j2VudIY/+DLgwLvPIuerozB5FGM7X5SNcpOylCVqgiVOptf3oRCsoAqAF
	wuUF+d0RtLEHhZ7ouyfbZiQYsRz9nRw/yWDflqlv2vKaWmNTrDaKU9J3IMw65JFf
	0hhieGiOM+hh3A1WMY9jTf9+9ekIinKWOH60+CIviMujWOGq3jV4Ju3VcIjPCMSh
	Jh23DNtSVnb9lanH/i9awBxWS7ayyLXxkMCN4mB/pfbVrrJpBv59Djgx8jvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735919169; x=1736005569; bh=8xGA+RQTNt3eqnsQGXg3r49UBKdlPqvIIYp
	z5Tj5hdI=; b=KuWKytgayyMomaBdGMlV0JolgKxlLRKug+QLpslKb7LoGB4bt5T
	lkEOKY5ltfssccPJ0zwitoVGsxLX+vTSHQ7WC8w7AQCQq8KQyVGYo6b+9zZz9/2d
	0vX43869G4pue2bqKnep5LKVg29BPHOh81QaqxrRwtn7p5h77zMLdenO4f+OdF8R
	DUB6Y4am6k1VgaN3sbjY2qtG+tzMeMaPYDkbd/9zCxQjypjmpfpqqJDRKKgwHbcT
	Ha3wSuS+bOwJ9ONohhYvFa8u4D7260phBt+yBIRRrT2P1H3OrsYs+QZ57ZkO+Kwb
	BSyr8hzE2Cd7cjyXgWfOCriFXHRhSiIPmGQ==
X-ME-Sender: <xms:QQZ4ZwS7Oh44WOKv9HHaaT5F7jm0DFCsqsgFFxx1HhHs-xC39g6gEA>
    <xme:QQZ4Z9xUrcrDeXglaoF6SGA_LnmR66wpAtLr8tg_8DS-BCFmoMIiv-GD6lhr-kabO
    j9XrzjiZiI-972H_w>
X-ME-Received: <xmr:QQZ4Z90hOwCzbsFd7yYKFlEM0Rv2khgOIr8WrrhhzpzguF8x5Y0hGGMV67YRNhsi5Y_5nlKYbIpggqbMpYBc22sXsf8SJxxHHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:QQZ4Z0BlOVxTuIHOW-laZDHDm4UGkSbrRVLXI_n0vE2rIcxDTfxgMw>
    <xmx:QQZ4Z5hgq-gp6XrcFurdw-VRUmCc-2PexrcCAq1Quh3cJ2O2Lw1xpg>
    <xmx:QQZ4ZwpNx2ZFw3zQWs89w6K2dPGLl2pmnyJiQS78DwIaAWOBzFzNbA>
    <xmx:QQZ4Z8ha6PW2MazxgSIaYpoWezpBci5nT4gsdl32Q3EpKKc8fCISEA>
    <xmx:QQZ4Z3bS12h5vjqdYRgm0bmCHRlFQUURikTDYJLAUcBcJmPNvZiaJW_t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 10:46:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
In-Reply-To: <Z3ec0768O64j-JeJ@pks.im> (Patrick Steinhardt's message of "Fri,
	3 Jan 2025 09:16:27 +0100")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<Z3ec0768O64j-JeJ@pks.im>
Date: Fri, 03 Jan 2025 07:46:07 -0800
Message-ID: <xmqqwmfbsxxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I wonder though: does this have any impact on '<rev>^{<type>}' and other
> syntaxes where we use '^' instead of '@'?
> ...
> Do these really need the FUNNYNAMES prereq? The prereq seems to only be
> about embedded quotes, tabs and newlines and is disallowed on MinGW. But
> I think both '{' and '@' should work alright there, shouldn't they?

Thanks for a review.  I am too curious how this change interacts
with syntax with {braces} that do not use "@".
