Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D1241663
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824509; cv=none; b=PibcRXYRPj0rNUA6LvuPwdpo5I6gSGxJh7Cgxm9yB+/ZG54+Mu9h3KWANcLX/E1c9imFmTzinHbyJG9kL6Y2Veh7sH+x0O8QI4XEIBoBxWCnXuFKP4BlbthqQXMIir7PfYbtV/l/EJNYDv3J7xScMjPUa5xICSCXmSBYZV00DtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824509; c=relaxed/simple;
	bh=XhJmRWFXnT0b6J9q+klJ4Fmot4CmQCCDSbOa5MU0NMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z8iYt6zWScj5XIGnBYb7q4OU8hcl+rM/7td/erYjAS9apA+75TK7Hf0XqIRVBowfpta/XEByLLnW3g4NyXm7ZpA0wwKwPUCzJowrHa5I9WbC+gebJmtHSxH8joqz511JjiQ1bNq2xto5f/pilww/1BGWINS/JCsISmytwvgkDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vPAu3csw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNl86ixV; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vPAu3csw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNl86ixV"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EA64EC00E0;
	Thu, 25 Sep 2025 14:21:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 25 Sep 2025 14:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758824505; x=1758910905; bh=nbIAbTt9Im
	jgGgYG+CuC9e2oOeEwmMVBLRmgumzRy2M=; b=vPAu3cswMEzzfcl051NFQjMahI
	BjR/AJ8RHvquWEaxwII2auZAycgmHKFR5WakUjjTNWQiKJhWxlXlnxTH87Gkkqqx
	UtLE1yc3yisGMxncge0THimWgZCmLqLTJVv46e1DuRsGUHyTfEh7JJfBhogQ8QLl
	3zrBYPt+hX25oZ1YD6GhhmD7w4ReRKSdyz6PlUogZzW+zPFivV6Rbm22mJEuTkMo
	M7xTWGNZlPM8NTvmjavtHT5zcLg7PkTgj6DAkSx0+jEiHrLaOsEbVvBjE2UFaoGp
	Xfcst2yKwJmsSAbR9IiUv9gBfJztj9IklJvj0LWwnCMcH6otlX52Fyw7lR6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758824505; x=1758910905; bh=nbIAbTt9ImjgGgYG+CuC9e2oOeEwmMVBLRm
	gumzRy2M=; b=PNl86ixVmbuoOQtgCaAXrsJSj1OGWpQMXLaHlbZtmFRk6/LYIuc
	PIvm8iC7nREDPB0rROfj294pn2IEV4J40bAru9Jc7p7wLYqF0+SOYtEmAywYKBxs
	rYZrDpt+bpR2/EoXEvhamyhHGe6FoobyddeL6vo5V4N3e+3c/NjOS7TDxB993GWL
	7SZ20wxSEDKWDto8NQEFmTelzQOBGEqqrlMalLsMVtOBv+XqNDRqRXAp7GTfHv6S
	iBOqbA0bRJYyxY9d253oYfdC4GE60P73gzWF481SBxw4gK2+XFQG0M3p+m06zR7x
	iDvxcraJ45CFPCHsEo+/wQvXfLoFewGHUcA==
X-ME-Sender: <xms:OYjVaAm7EiQrE_uUQHwEWNtg_QguAdkvOK2sacfngCJJHcqu21faLw>
    <xme:OYjVaJIoPU4hsPUzkyDYcbJTDvHUAz26GmFG1naaVDnWHEBIaJXGGYar38xEr0Eek
    qqhtmbDb9yvxG_PLU1lS33gTtVoN0Yp1Z8pZBarjYatG824ZMi9Pg>
X-ME-Received: <xmr:OYjVaF5Bi6uSYzvkNUanfLaVu77JnaZ-IDw6pukXF5oQeZqu9d8t-aTxOBdlU-Xg7RGE3dtMA0K9Kbwk2arajERTT6OjlKt4jA3L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:OYjVaN1n3XwHwPBu0729PLBm3wiHU2p23PigEZvRDzme9cRyJzgV_A>
    <xmx:OYjVaLc9WonzL-HwjZnOIbvOz9NJ-DKAXbiQ6qDZ5hZTm7kENFUmcQ>
    <xmx:OYjVaDe1YCRK7nrLHCFZ14RE8mO1y4u2ZIXfThF1S3POmG5C0ocNNw>
    <xmx:OYjVaGxu9AurbDQQp6_tF119dn_j4VnvWfHCQQhof9-v_Yblf6c2Aw>
    <xmx:OYjVaNtyX5alL_8m4X_9hAGErSi32zEEelymymVOM_LYwU64t2SJGSYb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 14:21:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/2] add -p: mark split hunks as undecided
