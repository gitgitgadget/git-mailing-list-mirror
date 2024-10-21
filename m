Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCB1E9060
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511897; cv=none; b=QPcB215wBjZ8lphUsGQ6xa/SynkuNSdYw2x6rEL/NWGCEcb3fRbKijj9JWqF5u+PUMcOgtJPFgs1rh2zWyj6DBkdmN7K353Dvh+D31hpYaNMjoIrTWcUM/HC4vx3oh6rvusSh/4+7bBwB8HZQP3KD5gGvK3GqnBxEY91A99asTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511897; c=relaxed/simple;
	bh=Y3Qwi7s3xtkMmAioB4AdrSnI5zY7g7xoyrFfkBKAimo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx5xeCReXnquF6PQvTfxs8rRBhqchos4PkT8lxTt5ImccejhPpfhxF25WNQ67oVgqj7ySaoybPQkWBeGEqJga3NGmb8cT6F4y7tRKQ8YwP1L8VrAs9e/DnPXwgx3OAHQCLKvtf9mM15wPmMvtLrxxgQu7YVnF5DiuUrb1MniW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=voslMywk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j0rMG6FY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="voslMywk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j0rMG6FY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0771F1140246;
	Mon, 21 Oct 2024 07:58:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 07:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729511893; x=1729598293; bh=V8GVr3zNOA
	C2bYyBKh5Y1GUOJgwGVdNvlFfXlCZzxFA=; b=voslMywkFZwJRL+2racR1NIy/B
	X++gfhCZcrqfW2ZFcmNh3f3XUU3TE5588/wTBy2yZ6VTJrTHHsq4TZG32co5gpwO
	ZwJ0v2ew9IntAk2DKA2rac6il2Zm188W5NFweZGx/uxaYqWY+q7aH/zUR+sW7W23
	2v8fItxwVec74YbGId7tIiKdUt8iA6f+80PjC8bkKpyvXlkgD7aycRax1aLVA1PZ
	/C65F2at6tYf0q/am7mW55hjXIDAAGGo7NtJkTy+f9427RS/+MEuRCbXjGWKbnOW
	fz5fO1Xj6F337OxvA63GpRhe/JnrmFPOJ03NPdoN3sJYsiwzvdYFCNCKXQwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729511893; x=1729598293; bh=V8GVr3zNOAC2bYyBKh5Y1GUOJgwG
	VdNvlFfXlCZzxFA=; b=j0rMG6FYr76jzx6qrnAWCsrC+tjPQTUdV3aiGGtE9S26
	D2rY6+LFCHOyDqUV96bldAaewfDLGGq+qM0qdbgylu6wspOrRo+siMKFdpxRVVnF
	Uyswoumxmz/CC7DzdOzbZiEQm+rkNdak5s4vqhdB9poF+hvjjZ95lWgO/VXS8N73
	rl/0ETDH8KldgC7Hd77p77SbhPfbi1jCv1JynORWOkPEZVTiaOzfhzuk7CS8DGIU
	yZmmsQyIaIFp+CSVwLOFO9AQfBF3nuFyFPMCX7TSK/tp0Uspu69FDTZdAYGrj+OG
	ojOALsmLxyYTMscumOQuf4GbYykyX3oWjvKTUGNosQ==
X-ME-Sender: <xms:1EEWZ6XQ0eBP5eW2cVgXJEgP-JGA2yRrEap4HhiGaRuy6-LxN1SmZg>
    <xme:1EEWZ2kw3PCW6G42fuSRLwNyPxizfO8N3IzqcXnrYj0NLlYA5a8LaJ2hD4W_uHnIk
    z-YBgpGfz1ilk5fkA>
X-ME-Received: <xmr:1EEWZ-ZKawdD9BdDXz73C2chfAQc0yTDgmwnyqLmYHZb_2burgLv0w5vFqfnRbFoLhQFqSfqV-WYBPYVS4Wf3c7bnCeqsdqZ6B8VpvQzaeVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:1EEWZxX05FJIYzjIjYB9l0QFmBmRRnVmwVung4KJetljBORuT0j4ag>
    <xmx:1EEWZ0mPZnQnJUrtAKAYhLdBNsoAGCsoqLE7JRCaftk86VkqCJYTDg>
    <xmx:1EEWZ2c0mZpAbmae8aR4UOPCWsaymk1ukm2Q0TGjYZsE-v2aaEBNtg>
    <xmx:1EEWZ2Fr4YtH0JPldcHVsta2ZBDQOAtPYI9NTeH1quf7pkV_yJfbdA>
    <xmx:1EEWZ-WmRiJR_BCuJ3ASVw__9453I0n5BN0MtKBqhIMd7AjweQ7EH-Fw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 07:58:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 341a5700 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 11:56:40 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:58:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v2] notes: teach the -e option to edit messages in editor
