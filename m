Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBE275111
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184338; cv=none; b=EzDDvIZ78FPQoRgc0P3jWO9z/vdS++N0fkJLU6wEc0yYO3RDE/OSqkhXd6D9FOFpA+9mro8N/Ke4eVttkun/d6Xtker1On4RWj+SnMUPElnqKYInpVdRpE8BIsCPpJiwnXGHUdyaa8lJ7vChMi1w8DhSABlu9uoXJET2rDc95TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184338; c=relaxed/simple;
	bh=IYaQiOOZMBWrMVTuyAvAdll1AI/teLmRqTMiYdV0M4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V98R3vnSAZi9MRKalfhTuje9ovOk1sw6jfpjTyWfwCcIH3hykTA0cF/a1J3ISTk9MOBc32bTsBK7OoAdniSzcWQIJZnUmQcw3e4znIUROp/kWeZSt46nl5EmwyrvlPFwqhhpLiKeHk3ywhDgjSrEnIltT+Nozxx649gkVDPrTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IJLmu2SW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bYBA91qF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IJLmu2SW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bYBA91qF"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A43F01D001A8;
	Mon,  3 Nov 2025 10:38:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 03 Nov 2025 10:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762184334; x=1762270734; bh=ZD9f2iQbN6
	EoAPuFr4MA7yXmkGJjWmIlz52WG8UgcpU=; b=IJLmu2SWFOxEjvBgNe073F3UCm
	kuv29+srp1E4tQ0yfF14+2kY3MPqJQOb9tZ+0DlRGhbKSVhSwc/5EHE4wmRIVcc/
	2ZP0tAjxjr4c/jGoa8Sn3gG456cDFHOlmkxR5M7iFkGoC1jvc8+mwP4+kYWOnVES
	mqjU2rNIK8AUGjM3ab1mJyj/kfqh5AhdzQhJaJ+VZUw/iYzNz62YRW7fK7u7EXt1
	iaUe8gujZcufM1sPMFOogJ6E3VjzaPalV67weSI8VNAVAGP0e8tpaLqiBi7Yv8Cy
	PbFXRDW0NhnrgxmPcoOMd32VTCtNTP2JiwaUgAOGPtHVn06euZYeua7tprbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762184334; x=1762270734; bh=ZD9f2iQbN6EoAPuFr4MA7yXmkGJjWmIlz52
	WG8UgcpU=; b=bYBA91qF9bEtdsRQH0u6HQlztHWPfXxO8wux1nbnZdjHT5YDe6w
	vtyaKyKt8tnnEsCncyRBkahLHkqVh307Q8q/0hhzqYddERp8qg68a7b3oTAgJzOQ
	7z+aJuhOqmKhbaca+0IniKcqfCFXidLxeNr4QuUHMo2aoHE6NFcHanGjYekgbxnW
	uc5YXiuLeFevWfdPT/dq5YXLn4z5muVsNbWWNWQL5sR9rLcKdJsHqBGW3WLBTsm6
	HUXoHxSpdAnRhzUfAh/yYee0qMFGlEI1DbCPxtcpX6Hm5W8NJ5kIDRDBjRsiiqB/
	N9bPvUygo5CFe0Y+tEI5wssG+In+mAxRryQ==
X-ME-Sender: <xms:jswIaXp2ku4MpJ8aygYMbyO3AtUXwCoDQ6sIw80WFvB32HJcPO4LnQ>
    <xme:jswIaT4SFC6GFLdVjCBY4ZAPnKVDFKVe_riJ11YteAK2OaUUkm-UhVEcJepoYs87k
    BdeMar3x0YX_xZz1VDknoujFrfQQ_n-wjdVNWuerRrqsGVg1yqSRg>
X-ME-Received: <xmr:jswIaWdUWycE_TdNcME8eS8dbme3dx0Y4FHnYocKEq2L--RJ3ebXmQxr2SYkgIG2M9MlD5cTssiiyZKqEZ9n1yp1DaM7yEXtZjTW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jswIaQ7oWn-AhWd0LUYwN7ThK25E-EWaTKL-6hm7M22C7G6W26cvmg>
    <xmx:jswIaVs2zj4UuaaT-hU-LqNZ6XjAP1RtJepIb1GfJsNdI2gxh8WE5g>
    <xmx:jswIaYhG1Fpozr7lK4T1zh4rPjgE4dw70hl3hjKCv1cgqxaAG7k3yA>
    <xmx:jswIaYqT-sxfrc5xJ3WUmgoNRwzvHuuVWE8YQYA6dnau4mRbWBz-gA>
    <xmx:jswIact0PUUW0-QNM6wwJymn7-TS8megAXZcwFtHUECneSDCoToEN5qe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 10:38:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
In-Reply-To: <aQhcbHJjiI5GtV6Y@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Nov 2025 08:40:28 +0100")
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
	<pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
	<xmqqtszf2kro.fsf@gitster.g> <aQhcbHJjiI5GtV6Y@pks.im>
Date: Mon, 03 Nov 2025 07:38:52 -0800
Message-ID: <xmqqwm47unw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We'd refer to the top-level directory when talking about the worktree.
> But what's referenced here is not referring to the worktree, but to the
> commit's tree. And here I think we rather consistently use "root tree",
> don't we? Our docs already mention "root tree" in several contexts.

Ah, thanks.  I wasn't aware that we use the phrase "root tree"; I
recall that I've always said something awkward like "the tree that
corresponds to the top-level of your working tree", due to lack of
that exact word.

It would be nice to add it to Documentation/glossary-content.adoc,
perhaps?  Here is my attempt (I am not committing this, and I won't
be polishing it myself, but recording it as #leftoverbit material
for somebody else to polish and make it a part of our documentation
set).

 Documentation/glossary-content.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/Documentation/glossary-content.adoc w/Documentation/glossary-content.adoc
index e423e4765b..bdf469f137 100644
--- c/Documentation/glossary-content.adoc
+++ w/Documentation/glossary-content.adoc
@@ -627,6 +627,12 @@ the `refs/tags/` hierarchy is used to represent local tags..
 	To throw away part of the development, i.e. to assign the
 	<<def_head,head>> to an earlier <<def_revision,revision>>.
 
+[[def_root_tree]]root tree::
+	The tree objct that corresponds to the top-level directory
+	of a checkout of the project.  A <<def_commit,commit>> object
+	holds a snapshot of the project state by recording the object
+	name of its root tree.
+
 [[def_SCM]]SCM::
 	Source code management (tool).
 
