Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CD31D757
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609453; cv=none; b=dXoYU/hWhhvJznc84m/ZLRhQHeFwpVdUpaHwINwqU5HMG05QrP8+SjW8uLWqnnSnxnAZsLS6lGceIFHfGmaRhm8kZc6KRs0WcU3T20YkCzYJxlExl0Pa55gOQmHkxKLaoTpvbOWS3hbBkh/tnQpSsIvaJLFXet+PH1HML9raMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609453; c=relaxed/simple;
	bh=0RUCn7t5ln/5R16Ky10h0HfaG7rPv3n9YE0iixDiVu8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sXyoDBMkeRbgD7vYK1vdUXsJBiLR5cioi1ir/9FF1leiiiNS0c6RAmg1ZKBx772fmKDDn9WzKJsASUhqKaZCBUFhLotg/gBH5OfCps3LYGQZ4q7Ky1yz/Gv1CQsZbK8sefrhdlvYZKgG4nHboRMdtR5PAhwK4PhG9lHbRoOw3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kjo7uQOw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V9OtwsAO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kjo7uQOw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V9OtwsAO"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C5BD71D0042E;
	Thu, 11 Sep 2025 12:50:49 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 12:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757609449;
	 x=1757695849; bh=F25OTF2cpTSCae3uvDC835eRWtXqGYv2gGiTdMYjirw=; b=
	kjo7uQOwWMe0CEnNLOja4w9t98pc5Wa/T2L1bnQrE+P/alNB1q56dJ8aWxDW3Bkt
	HAGsGOiQdoyDkXuPb4pAfI7DYNDv5l2h1yRIDAFToON+pusulbPq+XR847v8KyOn
	O+JxSXB4UEiSWSfWldNU6COcAFRttU4zLSA76j4TIdNSAi3IqOSez3ZDjPfjM0Lz
	vlAInmTlTzhvUU+a9Oscot4Zj+K/ZrF6pP38VKHriGt1sDcmBbI6vUMnVKqXWJoE
	JftdniONBI7XGEU2M2GDf8qlPeVQ5+rUY4aQKTBz08qtIqt521wzQAITeT4kEgog
	7ZgalZ8ayvEg/blwgV4JBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757609449; x=
	1757695849; bh=F25OTF2cpTSCae3uvDC835eRWtXqGYv2gGiTdMYjirw=; b=V
	9OtwsAOJ69XWgBDK6LRczxamrL3zv/1G8/g3nYMxy2QpmZKE2zpkWM/8oOLgCGzx
	3PM/n9cEXmImCmjtZuU8GkPJc+3MaDD9lfN6ic659zeFItpaIMaHLLLlB7W8uCGJ
	azioIF4Lc+6oWThBCreCMh5zj3XfZQd9gFuixiDkIF/Lg6C0mwuBQzqQsJYZ5T9Q
	RHk9RPRgnRIWCfkvo6hXvMYW7tioKzV+jQUgGQHIRHPiG56772ajkIJ1TZ3qAmO+
	pcUYuHW86adXCkRJHAsRWlZS6ftq2DWQFLrAcHr5KGN+fL4U67S/a927wdcpE+Gy
	0fNdHv7wjZIYBobggetCg==
X-ME-Sender: <xms:6f3CaAe7dHOQnhUhf2UiOUCbSdP_1czR97DQG4IClVwgt5t4djImw6M>
    <xme:6f3CaCMIJs2t7RrGpZJz3bawO_jE0jzVvyroIrTiQghmOQWg1G8AcEt6x0eAL7uFf
    XM6kNM_IK-JISE4hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:6f3CaHnsm-xueXyam-kbqgUn4-3WwjSEKpUnD6MLjKzvZ_dStflYLw>
    <xmx:6f3CaESbpW-lR_svWvaZbcEZC8EcC5TcExHatkdWLSTMHh9qWLviCQ>
    <xmx:6f3CaNOBSLxyBWEXD9JGs5pn40_AMMLUMxb65FF4xKSngBlM3mfOTA>
    <xmx:6f3CaFXs8X-B2NYH0aD3sXeuSiT7m1SgbJVaHeCkWNasXzt8Z8afEA>
    <xmx:6f3CaIMLSbaM8EqqbuhkVJX53FDZcl1CSoVqdEAs70qSP32FzxWY57Zi>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5AEB41EA0068; Thu, 11 Sep 2025 12:50:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoNNzv2g2dX3
