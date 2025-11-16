Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707921F37D3
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763271016; cv=none; b=Z/RKI/VwL+pcO/0Aa0GI7iHphhAd+uCTGj+KGccCKfDMcDp65sa8ny2yzDvmckqoEI91HyhdPa6qLkGk3vo6b35kZ6J9aE19cdBMIeRHvxi1Eo0B4OHeLeBMYaNzdYNpMzctcKtk7fcHdKvUOAVFSmmMSY3Vd34XSjFXd6BXjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763271016; c=relaxed/simple;
	bh=FJzJoXNm5ESz936XNM3ur6LBkdAelnLklyyCGZexKGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TD26V+bnnQ+95desnSlm821S9/31u/LLB7d0es6Hai7UKwQCXUSdPhUC74bcj6yPikYW9Kerigrmzu/NbEimCF1PL9+h4ZKhZPJV6SRHlgPBZybB4pWkdtYz+x7m90o//SSKy/9r8GefhgL5ERFccXK3OwldpdN2d9AmdqzpKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqzMTQFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yTXCSLAe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqzMTQFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yTXCSLAe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94BF414000C2;
	Sun, 16 Nov 2025 00:30:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 16 Nov 2025 00:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763271012; x=1763357412; bh=k0ci3phOFx
	cb7xFhoryGHpKWE8u/IkPypmgcE0QX1hU=; b=TqzMTQFV+Hvvzn0cdu0HFhNGeo
	Xb/jlDCjc54N97CyVoeD4S6XYvL5tv9vaQaCSbFPk7rI+efmK/iS32Z+rCib9fKV
	2bqdMopsEuDRf6oGwx6dEClc5Vml6tEn/KKvMafp5/FxhhQ/RLsjw6oy9WfjQcRM
	BCsNoKMCi4ylbBDfPxaSCvOB8G13OmXrFZkGo0zY4MD7Hem7TNdxz59pczZ7ktNi
	/lkj+bgRFzfGEqAPYJ/RboYEQMLQwwx5dIh+Q0UgYV2K3BU71z/laaKvzIFD8vLF
	e99Ibbr6gC16HprEYjtDujSI66XvKyA7LsdRAdslKE3yfu6D5QAzxix+0kWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763271012; x=1763357412; bh=k0ci3phOFxcb7xFhoryGHpKWE8u/IkPypmg
	cE0QX1hU=; b=yTXCSLAe0XPVrWpChyDhUpMkeDqw163CQPU7DBRMwbfds43+uR2
	nJbeK2Uh1LZhtxPkcYG+R2PMLWumFkm8sdwrIqRrGaMRBUtEpwiEqBlqxhbnS0W0
	5BVWAkqKXzCB6adA5ApFDtCsLuvku5Ftyq2wKBOtujQsBSn87YJqM3mcm30q/jBk
	C9e9t8/pQroxeqyS2e+deXZkuz8q3QOo1c/ELTAL7PK/E1h3ZbGyxMt2C+YhCS6+
	zr8ML/8yiZQUBIGPc85qK2Oa0Fjgy+Fr9n4gTbskIKooJhjU2TptDamu4Z9aD3NF
	BOsC0Zey/qvxAAbaVCtfkzR99meYvG2XIJw==
X-ME-Sender: <xms:ZGEZadozPjrq4urRUPwSKm6fM16J_OLHl9C-8YHsHyPNvgcxovANcA>
    <xme:ZGEZaevqchbz-ZhkfEWrAZoIOmQk0KhKDEcw59Q_-BAdJg7120tDOdxVbOUrwG54Y
    pyWn-60oS0xABFnbubgbqkLIkJjblX_ndBJ3Wwef4hfzfz18_R3Vg>
X-ME-Received: <xmr:ZGEZaQbmLbwvqZOIaS-dheWU6x7tI9R1iJmubnQrK6z1Bc9B0XGci9vn8tp9nxAM6x9NSjXAofz9SuP8EdKKDE5oN_vAieXcjZ_D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepsh
    gtohhtthesshihmhhpohhivghsihhsrdgtohhmpdhrtghpthhtoheprghvrghrrggssehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhiguvggvphhjugdrkeeludegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprhgrhihkrghrrdgrthhhsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZGEZaVZypRKNZWmaelC4XWh12j4kE5bt9F45upZ-qf2uaPWjFNk9kA>
    <xmx:ZGEZaRmBsbht2kSLKSSydttv3aPJ-mpBMhL_3BrfenerMwg9oqyJ3w>
    <xmx:ZGEZaY1rVK-Iua34Gon-_qUVF-Dm064ZlOFmY6LhLHT5rDQudDtAfA>
    <xmx:ZGEZaZ3JUW4e3kf22NRKadaWVWcHl38izYNyxC8dFPj2EPnIzcUQbg>
    <xmx:ZGEZaVub4HacM9RaqJh_X_KAgr2uSA127r0SB64ypqRBZXlYRSUBPYKh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 00:30:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: "Scott L. Burson" <Scott@sympoiesis.com>,  =?utf-8?B?w4Z2YXIgQXJuZmo=?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason
 <avarab@gmail.com>,  Jaydeep P Das <jaydeepjd.8914@gmail.com>,  Atharva
 Raykar <raykar.ath@gmail.com>,  git@vger.kernel.org,  "Scott L. Burson via
 GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] diff: "lisp" userdiff_driver
In-Reply-To: <773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org> (Johannes Sixt's
	message of "Sat, 15 Nov 2025 18:06:44 +0100")
References: <pull.2000.git.1763201865025.gitgitgadget@gmail.com>
	<773d3233-c890-4df9-8f7e-32ff8a48651e@kdbg.org>
Date: Sat, 15 Nov 2025 21:30:10 -0800
Message-ID: <xmqqbjl2ee8t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> +	 /* Either an unindented left paren, or a slightly indented line
>> +	  * starting with "(def" */
>> +	 "^((\\(|:space:{1,2}\\(def).*)$",
>
> Compared to the Scheme driver, this regular expression is
>
> - more restrictive because it does not permit arbitrary indentation;
>
> - less restrictive because it permits everything that begins with "(def".
>
> What would happen if this regular expression were added to the Scheme
> driver? Would it pick up additional and unwanted hunk headers is typical
> Scheme code?

As we generally assume that the file being edited is syntactically
sound, even if one lisp variant understands "(deffoo" and others do
not, it should be generally fine for the pattern to say something
like "at the beginning of the line, optionally following a few
spaces, four-letter sequence '(def' is likely to be the beginning of
a function definition", as long as there is some convention that
user defined functions and macros, unless they are to behave
similarly to "(defun", would not be named so confusingly to start
with d-e-f.

It would be nice if a single set of rules can cover what existing
scheme patterns cover, Emacs lisp, and Common lisp.

