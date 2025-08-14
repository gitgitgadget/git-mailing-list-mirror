Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36C274B46
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211759; cv=none; b=YIzmLt57ln0a0TvK948/vpgeShvVZfsMIL3M6ZpvomrUPQyCDf3eUyxesqEhGhcZgvBLOw+dDxC5ZHfDLAK81Ot0mqTC3DtY2CLyiAenFJN6G/2BdMgmpD8Taok1o+KnFM6BYUyPon1TewraqSYOmNjANx48V7+9afjOgPtrkig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211759; c=relaxed/simple;
	bh=Uw9c8KoLPbPe+W5LX/v80WD+QC4yeuVfc+5eRdedErc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qL0DIaE9dQEdwlpMyV+zuhRjITJixJ37NDb4yNjarvL2N1Do1WQWmy1ECpJFvyb1z8bibI4mAyBLeMp7xY5eLzqZfqkq5o1LFk/bZA/jYDswRVz/wqgC/zP+0MOb7cT33n9ImiSyX8Ok5YUB+GLTqhyJKHDg+EQ0t4xyZFJiwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ouozk9za; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GpCKC9ka; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ouozk9za";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GpCKC9ka"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 54C91EC0201;
	Thu, 14 Aug 2025 18:49:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 18:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755211756; x=1755298156; bh=c8Nn0rKmm7
	s1ODVDWtH51CdMrS4apWFeiskBFkEFI0Q=; b=Ouozk9za35PjJWJraDAFUg8svy
	XW+8oUJA37PaIjv1ODCvl4KQ4bpfv9W2ijnl1wjlrMxtpHsEpE/BbMKZArKLaj4X
	FO4Hs4NG6WLxpEmpqD11Vam6R5sVs3NRzC2qQThiG8rPgQL1eB6F6QpfBhKwcxsI
	OufaoBum9aodWuqhRAFdtO4837vXyLd0vyokihFcO9akCX17WQr2WL+Q6wgSqg1v
	lGFVs4X/Gp86SP8PK2O5wlnwDutVZPqogYOb5dEowVTtkA61oCkozQB0SuZROact
	w7UjBJBp0TljTzUHClwn76UbrqEpDW4HFWh8nIto9rox5dUiOfUhD2tFF6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755211756; x=1755298156; bh=c8Nn0rKmm7s1ODVDWtH51CdMrS4apWFeisk
	BFkEFI0Q=; b=GpCKC9kai64gdoot+D0rVangASdV/pzCYm5ufB/3GvH307/yYIL
	tV+TPdQA46D+T9rOSXEFbEFCVDWuiAUNlKG6cOPDoeXh5tJiEEQhQbJsK1+fuGpj
	EQr0mp41VzAFs+uHnakIrzileQQX/cyMyWkFqGb0fN8GFdLs9sbxx/3XbDFhUktm
	WLe5gQvDyj9kZf+3QIDfe0FyOvgnz1oPNMRAfqw+UpvdRhLXxCFR7KNz+i3SKwn9
	p9XIyQNdEHgyymvL0Pc0awryByrMe9/Bot0bbeN6WAJnYq2sEo+AP45wzOJowuuC
	YRmvNJMwVCXwhwKJrt4BiI6REbJ7fub0INA==
X-ME-Sender: <xms:7GeeaEgFEgSwZrpqX3WIxDRlyu8HicOMdfyYI1B7OiX15fGZKFuXBA>
    <xme:7GeeaKnLDiYOqiZPftyt7Zpr1PwkqBpb8WDcyiNV7hBOf93YwPDceCBpVigDWu2Y2
    uC9b1SpevvRkqtx6g>