Date: Thu, 11 Sep 2025 18:50:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <94eb9052-18e1-4565-8f33-42fdf136e2a4@app.fastmail.com>
In-Reply-To: <20250911-pks-config-color-v1-1-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
 <20250911-pks-config-color-v1-1-3a7c79df65b1@pks.im>
Subject: Re: [PATCH 1/5] t1300: write test expectations in the test's body
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 15:24, Patrick Steinhardt wrote:
> There are a bunch of tests in t1300 where we write the test expectation
> handed over to `test_cmp ()` outside of the test body. This does not
> match our modern test style, and there isn't really a reason why this
> would need to happen outside of the test bodies.
>
> Convert those to instead do so as part of the test itself.
>
> Note that there are two exceptions that we don't convert. In both of
> these cases the expectation is reused across multiple tests, and thus a
> conversion where we'd move that into the first test that uses the
> expectation would be invalid. Those are simply left as-is for now.

This is just a suggestion (which everything is):

    Note that there are two exceptions that we leave as-is for now since
    they are reused across tests.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t1300-config.sh | 290 ++++++++++++++++++++++++---------------------=
---------
>  1 file changed, 129 insertions(+), 161 deletions(-)
>
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh

For the following I looked mostly at a color-move etc. diff as well as
the commit.

> index f856821839..bde9bda234 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -134,38 +134,39 @@ test_expect_success 'clear default config' '
>  	rm -f .git/config
>  '
>
> -cat > expect << EOF > +test_expect_success 'initial' '
> +	cat >expect <<EOF &&
>  [section]
>  	penguin =3D little blue
>  EOF
> -test_expect_success 'initial' '

Ok.  Correct.  But I see that you are also overall doing a sort of
normalization.

=E2=80=A2 Remove-tabs if it makes sense
=E2=80=A2 No variable expansion if it makes sense

And here `<<\EOF` would work too.  Or is that worse style?

I will keep mentioning this throughout the rest.

>  	git config ${mode_set} section.penguin "little blue" &&
>  	test_cmp expect .git/config
>  '
>
> -cat > expect << EOF
> +test_expect_success 'mixed case' '
> +	cat >expect <<EOF &&
>  [section]
>  	penguin =3D little blue
>  	Movie =3D BadPhysics
>  EOF
> -test_expect_success 'mixed case' '

Ok.  But same as previous.

>  	git config ${mode_set} Section.Movie BadPhysics &&
>  	test_cmp expect .git/config
>  '
>
> -cat > expect << EOF
> +test_expect_success 'similar section' '
> +	cat >expect <<EOF &&
>  [section]
>  	penguin =3D little blue
>  	Movie =3D BadPhysics
>  [Sections]
>  	WhatEver =3D Second
>  EOF
> -test_expect_success 'similar section' '

Ditto.

>  	git config ${mode_set} Sections.WhatEver Second &&
>  	test_cmp expect .git/config
>  '
>
> -cat > expect << EOF
> +test_expect_success 'uppercase section' '
> +	cat >expect <<EOF &&
>  [section]
>  	penguin =3D little blue
>  	Movie =3D BadPhysics
> @@ -173,7 +174,6 @@ cat > expect << EOF
>  [Sections]
>  	WhatEver =3D Second
>  EOF
> -test_expect_success 'uppercase section' '

Ditto.

>  	git config ${mode_set} SECTION.UPPERCASE true &&
>  	test_cmp expect .git/config
>  '
> @@ -186,7 +186,8 @@ test_expect_success 'replace with non-match
> (actually matching)' '
>  	git config section.penguin "very blue" !kingpin
>  '
>
> -cat > expect << EOF
> +test_expect_success 'append comments' '
> +	cat >expect <<EOF &&
>  [section]
>  	Movie =3D BadPhysics
>  	UPPERCASE =3D true
> @@ -198,8 +199,6 @@ cat > expect << EOF
>  [Sections]
>  	WhatEver =3D Second
>  EOF
> -
> -test_expect_success 'append comments' '

Ditto.

