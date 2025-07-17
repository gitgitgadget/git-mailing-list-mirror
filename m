Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB3EED8
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 21:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789297; cv=none; b=U8Bv9bq976DxhVk4EBBVXolgtZKFLzzZlBSCmYJoMxQ5U2YnaCm2VL1HcMBFHviYuG4Z67QyEMRmdJp09ujPq8SWdrKm93QzBCKrTmnCJh37b8+j0D9BUoLB1zcXxoXvLdspFIeqknVkUcOTjEpPLnyW/uoAUEaogNXFJi01Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789297; c=relaxed/simple;
	bh=O0AieYlr5ttf+ays3EdMFc48tghkkkJ4YLaJ/AZOkWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W55j9L+yFMkQa3HMh/The9j/e3YfLwDomSpeD2JWpBMs2dI9le13d+DO9iQtQ/PdmInzpzZzOxeMa7TP8ziIiaO5bhyEyH2UQJ1gZwH0QGmeKUMXyu2SrpvT6CXUBD2IeyBlYupqE+znxCgrHliO7i702jsBehJvM7s/JC4WyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=du/SJLvD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgvowuJZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="du/SJLvD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgvowuJZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D6CD1D00120;
	Thu, 17 Jul 2025 17:54:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 17 Jul 2025 17:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752789294; x=1752875694; bh=bXKTCgItyi
	KJnztJU8na+HRZ+qlvrgyFAnmjLt+RU68=; b=du/SJLvDoRTL0JXXyUDwra3aTh
	H9aw4Ypggz1ksGzrPmWxvBqBsEHwRhDoLw9z5glkpFCtnrTRSKhWKpY48uzNz+DX
	oMAguXizs3tdv2BH0t2wGnZ5HWN6yrnoYSm9Sj5ghsHVY+v+BZrWAlopaUEwOLHl
	JVkSit+dYdttVc8eho6Iqg1DR9pq0H2RvrVwNmB2SeVq6a8lOTNWS8dAlitFChKU
	idQ6cTJgOV0h8RGHqJO2K2xRWIN7flKh1FInRzHr/Lb0Ek8bSuA8x8+imQF/hL1s
	d2mPRpVjjxkgz0gaYdEHfQQpj2KHh9RCJ5g9TQkcyY8si9LUhjZhP5ZXHPyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752789294; x=1752875694; bh=bXKTCgItyiKJnztJU8na+HRZ+qlvrgyFAnm
	jLt+RU68=; b=JgvowuJZVkMjEcvrM3aZuinY+gXhtT3XG2ZttQNmbjYFayPVLfa
	7DeS53xG66GSIlgAjYqAUkwZ6jgEu327VvH08/Ry7a1WLxNY2HkMHNA+0h5H/O/n
	e5gUjof7syuWZ0COPjExNeUCeBVsrdc0ElJFqzwJ+cDLodqP9MuYOwbMnVUPOU0u
	Gqi5L5ySL+d8Tea1OktQIA6J+FZ2Th3maaP2VAdlup+d5TaKrzQzNbGxO+mt0iD3
	2UJ4VmPe91ZBugrO9eMtFGVuCkbctxL3Zwzs1bKTymJ97kymNsLKDiM6FiTFNT5W
	wIVAyyvsORC8nIq6X6LbYLFUBmHkdMt05lw==
X-ME-Sender: <xms:LnF5aPRjaeDIvGnz8pa-8y8VvkCHwtGnpIUhNhh7lnNFMnzU8YWqWQ>
    <xme:LnF5aJMhYEI8nIgFqiiVylPkC3KC-BBlxgW29LqbeFBQALfCOgzyZHcJ2oVKQH4Ia
    XGWxg_Sc4IfylYh1Q>
X-ME-Received: <xmr:LnF5aFTNifIxrsHb9nvNHKB0tL9r2WPIpkK8Eqfp805uHjtSJDzPxDr7B5Rrsg6uomZuxZL3Se3x23I4G9bI3utG0Hd8xy8mVn6Q_TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:LnF5aPizC5sqjom4Qkdl_45IxXgHnEgVzsxFApn8VmqmtC9pRptQKg>
    <xmx:LnF5aG-PfA-ByjXOSGF-7T_2GnnmL3lh7TeR1mV-aXiNt843CgSmbA>
    <xmx:LnF5aOFCQwsL-WGQB2lPPbasPmcFn0m8FdxrbHzFARYM89UHLzZAng>
    <xmx:LnF5aBmk8_2qqYUKz18-1ucjNebv4QeT976yCWwP6OTiimrCw8Z7_w>
    <xmx:LnF5aBZlerEMVC_FmVHJPUl_kJMyX50buY9xz_N0fJzuc_DipXZm8pEj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 17:54:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 1/7] xdiff: introduce rust
In-Reply-To: <aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 17 Jul 2025 21:30:43 +0000")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<2a1f4be13dfbdee21811b7a4907f99042c791c2d.1752784344.git.gitgitgadget@gmail.com>
	<aHlrg7pbFqi2qNWH@fruit.crustytoothpaste.net>
Date: Thu, 17 Jul 2025 14:54:52 -0700
Message-ID: <xmqq1pqe5vpv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +# This file is automatically @generated by Cargo.
>> +# It is not intended for manual editing.
>> +version = 4
>> +
>> +[[package]]
>> +name = "interop"
>> +version = "0.1.0"
>> +
>> +[[package]]
>> +name = "xdiff"
>> +version = "0.1.0"
>> +dependencies = [
>> + "interop",
>> +]
>
> I would prefer that we not check in Cargo.lock in Git.  Part of the
> reason is that it changes across versions and so building with a
> different version of the toolchain can update the file.
>
> In addition, as I mentioned downthread, because our intention is to
> support the Debian stable toolchain for a year after the new stable
> release, unless we are exceptionally careful about dependencies, we may
> end up with a case where distros need to use older dependencies patched
> for security but other users may want to update the versions to newer
> dependencies with security fixes but that do not work on our pinned Rust
> version.  We can't possibly satisfy both sets of people if we pin
> dependencies in Cargo.lock, so we probably want to avoid checking it in
> and ignore it instead.

Yup.  

The comment in first few lines of the file says it very well ;-)
Thanks for flagging it.

