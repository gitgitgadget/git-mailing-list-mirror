Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704F35941
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735316140; cv=none; b=ixDNDTM1c/VZygxvHTY33+3cAxvGbJfKY1lrNFm2/62z9VgeBG+CGq9WyTtR2T1GCb3QHlyLqYJYXDrsAskd/xSP7TraRzjyDIIgRFeJo4ev7zhZagSKTq3GM5F8uk3BZ32RBX94KT+5PfEwx1Xd+1kR92S48GIxEe8WSVbG/L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735316140; c=relaxed/simple;
	bh=7/DH7FHUVkvuyFMorSdK2Zrpi84WmF8w51+3plyffbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aDPrs+6aOpD83X+NskGRUD3cHUMF406ZP9qh7Oc70N1phWczkO+A1j553ZwV1d5jVSErgHi19tLBe5gunwKYrSc0XhiFJgRPg9pilwyA6GbyA4pwcJRBAT3PxQhi/eI8pzlDScjKMXUOaP2aUB0I9XvSyyIebTTk1+PBA6ckaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r6qJD7wV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUDMPubc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r6qJD7wV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUDMPubc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2045011400BC;
	Fri, 27 Dec 2024 11:15:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 27 Dec 2024 11:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735316137; x=1735402537; bh=KpovrwDmO0
	7QW0f2SRzzwh5rsnEyCqRAHcsqg6mesLg=; b=r6qJD7wVBXR6XdewRwL2qcUqG9
	ZHA8V/XXAGdGveSq58EU3qcCbVyk+NL0TFFJxsHJRv/iBtC5y9UwUAHwvnh4aO56
	+loPKMdGjFEkfA7qDcluxlqs5gYlbAWdvJ33TZZSnfsdS58E0C3bYEnKtDOYu5Hz
	yZJcTXJ56NpUR9sSQEE3lrjIF3DDbNYuhpJw7M8NeVNL4XixsAEI+xVKAmlK+FBL
	/LICw1tPobMauXanrhdpbW813uw9Sg+AjKlHOrgjU6oN95CzL0uXPMvXRjT1ugxE
	tXQiKOFNYqO+qqJ04Vc8RI95xPt5jxgiQYqgk6RwusX7gWj8U/Lcv+ljTIFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735316137; x=1735402537; bh=KpovrwDmO07QW0f2SRzzwh5rsnEyCqRAHcs
	qg6mesLg=; b=mUDMPubci2sGKEpBrMncbMzMQBl0uGoPNQkbJ0hINsYOc0XwdMn
	AyZ9HB5sUjO99YudDcL71Ih4sASAT/TOR2polFhJYvgYp46iqL2nFEy4LYJmej/p
	QMsLYwVpo525lFQqt3cIVTUA5b+vcDXud1sqydWC6qGtY1u0lQX+JT6OUA2gIfHL
	xaxoMz0XB9Lrt9igxI9tXCc4TakCC8XX0f3boWkF5M+FcDPpogsVXE8JukpTnUS2
	KkZhh9X0nKmQQ79FWGsAMiy/MoZRJWmK09u0FI1eyv/XV6h3JeW6RiALCCpmpiWo
	N2jKZlEJS5FBLo+9hn4rJzD8cx34LbVIemw==
X-ME-Sender: <xms:qNJuZxKBqCCcCTrsGbxJzTnMCahrgCohL4VmCc45J2u7arvx5eCdfQ>
    <xme:qNJuZ9I8QyyimxwBtgeAZXvwBXrg-GQ6HWmovhI7288099ZHlOiMxzrSj0f46IxXf
    4unYBP5hP5KUdakVw>
X-ME-Received: <xmr:qNJuZ5vpPWZsGKCHTFws3nx7j6Ms8ea4b3lCWGt3o_9Wb63Rc4hfpd9arkr-TCbIB_I6d1UQTcSNhQqEU2yz3rSF0mZNWgmDSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkeffiedugeetvdehffevffeuteelhefhieev
    ffeuiedvvdekkeffffdvieehffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhi
    vhgrrhgrrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghh
    rghnughrrghprhgrthgrphefheduleesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qNJuZyYlBTIuiRdpCr5tiSmDfSDwho8Bpq0n76_qCzBrN9fgog2wKA>
    <xmx:qNJuZ4a53FrTdj12wGwMuSuGDvanZZozJ0CpDY1mBJF3MbK6IHXUgA>
    <xmx:qNJuZ2D-F7t6_O1jdx8YYoxDxtV6jxm6GJmgYdjQfo6b7GgLNB-Hrw>
    <xmx:qNJuZ2Yg32pQgi14fpN9tlsr6KpQdAggCtUXzgSanuC3GDwJQ2pJVg>
    <xmx:qdJuZ1S5nKxCMxsGfcv1w4HNaWEmiLY1YGUcm88xO0QvNzg9eNmCtCg5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 11:15:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: "Meet Soni" <meetsoni3017@gmail.com>,  <git@vger.kernel.org>,
  <christian.couder@gmail.com>,  <karthik.188@gmail.com>,
  <kaartic.sivaraam@gmail.com>,  <ps@pks.im>,  <shejialuo@gmail.com>,
  <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] t7611: replace test -f with test_path_is* helpers
In-Reply-To: <D6MH7E17E6I0.3IG5103E7XXP3@gmail.com> (Ghanshyam Thakkar's
	message of "Fri, 27 Dec 2024 17:49:17 +0530")
References: <20241220130632.11826-1-meetsoni3017@gmail.com>
	<20241227105345.10184-1-meetsoni3017@gmail.com>
	<D6MH7E17E6I0.3IG5103E7XXP3@gmail.com>
Date: Fri, 27 Dec 2024 08:15:35 -0800
Message-ID: <xmqqmsght848.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> On Fri Dec 27, 2024 at 4:23 PM IST, Meet Soni wrote:
>> Replace `test -f` and `test ! -f` with `test_path_is_file` and
>> `test_path_is_missing` for better debuggability.
>>
>> While `test -f` ensures that the file exists and is a regular file,
>> `test_path_is_file` provides clearer error messages on failure. On the
>> other hand, `test ! -f`, used to check either the absence of a regular
>> file or the presence of any other filesystem object, but looking at
>> them in the test individually, all of them should've said `test ! e`,
>> i.e. "there shouldn't be anything at given path on filesystem."
>> Replaced these cases with `test_path_is_missing` for better
>> debuggability.
>
> 'Replaced' -> 'Replace'. Cf. https://git-scm.com/docs/SubmittingPatches#imperative-mood
>
> Other than that, this LGTM.

Thanks, both.  Tweaked the log message before applying.  No need to
resend.

Queued.
