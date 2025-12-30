Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD12264D5
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110696; cv=none; b=GbxXCRLAjLHTSCPDP7Qaw5+yzryclA3M4Uk75mTu/KSLLW7/bopLptk5/y+LLMrA/JyS01TH1SNcC8fJVLX+glyeGSJa1qHqLTCjTdXzjagGqT9h0nrRDcP5/LiC8Y5FKeG32WWL1QmvQXtoy6Tx7fI/mMPMr9J7vizuKwfF+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110696; c=relaxed/simple;
	bh=6+Fk9PKtxEB4F7dxa3ExCG5p9HZDnV/dG2iYUELhet4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BP6/MSmRx0WmnQnUo4gTm1ntWEbyYoapC4y2LtPmVQg5vGTxaarK0YLt34+lICqjSgjmS8biFvQEG+FDv4oDJw9tHpP1FhaHc9Wqk9VZGQJGGSPDB3aNQ/nLPF/LaXspZa8YtZQ3kkkkLjbUGumo9dyTs8AJhl/DbhISTW0beWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WyObanTz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeaA2Hpu; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WyObanTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeaA2Hpu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BA3851D000B8;
	Tue, 30 Dec 2025 11:04:52 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767110692;
	 x=1767197092; bh=djy8nIqBvipEX8VhFcDCLBQ95ytQFU4GbT5U3i94QYY=; b=
	WyObanTz31Z0h17TQiYuf0AEsz3MY34WFow0JbrGpIZ+Kl1mrksjaPI0llVz1u1n
	7iPPs/A1aACosW2QW2TZMu6cbPjXj7HGKciGlWoVP4Ycqb9Bebyq3cs+zXy3i9Vt
	W/2QbY1siWddkISVBZ9Nc8/HjRynjDP/dWsl87Sg4iTIsPBo71554Y5PsOHRjoGU
	Fq+iTM/h7ESmGoKy1Ao8H0BkAnSQ9q8tFtAPTKqIT1tT6wQJ+47cKUVsiWabO3K3
	k4/XjtZMzhAgbwzFD4MgLyh/g8k3AcqZv+STmiyhH9Uy+mJGh079w2W9W85n47El
	gfI1eISNt9W83dj2Adrb1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767110692; x=
	1767197092; bh=djy8nIqBvipEX8VhFcDCLBQ95ytQFU4GbT5U3i94QYY=; b=P
	eaA2HpuBbViMOmzi8ltBeyBLWgRNP47Z+Yv5hLyoycYNqcgUsY+3ZtdPN6Uk5mF+
	R0aMWMZsIBrVOUBhTZV5mdvS77GGPL8LJ6oP23TmxXvdTsaixq+7HfEut7U3ElCH
	B28Hh/KOYNRVZWv4Y4aozvNs9zUVhwK4YMrYFFUoJZNnHuztrkWOl42anWRURkzU
	NCsmmDb1A4rBzfSzxfwZhOznGUa0JyGauBeU2lJcgQu0L5KWUrfVpCnqzErGkTww
	am+lJvHGkCfYewJPklyT3I/RcUHhh7p4/L0bWu3R1HU1M41IsSx4aW2MpwZjn/wQ
	VLgaqVpHwG0QesgZslWeQ==
X-ME-Sender: <xms:JPhTaepR3v4_W5GNzvXx-jFpwshm0D10bw3RDOFpTi9EaQe7mBjcF5Q>
    <xme:JPhTaXfwh43LxAmUWmz3cvxG7T7F3APFkY_wrEF_dO9ghsHa91LqW6bW9L_Xuem0u
    a-PaowpP7pQ4ig2oZaFi502kEvJufl2RBogu2g2YdkzTvazkpkCR0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JPhTaXGaDW-79DXXKwl0yE0giW6faiwh-aWImxifIYOc5L8ghvzLbg>
    <xmx:JPhTacHLgsgOor02lig30LUpN7ZCpfJA-bjTbTlZbx3dV5W661UWow>
    <xmx:JPhTacOiDYEpSQGkC670a7osfGidivDqCKjNARVCP0R4ix76RaIcXA>
    <xmx:JPhTaTEAX2O0I5monUo9oB3Kv9GcgA_T5MJskBlHzGS4qSSsaCqrAA>
    <xmx:JPhTaRlmQX7rUtB1PxlcuCxd_kvrOCZCiR1UQU96yBLE7w8_QQ1-3U-I>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70FCF1EA0066; Tue, 30 Dec 2025 11:04:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArCNidGKT4nk