Message-ID: <ZxZByGdre-lup2sO@pks.im>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
 <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>

On Sun, Oct 20, 2024 at 12:03:00AM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> 
> Notes can be added to a commit using the -m (message),
> -C (copy a note from a blob object) or
> -F (read the note from a file) options.

Nit: this would read a bit better if this was a bulleted list, I think.
E.g.:

    Notes can be added to a commit using:

      - "-m" to provide a message on the command line.
      - -C to copy a note from a blob object.
      - -F to read the note from a file.

    When these options are used, ...

> When these options are used, Git does not open an editor,
> it simply takes the content provided via these options and
> attaches it to the commit as a note.
> 
> Improve flexibility to fine-tune the note before finalizing it
> by allowing the messages to be prefilled in the editor and editted

s/editted/edited

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index c9221a68cce..d5505a426aa 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -9,9 +9,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git notes' [list [<object>]]
> -'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' add [-f] [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
>  'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
> -'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
> +'git notes' append [--allow-empty] [--[no-]separator | --separator=<paragraph-break>] [--[no-]stripspace] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>] [-e]
>  'git notes' edit [--allow-empty] [<object>] [--[no-]stripspace]
>  'git notes' show [<object>]
>  'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>

Nit: I'd move the `[-e]` before [<object>] so that -F, -C and -m are all
close together.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 8c26e455269..72c8a51cfac 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -489,6 +489,8 @@ static int add(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
>  			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
>  			parse_reedit_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),
>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> @@ -667,6 +669,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
>  			N_("reuse specified note object"), PARSE_OPT_NONEG,
>  			parse_reuse_arg),
> +		OPT_BOOL('e', "edit", &d.use_editor,
> +			N_("edit note message in editor")),
>  		OPT_BOOL(0, "allow-empty", &allow_empty,
>  			N_("allow storing empty note")),
>  		OPT_CALLBACK_F(0, "separator", &separator,

Nice.

> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index 99137fb2357..ffa1d21671d 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1567,4 +1567,60 @@ test_expect_success 'empty notes do not invoke the editor' '
>  	git notes remove HEAD
>  '
>  
> +test_expect_success 'git notes add with -m/-F invokes editor with -e' '
> +	test_commit 19th &&
> +	MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
> +	echo "Edited notes message" >expect &&
> +	git notes show >actual &&
> +	test_cmp expect actual &&
> +	git notes remove HEAD &&
> +
> +	# Add a note using -F and edit it
> +	echo "Note from file" >note_file &&
> +	MSG="Edited note from file" git notes add -F note_file -e &&
> +	echo "Edited note from file" >expect &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'

I was surprised at first why the MSG ended up in the commit message. But
the setup of t3301 writes a fake editor that listens to this environment
variable, so this looks good to me.

> +test_expect_success 'git notes append with -m/-F invokes the editor with -e' '
> +	test_commit 20th &&
> +	git notes add -m "Initial note message" &&
> +	MSG="Appended edited note message" git notes append -m "New appended note" -e &&
> +
> +	# Verify the note content was appended and edited
> +	echo "Initial note message" >expect &&
> +	echo "" >>expect &&
> +	echo "Appended edited note message" >>expect &&

When you want to write multiple lines we typically use HERE docs. E.g.:

        cat >expect <<-EOF &&
        Initial note message

        Appended edited note message
        EOF

> +	git notes show >actual &&
> +	test_cmp expect actual &&
> +	git notes remove HEAD &&
> +
> +	#Append a note using -F and edit it

There should be a space after the "#" here.

> +	echo "Note from file" >note_file &&
> +	git notes add -m "Initial note message" &&
> +	MSG="Appended edited note from file" git notes append -F note_file -e &&
> +
> +	# Verify notes from file has been edited in editor and appended
> +	echo "Initial note message" >expect &&
> +	echo "" >>expect &&
> +	echo "Appended edited note from file" >>expect &&

Same comment here.

> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git notes with a combination of -m, -F and -e invokes editor' '
> +	test_commit 21st &&
> +	echo "foo-file-1" >note_1 &&
> +	echo "foo-file-2" >note_2 &&
> +
> +	MSG="Collapsed edited notes" git notes append -F note_1 -m "message-1" -F note_2 -e &&
> +
> +	# Verify that combined messages from file and -m have been edited
> +
> +	echo "Collapsed edited notes" >expect &&
> +	git notes show >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done

It would be nice to have another test that uses EDITOR=false to
demonstrate that we abort when the editor returns an error.

Other than that this patch looks good to me, thanks a lot!

Patrick
