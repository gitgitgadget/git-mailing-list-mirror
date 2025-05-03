Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698C4690
	for <git@vger.kernel.org>; Sat,  3 May 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746234942; cv=none; b=mPjHe/mweBYbHF0YxNNaiJ+NwpQyPLKwvlp9qOPk7yPWwwPIuLzGC8c5cXA4rTXJpliKPJr3bHrowsCarBhKjN/nvKOUV4+X1MUFKHZxl7e2XlMBsCJXeNAm4L4Ty5uKezAHcO9rG3s0PBYLChDhm0E/0m99ProdSI4siOgLyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746234942; c=relaxed/simple;
	bh=ynCl4v1IOIIhf7ibkWwzH6GSxGQhjxNWAzI56rtnfuU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Le6/c2plktPg+CseHSdPCXu5B4EOptq/LwiKvLj9j915vNIGfAdnIWC9Xh8tklFP1u8q0k32ORlcoXamooJQmcuot9NuhTcRF+BgtcCKSaB7PCrrY5QNRYidxt1PNrsH3zaCrw/TqYajWPxZBPxKWvdkiQenJPPeL2w8MIJt+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D3XZGdTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FAciQyo8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D3XZGdTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FAciQyo8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id DBA351380F8B;
	Fri,  2 May 2025 21:15:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 02 May 2025 21:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746234938;
	 x=1746321338; bh=VIJXFek3P6QsyR146VPOyfOoXcc2H/W+xJEyt68qlz0=; b=
	D3XZGdTaBczuoeQ9Dx0+yLsvznttJB9qcv1SpD8r3c+wQmvyv1YMQmsHY0ltI2YJ
	m1YoCV9z/IuIh5EZXeF6pxSqdEcmL/+GTSE6jl2+lqsVpwPH4dMy5xZ5mkxZaUoA
	f22WTPtBQ8UIIRrHjMZpB5RLEHVCQHxyaWqSGW+qOB6kIW7XacUGBRl2FSW6R23X
	AtCrIEyv723KvNtTv3WwQb/LYrRAZoHz+TCdZTxqOIT8i6QjaWSc7/F1z6tCq9tM
	8QOQUP302MVXEJmAxlJ8MbRN2hoRNCEMBtoWB2+Lz6/91ZmsG60dTOv/OuUIz+pf
	PZ7WabAXby1muSOlu9QIzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1746234938; x=1746321338; bh=V
	IJXFek3P6QsyR146VPOyfOoXcc2H/W+xJEyt68qlz0=; b=FAciQyo8dqt0gSlLm
	oGO4eoqr9PbgNRXOXv5JqZWSRsUBXu10O4FJrTqUpjv51o7fzaVT01Y/BQxi39na
	xLXZfA+C22kEqOD2zZ5BZe8Y5dMLS1UJd31BxRktXgggxU66jbQOQ/zIvZgesjcj
	hORCZUA7QeouOuL7fCAluAbtwLBWeOCsym5Pld3lrCbuSI+Fz7EFjtZQwsnWSBxq
	gF3B5OIfy7wDtuG6T1RAqmrUsYN8Uhja7kpsq/YpTKdzfjTlhiM4nM3ASi85mwqX
	/O7b6PKctvjfJm1JQAt1L5f1sUQIsLqLAJyAm98kgkiazp7eI3fp/dDAEXbsb6lj
	VT5bQ==
X-ME-Sender: <xms:Om4VaFW3UTDWPEZnnhMLW-8gWfium-t160W7ncvJqt9wdmbko6GJFQ>
    <xme:Om4VaFmJ0_25MY9FG3gi2K5BipzFwgteivs14_2Y-gw7ztBa4NuClvKy6z9Sv4QBN
    C7sdyud1wjotcAUxA>
X-ME-Received: <xmr:Om4VaBbJ4-NWPx4yadZq82wVEMJmI-c2mI3lr4vGSWQzYeeMrC9ROPqKzEGC4KQV1RgngDhLh9Qa9oAE0NZe_uCPRltgS-H266q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtieegudfgieefgedvieetkefftdetleeuhfduteehgeeffeevjeegjeekheeggfenucff
    ohhmrghinhepvgigrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:Om4VaIXO0WfHQruJfr-jadUFXI68KLCxJNO_MuGURh1JzOWuRu5oTg>
    <xmx:Om4VaPkwwKidPR92WMxve8GiCFH1rHqv3L_mPdJ36Urgk1sFKTM6Rg>
    <xmx:Om4VaFcsRxqS7J3-tQOGiNvs9TtKKXT9TX_2qfIyHbTigII2PV1RBA>
    <xmx:Om4VaJGc9eaQK-HkOGDx5H6FQu18wsH7PiD40uL6aLlGfxSWpqh-LQ>
    <xmx:Om4VaBUgJhMI9KxP3MH6aDu0bthmAZPpMpxDx_oWykkFyDFe5jMa2ZYm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 21:15:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 0/3] A handful of doc synopsis/options update
