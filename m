Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4824676D
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242030; cv=none; b=NyNATteSnRsNTrxxpaxD4e5zjGG8bnmNaDBs4LkPW4IVb0/n8Gc0skfnV4XXYl8UB38AJvqnBejCKIAFCJfJofA++MfqLh0RM8QXtS1M4gc0eUM6p+bG3TWlylcfMMdTenIsZkL2teMz/xTargAVG+n+5AChGfR4gsu3H+C/Wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242030; c=relaxed/simple;
	bh=Zpk0JB64VLAf3kv4giPPnAkWmuvJbjLhji0patbFXD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2wa+37i6qkrOTp+0+m6Gc6zfhfqZ/xdKwqQmmxEGx9K5RoQ/lzzV4b1yVx3wsZNaqdUWzSykpXcvFHHmMnY2M6wbyff3WzaYleRnrkY+Do6c8bxCfIFYYasjIg6W8KHtBfFiR+ktxulZTm8d/6I7OpNMpZk4RCt/ULj6JKPutc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tb80StV0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZ0EKMdK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tb80StV0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZ0EKMdK"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 513E51D002AD;
	Thu, 18 Sep 2025 20:33:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 20:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758242027; x=1758328427; bh=FndwzFmdOz
	ELUuA6r8zTwSt1HmL93j8LjZS12VtIs4U=; b=Tb80StV0OvqXOrm7FdZlbaU26F
	ee6wbsBQxCJcHMZvN2wVrys9tVvDfnHPenq50j2wcOHiKq6Cgphqj9GzSeTBZ/wa
	spHWTkJDkMEqsvqhFOjrOzEv9S9wJOda0sexHhANEFm5268JVKpHgHHKnhDZHL/h
	Dx0EUojQOzXIJEXurwAC+npFFEAQJjhrWqjFtUuJl1ayJgQL02JHhfVxwc6cx8Rz
	3C5EQf1QnTjQPYEo2RkNG+2eVk5Me2SUEbk24TWXQWZadI2QmwQbRiMlytQpIt2W
	wKAZeK55Eenj+LNH28oZcHk5gC2MtT5Y5lp+1iA5OXCQchqVhNzyIYicNW6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758242027; x=1758328427; bh=FndwzFmdOzELUuA6r8zTwSt1HmL93j8LjZS
	12VtIs4U=; b=lZ0EKMdKMVquOofGLZ0w0l9g4R764Uv/WblDcdTIncUmLh377hc
	OohtOqSGqkZUDbiOtjmVY4ZJvUk+NF+0FmHtC4thV0sZCUtA1q02fMr4eZLgQd5K
	0q8bU+A2xCX07R5w5wll6sRlhI22TJjCYkU73b7ZqXcpoWZ8pAJ73kFj9uxJ1Y/a
	i35jwXcuQpq0HWl3yoyEelYB7MemHH/+blZiOPzefUIqUQ98azKd+Reerfq1XfA3
	3zr8+YtAbLBmAKAilt/2it2pjjFVRWFdUsD7gzwXHyy+yjnY2QTij0rX5viTjw0I
	n50Mwp75fD9DmiORiKiNvVKuVFePratNr+Q==
X-ME-Sender: <xms:66TMaLwQQioqnIS4LGUIi7BmCLiBDZet9KupoEHg6tBeJuWyVMJEJQ>
    <xme:66TMaA3kvbneEVWoMRKKQrVVqUVsxEagDwTK3YWA1fOdmWEyrEr7dWK1W48cR3fGp
    FmHmbsXaKRMk6GsAw>
X-ME-Received: <xmr:66TMaLw1acFXY2G9PqDi1wpj3UqxTIYHzJQ9eOxn0SghS15ifvDtgo8halIuyp8_CKStTQ--d4c1e_dBcamSQzD_kM9OywyoSdBlGDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvg
    iivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:66TMaHGdF7nh6V0WBcCARDmRJR-uVLDgAhtNFgXHkKyTiqQnJUobuA>
    <xmx:66TMaObu-npqmddp5J3QYn9YonELcO3ZqMvMLRQpYFk7gkZVF6NHsg>
    <xmx:66TMaJC3XPPY8SMduUUj6cgSuexDhPCGcZ38b5v5RO1PSaH3SIRuHA>
    <xmx:66TMaGmDjpIXdQTF5bjZwyooknd8YremL2rnzPdvfjZvSI_rQDbLVA>
    <xmx:66TMaPgqgKUpHw9SXrnAvmjjRUODqB9Vpaj7XxA26-UE35H-nShS7XF5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 20:33:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 00/10] Use rust types in xdiff.
In-Reply-To: <pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Thu, 18 Sep 2025 23:56:19
	+0000")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<pull.2048.v2.git.git.1758239789.gitgitgadget@gmail.com>
Date: Thu, 18 Sep 2025 17:33:45 -0700
Message-ID: <xmqqa52r702e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1, to address review feedback.
>
>  * Only include the clean up patches; The remaining patches will be split
>    into a separate series.
>  * Commit message clarifications.
>  * Minor style cleanups.
>  * Performance impacts included in commit message of patch 8.
>
>
> Relevant part of the original cover letter follows:
> ===================================================
>
> This patch series involves ZERO Rust code and toolchains, which avoids the
> debate about Rust's portability and timeline. Instead, it shows how Git can
> immediately benefit from Rust's design choices without using it at all. The
> rationale for using Rust types on the C and Rust side is addressed in the
> commit that creates compat/rust_types.h.
>
> This patch series has 2 parts:
>
>  * Patches 1-9: Clean up xdiff, this can be merged without part 2.
>  * Patches 10-17: Define Rust types in compat/rust_types.h and then start
>    refactoring xdiff with Rust types. This depends on part 1.

This is probably stale.  If the patch numbering is to be trusted, we
are missing [09/10] (at least we haven't seen it in the list archive
30 minutes after the other messages in the series landed there), so
the "clean up xdiff" stage consists of 10 patches, and this cover
letter does not need to talk about "Patches 10-17" (yet).

Will see if lore.kernel.org catches up in the morning and process
them.  Thanks for working on the topic.

