Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338D24A7CE
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984972; cv=none; b=Dzm3e9LbrtnelssEg2V1vCRo7xuVg3f7Ebafnj1hLv8CNA7jToG1arTBj5p79/dwqFPc0wyg5G/3zjNHSAJ3H/It0sUOW2585R4SQiSPq+tw1l6S3nqf0u2J3xGu5xjCDLlBoiJXfvJ3qQBsfHJpBM/1XNuFmSVERKDXmhAzvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984972; c=relaxed/simple;
	bh=OX88LE8cTIGQO1IiKYAWpmXPg8pYywu1YqIThXvXDuQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mu5mus74cOfwiKnM4XS7cmvyFfk8X4zlmdA3cW/8SMteOI9LUjZMfbuT2ozfzdvLBi80OGtXxvDWjv2Yt6Tiiu/oIgIy1EJp5KquiLQ0ECKwyFFdGZz3MhnxS/GCnrSfNNAphBparP0gW8A7z9VbqN0dQJZ3Ag4qETOh1yTXU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c7+ZZZet; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4UxKW03; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c7+ZZZet";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4UxKW03"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 09D7B114015F;
	Wed, 15 Jan 2025 18:49:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 18:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736984969;
	 x=1737071369; bh=EuW5PAKEuuQ0bBDIhQbCaDwVJa2mXXfGsAApiTrEDD4=; b=
	c7+ZZZetPDgskRa/q0jt2z4p2Yg4JfSLIxFexd5CGm9/20Ew4Ero4y0KOz/aWLJT
	JQTVzDCA8h4Fnzg7MF1NSlNaklbaB6rxerCfGzkjyqIxNtWP570A29Js/2YH5h4P
	VF5NA/Da3ZJa1b6fxum5TrnUN1WPehYuUQAgK68LsUp7p2tdk0T/n7nze97cTJij
	DbKM7nMRBI759bZMS9p/yh/0WQSC4H1jmGP2uDGazlqNVCQYHpx1Mlsc4InRPqPk
	CKWNGI1xUWoLktqCHn8NveB2lFe7UKdR7RPmSn08TkKQ4nKgU9B08/MbHd4JoZa6
	QhTCuqX1VeBRXbsbdefRbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736984969; x=
	1737071369; bh=EuW5PAKEuuQ0bBDIhQbCaDwVJa2mXXfGsAApiTrEDD4=; b=h
	4UxKW03Dq7B3oJkwiTKeRDln/3HurV39RyAaV11AuFiZF96S18QLdJYV7CJiAQZm
	frj0KN5pKgL9w754n1QzuTcywJG4wGRy7xexpZuko6dJsEXqLQa/HSpUdqpe9ZQR
	IyMvVkPWgtje4HlE4LJiKOVmLPa7cTUbuGhukVO+NEwmSa0AazGy7r1E3rqim8AG
	Z0BqoNwrPZTAZ1Pnon0NvlcMx6Tk2EbsOC5iW2FIR59P8w5QJzZFy2RmgEiTSYwx
	vcigHbWUyjDA+6SVQnRyxOBqCUT99WPUyqFVjlfxEUvaby7H2ogeCvS41gXSkSZw
	KEjn7PoCVN0vGi98d8vhg==
X-ME-Sender: <xms:iUmIZ9mbXwAtJfwoKueZCmNXXWqsal5Q3b02nUnaX-_gGaXVFkoPiw>
    <xme:iUmIZ41tvDCf4QN_O4vJ2OfLJzHkIjkEkn8cICyE-9yY5B_qhcv-CD13eI3SR4zRA
    qIRnOKQw9xdy9aZWA>
X-ME-Received: <xmr:iUmIZzqrA0bAgATG29OxYDkCIzKfkIkdNQy2pEfQZadvT1RrbrsOEIZ8R4yM7yJdLD64R6F5MxX9KphsjjZoHjfG1TLQfOH9pbXy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:iUmIZ9lvwYVrRAkKxFWG2VuPTPH43KjBBy_RWUlHhuAuKlWiDQbRsQ>
    <xmx:iUmIZ71ZKUQA9rx3D2bOOdNsPJH-6jd1YiBSnNCPkfKuyagjYC8hrA>
    <xmx:iUmIZ8ufXU2ktUVoyA1SbnSgPxRZGYsNUpZWJQsWT3jRjqrtElgOYA>
    <xmx:iUmIZ_X8LtoTcAR09PBFbQIV96VOFnVA0fdIpsdXOv298Tk8ys1y2Q>
    <xmx:iUmIZ78p9q3Gs0gEqNmYw-TATuronXKo-U_QyXDbsd6ky2Gk-Oqmnmfk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 18:49:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 4/5] doc: convert git commit config to new format
In-Reply-To: <9216554bd7096f2543e987fc7fd20f5e64630187.1736972628.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Wed,
 15 Jan 2025
	20:23:47 +0000")
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
	<9216554bd7096f2543e987fc7fd20f5e64630187.1736972628.git.gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 15:49:27 -0800
Message-ID: <xmqqbjw7vdrs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +ifdef::git-commit[]
> +:see-git-commit:
> +endif::git-commit[]
> +ifndef::git-commit[]
> +:see-git-commit: See linkgit:git-commit[1] for details.
> +endif::git-commit[]
> +`commit.cleanup`::
>  	This setting overrides the default of the `--cleanup` option in
> -	`git commit`. See linkgit:git-commit[1] for details. Changing the
> -	default can be useful when you always want to keep lines that begin
> +	`git commit`. {see-git-commit} Changing the default can be useful
> +	when you always want to keep lines that begin

OK.
