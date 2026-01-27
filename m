Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D5250BF2
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552361; cv=none; b=gMrbkw1LDKlIKpD906WmDo22x2fLYziGKFXUngKz23RPWlq+F+scWTbhc8Jo4i5/mV+Z9zAuGcEoXT6UAnelW63QLLgSG9XrTLYahD9L80dl+ebPaoiPCSgqhPLlYita149FxZV6xn7JxKHYybDUOyVRCmhbS5c8yRg29G2UEX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552361; c=relaxed/simple;
	bh=aihn77Hjkotpbc4CjouvKGu9F7LXy8bc6aTrKilIhSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H2akZaSDfAnmCdl2H3VQo3bakiUYehYYsS3RpsBetqQ93Wib3drgCKi6+izD/Uzzp0cvN7RNeojtW/XeSASgSEQYJH+O7pW4kiCMwVxu/uy22KYWj8wFMJDKEwkYXSMmR3wjOJTnCBgQ1P0MWkZckSFJeptFQoO2JBkkxJRYbYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QTo0Yud4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ruGlZq8i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QTo0Yud4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ruGlZq8i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D1E6DEC023C;
	Tue, 27 Jan 2026 17:19:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 27 Jan 2026 17:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769552358; x=1769638758; bh=VEhrlYhbJF
	3fK4D2YCdpEphhMRZv4e3w8NRptJ3/Ays=; b=QTo0Yud4BV3+X7I35Fp5phpcT4
	R4kljE+GI53O4buBbqp5eqiQiGvekW0I9tUMZpTup+n+NJV1rfzshvIrMOsktiBa
	rG2MmXoCRRr3ET0OqF4SamzVNnjoZo9ZlMebsJ5UUCEP1OJCRCmptrwWfiuSQD1Q
	i/d+9HH0DWfCWF07Qduaony+ci8TXc2VgGbl4au9qb13bqhoaLJPvU78enCiCoBu
	bpUnbfNMJfz6nVDTRFT1+fuJZi47Y1UHq0PnZxiBlGTCgIAQy90e/yVGtwr28D5K
	LO3AgWXbVP7NPEo4V9cIJ6qBCoD9CsjG89XTpovZgXPdyEgr0vPuFzCp/t2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769552358; x=1769638758; bh=VEhrlYhbJF3fK4D2YCdpEphhMRZv4e3w8NR
	ptJ3/Ays=; b=ruGlZq8i8D8vqXC9gCu0nAP24EIZMyBGD8iwRmFQ/CnVwHBaN6C
	Vm9GLtLh0jkY17ViBbbDO9LfKwfXsqwav+LpZVdO8wLzcadL1Kz0m7jQXBPTr5tX
	MNbKe1xjdCK+N75/WGuEptDv4ByK34MmvzTPuyiCiNGhs98SQ0tJsz7PcHm6wgdf
	GZMAt/eP9dmB6treLTgJxGCBdHpWgkKjGdaDgruSNPDnsdBmDI39Qn/B9eseiRQZ
	bD+JX+ho710/E/hdLQtn9NPT3EjZVVXp0j6yeQ9o5Hhl72vnXXfdVVq1fprTuf5O
	l8llxEGIh9DEpQtXhRvdY/C4rgR1XYV4MfQ==
X-ME-Sender: <xms:5jl5abuEpB2Ge7zJ8AT_2-2E5nBBCs_iZlt898H__gfnMK0PDMm_GA>
    <xme:5jl5aTdG31fEYI3A4uPXFqTliync4PWBIKuEDUid0nKIg_utlmP4JidkxhgoWKnC5
    v-Aa9f67_gSQwTAR_LPXAwVJKHMdL1FaXqljhHYQkcYWyaTLSGywA>
