Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB63A5E92
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891139; cv=none; b=ozDbgJYLsLsm+PiLGcycw3Y9/D/KBSV4+XB/Q5c3lUfsC1Evgzs5rgxbXS6GkZM5ResJDm7o69A0ksh9Y1DoTB42Ctxm0yTGbvf/j/zKOuCXqd34khm1hqW4m4eWrVI/52VBg2fvIHIVrJDVtu/F09RaGwTNQeAsvdBmXppahq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891139; c=relaxed/simple;
	bh=nn928TvCCv/9ZEfMBSYpWm8o3UhkQrr4hvGvQ5TYVvI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T6FXw0gPY+JF8MPs4YTyjn8rIH3aOghH7U5Effv4GjY/T38tyVHdyFM9pFcy5RBbmSiEfzIQXCEID0Naj0mwPbwXqBkkhnw+SHYPXPdNQxSHFiHQiDvBLLWV1n74V6u4vMQwjPxkOOrK9hNoSr6LWLDz0jBR447CSLOUxxkJhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ExXMbHhL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBAAmqs8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ExXMbHhL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBAAmqs8"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26A397A010D;
	Tue, 11 Nov 2025 14:58:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 11 Nov 2025 14:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1762891136; x=1762977536; bh=Nudct1Ew5dsBIgGAbtcdv
	SM4Xid7+136ZzJf8GGQrlU=; b=ExXMbHhLjC7xuQLmhT08GCgGnFAln0LuEd2gE
	dMuToK56YOSPdU7zGbivPd494v2RC5KHGJ2ayIWc33ZqFIH/W3dn7oxjIT+YhEbu
	R6Y20+5eUp4Kx/lCzrZjtsw7EX7wRi43Z1zjjPUK+53dq/mXg06JVyKrqoS0qI4f
	DvydD8uTkgPKsuc4dDCjV84GnDmBimazWL/yIxNO6+unoRy1Tgu1md+YlCxaWfyS
	HmyoGeznvUSh8WguC3lxJ3NDfmRQ53vkLFT5NkPcMFgOQawfjrUWtHuZf9T92peG
	/o2o3CC5p1xFpJ+1rNYdzBN/R6ucw5TF53fSGXf0sG4/eMPkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762891136; x=1762977536; bh=Nudct1Ew5dsBIgGAbtcdvSM4Xid7+136ZzJ
	f8GGQrlU=; b=dBAAmqs81t02Ob9zsAtH/mGOE6VnilLdiLao5YsmBhf8S2R8Gal
	IFoZcE0CxmoZaIGAae8mtzMCAF3NpMS108PU4g/G0I+YOPFuAJuVUXwZCAlTT2Kg
	o/LKki11f2PGuDocrPHb1yhFrAOSs8unUg86ogif73NJmbSytiI7cQgXJdmfvqeU
	6bZXS2BVNk3lee5+G1J5p409EJ9n+riX0dX7GarfejiSyhuUTpNhYffVcMZ+SDL8
	avsvqBusYgEr2HZPQ/7kA5W34gIccC1I3tRZsXL9ahne3Hbtwz2QtYrxRQHy3lIG
	Z0S8R14r99dIC8duOu3ETX3Um8+ymfaD3WA==
X-ME-Sender: <xms:f5UTabA1Kh3Cg7k8NswgCD7X0tekZyvXyeHnDC9FcjBEGVQX_FuXBA>
    <xme:f5UTaXibCE6uNNTh_bLnHXYzJWiQxy-0vwQcJM1vZFnuxzkGMby68JN5B8RIASMSH
    MvyvGzDWqBD5yil0TMuzEYfAQmTb2XFFDvEJgdPmLZdw47ZvMbGOQ>
X-ME-Received: <xmr:f5UTaUP4QIyWRe7lrvtBBPaqU6NxSSuSOuT4hBm7rZT9ZsAo3PgF8KkWGNeBefaRmdI0ejiFykGwEenM8Cxes8NgiWAyPndYDLMr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepfeelveduffeltdejgfdvueevgefgveelud
    ehtddujeetgeffieeljeeuieethffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:f5UTaY4vVDYNNbiF3MBqffSzhOoBhhIylpvdoUcwylhPKcxUWOnB_A>
    <xmx:f5UTaS1RQKltdJFyWSPNRsxdbVnfq4NzbVMZy3oWkT9dQj7YuwQMqQ>
    <xmx:f5UTaZbpZFKZiuvvVj2HE39Hix53AFsIxOG66ktB7-K7gp87oFNYgQ>
    <xmx:f5UTaaDrsASMFkmvsOadW5My8z3kY72cNmWRxTPuXYhxdk3CE6ugXQ>
    <xmx:f5UTaebbuzhuWkHXSBzr8k0ALHWeb-Lf5Oo1ieQ2rNz3dvxIpryu02yF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 14:58:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 0/3] War on "work tree"
Date: Tue, 11 Nov 2025 11:58:50 -0800
Message-ID: <20251111195853.2511146-1-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are "working tree", which is explained as

	The tree of actual checked out files.  The working tree normally
	contains the contents of the <<def_HEAD,HEAD>> commit's tree,
	plus any local changes that you have made but not yet committed.

and "worktree", which is explained as

	A repository can have zero (i.e. bare repository) or one or
	more worktrees attached to it. One "worktree" consists of a
	"working tree" and repository metadata, most of which are
	shared among other worktrees of a single repository, and
	some of which are maintained separately per worktree
	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
	per-worktree refs and per-worktree configuration file).

in the glossary, but there are many documentation pages that talk
about "work tree".  Most of them were written before the worktree
mechanism was invented (i.e., back when contrib/workdir was the only
hacky mechanism to attach more than one directories to the same
repository) and they use "work tree" (two words) to mean what we
call "working tree" these days.

This patch series updates our documentation to use either "working
tree" or "worktree" as appropriate.

Junio C Hamano (3):
  notes doc: call NOTES_MERGE_WORKTREE a "worktree", not "work tree"
  Documentation: your checkout directory is "working tree" (part 1)
  Documentation: your checkout directory is "working tree" (part 2)

 Documentation/diff-format.adoc     |  2 +-
 Documentation/diff-options.adoc    |  2 +-
 Documentation/git-add.adoc         |  4 ++--
 Documentation/git-grep.adoc        |  2 +-
 Documentation/git-hash-object.adoc |  2 +-
 Documentation/git-notes.adoc       |  4 ++--
 Documentation/git-read-tree.adoc   | 16 ++++++++--------
 Documentation/git-rev-parse.adoc   |  4 ++--
 Documentation/git-rm.adoc          |  8 ++++----
 Documentation/git-stash.adoc       |  2 +-
 Documentation/git-status.adoc      | 14 +++++++-------
 Documentation/git-submodule.adoc   |  4 ++--
 Documentation/gitattributes.adoc   | 16 ++++++++--------
 Documentation/gitcli.adoc          | 12 ++++++------
 Documentation/gitmodules.adoc      |  2 +-
 Documentation/user-manual.adoc     |  8 ++++----
 16 files changed, 51 insertions(+), 51 deletions(-)

-- 
2.52.0-rc1-455-g30608eb744