>  	git config --replace-all --comment=3D"Pygoscelis papua" section.peng=
uin
> gentoo &&
>  	git config ${mode_set} --comment=3D"find fish" section.disposition
> peckish &&
>  	git config ${mode_set} --comment=3D"#abc" section.foo bar &&
> @@ -214,7 +213,9 @@ test_expect_success 'Prohibited LF in comment' '
>  	test_must_fail git config ${mode_set} --comment=3D"a${LF}b" section.=
k v
>  '
>
> -test_expect_success 'non-match result' 'test_cmp expect .git/config'
> +test_expect_success 'non-match result' '
> +	test_cmp expect .git/config
> +'

Okay.  You normalize the one line to

    test_expect_success <name> '
         <body>
    '

The same kind of change done in the next patch `t1300: small
style fixups`.

>
>  test_expect_success 'find mixed-case key by canonical name' '
>  	test_cmp_config Second sections.whatever
> @@ -265,14 +266,15 @@ test_expect_success 'unset with cont. lines' '
>  	git config ${mode_unset} beta.baz
>  '
>
> -cat > expect <<\EOF
> -[alpha]
> -bar =3D foo
> -[beta]
> -foo =3D bar
> -EOF
> -
> -test_expect_success 'unset with cont. lines is correct' 'test_cmp
> expect .git/config'
> +test_expect_success 'unset with cont. lines is correct' '
> +	cat >expect <<-\EOF &&
> +	[alpha]
> +	bar =3D foo
> +	[beta]
> +	foo =3D bar
> +	EOF
> +	test_cmp expect .git/config
> +'

Correct.  You eliminate tabs and retain `\`.

>
>  cat > .git/config << EOF
>  [beta] ; silly comment # another comment
> @@ -292,16 +294,15 @@ test_expect_success 'multiple unset' '
>  	git config ${mode_unset_all} beta.haha
>  '
>
> -cat > expect << EOF
> +test_expect_success 'multiple unset is correct' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
>  [nextSection] noNewline =3D ouch
>  EOF
> -
> -test_expect_success 'multiple unset is correct' '
>  	test_cmp expect .git/config
>  '

Correct.  You replaced `'` with `${SQ}` (I assume =E2=80=9Csingle quote=E2=
=80=9D) which
is probably good style in general in order to avoid toothpicks.

>
> @@ -318,37 +319,38 @@ test_expect_success '--replace-all' '
>  	git config ${mode_replace_all} beta.haha gamma
>  '
>
> -cat > expect << EOF
> +test_expect_success 'all replaced' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
>  	haha =3D gamma
>  [nextSection] noNewline =3D ouch
>  EOF
> -
> -test_expect_success 'all replaced' '
>  	test_cmp expect .git/config
>  '

Correct.

>
> -cat > expect << EOF
> +test_expect_success 'really mean test' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
>  	haha =3D alpha
>  [nextSection] noNewline =3D ouch
>  EOF
> -test_expect_success 'really mean test' '
> +

New blank line.  That can be dropped.

>  	git config ${mode_set} beta.haha alpha &&
>  	test_cmp expect .git/config
>  '
>
> -cat > expect << EOF
> +test_expect_success 'really really mean test' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
> @@ -356,7 +358,6 @@ noIndent=3D sillyValue ; 'nother silly comment
>  [nextSection]
>  	nonewline =3D wow
>  EOF
> -test_expect_success 'really really mean test' '
>  	git config ${mode_set} nextsection.nonewline wow &&
>  	test_cmp expect .git/config
>  '

Huh, the similarity between =E2=80=9Creally=E2=80=9D and =E2=80=9Creally=
 really=E2=80=9D confused me.
But correct.

> @@ -365,23 +366,24 @@ test_expect_success 'get value' '
>  	test_cmp_config alpha beta.haha
>  '
>
> -cat > expect << EOF
> +test_expect_success 'unset' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
>  [nextSection]
>  	nonewline =3D wow
>  EOF
> -test_expect_success 'unset' '
>  	git config ${mode_unset} beta.haha &&
>  	test_cmp expect .git/config
>  '

Correct.

>
> -cat > expect << EOF
> +test_expect_success 'multivar' '
> +	cat  >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
> @@ -389,7 +391,6 @@ noIndent=3D sillyValue ; 'nother silly comment
>  	nonewline =3D wow
>  	NoNewLine =3D wow2 for me
>  EOF
> -test_expect_success 'multivar' '
>  	git config nextsection.NoNewLine "wow2 for me" "for me$" &&
>  	test_cmp expect .git/config
>  '
> @@ -415,9 +416,10 @@ test_expect_success 'multi-valued get-all returns=
 all' '