X-ME-Received: <xmr:7GeeaCj7wVsJdIN7zYZnO8wH0WtpBnKVPY5aggFZUW3EoQFJnklLQHWIh5dWlVsjyp1XyuUqHi9TwJu0ZmwJAxQAYw3NJGl3CkogQXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7GeeaG200tkitw3sdaCle7bmD7o6R9vvsBib_1mDlvKN7NPfoRCh6A>
    <xmx:7GeeaDIgmjlotOUXteim5Y7UauvPP9QYiNm-nezsN8hvLxJr1JR8JQ>
    <xmx:7GeeaOz8fn3YT_5E7D1NBmlWssFsROqszClHgSx89ZD0YRdb4zVONg>
    <xmx:7GeeaJWzRubEynX1eFaWwLbeJdwtvWUKuzHTx_4vkSODHXZT9pbMtg>
    <xmx:7GeeaPYFN3QaWA8LbcysBhO96a_E5SSFsiqWgtgZDUm0FcXZV-o9t8oG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 18:49:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,
  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 4/4] doc: git-add: explain inconsistent terminology
In-Reply-To: <9e595f9ad59776d74a431731824410c7b73795dd.1755127218.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 13 Aug 2025 23:20:18
	+0000")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<9e595f9ad59776d74a431731824410c7b73795dd.1755127218.git.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 15:49:14 -0700
Message-ID: <xmqqldnlwmc5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> I think the fact that git uses these three terms interchangeably is
> extremely confusing and that it deserves to be noted.

We tend to avoid saying "I think" in our proposed log messages, as
we do not churn the code and documentation merely to match personal
preferences.

I do not necessarily think "git add --help" is an appropriate place
to leave this note, by the way.  We should start from teaching "git
help glossary", which does not mention "staging area" at all, which
is a sign that it is somewhat outdated.  It does not use the verb
'to stage' even once, either.

Here is my attempt to improve the situation by giving a definition
of "staging area" in the glossary.  Luckily, "cache" already has its
own entry, describing it as an old synonym to the 'index', so I
didn't have to do anything there.  Also the description of 'index'
has a bit too much implementation detail, which I toned down.

---
Subject: glossary: talk about "staging area"

Surprisingly, "git help glossary" does not mention the 'staging
area' synonym for the index, or the verb 'to stage'.  As "git
status" output uses the latter (i.e. "Changes not staged for
commit"), we should not leave it undefined what the verb means.

Rewrite the definition of the `index` somewhat to reduce the level
of implementation detail exposed, and focus more on the fact that it
is a mapping from pathnames to the contents at these paths.  And
mention the `staging area` there, as well as giving its own glossary
entry.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/glossary-content.adoc | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git c/Documentation/glossary-content.adoc w/Documentation/glossary-content.adoc
index e423e4765b..10f0c21e88 100644
--- c/Documentation/glossary-content.adoc
+++ w/Documentation/glossary-content.adoc
@@ -247,11 +247,15 @@ for a more flexible and robust system to do the same thing.
 	of Git you had to make them executable.
 
 [[def_index]]index::
-	A collection of files with stat information, whose contents are stored
-	as objects. The index is a stored version of your
-	<<def_working_tree,working tree>>. Truth be told, it can also contain a second, and even
-	a third version of a working tree, which are used
-	when <<def_merge,merging>>.
+	The index stores the mapping from filenames to their contents
+	to prepare the contents of the next commit by updating the
+	object recorded for each path (for this reason, people often
+	say that the index is "like the staging area" when explaining
+	the concept), together with other information to detect which
+	working tree files are modified efficiently.
+	During a conflicted <<def_merge,merge>>, the index can have
+	multiple versions of contents at higher stages for the same
+	path.
 
 [[def_index_entry]]index entry::
 	The information regarding a particular file, stored in the
@@ -650,6 +654,12 @@ the `refs/tags/` hierarchy is used to represent local tags..
 	is created by giving the `--depth` option to linkgit:git-clone[1], and
 	its history can be later deepened with linkgit:git-fetch[1].
 
+[[def_stage]]staging area::
+	A synonym for <<def_index,index>>.  Adding contents to the
+	index to update the mapping from the filename to its contents
+	is often called "to stage" (verb), as people explain the index
+	is like a staging area to prepare for the next commit.
+
 [[def_stash]]stash entry::
 	An <<def_object,object>> used to temporarily store the contents of a
 	<<def_dirty,dirty>> working directory and the index for future reuse.