Date: Tue, 30 Dec 2025 17:04:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <9fae6398-cdc5-4ccf-8bd6-47425efb0c5b@app.fastmail.com>
In-Reply-To: <pull.2023.git.1767033783800.gitgitgadget@gmail.com>
References: <pull.2023.git.1767033783800.gitgitgadget@gmail.com>
Subject: Re: [PATCH] merge-ort: fix corner case recursive submodule/directory conflict
 handling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [PATCH] merge-ort: fix corner case recursive submodule/directory confl=
ict handling

s/corner case/corner case in/ ?

On Mon, Dec 29, 2025, at 19:43, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> At GitHub, a few repositories were triggering errors of the form:
>
>     git: merge-ort.c:3037: process_renames: Assertion `newinfo &&
> !newinfo->merged.clean' failed.
>     Aborted (core dumped)
>
> While these may look similar to both
>     a562d90a350d (merge-ort: fix failing merges in special corner case,
>                   2025-11-03)
> and
>     f6ecb603ff8a (merge-ort: fix directory rename on top of source of =
other
>                   rename/delete, 2025-08-06)
> the cause is different and in this case the problem is not an
> over-conservative assertion, but a bug before the assertion where we d=
id
> not update all relevant state appropriately.
>
> It sadly took me a really long time to figure out how to get a simple
> reproducer for this one.  It doesn't really have that many moving part=
s,
> but there are multiple pieces of background information needed to
> understand it.
>
> First of all, when we have two files added at the same path, merge-ort
> does a two-way merge of those files.  If we have two directories added
> at the same path, we basically do the same thing (taking the union of
> files, and two-way merging files with the same name).  But two-way
> merging requires components of the same type.  We can't merge the
> contents of a regular file with a directory, or with a symlink, or with
> a submodule.  Nor can any of those other types be merged with each
> other, e.g. merging a submodule with a directory is a bad idea.  When
> two paths have the same name but their types do not match, merge-ort is
> forced to move one of them to an alternate filename (using the
> unique_path() function).
>
> Second, if two commits being merged have more than one merge-base,
> merge-ort will merge the merge-bases to create a virtual merge-base, a=
nd
> use that as the base commit.
>
> Third, one of the really important optimizations in merge-ort is trivi=
al
> tree-level resolution (roughly meaning merging trees without recursing
> into them).  This optimization has some nuance to it that is important
> to the current bug, and to understand it, it helps to first look at the
> high-level overview of how merge-ort runs; there are basically three
> high-level functions that the work is divided between:
>     collect_merge_info() - walks the top-level trees getting individual
>                            paths of interest
>     detect_renames() - detect renames between paths in order to match =
up
>                        paths for three-way merging
>     process_entries() - does a few things of interest:
>       * three-way merging of files,
>       * other special handling (e.g. adjusting paths with conflicting
>         types to avoid path collisions)
>       * as it finishes handling all the files within a subdirectory,
>         writes out a new tree object for that directory
>
> If it were not for renames, we could just always do tree-level merging
> whenever the tree on at least one side was unmodified.  Unfortunately,
> we need to recurse into trees to determine whether there are renames.
> However, we can also do tree-level merging so long as there aren't any
> *relevant* renames (another merge-ort optimization), which we can
> determine without recursing into trees.
>
> We would also be able to do tree-level merging if we somehow apriori

s/apriori/a priori/

> knew what renames existed, by only recursing into the trees which we
> could otherwise trivially merge if they contained files involved in
> renames.  That might not seem useful, because we need to find out the
> renames and we have to recurse into trees to do so, but when you find
> out that the process_entries() step is more computationally expensive
> than the collect_merge_info() step, it yields an interesting strategy:
>    * run collect_merge_info()
>    * run detect_renames()
>    * cache the renames()
>    * restart -- rerun collect_merge_info(), using the cached renames to
>      only recurse into the needed trees
>    * we already have the renames cached so no need to re-detect
>    * run process_entries() on the reduced list of paths
> which was implemented back in 7bee6c100431 (merge-ort: avoid recursing
> into directories when we don't need to, 2021-07-16)  Crucially, this

Missing period before =E2=80=9CCrucially=E2=80=9D.

> restarting only occurs if the number of paths we could skip recursing
> into exceeds the number we still need to recurse into by some safety
> factor (wanted_factor in handle_deferred_entries()); forgetting this
> fact is a great way to repeatedly fail to create a minimal testcase for
> several days and go down alternate wrong paths).

Missing open paren?

>
> Now, I earlier summarized this optimization as "merging trees without
> recursing into them", but this optimization does not require that all
> three sides of history has a directory at a given path.  So long as the
> tree on one side matches the tree in the base version, we can decide to
> resolve in favor of whatever the other side of history has at that path
> -- be it a directory, a file, a submodule, or a symlink.  Unfortunatel=
y,
> the code in question didn't fully realize this, and was written assumi=
ng
> the base version and both sides would have a directory at the given
> path, as can be seen by the "ci->filemask =3D=3D 0" comment in
> resolve_trivial_directory_merge() that was added as part of 7bee6c1004=
31
> (merge-ort: avoid recursing into directories when we don't need to,
> 2021-07-16).  A few additional lines of code are needed to handle cases
> where we have something other than a directory on the other side of
> history.
>
> But, knowing that resolve_trivial_directory_merge() doesn't have
> sufficient state updating logic doesn't show us how to trigger a bug
> without combining with the other bits of information we provided above.
> Here's a relevant testcase:
>    * branches A & B
>    * commit A1: adds "folder" as a directory with files tracked under =
it
>    * commit B1: adds "folder" as a submodule
>    * commit A2: merges B1 into A1, keeping "folder" as a directory
>      (and in fact, with no changes to "folder" since A1), discarding t=
he
>      submodule
>    * commit B2: merges A1 into B1, keeping "folder" as a submodule
>      (and in fact, with no changes to "folder" since B1), discarding t=
he
>      directory
> Here, if we try to merge A2 & B2, the logic proceeds as follows:
>    * we have multiple merge-bases: A1 & B1.  So we have to merge those
>      to get a virtual merge base.
>    * due to "folder" as a directory and "folder" as a submodule, the
>      path collision logic triggers and renames "folder" as a submodule
>      to "folder~Temporary merge branch 2" so we can keep it alongside
>      "folder" as a directory.
>    * we now have a virtual merge base (containing both "folder"
>      directory and a "folder~Temporary merge branch 2" submodule) and
>      can now do the outer merge
>    * in the first step of the outer merge, we attempt to defer recursi=
ng
>      into folder/ as a directory, but find we need to for rename
>      detection.
>    * in rename detection, we note that "folder~Temporary merge branch =
2"
>      has the same hash as "folder" as a submodule in B2, which means we
>      have an exact rename.
>    * after rename detection, we discover no path in folder/ is needed
>      for renames, and so we can cache renames and restart.
>    * after restarting, we avoid recursing into "folder/" and realize we
>      can resolve it trivially since it hasn't been modified.  The
>      resolution removes "folder/", leaving us only "folder" as a
>      submodule from commit B2.
>    * After this point, we should have a rename/delete conflict on
>      "folder~Temporary merge branch 2" -> "folder", but our marking of
>      the merge of "folder" as clean broke our ability to handle that a=
nd
>      in fact triggers an assertion in process_renames().
>
> When there was a df_conflict (directory/"file" conflict, where "file"
> could be submodule or regular file or symlink), ensure
> resolve_trivial_directory_merge() handles it properly.  In particular:
>   * do not pre-emptively mark the path as cleanly merged if the

s/pre-emptively/preemptively/ (according to Merriam Webster)

>     remaining path is a file; allow it to be processed in
>     process_entries() later to determine if it was clean
>   * clear the parts of dirmask or filemask corresponding to the matchi=
ng
>     sides of history, since we are resolving those away
>   * clear the df_conflict bit afterwards; since we cleared away the two
>     matching sides and only have one side left, that one side can't
>     have a directory/file conflict with itself.
>
> Also add the above minimal testcase showcasing this bug to t6422, **wi=
th
> a sufficient number of paths under the folder/ directory to actually
> trigger it**.  (I wish I could have all those days back from all the
> wrong paths I went down due to not having enough files under that
> directory...)

:)

>
> I know this commit has a very high ratio of lines in the commit message
> to lines of comments, and a relatively high ratio of comments to actual
> code, but given how long it took me to track down, on the off chance
> that we ever need to further modify this logic, I wanted it thoroughly
> documented for future me and for whatever other poor soul might end up
> needing to read this commit message.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
>[snip]