>  	test_cmp expect actual
>  '

Correct.

>
> -cat > expect << EOF
> +test_expect_success 'multivar replace' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
> @@ -425,7 +427,6 @@ noIndent=3D sillyValue ; 'nother silly comment
>  	nonewline =3D wow3
>  	NoNewLine =3D wow2 for me
>  EOF
> -test_expect_success 'multivar replace' '
>  	git config nextsection.nonewline "wow3" "wow$" &&
>  	test_cmp expect .git/config
>  '

Correct.

> @@ -438,17 +439,16 @@ test_expect_success 'invalid unset' '
>  	test_must_fail git config ${mode_unset} somesection.nonewline
>  '
>
> -cat > expect << EOF
> +test_expect_success 'multivar unset' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
>  [nextSection]
>  	NoNewLine =3D wow2 for me
>  EOF
> -
> -test_expect_success 'multivar unset' '
>  	case "$mode" in
>  	legacy)
>  		git config --unset nextsection.nonewline "wow3$";;

Correct.

> @@ -466,9 +466,10 @@ test_expect_success 'hierarchical section' '
>  	git config Version.1.2.3eX.Alpha beta
>  '
>
> -cat > expect << EOF
> +test_expect_success 'hierarchical section value' '
> +	cat >expect <<EOF &&
>  [beta] ; silly comment # another comment
> -noIndent=3D sillyValue ; 'nother silly comment
> +noIndent=3D sillyValue ; ${SQ}nother silly comment
>
>  # empty line
>  		; comment
> @@ -479,19 +480,16 @@ noIndent=3D sillyValue ; 'nother silly comment
>  [Version "1.2.3eX"]
>  	Alpha =3D beta
>  EOF
> -
> -test_expect_success 'hierarchical section value' '
>  	test_cmp expect .git/config
>  '

Correct.

>
> -cat > expect << EOF
> -beta.noindent=3DsillyValue
> -nextsection.nonewline=3Dwow2 for me
> -123456.a123=3D987
> -version.1.2.3eX.alpha=3Dbeta
> -EOF
> -
>  test_expect_success 'working --list' '
> +	cat >expect <<-\EOF &&
> +	beta.noindent=3DsillyValue
> +	nextsection.nonewline=3Dwow2 for me
> +	123456.a123=3D987
> +	version.1.2.3eX.alpha=3Dbeta
> +	EOF
>  	git config ${mode_prefix}list > output &&
>  	test_cmp expect output
>  '

Correct.  Removing tabs now that you can.  Also no variable expansion.

> @@ -500,44 +498,40 @@ test_expect_success '--list without repo produces
> empty output' '
>  	test_must_be_empty output
>  '
>
> -cat > expect << EOF
> -beta.noindent
> -nextsection.nonewline
> -123456.a123
> -version.1.2.3eX.alpha
> -EOF
> -
>  test_expect_success '--name-only --list' '
> +	cat >expect <<-EOF &&
> +	beta.noindent
> +	nextsection.nonewline
> +	123456.a123
> +	version.1.2.3eX.alpha
> +	EOF
>  	git config ${mode_prefix}list --name-only >output &&
>  	test_cmp expect output
>  '

Correct.  But you can use `<<-\EOF`.

>
> -cat > expect << EOF
> -beta.noindent sillyValue
> -nextsection.nonewline wow2 for me
> -EOF
> -
>  test_expect_success '--get-regexp' '
> +	cat >expect <<-EOF &&
> +	beta.noindent sillyValue
> +	nextsection.nonewline wow2 for me
> +	EOF
>  	git config ${mode_get_regexp} in >output &&
>  	test_cmp expect output
>  '

Ditto.

>
> -cat > expect << EOF
> -beta.noindent
> -nextsection.nonewline
> -EOF
> -
>  test_expect_success '--name-only --get-regexp' '
> +	cat >expect <<-EOF &&
> +	beta.noindent
> +	nextsection.nonewline
> +	EOF
>  	git config ${mode_get_regexp} --name-only in >output &&
>  	test_cmp expect output
>  '

Ditto.

