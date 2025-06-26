Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391472E718D
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952441; cv=none; b=UzrrhCGfGQWCUMZsPdQ7ZjatACU3iX8Z3QTbkNk+R1LSAgOx9jLHg6Mc2ZAfwBu1Aw9JFBe3Uutyvx2WLWDse+SzgxfPB9Boy0wN3Rcsyyh78fKKFq6v3xIrolP7Qvsg2y1pIsft8YT+6RwL7bL8MRxFJeuBPdj7iTbTJLUYue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952441; c=relaxed/simple;
	bh=zCxa2bWd1yTXsmsgr/Nu0TKdCNwXdHnRlMZhtZmOCBE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oS2kY0sLsP6upjjZOFx68Rkt0dOeiy95HnZrk9eCn9Y1co52+YTW6dDwOyIkKYMJyyNAXmPKLkr9mHS8kP4I7MUuao3q/DwftxyfNdOFwU7jxV/kwQvK0UsezC4qlXBy6w/UmY368sfyLO3u/UrjwpuK6a1ZpnmZ+7zBUTe0NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mWaqrsTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKGAAf5v; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mWaqrsTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKGAAf5v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 43A591D002AA;
	Thu, 26 Jun 2025 11:40:38 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 26 Jun 2025 11:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750952437;
	 x=1751038837; bh=Uoz5GAScyj7wMfL62fienX4LwGEGyp+cDujGlwACzIU=; b=
	mWaqrsTAl/Pkcc77TDOyCMcDX5Z10TwlQE7uA/cayQYlOfCeR8lOJ95YyNe6mkfZ
	25Ipi9TLABuFEDxh//k853oS78hODM0qrGNZVDSdJJON1xbS1SBOxtN6FPAtVp9G
	Gf5Ur1WksjSVn71KlGEoX4gCyBQ8IJJa0rm14VYORRBv/AGeyr41dyk6PFdCzrbl
	FHtORVjddHIDwaMALH+JwObF878V28MV2WYBAlBYGezpi2MwXadj+ybapXuE8LI9
	6ZP1uNUGZZBYuAcjoiC/bpjCee1ZE397i/9yf+i9XDqdJ8pYkb4ucPWDVqnVtcXi
	yJGog8cxoHzhDyi2+onDhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750952437; x=
	1751038837; bh=Uoz5GAScyj7wMfL62fienX4LwGEGyp+cDujGlwACzIU=; b=o
	KGAAf5voNTwVm0nUYAKP3FQ55MWC/mpOS7qN2lb4Oal2V4LnKM/JWhZLt/n88TAZ
	1Ib+/xFMo1pmzeol3X1AHXx6GG3fneCLV4jdm8LQ8FTjprkJqAgDDduXyElxxi1f
	0kK4S9ZgNJI8xiLE7zZfnWg4K2qM8LlIDLyGhp+zidtKfGrvFXT3jshiIhR2C70b
	6XHH0AWoJ/PAvmJ5CB/MilglEVCp/rsn4WQczCHwwuMDnztCjMmMxIqcSsaYiy1Z
	4VomlBUpQFSl4LhSqQdVB8pTLJ6HV2B7buQ9u0eRhZdNsFi28nL/PoidzIJdbte4
	xGWGkb4Qbn1FuWxiqhDpg==
X-ME-Sender: <xms:9GldaJEWkO22YvuB05eecj83azfFHQk2IIj3AUcK2WKw4R8jYqsnDOU>
    <xme:9GldaOX9QW7FxU5PQxr6jlpbRpRVvBj3b6pE-hNeXEludUPO_rY9grRXRr1Y-1xJA
    44pqw9meyn7TA70pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffueeuieehheffjeeg
    tdevfeehtdfhvedvgeduledtffehjedvhfejudffheegleenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegr
    hihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhish
    htihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrg
    hkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9GldaLIwsdjjxV9tC4YV16wLJjwrpJAU4n9gDGjkd3Ckvmb9QyFHYA>
    <xmx:9WldaPETLfrKuI3MepVHqifV7ihVsKMR10CBovRec5IXXHZ30Eujkg>
    <xmx:9WldaPXHi6EuIzmwYn-y8DQAfswJuGchBrdJeKyoOiP1oRXECxHYVQ>
    <xmx:9WldaKPd7KrFSJdoPHX7soQMmeAUj11XW0jfnFJuxih_tzUJcOY8EQ>
    <xmx:9WldaD96CnIU6lAwVwr-ELD4TWdSJPSJlebwW9LDpR8r8KxvIQPQs5q7>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9FC11EA0066; Thu, 26 Jun 2025 11:40:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T1b024294e1c81f41
Date: Thu, 26 Jun 2025 17:40:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ayush Chandekar" <ayu.chandekar@gmail.com>, git@vger.kernel.org
Cc: "Christian Couder" <christian.couder@gmail.com>,
 shyamthakkar001@gmail.com, "Phillip Wood" <phillip.wood123@gmail.com>
Message-Id: <ca8e7670-cf4f-4915-a37f-09d2e4b7c62a@app.fastmail.com>
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Subject: Re: [GSOC PATCH] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 26, 2025, at 15:22, Ayush Chandekar wrote:
> When core.commentChar is set to "auto", Git selects a comment character
> by scanning the commit message contents and avoiding any character
> already present in the message.
>
> If the message still contains old conflict comments (starting with a
> comment character), Git assumes that character is in use and chooses a
> different one. As a result, those existing comment lines are no longer
> recognized as comments and end up being included in the final commit
> message.
>
> To avoid this, skip scanning the trailing comment block when selecting
> the comment character. This allows Git to safely reuse the original
> character when appropriate, keeping the commit message clean and free of
> leftover conflict information.
>
> Background:
>
> The "auto" value for core.commentchar was introduced in the commit
> `84c9dc2` (commit: allow core.commentChar=auto for character auto
> selection) but did not exhibt this issue at that time.
>
> The bug was introduced in commit `a6c2654` (rebase -m: fix --signoff
> with conflicts) where Git started writing conflict comments to the file
> at 'rebase_path_message()'.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---

Nice explanation.

> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 127216f722..a8e89a250b 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -328,6 +328,24 @@ test_expect_success 'there is no
> --no-reschedule-failed-exec in an ongoing rebas
>  	test_expect_code 129 git rebase --edit-todo
> --no-reschedule-failed-exec
>  '
>
> +test_expect_success 'no change in comment character due to conflicts
> markers with core.commentChar=auto' '
> +	test_commit base file &&
> +	git checkout -b branch-a &&
> +	test_commit A file &&
> +	git checkout -b branch-b base &&
> +	test_commit B file &&
> +	test_must_fail git rebase branch-a &&
> +	printf "B\nA\n" >file &&
> +	git add file &&
> +	write_script fake-editor <<-\EOF &&
> +	exit 0
> +	EOF
> +	FAKE_EDITOR="$(pwd)/fake-editor" &&
> +	GIT_EDITOR="\"\$FAKE_EDITOR\"" git -c core.commentChar=auto rebase --continue &&

How about

    GIT_EDITOR="cat >actual"

Then you can `test_grep` on that.  Like in

https://lore.kernel.org/git/5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com/

> +	# Check that "#" is still the comment character.
> +	test_grep "# Changes to be committed:" .git/COMMIT_EDITMSG

Nit:

    test_grep "^# Changes to be committed:$"

> +'
> +
>  test_orig_head_helper () {
>  	test_when_finished 'git rebase --abort &&
>  		git checkout topic &&
> --
> 2.49.0