Date: Fri,  2 May 2025 18:15:34 -0700
Message-ID: <20250503011537.3035416-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-601-ga5925c3955
In-Reply-To: <20250501213414.370514-1-gitster@pobox.com>
References: <20250501213414.370514-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Continuing what Jean-Noël started with 22293895 (doc: apply synopsis
simplification on git-clone and git-init, 2024-09-24), use more
[synopsis] (rather than [verse]) mark-up and also make sure

 - dashed options in the text, including the heading for enumerated
   dashed options in the OPTIONS section, are `backquoted` to be
   typeset verbatim.

 - both positive and negative variants are spelled out when the
   option is negatable, i.e. a heading "--[no-]opt::" is separated
   into "--opt::" and "--no-opt::", to help grep hit with simpler
   patterns.

 - non-options are not described in the OPTIONS section.

The changes in the first two patches are unchanged.

The update to "git daemon" documentation has acquired a bit more
`literal` mark-ups, prompted by a comment by Eric Sunshine on the
previous iteration.

The initial iteration contained a WIP on worktree documentation,
which has been dropped in this iteration.


1:  65a5556d4b = 1:  5e8ae75a6b git-verify-* doc: update mark-up of synopsis option descriptions
2:  a9c5bd63ee = 2:  c6cc44c72b git-{var,write-tree} docs: update mark-up of synopsis option descriptions
3:  eb0e783e21 ! 3:  d424d8c846 git-daemon doc: update mark-up of synopsis option descriptions
    @@ Documentation/git-daemon.adoc: git-daemon - A really simple server for Git repos
      
      DESCRIPTION
      -----------
    +@@ Documentation/git-daemon.adoc: that service if it is enabled.
    + It verifies that the directory has the magic file "git-daemon-export-ok", and
    + it will refuse to export any Git directory that hasn't explicitly been marked
    + for export this way (unless the `--export-all` parameter is specified). If you
    +-pass some directory paths as 'git daemon' arguments, the offers are limited to
    ++pass some directory paths as `git daemon` arguments, the offers are limited to
    + repositories within those directories.
    + 
    + By default, only `upload-pack` service is enabled, which serves
     @@ Documentation/git-daemon.adoc: An `upload-archive` also exists to serve 'git archive'.
      
      OPTIONS
    @@ Documentation/git-daemon.adoc: An `upload-archive` also exists to serve 'git arc
     +`--strict-paths`::
      	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
      	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
    - 	'git daemon' will refuse to start when this option is enabled and no
    +-	'git daemon' will refuse to start when this option is enabled and no
    ++	`git daemon` will refuse to start when this option is enabled and no
      	directory arguments are provided.
      
     ---base-path=<path>::
     +`--base-path=<path>`::
      	Remap all the path requests as relative to the given path.
    - 	This is sort of "Git root" - if you run 'git daemon' with
    - 	'--base-path=/srv/git' on example.com, then if you later try to pull
    - 	'git://example.com/hello.git', 'git daemon' will interpret the path
    - 	as `/srv/git/hello.git`.
    +-	This is sort of "Git root" - if you run 'git daemon' with
    +-	'--base-path=/srv/git' on example.com, then if you later try to pull
    +-	'git://example.com/hello.git', 'git daemon' will interpret the path
    +-	as `/srv/git/hello.git`.
    ++	This is sort of "Git root" - if you run `git daemon` with
    ++	`--base-path=/srv/git` on `example.com`, then if you later try
    ++	to pull from `git://example.com/hello.git`, `git daemon` will
    ++	interpret the path as `/srv/git/hello.git`.
      
     ---base-path-relaxed::
     -	If --base-path is enabled and repo lookup fails, with this option



Junio C Hamano (3):
  git-verify-* doc: update mark-up of synopsis option descriptions
  git-{var,write-tree} docs: update mark-up of synopsis option
    descriptions
  git-daemon doc: update mark-up of synopsis option descriptions

 Documentation/git-daemon.adoc        | 119 ++++++++++++++-------------
 Documentation/git-var.adoc           |   6 +-
 Documentation/git-verify-commit.adoc |  16 ++--
 Documentation/git-verify-pack.adoc   |  28 +++----
 Documentation/git-verify-tag.adoc    |  16 ++--
 Documentation/git-write-tree.adoc    |  16 ++--
 6 files changed, 97 insertions(+), 104 deletions(-)

-- 
2.49.0-601-ga5925c3955