>
> -cat > expect << EOF
> -wow2 for me
> -wow4 for you
> -EOF
> -
>  test_expect_success '--add' '
> +	cat >expect <<-EOF &&
> +	wow2 for me
> +	wow4 for you
> +	EOF
>  	git config --add nextsection.nonewline "wow4 for you" &&
>  	git config ${mode_get_all} nextsection.nonewline > output &&
>  	test_cmp expect output

Ditto.

> @@ -558,37 +552,32 @@ test_expect_success 'get variable with empty val=
ue' '
>  	git config --get emptyvalue.variable ^$
>  '
>
> -echo novalue.variable > expect
> -
>  test_expect_success 'get-regexp variable with no value' '
> +	echo novalue.variable >expect &&
>  	git config ${mode_get_regexp} novalue > output &&
>  	test_cmp expect output
>  '

Correct.

>
> -echo 'novalue.variable true' > expect
> -
>  test_expect_success 'get-regexp --bool variable with no value' '
> +	echo "novalue.variable true" >expect &&
>  	git config ${mode_get_regexp} --bool novalue > output &&
>  	test_cmp expect output
>  '

Correct.

>
> -echo 'emptyvalue.variable ' > expect
> -
>  test_expect_success 'get-regexp variable with empty value' '
> +	echo "emptyvalue.variable " >expect &&
>  	git config ${mode_get_regexp} emptyvalue > output &&
>  	test_cmp expect output
>  '

Correct.

>
> -echo true > expect
> -
>  test_expect_success 'get bool variable with no value' '
> +	echo true >expect &&
>  	git config --bool novalue.variable > output &&
>  	test_cmp expect output
>  '

Correct.

>
> -echo false > expect
> -
>  test_expect_success 'get bool variable with empty value' '
> +	echo false > expect &&
>  	git config --bool emptyvalue.variable > output &&
>  	test_cmp expect output
>  '

Here you should use `>expect`.

> @@ -604,19 +593,19 @@ cat > .git/config << EOF
>  	c =3D d
>  EOF
>
> -cat > expect << EOF
> +test_expect_success 'new section is partial match of another' '
> +	cat >expect <<EOF &&
>  [a.b]
>  	c =3D d
>  [a]
>  	x =3D y
>  EOF
> -
> -test_expect_success 'new section is partial match of another' '
>  	git config a.x y &&
>  	test_cmp expect .git/config
>  '

You can use `<<\EOF`.

>
> -cat > expect << EOF
> +test_expect_success 'new variable inserts into proper section' '
> +	cat >expect <<EOF &&
>  [a.b]
>  	c =3D d
>  [a]
> @@ -625,8 +614,6 @@ cat > expect << EOF
>  [b]
>  	x =3D y
>  EOF
> -
> -test_expect_success 'new variable inserts into proper section' '
>  	git config b.x y &&
>  	git config a.b c &&
>  	test_cmp expect .git/config

Correct.  You can use `<<\EOF`.

> @@ -642,11 +629,10 @@ cat > other-config << EOF
>  	bahn =3D strasse
>  EOF
>
> -cat > expect << EOF
> -ein.bahn=3Dstrasse
> -EOF
> -
>  test_expect_success 'alternative GIT_CONFIG' '
> +	cat >expect <<-EOF &&
> +	ein.bahn=3Dstrasse
> +	EOF

Ditto.

>  	GIT_CONFIG=3Dother-config git config ${mode_prefix}list >output &&
>  	test_cmp expect output
>  '
> @@ -675,14 +661,13 @@ test_expect_success 'refer config from subdirect=
ory' '
>  	test_cmp_config -C x strasse --file=3D../other-config --get ein.bahn
>  '
>
> -cat > expect << EOF
> +test_expect_success '--set in alternative file' '
> +	cat >expect <<\EOF &&
>  [ein]
>  	bahn =3D strasse
>  [anwohner]
>  	park =3D ausweis
>  EOF
> -
> -test_expect_success '--set in alternative file' '
>  	git config --file=3Dother-config anwohner.park ausweis &&
>  	test_cmp expect other-config
>  '

Correct.  Here you do `<< EOF` =E2=86=92 `<<\EOF`.

> @@ -730,7 +715,8 @@ test_expect_success 'rename another section' '
>  	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branc=
h.drei
>  '
>
> -cat > expect << EOF
> +test_expect_success 'rename succeeded' '
> +	cat >expect <<\EOF &&
>  # Hallo
>  	#Bello
>  [branch "zwei"]
> @@ -740,8 +726,6 @@ cat > expect << EOF
>  [branch "drei"]
>  weird
>  EOF
> -
> -test_expect_success 'rename succeeded' '
>  	test_cmp expect .git/config
>  '

