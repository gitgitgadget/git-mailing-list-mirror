Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6EF35974
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735406441; cv=none; b=mnnWk/gJOK/5dwEvCJ2CA27I96bLrZnGmXuO+1AMQgGvPUK624hiG71XrCB1EAT8eMgJtLA+bgIDA0yVPciJOvcUkyUnOV+D5z6fzpdWmgpz00thPOljjExkRj9XyYIAJPSD2AIEH/79pwES3hCC+0WFTvDqtKG7cr3u5cUOjc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735406441; c=relaxed/simple;
	bh=MdP7CQEO/1tm/VCKFy11eLz1mqG0+bi41+eEJfWxGDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L7L1aSM0WeOxa4gawwnPwQv23b6xxAYf+rfdV/ad+Y7lTYMIMlmeHUimJS8oo3Ll1mlQRWUOh8JpyPwZt58KPsvATi2l97/CFQxbEU6ywk5O7tcaZOqw30yEu+xnbIgV5STNzjITN2tQU/zpZRO4evz+mL/EfJHAopdS5pEtH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w1gto7R3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rZ/sP+z8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w1gto7R3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rZ/sP+z8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48C751140158;
	Sat, 28 Dec 2024 12:20:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 28 Dec 2024 12:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735406438; x=1735492838; bh=F0trnhg2G3
	+JHznMpNzSJi8+Yu7Hd4S1Wd0Fk8X4ark=; b=w1gto7R3Hl3FjX8RP9YQtKRya6
	TxU/AyQ7k/M5jad8HbEQyB+64fMYXCEcXkD3yYDOtGeukmArzPU8BaZG6oHncajs
	wZOvTqZmYwXcEFqEXHJ69U4LZOkLoE7Sox0ztTkrdPuOLjgEgVkPPY5BlaYFDGNk
	AvFzfFOYqp8mRwVYctiP6b5NSyCPHwofOuzEqTEg7DW4UeecakIwQrAVnt2QZLiU
	nI/fQnJcbelMrXfx2X8U+9mugR2JoAS7hbDWy+JXKS18b7RNboW7xNkR6QpE9Vso
	gmVtbYx8VhrGXTrgZP73zEFxeEknSbm3zzHd/AEP1C5RLbqc2xsoYTt41vyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735406438; x=1735492838; bh=F0trnhg2G3+JHznMpNzSJi8+Yu7Hd4S1Wd0
	Fk8X4ark=; b=rZ/sP+z8S/h5Y3pJHaRNNOrqjdmIo1oY6b7cs3EtKpo9FlULbur
	h6oS8jNs0RwOaRlcAaMzXDilyB3qX5A/rzYmOlActVVt+J3msVzhdknxpaoKFcEx
	kymETPtvtprB7p8yiMbzjpmBH/dPIIuJLHzrW51po5okslQ+jJFLfRv/m7Agpe6U
	LlpA0MXZ6kGFbDtUYC3n1RXDpkWMwDXKj4/A3vUT0/J1qTvACgEiSJj8K4EJ8kZj
	nyl0KR7IrEgPkmTrCPxL05X6iaPldQREHyj8lKsIoLsQBG8OP6OcHUpKV5X8wgDL
	6lfE1ErZ+35TNaFV9q6uWIfCr1EJmbcUjHA==
X-ME-Sender: <xms:ZjNwZ-xpgUwaGSpcLIJh2RkwGImPBiKT7VbWL9YoECWHHiyUPnQIrQ>
    <xme:ZjNwZ6Q9ym2gUkFqcu_Xh_fWNXJIB3sEmu5PRIlYFx3j4W5s_LWZ0avylx3ZXwRTI
    9TPBnDhNhBKVuXGVQ>
X-ME-Received: <xmr:ZjNwZwXvDXUGW3v5ERVw5jVbsu9ehudZiwu2ysvPBVccORSzhHBjYiWwNHWeBOpi3CACBFYJrcWyb6BRXV2p_10EFgi-HrwveQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehstghhfigrsgeslh
    hinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheptghrshhtmhhlsehlihgsvghrohdr
    ihhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZjNwZ0ivLE_U6iM4cCPzZHnMCazeDgf4z5YUFrwfO9YmEOXA_S841A>
    <xmx:ZjNwZwAWJR67KLL_iCbPxEDGS8pjsRteUAg2N-1b8q1aAhOKSdXd8Q>
    <xmx:ZjNwZ1L6dPASIT6DHwRWIIJdNRFtd21EKcp8YizqNA2bsCf6DAPN0Q>
    <xmx:ZjNwZ3DS6cyq2GLAGEFXU6FQt6ELWcf0eEWEsQ89Kk9fliOfsEpgTQ>
    <xmx:ZjNwZz8_-fIvWC9tWcDjoTKI3bAbOyTh47F_--uxpzGSJxYiDzVlZ7kS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 12:20:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: crstml@libero.it,  git@vger.kernel.org
Subject: Re: connecting the local main branch to the remote origin/main
 without pushing
In-Reply-To: <87h66nk9uy.fsf@igel.home> (Andreas Schwab's message of "Sat, 28
	Dec 2024 18:15:01 +0100")
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
	<87h66nk9uy.fsf@igel.home>
Date: Sat, 28 Dec 2024 09:20:36 -0800
Message-ID: <xmqqikr33esb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Dez 28 2024, crstml@libero.it wrote:
>
>> My question is:
>>      Is it possible when applying the method 2 to have (without pushing)
>>      the local main branch connected to the remote origin/main branch as
>>      in the case of method 1 which by cloning connects these branches.
>
> You can establish the effect by setting two config entries:
>
> $ git config branch.main.remote origin
> $ git config branch.main.merge refs/heads/main

Perfect ;-)  Thanks.
