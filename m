Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B924772617
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243382; cv=none; b=NPQKR4Fil5DMWpsy3xcFTFcePqYV0F2xBC1V/vtCGiCzMDS9CTH2KNabX3za5eEIIJ2gOTnVUj6DuFVdvEo0eZyJWoi9UwTqy9WR7onuNOkcRconbv1eqNKrx4tfg/Jnw4XbLW7tdGLTES7DwnxOvwPPK0qB8+afit1Z7PU1seQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243382; c=relaxed/simple;
	bh=56a+AYul9UuTHcPHjjeOPGu0fd7vdcDBtbNjx07tbPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jn726g11909vbqTRi5IL18178Moe4Lxgyi15WwAehCvkAWCsTPyWuc0aKw2K5gPTVtO9JEuag8CttTUWOYXKj8skLDWjLIXWXrxu8AKGYs9z2pNca3a0KwlhMJYBInHOWQ8z3+9icnUk1aQ65LthlOkSfpSOVQYNvLm2iFNq5c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NYpDjvFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2ICX+yC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NYpDjvFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2ICX+yC"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8CB01400190;
	Tue, 30 Sep 2025 10:42:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 30 Sep 2025 10:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759243378; x=1759329778; bh=56a+AYul9U
	uTHcPHjjeOPGu0fd7vdcDBtbNjx07tbPg=; b=NYpDjvFsKnv8KONEs01BAohUUW
	jp7xG3e5kk2oLsig2gk35+MoPnfD3rYDXobcE38jo/P88qldItzKV8V9TMvRyADI
	bn4OsY/BCkp7z6Q9qEl88pf0fTyK/5ZrfdKzO+lNS94mEZnjstm0yiIupIGbNdLk
	ZgOzmPJrWgksTdVZaCiWyPTEUuCYEWtI1E9bavNi9I0x1WVQ10fT6cSbNO3cttB9
	TzTapBm7DnjuSQOXeHvgEF/T13ayIqRo880XAt5P/AA/C8250k2S/wXBD7EXHusE
	QW5k6JnsZ3trmZwRoFfCk84NprSJT23PSs2A2UNAAODqubfFI/AzD0/L/UWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759243378; x=1759329778; bh=56a+AYul9UuTHcPHjjeOPGu0fd7vdcDBtbN
	jx07tbPg=; b=F2ICX+yCEDbg6SL4B4SznarecvtVNv2zN936x3yEr4e3YaW1HkK
	7kbZOwyrsN+hKMManYbDaD4s4FW+oClv2br58nzcGPYNJI4FQsEtGgFSsO0Z/8qj
	8wLXFtN2En/oHHWMp26AnKG2g0g0F9ojSXUr0H7MZsAQVW6O4VhcgOhxoh+bV8Pr
	V5IZnpRWz02v26O2fT1RyruUOQ4xOAwykkEYyKWjp5s4FNExUdntw2VgZbaojHTB
	VQ4l/ZNWiJ6yS28mADDLcc3ooOdY97XmMdRXMWzklNO5v0HAFx1TVTjl3zPuJ8Md
	VdcLjMasv6PRPC9xYKsGHFF40kZ8dXM/H+w==
X-ME-Sender: <xms:cuzbaLZdbVC0rkkXsh-PLmBCCqsd00KD7LvqipfQvC9v-1sz_-EPYQ>
    <xme:cuzbaBYruRs8fRLpDhGFgFcwMvyX_MmEXL9ZTvXjTUbt54FZ20R7d0c-ZqzKdDmOM
    WO6W-j_eXRgnuDeqMsuFksKC7ZNTH8cc6UFRoYMfmIXJ1J2wJKRdw>
X-ME-Received: <xmr:cuzbaC8qv2RrD0nRy63y_-KlPcR7laGvgpsjDfUA9GsPRwPBHsc2acorKTBNIQGDShn0f3W0fcKWN19qGKvSKCvJv5_ByniUsCxL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithdqphgrtghkrghgvghrshesghhoohhglhgvghhrohhuphhsrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cuzbaAg-vyMMPmlemHCNOzj-rJxHny3tGtcAR6Vg3BJzYagvJa7khA>
    <xmx:cuzbaCfPydaPQoYJQtzkJ-V-ioVw72tvlwHY9C7xUbgt3d_Lc5bCmA>
    <xmx:cuzbaHqLlNzmWxNQZxoc7HAuCMkPiBZkUNxNrzWmDBov5XuB6VObTA>
    <xmx:cuzbaHAS8kjfKyMyQ0QaWWNVlsjmqc29C18j6U_xNtiucNVMDW2ohw>
    <xmx:cuzbaFBS7e6fr9fPWxrNiCGFSUYMGiAkwhElQIR6AnWKBmxsMqVGbVVX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 10:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: git@vger.kernel.org,  git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.51.0(2)
In-Reply-To: <1N2mBa-1uKVV81q0a-017bZy@mail.gmx.net> (Johannes Schindelin's
	message of "Tue, 30 Sep 2025 00:24:41 +0200 (CEST)")
References: <1N2mBa-1uKVV81q0a-017bZy@mail.gmx.net>
Date: Tue, 30 Sep 2025 07:42:56 -0700
Message-ID: <xmqqms6c57db.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Bug Fixes
> ...

I see you are merging a lot of fixes ahead of me, which is very much
appreciated, as I was planning to do 2.51.1 before 2.52, and the
selections you made so far are very sensible and pretty much in line
with what I had in mind.

Thanks!
