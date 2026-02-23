Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D336C0C2
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877112; cv=none; b=puJsvyQsCTaIIxgDpNqEghR6KIm511xP/WT5mcA42NsNaMxkFt2XOaa4H2clW7F0dO7ude1j4yb5ouVN0yWn4UmC9Pu0fW2ZW8I+JYJ4JO9+TGrFQpbWG1CvcLjSzMYzOzp0HN++zCEW0ocvp9BH8rikmAN0f59CADf/GXQkguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877112; c=relaxed/simple;
	bh=vIkNoE2k8gDW3UUtNBTLyIqtl4i1BzXqQMzKaIlSlnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VJ/N4Cr11z2tci4i3GVNySSGceCOfggNJtjnZzdwSCeCQk/+0t321hj1t5ekkU21bNb8r+ofB/4aFEBSFYIPK6HjaAyk0eNw3gxXoJldEXBM2+8D7504QK4WcZmLwW/7x9JQMhNb/B7sInJRS1mxL+hYun7Ahm1nMzR2YfAjfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KUH8Ao/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NkpMA2Z5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KUH8Ao/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NkpMA2Z5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60E141400179;
	Mon, 23 Feb 2026 15:05:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 23 Feb 2026 15:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771877110; x=1771963510; bh=AizHZmpEV5
	y1iTvaaUoQKyjcq6UZ/miWkbdemxwCI2Y=; b=KUH8Ao/ldAfc8ySqaKexrcCVLX
	Gab6Puijbq3pwvxORFvEpEBgXCnwVktZ0/aZi3awNQozUvJa84Ma5/tIfNLVBlWb
	bLNHOhUJvNjcAzApzfVaSvPWk1ESmOEnziKPlbJAzJc5tAIkTDtQ0P5I+3pBg0vF
	m7OwoNdnhv85M/8nbx1HVprZoofUTfCSaX2c3f8dZUyB3UQgF9xWWbL8zFxHzb+c
	Yrnh4Vzjahj+VveERGCgW6rTistr1Cn25iFS5ScFD9AHwpfctCsj3SzXYzI8TIKB
	GQ8rv18HCLbPxnc4DUS8bKisEyGVoYZfZwRaXe4Ga/fozbRBoWFqOFAZX3aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771877110; x=1771963510; bh=AizHZmpEV5y1iTvaaUoQKyjcq6UZ/miWkbd
	emxwCI2Y=; b=NkpMA2Z54q0hIq8MvWGXStUeUJAnm1ksACL9F822ukBfyoI6dtd
	jJ7xIs3cHhfyHDzXFi3p02I8LY5OfE0OOeHkXpGFfB8maerAMqopGaRYMprgZ/s7
	/pXgTkPAynbTIDyRnpL4yiyVBMTznYY6D9SqWBqPWvFs5prPyae8+s4kF0XVV/OE
	cYSiplrbVjvAs3hecuYc981IGTQodGX3cw8yezxXj1d8SfUQI1WRhP/v0LtN36lD
	fDdB2XWyo8mILy24FgNjYIfSsvbH/DgRPegiG5IPCrnTOzrWRmyZo3za/xfWoGYx
	1ZOV2G6ctUFiTUhKM86HMUMW4W+VC6cWndQ==
X-ME-Sender: <xms:9bKcafwyvAK9HRYRlM4OG5Kh6OIb7kQDQ0nGzq5c6VNi9AiSun2g5g>
    <xme:9bKcaa9esb_wSzmbLc_NowMnkXwTANEJtxFJdIL7UEwd8V6ltduEIPO3KunCxjxhA
    7Rr4zp6DMAIcrWqiykosYbnXTaLE2HGNDWVnN52OGhl_pAkMH1V9w>
X-ME-Received: <xmr:9bKcaTLlrU2fCl4Xt_FWjkh2vuFJ8ECgmz_3W1iFC0pR5ouSd2BoCq3MxUsgnbLPy4PBHXtU8yrhmnX8EYBL89_iyTIeWb-Z2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieefkefgueeujeeuudevfeegueevleefgfeggefgudefiedtheduffehheel
    uddvnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgv
    vgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9bKcaQfy-tiJGC78OWM1QeQ_ZYolBT5V1z5qwaOZ292F8dZOwbc5ng>
    <xmx:9bKcaS8mNW_JCcXfPo7lur18I2xYIzVsb0yDMk4BgiYYjmitlDQ0Mw>
    <xmx:9bKcadqac54Vg34rlalWWM8RNvi6aoFeRlqk1j16bRRLMbF0fWs10g>
    <xmx:9bKcaXBBWS-NjQ4gEsCK44yLhgFCay1_MxWssChBJtaW7nQHvbD0-A>
    <xmx:9rKcab5lBMP2zw082Rl_q1P6YvN596ajyFRemHJK2LF4k-CceIXjXiZn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 15:05:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  toon@iotcl.com,
  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v8 0/6] refs: allow setting the reference directory
In-Reply-To: <CAOLa=ZQ2qaSbxaEfK-ngZUfM-WwPhiFF6wYRK68=0QJ9P-5BnA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 23 Feb 2026 05:37:57 -0800")
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
	<20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
	<aZwx6F-ZeQ-LZv1M@pks.im>
	<CAOLa=ZQ2qaSbxaEfK-ngZUfM-WwPhiFF6wYRK68=0QJ9P-5BnA@mail.gmail.com>
Date: Mon, 23 Feb 2026 12:05:08 -0800
Message-ID: <xmqqikbnmdjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Mon, Feb 23, 2026 at 09:01:35AM +0100, Karthik Nayak wrote:
>>> Changes in v8:
>>> - Fix a typo/grammar in commit 4.
>>> - In the final commits tests, avoid creating a file for text
>>>   comparison.
>>> - Link to v7: https://patch.msgid.link/20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com
>>
>> Thanks, I'm happy now with the current version based on the range-diff.
>>
>> Patrick
>
> Thanks for the reviews.

Let me replace what I have with this latest and mark the topic for
'next', then.

Thanks, all!