In-Reply-To: <4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Thu, 25 Sep 2025 15:10:37
	+0000")
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
	<4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 11:21:43 -0700
Message-ID: <xmqq348agzpk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ... In the case
> where the user only wants to change the selection of the first of
> the split hunks they will now have to do more work re-selecting the
> remaining split hunks.

In general, that is not just "first", as you can jump ahead, or just
keep typing "J" which is not all that hard, until you find the hunk
you are looking for, at which point you flip its status.  So I would
say that it is more work if you realized a small part of the change
needs to be deselected after you selected a big hunk, and want to
recover by splitting this already selected big hunk and selectively
deselect these small number of subhunks.

If you explicitly decided not to use a hunk (instead of leaving it
undecided) and then chose to split it, in order to resurrect only a
few part, the end-user experience would be affected equally by this
change.  The user is shown each one of them and needs to select.

> However, changing the selection of any of the
> other newly created hunks is now much simpler as the user no-longer has
> to navigate back to them in order to change their selected state.

So I do not exactly buy the above argument.

The traditional rule that applies when you split a hunk you have
already decided what to do with, these hunks will remember your
earlier decision so that you can selectively change them by going
through them.  The new rule says that by splitting an already
decided hunk, you are discarding your earlier decision and redoing
the selection from scratch.

But I think the new behaviour shines in one very important point.

When you are looking at a hunk, you cannot easily tell if you
already chose to use the hunk or not.  So if you select a hunk,
navigate back with "K", and then split it with "s", you may be
seeing the first minihunk.  You cannot tell if that is already
selected, or you need to say "y" to select it.  Or if you need to
say "n" to deselect it, or simply saying "j" is enough.

And the new behaviour sidesteps that particular usability glitch of
the selection UI.  By simplifying the rule to say that splitting
will cancel all the previous decisions you made on the minihunks
created out of the hunk, things will become much simpler.  You'll be
able to view all these minihunks again and choose their fate afresh.
You do not have to remember (and this is the hard part---there is no
strong indication of the current selected/deselected/undecided
status, unless you remember you came with "j/k" not "J/K" in which
case you are looking at an undecided one) what you decided to do
earlier when you look at each hunk, and the split hunks remembering
your earlier decision does get in your way navigating.

So I like the updated behaviour very much, but I am reluctant to
pretend as if we are siding one camps of folks who think that
splitting a selected hunk is done with an intention to deselect most
of the minihunks most of the time, playing favors.  I think that
is a wrong way to frame the problem this patch solved.

In any case, I no longer have problems with the updated behaviour
with these two patches.  Thanks for working on them.

Will queue.



> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c                |  3 ++-
>  t/t3701-add-interactive.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 302e6ba7d9..61f42de9ea 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -956,6 +956,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  			* sizeof(*hunk));
>  	hunk = file_diff->hunk + hunk_index;
>  	hunk->splittable_into = 1;
> +	hunk->use = UNDECIDED_HUNK;
>  	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
>  
>  	header = &hunk->header;
> @@ -1057,7 +1058,7 @@ next_hunk_line:
>  
>  		hunk++;
>  		hunk->splittable_into = 1;
> -		hunk->use = hunk[-1].use;
> +		hunk->use = UNDECIDED_HUNK;
>  		header = &hunk->header;
>  
>  		header->old_count = header->new_count = context_line_count;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 04d2a19835..a6829fd085 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1301,4 +1301,14 @@ do
>  	'
>  done
>  
> +test_expect_success 'splitting previous hunk marks split hunks as undecided' '
> +	test_write_lines a " " b c d e f g h i j k >file &&
> +	git add file &&
> +	test_write_lines x " " b y d e f g h i j x >file &&
> +	test_write_lines n K s n y q | git add -p file &&
> +	git cat-file blob :file >actual &&
> +	test_write_lines a " " b y d e f g h i j k >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