Ditto.

(That four tests are named `rename succeeded` is a bit disorienting.)

>
> @@ -753,7 +737,8 @@ test_expect_success 'rename a section with a var on
> the same line' '
>  	git config ${mode_prefix}rename-section branch.vier branch.zwei
>  '
>
> -cat > expect << EOF
> +test_expect_success 'rename succeeded' '
> +	cat >expect <<\EOF &&
>  # Hallo
>  	#Bello
>  [branch "zwei"]
> @@ -765,8 +750,6 @@ weird
>  [branch "zwei"]
>  	z =3D 1
>  EOF
> -
> -test_expect_success 'rename succeeded' '
>  	test_cmp expect .git/config
>  '

Ditto.

>
> @@ -816,32 +799,29 @@ test_expect_success 'remove section' '
>  	git config ${mode_prefix}remove-section branch.zwei
>  '
>
> -cat > expect << EOF
> +test_expect_success 'section was removed properly' '
> +	cat >expect <<\EOF &&
>  # Hallo
>  	#Bello
>  [branch "drei"]
>  weird
>  EOF
> -
> -test_expect_success 'section was removed properly' '
>  	test_cmp expect .git/config
>  '

Ditto.

>
> -cat > expect << EOF
> +test_expect_success 'section ending' '
> +	cat >expect <<\EOF &&
>  [gitcvs]
>  	enabled =3D true
>  	dbname =3D %Ggitcvs2.%a.%m.sqlite
>  [gitcvs "ext"]
>  	dbname =3D %Ggitcvs1.%a.%m.sqlite
>  EOF
> -
> -test_expect_success 'section ending' '
>  	rm -f .git/config &&
>  	git config ${mode_set} gitcvs.enabled true &&
>  	git config ${mode_set} gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
>  	git config ${mode_set} gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
>  	test_cmp expect .git/config
> -
>  '

Ditto.  And normalized blank lines, that=E2=80=99s good.

>
>  test_expect_success numbers '
> @@ -885,19 +865,17 @@ test_expect_success 'invalid stdin config' '
>  	test_grep "bad config line 1 in standard input" output
>  '
>
> -cat > expect << EOF
> -true
> -false
> -true
> -false
> -true
> -false
> -true
> -false
> -EOF
> -
>  test_expect_success bool '
> -
> +	cat >expect <<-\EOF &&
> +	true
> +	false
> +	true
> +	false
> +	true
> +	false
> +	true
> +	false
> +	EOF
>  	git config ${mode_set} bool.true1 01 &&
>  	git config ${mode_set} bool.true2 -1 &&
>  	git config ${mode_set} bool.true3 YeS &&

Correct.

> @@ -923,7 +901,8 @@ test_expect_success 'invalid bool (set)' '
>
>  	test_must_fail git config --bool bool.nobool foobar'
>
> -cat > expect <<\EOF
> +test_expect_success 'set --bool' '
> +	cat >expect<<\EOF &&
>  [bool]
>  	true1 =3D true
>  	true2 =3D true
> @@ -934,9 +913,6 @@ cat > expect <<\EOF
>  	false3 =3D false
>  	false4 =3D false
>  EOF
> -
> -test_expect_success 'set --bool' '
> -
>  	rm -f .git/config &&
>  	git config --bool bool.true1 01 &&
>  	git config --bool bool.true2 -1 &&

Correct.  But add a space? (>expect<<\EOF)

> @@ -948,15 +924,13 @@ test_expect_success 'set --bool' '
>  	git config --bool bool.false4 FALSE &&
>  	test_cmp expect .git/config'
>
> -cat > expect <<\EOF
> +test_expect_success 'set --int' '
> +	cat >expect <<\EOF &&
>  [int]
>  	val1 =3D 1
>  	val2 =3D -1
>  	val3 =3D 5242880
>  EOF
> -
> -test_expect_success 'set --int' '
> -
>  	rm -f .git/config &&
>  	git config --int int.val1 01 &&
>  	git config --int int.val2 -1 &&

Correct.

