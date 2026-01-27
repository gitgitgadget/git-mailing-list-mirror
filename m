Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF812D838B
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556390; cv=none; b=qheQLN1l6I68k9wMkw4pSa8Lrt31lR6Csz3LOE5zDADgwtuDqsF8YsQWSmcD+vZZNKjKBrquh289gLTlvDAlEzcQ7h5mqwSMcDeGkIRMyF1YKlVXQN0oBdteJ0JiC9kehaUX/6msy5b5QtUYBsFrIVxctB5ABAXF7sFyqtWQNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556390; c=relaxed/simple;
	bh=VCHpqxZl3lDX49Us4d4tepXE13E76tyFkkTD2712SYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P/Z0ZuZT7p6risGz+D1G4A0i9aHvdFJtHtdDOtLJSd43Jzxv8H+grfm++h06NxKNw7E0NW+JFFV1XACMZoT5FXPkUkF0n3Nat2u5EY+q3O76AzsRe7Q87LEbpD/60/1RZQBQbVR6NECILAQ5Ke5RwFq007UdElpAckU8Vw9wOyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=id5XWAT2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mv13rvSF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="id5XWAT2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mv13rvSF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C2CC1400111;
	Tue, 27 Jan 2026 18:26:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 27 Jan 2026 18:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769556387; x=1769642787; bh=2oZqSTrXmu
	t6M8TyFlbK/TbZ5iNx8r+DhutfC4Vz8X4=; b=id5XWAT2BODYKrrtDu0XdRNV5p
	6sqMTqMjcoippcTGrpl2r5//NAhnRRzJurAZUczBBlM5P6pmWcP9VuAC9bs4Qy5s
	vm+8zLjD9dH7mVLjNZ8uxIT8x4WbhtrTOnd+7ubnYSqgudonD4KqNt77HJCFdOcu
	Sthu0ZCTjMClNX2IxJ/7F8o4I6HTDHH68Nvda2Z4l6gYIZLEgsCSwTHsEsc9RE+o
	Q59VuXyQ3q179QD8eL3L4hliO0zHJDvEFzJ+eWP+NQx9OhoLaGN+/QE17UI6sbLQ
	wXLK/slqmiLo+HBnLLrSl6laSkns06fPVXQaNZiEB73Zxhsk1j0Omx7fWWoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769556387; x=1769642787; bh=2oZqSTrXmut6M8TyFlbK/TbZ5iNx8r+Dhut
	fC4Vz8X4=; b=mv13rvSFPSVdOsHBEq4hax9uPWWqJ7DM+C6snReYr77suQPdM+l
	I/L3qUPVoJSnS+k267zkQpfWDoPxA70+Y+kzKz+qA6hJf/1pOW7NH3PJUsmvrdoN
	94rI3B7jZv1iVzQD5JRlURh0cy3cce7B5Ljv6hgob5+iaqYIe8uaTCxgyXCYBh9x
	gMPuZpIaSpgevUw1B+naT/2fdx6ONViVZpAgO9nrYCFGC9ksFF/fq7oY7HDG65BC
	71fYBeI4VZFZRnL62QcLANY13Mqp1txmX/I1WR7Kfh9+7hwdLFAfBdICcS/JGM+8
	GWWoQbUgneBXJ09Su4RNzy+JzhnTb1GU+Zw==
X-ME-Sender: <xms:o0l5aRCBdQGVOiLZG3Xc1fvhm6BcaWE6REM33ulU0lqbvLmYTbowwg>
    <xme:o0l5aY3Dqe_fmkwuuVAfLnHZsbbXHm-zM1kD4zfnGjtYAhObUY4lRyzUkY8ThAAkw
    oBg0JXElgRGfHM8Ikuj4j9JSY-5kdKyvHCC9JdZoHn5RjiHZaZOOA>
X-ME-Received: <xmr:o0l5aT3AaoPHkWq1lxeepZXoXe6KcyvbZH1qJQvfjF72wRnjFx5opv1YSZ4p6eis6s03x3_Ggz6ydBy9H4a38_oNxPKRkMLkr4xokKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhthhhusggptghhrhhishgpihguvghmrgesphhrohhtohhnrdhmvgdprhgtphhtth
    hopehmihgthhhisehitghoshgrhhgvughrohhnrdguvgdprhgtphhtthhopehprghtthhh
    ohihthhssehushgvrhhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:o0l5adDGlop-gV6YtDQiuJOBZkbH-IxOXpGcZJijBGcaZR0PLxxASg>
    <xmx:o0l5aS79mS547PPHvWVPHEq1GsZt5sVAOFWVjactSV12tVtEhjlEVA>
    <xmx:o0l5aeIkPnqk9uRT08V9wphilScJzPvjtAh4MZqnkrsmgFRn-0PH5A>
    <xmx:o0l5aTucNMnW2KEW-9Fp2OgMpQWHrccfKICjEP8x1Tfg0CD5MzM2JA>
    <xmx:o0l5aaVxm4yo7tQyzaIKA698V1a0NTOwW_SMBRtBJHMuLOYw-mMR0Ki6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 18:26:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Idema <github_chris_idema@proton.me>,
    Michael Lutz <michi@icosahedron.de>,
    Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