X-ME-Received: <xmr:5jl5aTxdxN1kOmX4ypqEnQVzNy7oWvhQyAQXgJIPrE6_1hLCK0FL7Jx_BSTBI9puVEuJ-xqMAX5dg_LiImTtPvQfe_t3w85QWYzhwiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhthhhusggptghhrhhishgpihguvghmrgesphhrohhtohhnrdhmvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5jl5aZGoz6xx3zisrGnlCeB3C8yZwRQ4NvU8qxF2WrjJyv4QRqp8og>
    <xmx:5jl5aXxByvZmArTTc580jxdsPr5ylrBxDIwHqc635E7atz5iya9W9A>
    <xmx:5jl5aauX2f9eYxX2MngBv4YZ6nQjV-V0tXRfbSnAeB3b1xQlW4lAXA>
    <xmx:5jl5aU1JeBHhoCB6uaKxE9cK89PKyEqS6NCBDejztcSBCwQEu4OXHQ>
    <xmx:5jl5aTwyV2_a9qTpfUfgY9PmSVKSxgBQUIyYkd4Fic8MFygzqyBMp7li>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 17:19:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chris Idema <github_chris_idema@proton.me>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
In-Reply-To: <e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
	(Chris Idema via GitGitGadget's message of "Tue, 27 Jan 2026 20:33:16
	+0000")
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
Date: Tue, 27 Jan 2026 14:19:16 -0800
Message-ID: <xmqqsebqem1n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Chris Idema via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chris Idema <github_chris_idema@proton.me>
>
> Signed-off-by: Chris Idema <github_chris_idema@proton.me>
> ---
>  git-gui/lib/diff.tcl | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
> index 2e13f8c776..0f0951cc57 100644
> --- a/git-gui/lib/diff.tcl
> +++ b/git-gui/lib/diff.tcl
> @@ -12,27 +12,6 @@ proc apply_tab_size {{firsttab {}}} {
>  	}
>  }
>  
> -proc expand_tabs {line {startcol -1}} {
> -	# startcol set to -1, because in preview the lines start with a '+', '-', or ' '
> -	global repo_config
> -
> -	set col $startcol
> -	set out ""
> -
> -	foreach char [split $line ""] {
> -		if {$char eq "\t"} {
> -			set spaces [expr {$repo_config(gui.tabsize) - ($col % $repo_config(gui.tabsize))}]
> -			append out [string repeat " " $spaces]
> -			incr col $spaces
> -		} else {
> -			append out $char
> -			incr col
> -		}
> -	}
> -
> -	return $out
> -}
> -
>  proc clear_diff {} {
>  	global ui_diff current_diff_path current_diff_header
>  	global ui_index ui_workdir
> @@ -516,9 +495,8 @@ proc read_diff {fd conflict_size cont_info} {
>  			}
>  		}
>  		set mark [$ui_diff index "end - 1 line linestart"]
> -		set line [expand_tabs $line]
> +		apply_tab_size 1
>  		$ui_diff insert end "$line" $tags
> -

Why does this series first add proc expand_tabs, only to remove its
use in this second step?  Shouldn't these two patches be squashed
into one, and explain why we want to use "apply_tab_size 1" here?

It smells fishy to do "apply_tab_size 1" here in "proc clear_diff".

It is called from "proc show_diff" but the latter, after it calls
clear_diff, calls "apply_tab_size 0".  Doesn't that defeat the
effect of this new call added to "proc clear_diff"?

By the way, this has nothing to do with your change, but the only
existing use of "apply_tab_size 1" is also somewhat curious.  When
"proc read_diff" detects that a patch hunk header has three (not the
usual two) at-signs, it calls "apply_tab_size 1", presumably to
adjust to the fact that combined diff has two leading columns used
to signal added/removed/context lines, instead of one.

Apparently the author of the original code thought that it is a good
idea for such a payload if first tab moves 1 column, and second and
subsequent tabs taking gui.tabsize after that tabstop.  A line in
combined diff uses two leading columns for line prefix.  Isn't it
curious that these two patches under discussion claim that the same
exact setting of "apply_tab_size 1" is appropriate for _anything_
that is shown in the $ui_diff widget prepared with "proc
clear_diff"?

Presumably most of the time, the output format would use just a
single leading column for line prefix added (+), removed (-), or
context ( ).

Both cannot be correct at the same time, can they?

So, either the original author is wrong and the current code is
broken with or without your change when it shows a combined diff, or
these patches is wrong and there is off-by-one bug somwhere.

Puzzled and curious ...

