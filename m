Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67AE22A1F1
	for <git@vger.kernel.org>; Thu,  8 May 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715983; cv=none; b=hLqUciKONBkSBWPtrhsVwFBY+mfzxGNB/qcegkucrI3teBmktXIHEHNx8bo0aZZmNUFYVhMK8lzhdlZnWWpBAhFT1Rc4VYV6btcAKjfUnG/kvTE1gDbIeB61qPisBa1SSUChrZrK3cIBqjJkvDMFlXRoRGl18JIhthW67kmz4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715983; c=relaxed/simple;
	bh=hY+wvFin0KIm+Bg3fj3FOXzbli1dMsRXHPPqQFrAnpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GjoQ/i7Ocep5oOXFrghLp/rD2Z2OyYK7H5tfg+P9X6058Cpk+TVNiOymDVhVontZeq0/7+NWaFtnox43uNXQjK/bEXsMt1/OMW/WTJ1EAumnJyrD8sRq1onuKCNUGx8aBIcsO4A5kNjblxyUTyMrpPwfsPyo2EonyyqpLbRXel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bWgZ9Osy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boDFu7rm; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bWgZ9Osy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boDFu7rm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BB7F11401D5;
	Thu,  8 May 2025 10:53:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 08 May 2025 10:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746715980; x=1746802380; bh=GSC/HGK25G
	Biae3T8zeq1UTMrMIHACnzeps8e5ssspk=; b=bWgZ9Osy161Wj28OKmd3/XCbkz
	AI/WT4l+rYUQKHpn6dSeo5i20e4xThvGJ5IIseplLbQ0GZd2rpDdNdOrv+DrDgdy
	5xvSif6iC7TTAKLGFbdT5LaxZLmMWw2KHOpjp762zIKrNH5gK7vARDAlqft01u9v
	f2erlNAiCe/6C1Hz8GlJ5OwP+Ub5aolTuDilCazaM+AlzoktIICom34cPCc0mP6d
	JIdDeC3svGkbDSOwPsYhGI/t6ufOQ1rF1OL1QxsAsMTKRKwloF7lmSkofiYRF/4P
	iWxhYM83pU40S01duWIFfZiiFh5oSW7mHc+tY6W7zE22cGKNdQPJnVGPJBrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746715980; x=1746802380; bh=GSC/HGK25GBiae3T8zeq1UTMrMIHACnzeps
	8e5ssspk=; b=boDFu7rm2YxdDnp9Apl8fA/9lbWq5L6DwO7GarbsAOb9H3D3hdC
	swuW/0eNnxonj/sIEuWI34htchIeubZp01Qex+HOrsyMNA1OWtv0Bb8KxbS2tEXe
	ANLzN0/SlBWMjYfZVyvqRKZMe/I8GKT1L6qt54COXmG6jVnhlkVJca/uml545EPD
	AZe5TAznyZAvyAg9nBARBsvfdeMMwGDTEaqClYt/E/F+GZCzi/fzN+og4wM2U6dP
	uNssuxYMf2BBsTg/OvDt8isAfZ3HJRKj2OdLWJ7k23MwrfmjCdtYIUQ7yfqy8KD3
	fa8zkr0e7TgJ2vsp571YkIzlseiUBbcG5GQ==
X-ME-Sender: <xms:S8UcaH9q3LSOWb5JJb7E8ieyj-sBm9MQaznIw0j893lBNhrPhO9WPw>
    <xme:S8UcaDuOkaCtuUT-hlmm_qEuE4HSmmJXTR6sgPzf4a5DuSDRYYNgc12-qgQiTHbs0
    ycEaKh2GrquZTzZLQ>
X-ME-Received: <xmr:S8UcaFDphmOaJa69h9HnoI2YYE0VJAk_wy7bRmOFiXyBtjKeY10XawDhvEwpVIS1feiyW5On_iN7dl1qrtF8mmRlLcUD6UrxA-0h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledttddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvedvffetgedugfeiieefffeghfegudek
    geekfffgieehvedvudefkeejueehueefnecuffhomhgrihhnpegvgigrmhhplhgvrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhi
    thhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmh
    hirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepjhhulh
    hirghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghoseguihhsrhhooh
    htrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S8UcaDejslCLfBLA21AhzeVfrDJ1m4t2veYobpOEsbpPwlAWGiSZng>
    <xmx:TMUcaMOsqj--N2vKIt72sb2ajrhGV8iiGdpzwvgpibiysWs0a9UZsQ>
    <xmx:TMUcaFldjVHupseMv3XBeWcWQT5iG-Oys1_Pf0GuZQ1Tk3Zs3iuo0w>
    <xmx:TMUcaGtGuGmS0wTZZJh2o7G1wYOKCMtw5MUVERUAdNw50S8OtR2KzA>
    <xmx:TMUcaJxSRjGxjA-P9akosK9aSQBNUtWQ3z2cHY63HqhBvb5mjWQErA6u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 10:52:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  M Hickford
 <mirth.hickford@gmail.com>,  "sandals@crustytoothpaste.net"
 <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Zi
 Yao <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/3] docs: improve send-email documentation
In-Reply-To: <xmqqwmar8bw9.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	08 May 2025 06:33:58 -0700")
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959781C8A5B990B2CCB68836B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xicawp4.fsf@gitster.g>
	<PN3PR01MB9597C4313236E59ABEF0B732B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqwmar8bw9.fsf@gitster.g>
Date: Thu, 08 May 2025 07:52:58 -0700
Message-ID: <xmqqcycj888l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> I think ~/.gitconfig should be in single quotes, its not a command.
>
> "Is this something the end-user would type verbatim?" is the criteria,
> not "Is this a command name?".

Looking for "^Markup:" in Documentation/CodingGuidelines, we find a
better description.

 Literal parts (e.g. use of command-line options, command names,
 branch names, URLs, pathnames (files and directories), configuration and
 environment variables) must be typeset as verbatim (i.e. wrapped with
 backticks):
   `--pretty=oneline`
   `git rev-list`
   `remote.pushDefault`
   `http://git.example.com`
   `.git/config`
   `GIT_DIR`
   `HEAD`
   `umask`(2)

