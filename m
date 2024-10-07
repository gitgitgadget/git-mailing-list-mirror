Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC7188013
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288516; cv=none; b=iKFVco1SbJls39Bs+EU1gwvzsbxf2+RN1qhDjNdiAN/bsWolbdSezSw/TWXcupFVfBem+3lrNWPr0kEtKC46o2ZxQZ82z/xiCysTb+plasJuWxTlhRTw78PMVrm5eDXeI2xxE/TkSq0xUWNDcjBqM+8bd5E3aUCxkqW4s7eBsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288516; c=relaxed/simple;
	bh=Bj4c2nUv6cR+6L2ouDxyRD7SUV3kZRJT7bvOi8RhMLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk9j8lfzeUn6TOsy3dFmzh/AyFl3UBK5UK3XqTA3CsaLqG3aSYKiIss1c8Oa9h7ZcWVAKk3I+LRjo4DN6K0ov1pRC/s0oBybmcOIB5l9GvlSBkAeTGJAIfb6OLpVDP5yRtSNRNAreYOkwA8H+E2hdwzBgvf6lbqewjqU5ZckfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOkRuT2j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSJ799Ph; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOkRuT2j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSJ799Ph"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D70F25400DD;
	Mon,  7 Oct 2024 04:08:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Oct 2024 04:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728288513;
	 x=1728374913; bh=DMqprM2iaRm0K0HrcU66GB0TI23DLQ9masxUdiF2DuQ=; b=
	dOkRuT2j0Dv4Srj8Ch/oxthkf0SN20jldui9ttEuS6lZX0MGCYfumS0cxbh8RERM
	+gDpJuzhd8MjgtHN7v6G4MeMTXQJzhiuqwXdcBKxS1pBbMCS+nBQZ3xzsazhHJTQ
	kK6nN9hJTg4J7Ir1n0arMdKbEkpCNkafgDxGnC5KjV8KV50MlO+lUFfghonr63fm
	sVGwU1qAsqnRFlsF2lVMnnHBD5/T2/P5N8KxjgqLCmmT9jRq8v7hz7jxolIjP/mV
	vpLKw0t+YQWQl3uhzC87TgtPeP4XPkUSnZk3tWD8Pf1ILP4JbONkADGZ384CvHmW
	THNQghSfXy5zyvJzBMmXMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728288513; x=
	1728374913; bh=DMqprM2iaRm0K0HrcU66GB0TI23DLQ9masxUdiF2DuQ=; b=C
	SJ799PhD1oWb/xQ1f5jO9lg9kv92aP9GIQXfRVJ0Foifmrm34p1ZFYA2Bzc8QlOP
	CqVUSPdIFHQVOZudh3quTzLwHuzZj8BDxFl2P7eB/02mAu/Dyc8d/bMEN0Oo1K7S
	pnb3tuqH6yo2V13mP1qXLjnhcTHX/9IQRiuah+0IranYM95O53BbvoKPa7EJcKZr
	iAGJRpK649DxwtEJakfX9kcz6e0cMz4CA2Z0ftPOdlE2O5KQ8yjlCkZjjZzo4RMY
	dDOUmKgD4iUrKPsSzqRUUxV/MlLSyaCi256oqM6xlTqEzHIl18oU5Jo3q+ulenkB
	04b6tSwfHuyb2UQqM2UOA==
X-ME-Sender: <xms:AJcDZ89KYLVQSpVX4UOivUP2aVMnTtnh9toufY3civNlEGBSLyOYXw>
    <xme:AJcDZ0vw_31ggRoYeD7FblOPxBKXkbMFV1DryfRLUiTVqvk37uJp4XyxB720qKSif
    e3ICqgjbt8IuhRbTg>
