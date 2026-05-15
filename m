Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1D78F26
	for <git@vger.kernel.org>; Fri, 15 May 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809590; cv=none; b=LJId3eOaTegLdo7tOmPSz1bsKHhkCmMDBwMJTeu6c8wjWfBMmfwLRP+Mg4vy46CoaNyq6ACXX2+jtABByuG1k8Bb55K8KRvj9ctNUjKeIYE/qSUVtsPLB41yQRRamLkoavyZuC13PBP8tS+ZGeq3sAaUk/Ez4lv4yr+628jtBe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809590; c=relaxed/simple;
	bh=oOvhH1lG3CPuhH8dtiPv0UQ+GdydH0HxkfewBuCzMpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U/XxUmLgfKLgXN/Z8eFp0qnOmf5XB0cnteCZ7JVAHUpvtAyrxmrPeJj/e3cfLknbdPYuFWXYdQmo8m99QBNgOWHW4tvPDSBtGca0mwSX8j2j6p7h6p0569wm3SRV4XG62omvojaz0L6KnUTwK6am4IxJywQCBtUFkyQHIe5H7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GIRr346q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HunX3cR6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GIRr346q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HunX3cR6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A45C1EC01DA;
	Thu, 14 May 2026 21:46:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 May 2026 21:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778809588; x=1778895988; bh=YYCfugOuxa
	m13cpVdrHNaTdUCEWWDiB6j0dvxPuc0sQ=; b=GIRr346qwXeAZdXevlDMGf/qKG
	g4ntUbdK1LTHLcaLmEXEU7/aUJRIqaWIko1P+xnsYS1Cgt4b00pbfXPyUuRANJVH
	A1R+TSqTW6mEgaOLKDPl9wcx0vR5VUGSxT3FDKlnkofVNl6ejk1hebz7yY3gk6Wn
	kPbRZC3jVqsaSlV/VmQEulF5rdhFB5kSUCiifTPGyuiWegmxMo1+BbNUH2ASLUsL
	/5bSrrAvh1edcmCHAbNzUJTgEOXizlhzX4xqqo59HBtpE1XZPBDyuvRDit1wR0m0
	MWfgyOtwJQr57pIrT4+dFPnXsdi2QbEIo82xJDPTjuneU/fpASVzmzX62gZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778809588; x=1778895988; bh=YYCfugOuxam13cpVdrHNaTdUCEWWDiB6j0d
	vxPuc0sQ=; b=HunX3cR6xNJYD5bE6HEiW99gCdXSBfaRd6rgWnWd6SE94uSwa2W
	3GRxdzEtGSAJOFtV/dlLAeBq1laXRT3pkBKusKkDIjSvliVcfWSfPspojTBaYAVU
	wxryO6c0P5mKBMq6hHnF4swQs8dazoYCEdVatRkGDT8hXLQ61ZrLKkNgBdBmNUOC
	GA2uL00IinC2SUnIQRTrbPa39b00f/cuc6VrQC45RxmHgFK0Whp6sHrfZsHBHJIc
	KxTCySDvnMqqVsqfmGDapx6OJzbWL8P3KpFmKRhlx1UpD5seh1P4kSzXVpHjBPFw
	R+9ou6MXkd8szMF57MWlyjDFv1Cztiy1gqw==
X-ME-Sender: <xms:9HoGanhrRSR3wbaSttHLFWoFxEzxmxDQ-U7gYz8nFMscIUZfZPwWSw>
    <xme:9HoGareJjqTitNMbzJ-4fbnYCPh3lhrbnNCBauG-rMNqKtWT4RsEOp4U8qgDyRKSA
    8_J05dTqBnNUynkLbz2suRiseJry89naCOZ_rbWlukv7PyoJysy5w>
X-ME-Received: <xmr:9HoGakcVnfvhOvWR8gK0Lk2VlNNglLjOb8gfueVLtaLnkxMkRHKeSvB85reZ40rHK-uZiDlsxt-c4OERnj_fGfjWHnObO55yqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeludduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhushhhkhgrrhhkuhhmrghrshhinhhghhduleejtd
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9HoGat9cPluLy80bXAcV8mRABAOTgXUJxh7dc6d8yAFKpvSkm65MZw>
    <xmx:9HoGaolg80pGi525u6bmycvmFKWHhDZ9BQCn6m0mC8uuWafKCwjTlg>
    <xmx:9HoGan-xOGl2LzK7gKxsTfcXmVsEFhcaOhfwb0j4yW_kthged0-o0Q>
    <xmx:9HoGaum2gu13vtaGjbepMLv4OWbIa1lmsiFvu0Nlp9yn7FkRM_Dr4g>
    <xmx:9HoGarfejZxdz6Z3qLpAPO5fn30kly73KCULejNqSeALaFvby1w0mXjJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 21:46:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #03)
In-Reply-To: <CALE2CrTea19qHKbhQK8V+uQJgh5GdT+8ia1q2jwr+hf546fnaQ@mail.gmail.com>
	(Pushkar Singh's message of "Thu, 14 May 2026 23:11:46 +0530")
References: <xmqqik8tm16n.fsf@gitster.g>
	<CALE2CrT9=5mOauUdzxJAEjeeD77RWGyXjLGGTObsk9R1eOrP0g@mail.gmail.com>
	<xmqqmry3i9a4.fsf@gitster.g>
	<CALE2CrTea19qHKbhQK8V+uQJgh5GdT+8ia1q2jwr+hf546fnaQ@mail.gmail.com>
Date: Fri, 15 May 2026 10:46:27 +0900
Message-ID: <xmqq5x4pe970.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

> My thinking was mainly that git stash show normally omits untracked
> changes, while --include-untracked consults the additional untracked
> parent of the stash commit.
>
> I did not see existing coverage specifically checking that behavior,

Ah, OK.  Please more explicitly state that it is filling a gap in
test coverage in the proposed log message; it would have helped to
sell the patch better.  Adding even more when we already have
adequate coverage is one thing, covering the cases we had no
coverage is totally different matter.

Thanks.
