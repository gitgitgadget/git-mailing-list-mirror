Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45A20ED
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858255; cv=none; b=tAGI+caf/MBXSMoPaFmdGnqqvk1rWmsr1cPEMj55pZvYqzNDf4qBvm6pJu59E53jRS5uHK/TGj5qV9do8sXt4pn2Eo9OHWn0YBLOCTwI7dpXNiug53YGFC2Df0K/fQtXTCvEvpw84HAwOWhUw8wnwe+L2N3X15YDCb8fyS3HBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858255; c=relaxed/simple;
	bh=OCX0cMTHr1f/DvbCC3YW++mVsfyS2EzPH7TIvxwzdMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RQKBqZIdBz+1TCGqEVKGdaelHAVi20GPmiJZNhMUQmuelJW5HwhOAQRt2+lqtge8/69dAKpsJ0MyP2mmj0ctEQYbG/fUZiwSeTRsLiPBgmlLNKVkhX0aMj8RsTJrp33mo/KJrn1Qc2nrVlloOmUnb/CHWW7EyUEsoxMZ6VF4HXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OV+8VqJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bEnal/hC; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OV+8VqJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bEnal/hC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C1D732540277;
	Mon, 28 Apr 2025 12:37:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 28 Apr 2025 12:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745858250; x=1745944650; bh=NIDi6Ypkf8
	GuHEr959HevA3TD6j7GV/snhSdOAWO0I8=; b=OV+8VqJ9MT8zqczeHQ5No3KPDo
	uafz20/1lAsJZUjx9bYa0tt1YVnNOz78nRFH32LeAevQ28GTs5vW7Duh8RXDzb4D
	OdoQnkEjIBzXqhldfrSyPwLFr2Mi/nSmQgw/cTEDj3pTMhw/oimEFL7x7Bp6wm1N
	P5aIZ+KEdazUjv3MLpPIEl2M8uCkXs4oaMKrsetrjvFzTM2OSZg9lCt/QiPKUHby
	yc7JPH+6yl3ZlqmLH3uL4fheHbKP7iOGRmZdMO5Y7BDgAqdj8yL1ZpffjO15C3Oe
	ge9qcZHj//XSiZ99E6zjpnWjpYdGBfWcnrRGl25FxlfLQJduhHe1apeevS5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745858250; x=1745944650; bh=NIDi6Ypkf8GuHEr959HevA3TD6j7GV/snhS
	dOAWO0I8=; b=bEnal/hCccDjUMWSLTU2kMImvNYZC6F4tKzJZHugz1IF6Xqrcgm
	px46jSXfTWLb1R5do14zUqa19BbiJ9gXBmshX6auZtLL6aT4DsaKPLYFlvZk1C66
	s68/aFiXYX75TR6pdV4JhgO4b/JLoVQWBIG86sNOtY2WF2fopyCEipJYsGD3tJ1p
	CBR286XcQ3xh6JdVfbjAC0pGGEYGtJ6vMYhqFnqq/GSLeuJ5nIFPoBJukDHjlGGW
	vmcd0nAZJXQDDXyAfEC1VBPyLB+A3zWTNs1ZhGOZdsmwTEEGkIuThXr6SS3lBQBL
	CYgDuO74xXhRPpkzmMlc98r8MrV1/UNwJSg==
X-ME-Sender: <xms:yq4PaEbKRD23WrTYXWGT2odnF214S1Ju2BtEyYiw6KwHuDK8j3R3bw>
    <xme:yq4PaPYfg1iNZR8WH5jGK7UQ2fkADvPLT6PnX9LQ9YXLaoKydUZMonZk3BWsPLH9A
    BFlRvgo0bwchDWLPg>
X-ME-Received: <xmr:yq4PaO_3s0CpaaS6iFVG6wbivDMx6RwAMjVshWbLeby-o3iUrGYvoWbTqBGDlbWdbeF4d-5NKoNY-qPzI_DdjBl_oxiS5DMxinBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yq4PaOq2mFTp4OhFamcX45i8BJaew1ahPQwTNTBSikQ-TfWPlfryaA>
    <xmx:yq4PaPrhVwHDRigEH_kyuSmJuEKlcYYNTbpWtLb-AgsEoNZknX70mg>
    <xmx:yq4PaMRv0CYpCzmP-LoPfTRP9Y_bbt9b-QXiYJefIgU0ZdzpM2UDCA>
    <xmx:yq4PaPo_dz7_rnQPF4IWSvZZ3V9jvn01aQHJp07PWjvKnhHwLux5PA>
    <xmx:yq4PaH0mtcuhobQCovZCuaNzwOKfScPlb25ptL_R-FWHCbmmM9NikAlF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 12:37:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH 1/3] test-tool: add pack-deltas helper
In-Reply-To: <275808ae-7126-4a24-b5f3-283ea8023f5f@gmail.com> (Derrick
	Stolee's message of "Mon, 28 Apr 2025 11:22:13 -0400")
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
	<5d4beb202d6ed842de72928462a10a4f5faa2718.1745430004.git.gitgitgadget@gmail.com>
	<aAsQwSfr-YvS2Mvh@pks.im>
	<090ef16f-42a7-8de6-a79e-5a1958e2c103@gmx.de>
	<aAtZuU6Qqfag6OHj@pks.im> <xmqqbjskurz5.fsf@gitster.g>
	<275808ae-7126-4a24-b5f3-283ea8023f5f@gmail.com>
Date: Mon, 28 Apr 2025 09:37:28 -0700
Message-ID: <xmqqmsc0dyyf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> Yeah, I think we clearly showed our "it's just test helper, whose
>> callers are supposed to know what they are doing" attitude, but with
>> proper helpers, it is not too much additional effort to do the right
>> thing.
>
> But with this philosophy in mind I can change the CLI to be of the form
> "--num-objects <n>" to use the parse-options feature. This should make
> things more extensible in the future.

True.  If we are aiming to deliver this to end-user's hands in some
future, I agree that we want to make it extensible, make it dtrt
without being told, and make it harder to give wrong input.  If we
are going in that direction [*], I suspect this should not be a
separate and independent input---rather, shouldn't the tool already
_know_ what objects it placed in the resulting output stream, and
should be able to _count_ that number by itself?  One thing it lets
us do to have this as a separate number is to create an invalid pack
stream where the header gives a wrong number, and as a test tool,
that may trump the convenience of not having to give the number
explicitly.

Another thing we may want to add to the tool is to give it a mode
that either (1) refuses to place the same object in a single pack
stream more than once, or (2) warn when it happens.  The latter
would be useful to create an invalid pack stream for testing.

Thanks.


[Footnote]

* ... which I would welcome as the project manager, even though
  personally I find that 'it is just test helper' attitude
  attractive.  Not everybody in this project is experienced enough
  to understand the 'it is just test helper, let's not spend too
  much effort on it' attitude and elements in the code there should
  not be blindly copied and pasted to production part of the system.