In-Reply-To: <xmqqsebqem1n.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	27 Jan 2026 14:19:16 -0800")
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
	<xmqqsebqem1n.fsf@gitster.g>
Date: Tue, 27 Jan 2026 15:26:25 -0800
Message-ID: <xmqqfr7qeixq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> By the way, this has nothing to do with your change, but the only
> existing use of "apply_tab_size 1" is also somewhat curious.  When
> "proc read_diff" detects that a patch hunk header has three (not the
> usual two) at-signs, it calls "apply_tab_size 1", presumably to
> adjust to the fact that combined diff has two leading columns used
> to signal added/removed/context lines, instead of one.
>
> Apparently the author of the original code thought that it is a good
> idea for such a payload if first tab moves 1 column, and second and
> subsequent tabs taking gui.tabsize after that tabstop.  A line in
> combined diff uses two leading columns for line prefix.  Isn't it
> curious that these two patches under discussion claim that the same
> exact setting of "apply_tab_size 1" is appropriate for _anything_
> that is shown in the $ui_diff widget prepared with "proc
> clear_diff"?
>
> Presumably most of the time, the output format would use just a
> single leading column for line prefix added (+), removed (-), or
> context ( ).
>
> Both cannot be correct at the same time, can they?
>
> So, either the original author is wrong and the current code is
> broken with or without your change when it shows a combined diff, or
> these patches is wrong and there is off-by-one bug somwhere.
>
> Puzzled and curious ...

Apparently the whole thing comes from a43c5f51 (git-gui: add
configurable tab size to the diff view, 2012-02-12).

It is clear that "apply_tab_size 0" is designed for a single-parent
diff, while "apply_tab_size 1" is designed for two parents diff.  If
this new series to make sense, I think it should argue why that
setting that users are already familiar with for the past 14 years
is wrong, and "apply_tab_size 1" is more appropriate for a single
parent diff (and presumably "apply_tab_size 2" is better for two
aprent diff), I think.

I do not know if those involved in the original commit are around,
but just in case if they remember, I'll CC them.


commit a43c5f51a4b1e56b746295f19daa240283092005
Author: Michael Lutz <michi@icosahedron.de>
Date:   Sun Feb 12 16:55:17 2012 +0100

    git-gui: add configurable tab size to the diff view
    
    For Tk 8.5 the "wordprocessor" mode allows us to get a bit fancy for merge
    diffs and intend the tabs by one to compensate for the additional diff
    marker at the line start.
    
    The code is heavily based on how gitk handles tabs.
    
    Signed-off-by: Michael Lutz <michi@icosahedron.de>
    Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

diff --git a/git-gui.sh b/git-gui.sh
index 6cbb36eab6..bf68699616 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -912,6 +912,7 @@ set default_config(gui.fontdiff) [font configure font_diff]
 set default_config(gui.maxfilesdisplayed) 5000
 set default_config(gui.usettk) 1
 set default_config(gui.warndetachedcommit) 1
+set default_config(gui.tabsize) 8
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index b0a5180af7..0d56986215 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -1,6 +1,19 @@
 # git-gui diff viewer
 # Copyright (C) 2006, 2007 Shawn Pearce
 
+proc apply_tab_size {{firsttab {}}} {
+	global have_tk85 repo_config ui_diff
+
+	set w [font measure font_diff "0"]
+	if {$have_tk85 && $firsttab != 0} {
+		$ui_diff configure -tabs [list [expr {$firsttab * $w}] [expr {($firsttab + $repo_config(gui.tabsize)) * $w}]]
+	} elseif {$have_tk85 || $repo_config(gui.tabsize) != 8} {
+		$ui_diff configure -tabs [expr {$repo_config(gui.tabsize) * $w}]
+	} else {
+		$ui_diff configure -tabs {}
+	}
+}
+
 proc clear_diff {} {
 	global ui_diff current_diff_path current_diff_header
 	global ui_index ui_workdir
@@ -105,6 +118,8 @@ proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
 
 	set cont_info [list $scroll_pos $callback]
 
+	apply_tab_size 0
+
 	if {[string first {U} $m] >= 0} {
 		merge_load_stages $path [list show_unmerged_diff $cont_info]
 	} elseif {$m eq {_O}} {
@@ -401,7 +416,10 @@ proc read_diff {fd conflict_size cont_info} {
 
 		# -- Automatically detect if this is a 3 way diff.
 		#
-		if {[string match {@@@ *} $line]} {set is_3way_diff 1}
+		if {[string match {@@@ *} $line]} {
+			set is_3way_diff 1
+			apply_tab_size 1
+		}
 
 		if {$::current_diff_inheader} {
 
diff --git a/lib/option.tcl b/lib/option.tcl
index 23c9ae72a4..b5b6b2fea6 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -161,6 +161,7 @@ proc do_options {} {
 		{b gui.warndetachedcommit {mc "Warn before committing to a detached head"}}
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
 		{b gui.displayuntracked {mc "Show untracked files"}}
+		{i-1..99 gui.tabsize {mc "Tab spacing"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
