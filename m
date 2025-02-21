Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771A253F0E
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174157; cv=none; b=BYWYLfjP91WAeo+sXhNyQv2kAhMzlLH2mqnsyzzy+W4job3cLy1GZqquWSsFNqvo7PZo1S4H8OLv6k0wmvz8wY1of1J57R5z/PpV+6YP+q7ibwj8LCjRDaoSc5QBG8Bw3v+npHyy3GLIMy/4ubtPrchMytQczpXrCswkQPyirMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174157; c=relaxed/simple;
	bh=QVtcYxtw1lyGbGcFNROmN8GtUEzYXceavSB6hFPPjjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RaCKawLCAA/TVo2nype317qtRgENQqYV4+D98N5CEJ8MdIvszdu8dDqmk8DmTR6Ebvcl7Rkl13vaKIWPR97BKbjxklk6ugL5Wx5Tk+0VmTop2tf7zUxvpGgIpAH5oxtFldkL6gcdKW18bpAaprmVECEVWlIOeqZpnHEVK2u3luo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UeLUCU3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q54nOw++; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UeLUCU3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q54nOw++"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 84898254010E;
	Fri, 21 Feb 2025 16:42:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 21 Feb 2025 16:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740174154; x=1740260554; bh=xQWGfAShuI
	1Y/GKp/HifoVbR2tP4dUp4c/M8uJ0whCA=; b=UeLUCU3gMAMW1l2I2zAd3bizJD
	i2FyKsddMhICLvhWfjdpdAEAzn9z+fQwtMpmtRK/OO9lH6AkGxxU7jUVHGUtJX8d
	+LbLRul9tVJzbVqO96SxJw91kqX7kYyML+Gy3pyEiU/XWG8FAHNxYh23oZxuco8X
	r2TVEBo9yLJJYhflhTj8Pq12LymnxFC3CYH73gzttueMAxDRt/HMqxVr87WoNBoG
	DueNNJXRuHV2fX+y4e5XSYWvx5zMH62//DEcC/4MzUxqpMpsMG7m4PqNctMFedST
	iQ0WWtuIop8THq2z2o3D5sx9WRe4oLYAXhNB/oVwk9ZIzS+VeJLEr0A6XCJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740174154; x=1740260554; bh=xQWGfAShuI1Y/GKp/HifoVbR2tP4dUp4c/M
	8uJ0whCA=; b=Q54nOw++VfE3UhtIPVHP++TidFtfp/yBvM2PpOFVuQBBaGA0YOz
	jOjHALcTLKficQTYYT/S2cpxi2XXsfbs4Nl5picU+dViD6XuxKMTRgO2xITX3y2c
	vWIdR5JStCYAsrbhMMiJ0sY5vYxNU/ooNxhf3gjMNU78ot4E9KUVvAAQXJEiMioV
	SBOsKJOemDt3TjLxFWUtkURp2KjIgnkLZrVYA22VwUEA6qyswlzbrtR/wLB1EcdH
	ZbO1Utxd6X9Q+VK6KYaTcuaYWZEhaJQVyEuH1s9eRct838g/hSDUHHEZIfjMHQAd
	1SgURaJTFUYr2B6KehdNtABqrLnJz9fgbSQ==
X-ME-Sender: <xms:SfO4Z-Ci2LaXtuyDszjO-RigWg67fDFafTRoWPss-tDbzkki7HBNJg>
    <xme:SfO4Z4i1CCsGGjDaFKCpJmDfVZj--09_IAlpHJIDk6cD4FDSsO_EJKFbi4C4RF5VL
    TBAmV6cCZ0ioNksAg>
X-ME-Received: <xmr:SfO4ZxnTjWYY626BkNT9TK084PXNfxrRSE3HAvNnotCyjiEM-WSG-0VIe_K2q0aZ2vEW3Sl_12DK207h9j5a9NSU_-ckgGRCDkzzc5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SfO4Z8zD-qODbV6TppyKut19uoIKplT1an6XxUrzz_4QaVPJQdnlZw>
    <xmx:SfO4ZzRqAsKuJ_Q5Lp336esY3O1i7P_x3VC3l2DgaTQkS25f4QI6dw>
    <xmx:SfO4Z3aMSEdkBIqHLqvlRf0rSu30nbGymUJtVQwwIRmjUZNXL78ykw>
    <xmx:SfO4Z8Rje8shUZv-W47aDm41zwhONVc3lC5BhqQuI68zaMNebSZ2Ag>
    <xmx:SvO4ZxMnJFofsg9cGMStDurRbNNSwUyUPacJNHEULdKH5nFRcL3wFKaN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 16:42:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] add-patch: update hunk splitability after editing
In-Reply-To: <35ef0ee2b9925748ae3b6b6ac68e79c71782e5cf.1740149837.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Fri, 21 Feb 2025 14:57:17
	+0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<35ef0ee2b9925748ae3b6b6ac68e79c71782e5cf.1740149837.git.gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 13:42:32 -0800
Message-ID: <xmqqwmdj7z5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When the users edits a hunk if they change deletion lines to context
> lines or vice versa then the number of hunks that the edited hunk can be
> split into may differ from the unedited hunk and so we need to update
> hunk->splittable_into. In practice users are unlikely to hit this bug as
> it is doubtful that a user who has edited a hunk will split it
> afterwards.

Heh, when I did the original "add -i/-p", I said "it is doubtful
that a user who has selected a hunk will split it afterwards" ;-)

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c                | 12 +++++++++++-
>  t/t3701-add-interactive.sh | 21 +++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index f44f98275cc..982745373df 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1182,19 +1182,29 @@ static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
>  {
>  	struct hunk_header *header = &hunk->header;
>  	size_t i;
> +	char ch, marker = ' ';
>  
> +	hunk->splittable_into = 0;
>  	header->old_count = header->new_count = 0;
>  	for (i = hunk->start; i < hunk->end; ) {
> -		switch(normalize_marker(&s->plain.buf[i])) {
> +		ch = normalize_marker(&s->plain.buf[i]);
> +		switch (ch) {
>  		case '-':
>  			header->old_count++;
> +			if (marker == ' ')
> +				hunk->splittable_into++;
> +			marker = ch;
>  			break;
>  		case '+':
>  			header->new_count++;
> +			if (marker == ' ')
> +				hunk->splittable_into++;
> +			marker = ch;
>  			break;
>  		case ' ':
>  			header->old_count++;
>  			header->new_count++;
> +			marker = ch;
>  			break;
>  		}

OK.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 760f3d0d30f..cb81bfe64c8 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1240,4 +1240,25 @@ test_expect_success 'splitting previous hunk marks split hunks as undecided' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'splitting edited hunk' '
> +	# Before the first hunk is edited it can be split into two
> +	# hunks, after editing it can be split into three hunks.
> +
> +	write_script fake-editor.sh <<-\EOF &&
> +	sed "s/^ c/-c/" "$1" >"$1.tmp" &&
> +	mv "$1.tmp" "$1"
> +	EOF
> +
> +	test_write_lines a b c d e f g h i j k l m n>file &&
> +	git add file &&
> +	test_write_lines A b c d E f g h i j k l M n >file &&

Missing SP before ">file" on the earlier line.

> +	(
> +		test_set_editor "$(pwd)/fake-editor.sh" &&
> +		test_write_lines e K s j y n y q | git add -p file
> +	) &&
> +	git cat-file blob :file >actual &&
> +	test_write_lines a b d e f g h i j k l M n >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
