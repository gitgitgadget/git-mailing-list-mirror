Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23451367
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771910267; cv=none; b=LiBdC/dt2VzO5xB83QHMGA25f2wQj0DddZn5dsknwW54oUfWf/zrgd9dfyQJ/MdoDS4ZotTFt+JCKk8VmKz+qI5pbwgT1ERqyv3GvfIwEkUEnT76hWaFQasHzh6W6XK8VAbyxt3fSO93kD/GZxE2u37kBJLbGwnu+uCNaiKb+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771910267; c=relaxed/simple;
	bh=DyEmzhUkenBZH0sOvz9p3NhAV/zvlQBeZXj2s6+eDeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/Dhd7BFG/5RuxqnPdnF+hURd1+fy9Oaw1UMeyogcZm2XkvBG9Du2ot+qTZV8yPcslO3RCOX1H15vAFhguMaTiF9R+VaEVG0ZmTQTaOPwjBGy83rYVHk8yzb0QTlm5QuqttvMs//zgp+h7dt0IW+TxEY2TS+iCN6U7Do4yTUGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XK1YKbGj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDWwaGtu; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XK1YKbGj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDWwaGtu"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B167B7A01FE;
	Tue, 24 Feb 2026 00:17:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 24 Feb 2026 00:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771910264; x=1771996664; bh=HTvXnR+0cD
	U07VeUnsuEF0PKlRolrh7+vTr7WxeCAbY=; b=XK1YKbGj9LGAHrys+ISBTj8uN8
	QqDuONLerBem3uezxrwDYBi2Z2M14VRVKnD2m2KUxDgyH7ogk2eBtrPy3Uh1m7kg
	gPQqyvbPL8cvlI4BeCn1eFiBesTV7Tic01ggJe9gzQhGbO2XKhW6ul8z0Zvd/ao6
	aRq/2Nm1dsryerWxfPo97E4WwcQhG4/y1tTVDLYS3cjtqV44/0QGYBuuCZQ8FPZE
	7A+eSUJdeJ8sPQwI5ELbDl7sdDn7gAe7F8RwfMKJd0lvl+2tO/DnuGWi72CayLqr
	SWS+qz/Q8hHMhwfk/KAM8Qjbi7EqjhlVdUJ5/w3LBzlvCG5wpUC+busi7Ljg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771910264; x=1771996664; bh=HTvXnR+0cDU07VeUnsuEF0PKlRolrh7+vTr
	7WxeCAbY=; b=EDWwaGtu+E5rbOpUyqZkFpQRvZBf8//mCaab6z7FqUYsE62UXKm
	kd99VPKKFtYoJTIBwRCe/PYW4DYXMwLe+ZM/DRcirQ3aG02O8bVvdHybmsw0zX0f
	xShYYExBN+if5KdLaIpw4cAxZnZKziJHLOEnWXeSXLjXknkOxMJELFPIq2kdUw06
	qeiMpHq3/tJi+zNf2hUqJ6F7YMK0XeUHsYAFZqHn+NsIq7dd6Fdl7ZM8RFKUu+HP
	2gmd8TbaDKOQRsqMIAv/Bd7dZGz5vGy0HVnfzCpwXtisDi7WKdKOzSKyCT5tan1I
	KH1xZ+hE6+6wjJMs8nUS9RQQtFepTOsJjZA==
X-ME-Sender: <xms:eDSdadGVyicWF7Xsmb1w2RhQA9rZYm6ZES8_LDYjJ5GRjAOenNPSuA>
    <xme:eDSdaZyHWQARiuFSep7eLFyORf_hxN2sGev6y8Y9qlxKAGONFODZpaFZE7Ad8oLoZ
    uvlMOvoVJ5tkqKsWE0yOy9w7lo2zSJLFdvR7aJNHt8m9uLIHApXOl0>
X-ME-Received: <xmr:eDSdacjtQhZy4Bx4ITNdV2kyxN5rGaN2cPPvyUn7SIdWLv-fU-9OYJxMrK9DsqdRscKgMvDaBEfOwhxZ9MH4DWAhxHm3gCxUMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eDSdacxxSymD0yy8ZlIFVQjpzRilgQjy8Nb0LlnCszNmMKWO-llRDw>
    <xmx:eDSdaXI3zpfjEzKGbwZXGAzn9ex6ZOkvb2yR_On4RSfVyemq_1_HrA>
    <xmx:eDSdabSIR-y7sh5qRmgsD6VvqTssM9vJ0yOByEnEqULGkRjao5PlTg>
    <xmx:eDSdaXr2CWsXd6tsn9Fs4rDJ8YIoViiQQB3i34xsUPC2kRm5qD2p7g>
    <xmx:eDSdadxMxi3lsK8yn9Nt1ddlNFaMa8S4KPzLrj_6gyUlV29g6CYRfSk5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 00:17:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 0/2] diff: handle ANSI chars in prefix when
 calculating diffstat width
In-Reply-To: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Tue, 24 Feb 2026 02:09:46 +0100")
References: <cover.1771894207.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 23 Feb 2026 21:17:43 -0800
Message-ID: <xmqqwm02k9e0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> This patch aims to fix a bug where the calculation of the diffstat width
> incorrectly uses the strlen() of line_prefix instead of its actual
> display width.
>
> This patch addresses the NEEDSWORK item added by ce8529b2 (diff: leave
> NEEDWORK notes in show_stats() function, 2022-10-21).
>
> Also, this bug was reported and suggested to me by Junio C Hamano here:
> https://lore.kernel.org/git/xmqqikd3ermt.fsf@gitster.g/
>
> Junio, do you wish to be included in this patch by a Reported-by and/or
> Suggested-by tag?

Neither.  I didn't report or suggest anything recently.  I merely
pointed at one out of the two NEEDSWORK comments that was written
long time ago when you addressed the other one.

>   diff: handle ANSI chars in prefix when calculating diffstat width
>   t4074: add test for diffstat width when prefix contains ANSI chars

"ANSI chars" is a phrase that was hard to understand, as the theme
of this was paged out of my working memory a long time ago ;-).  I
think the issue is that strings with ANSI color escape sequences are
used in "log --graph" and other output, and in order to measure how
many display columns these strings occupy, we must not be using
strlen() but utr8_strnwidth() that knows how to count UTF-8 chars
(whose display widths do not match the number of bytes) as well as
that these color escape sequences do not occupy any display width?

Anyway, thanks for working on these patches.