X-ME-Received: <xmr:AJcDZyAKYR6563f3gJk7TBFKVVYLTkwPuLqePaIZN_5-3mGnSrSsTR4efUbSK_-_PYI0ZjG_ttTIf-6XnyrSFd2WKSUr40MKgfWg523IinYI55c0Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdev
    veejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddt
    vdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AJcDZ8d7zXhO00NHURwEaT6HNGnRuLTovC_kIJnIKp8_7g00yxrXlQ>
    <xmx:AJcDZxNCavbHwpDodjrp3JCUZW7KbIjN8dWDQ1nm8qsnDd4ADDXEjg>
    <xmx:AJcDZ2nQBUe_oWRJl3reNfV0ZUl8JDcrM_Q1faZfwxH5QC0ZaslVew>
    <xmx:AJcDZzukIRijHoYOWVRFWjlDogfkVF3joBZun6VeAq0VSJX2HuGLLw>
    <xmx:AZcDZ0cjQvIZ-INygjffL19Mgi6S5V2bojj21Jqdep8J5SrrVS0g-kKO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 04:08:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d19a2315 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 08:07:32 +0000 (UTC)
Date: Mon, 7 Oct 2024 10:08:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
	shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v3 0/2] [Outreachy][Patch v2] t3404: avoid losing exit
 status to pipes
Message-ID: <ZwOW96K1_12Kzefo@pks.im>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <CAPSxiM9eExGxy5biEr_23tCKXaUQg=tsD57VR7e2SVdvVJR+Kg@mail.gmail.com>
 <CAPig+cQ1xC9ky8+NZO0ywmYAa6Vxe2ZUbs_Ae4OTTcWM8tHY_Q@mail.gmail.com>
 <CAPSxiM9Z3q5Oz0PkadC72J0cU2F9D8Rh5eAtNz7aZoUZxp6PUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9Z3q5Oz0PkadC72J0cU2F9D8Rh5eAtNz7aZoUZxp6PUA@mail.gmail.com>

On Mon, Oct 07, 2024 at 07:25:44AM +0000, Usman Akinyemi wrote:
> On Mon, Oct 7, 2024 at 4:24 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >
> > On Sun, Oct 6, 2024 at 12:18 PM Usman Akinyemi
> > <usmanakinyemi202@gmail.com> wrote:
> > > Kindly, help take a look if this is okay now.
> > >
> > > Also, I wanted to change this also to use test_line_count,
> > >  test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> > >
> > >  But, I tried a different approach and the test kept failing.
> > >
> > > Similar as
> > >
> > > git show >output &&
> > > count=$(grep NEVER output | wc -l) &&
> > > test 0 = $count &&
> >
> > What is the actual error you encountered?
> >
> > By the way, we have a handy function, test_must_be_empty(), which can
> > be used if you expect the output to not contain anything. As an
> > example:
> >
> >     git show >output &&
> >     grep NEVER output >actual &&
> >     test_must_be_empty actual
> 
> Thanks for your review, I really appreciate it. I tried this approach,
> but I was getting this particular error for the testing.
> 
> not ok 32 - multi-fixup does not fire up editor
> #
> # git checkout -b multi-fixup E &&
> # base=$(git rev-parse HEAD~4) &&
> # (
> # set_fake_editor &&
> # FAKE_COMMIT_AMEND="NEVER" \
> # FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
> # git rebase -i $base
> # ) &&
> # test $base = $(git rev-parse HEAD^) &&
> # git show >output &&
> # grep NEVER output >actual &&
> # test_must_be_empty actual &&
> # git checkout @{-1} &&
> # git branch -D multi-fixup
> #
> Below is the particular test case
> 
> test_expect_success 'multi-fixup does not fire up editor' '
> git checkout -b multi-fixup E &&
> base=$(git rev-parse HEAD~4) &&
> (
> set_fake_editor &&
> FAKE_COMMIT_AMEND="NEVER" \
> FAKE_LINES="1 fixup 2 fixup 3 fixup 4" \
> git rebase -i $base
> ) &&
> test $base = $(git rev-parse HEAD^) &&
> git show >output &&
> grep NEVER output >actual &&
> test_must_be_empty actual &&
> git checkout @{-1} &&
> git branch -D multi-fixup
> '

That makes sense. The expectation here is that `output` shouldn't
contain the string "NEVER" at all. And as grep(1) would fail when it
doesn't find a match the whole test would fail like this. So the below
would likely be the best solution.

Patrick

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061..978fdfc2f1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -410,7 +410,8 @@ test_expect_success 'multi-fixup does not fire up editor' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 0 = $(git show | grep NEVER | wc -l) &&
+	git show >output &&
+	! grep NEVER output &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