> @@ -994,7 +968,8 @@ test_expect_success 'get --bool-or-int' '
>  	test_cmp expect actual
>  '
>
> -cat >expect <<\EOF
> +test_expect_success 'set --bool-or-int' '
> +	cat >expect <<\EOF &&
>  [bool]
>  	true1 =3D true
>  	false1 =3D false
> @@ -1005,8 +980,6 @@ cat >expect <<\EOF
>  	int2 =3D 1
>  	int3 =3D -1
>  EOF
> -
> -test_expect_success 'set --bool-or-int' '
>  	rm -f .git/config &&
>  	git config --bool-or-int bool.true1 true &&
>  	git config --bool-or-int bool.false1 false &&

Correct.

I tried with here `<<-\EOF` but that made something fail. :)

> @@ -1018,14 +991,13 @@ test_expect_success 'set --bool-or-int' '
>  	test_cmp expect .git/config
>  '
>
> -cat >expect <<\EOF
> +test_expect_success !MINGW 'set --path' '
> +	cat >expect <<\EOF &&
>  [path]
>  	home =3D ~/
>  	normal =3D /dev/null
>  	trailingtilde =3D foo~
>  EOF
> -
> -test_expect_success !MINGW 'set --path' '
>  	rm -f .git/config &&
>  	git config --path path.home "~/" &&
>  	git config --path path.normal "/dev/null" &&

Correct.

> @@ -1037,25 +1009,23 @@ then
>  	test_set_prereq HOMEVAR
>  fi
>
> -cat >expect <<EOF
> -$HOME/
> -/dev/null
> -foo~
> -EOF
> -
>  test_expect_success HOMEVAR 'get --path' '
> +	cat >expect <<-EOF &&
> +	$HOME/
> +	/dev/null
> +	foo~
> +	EOF
>  	git config --get --path path.home > result &&
>  	git config --get --path path.normal >> result &&
>  	git config --get --path path.trailingtilde >> result &&
>  	test_cmp expect result
>  '

Correct.

>
> -cat >expect <<\EOF
> -/dev/null
> -foo~
> -EOF
> -
>  test_expect_success !MINGW 'get --path copes with unset $HOME' '
> +	cat >expect <<-\EOF &&
> +	/dev/null
> +	foo~
> +	EOF
>  	(
>  		sane_unset HOME &&
>  		test_must_fail git config --get --path path.home \

Correct.

> @@ -1112,12 +1082,11 @@ test_expect_success 'get --type=3Dcolor' '
>  	test_cmp expect actual
>  '
>
> -cat >expect << EOF
> +test_expect_success 'set --type=3Dcolor' '
> +	cat >expect <<EOF &&
>  [foo]
>  	color =3D red
>  EOF
> -
> -test_expect_success 'set --type=3Dcolor' '
>  	rm .git/config &&
>  	git config --type=3Dcolor foo.color "red" &&
>  	test_cmp expect .git/config

Correct.  You can use `<<\EOF`.

> @@ -1133,14 +1102,14 @@ test_expect_success 'set --type=3Dcolor barfs =
on
> non-color' '
>  	test_grep "cannot parse color" error
>  '
>
> -cat > expect << EOF
> +test_expect_success 'quoting' '
> +	cat >expect <<EOF &&
>  [quote]
>  	leading =3D " test"
>  	ending =3D "test "
>  	semicolon =3D "test;test"
>  	hash =3D "test#test"
>  EOF
> -test_expect_success 'quoting' '
>  	rm -f .git/config &&
>  	git config ${mode_set} quote.leading " test" &&
>  	git config ${mode_set} quote.ending "test " &&

Correct.  You can use `<<\EOF`.

> @@ -1166,13 +1135,12 @@ inued
>  inued"
>  EOF
>
> -cat > expect <<\EOF
> +test_expect_success 'value continued on next line' '
> +	cat >expect <<\EOF &&
>  section.continued=3Dcontinued
>  section.noncont=3Dnot continued
>  section.quotecont=3Dcont;inued
>  EOF
> -
> -test_expect_success 'value continued on next line' '
>  	git config ${mode_prefix}list > result &&
>  	test_cmp expect result
>  '

Correct.  You can use

	cat >expect <<-\EOF &&
	section.continued=3Dcontinued
	section.noncont=3Dnot continued
	section.quotecont=3Dcont;inued
	EOF

>
> --
> 2.51.0.450.g87641ccf93.dirty
