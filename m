Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80737D123
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937196; cv=none; b=syL//phPwzqagH8fKePbLcol0NSvHQ/s+dHTWZOk9kEEvDHawsEv+vkLVlUSfuHqg9HjAHSPq6PAWTWTWKFFPiO1r7OmoIHDAy49iemlFput2UlRgWw+czQJ+ujUbSgSBSU+UNAOJijIZmkB3jLIJwibt/7JJx/0Lc3C4uY+EO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937196; c=relaxed/simple;
	bh=v3LuC4NEeEpdil8OtuGWq67Q96vRuXcCgPIo09Rm/xA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t7qO9sXlDmG0YxLIAkVmKT/zrvaQnQPKUbwtH5E1R88rfHfomz3WdHN0E/p6ieMSv+kx0Cmr45sSlrXJYnXhe9VBgJ6wMHbIW2xNnOR2B1eVLk9PFPPMC/sDR6JAQZI1TseL9KyhMCxmz6S8ANrRgo4NVQblb+gmTNqrKRsABT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BrLsXMiM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T3ZkCI/M; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BrLsXMiM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T3ZkCI/M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CD561D0011A;
	Fri, 28 Aug 2026 13:13:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 28 Aug 2026 13:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787937194; x=1788023594; bh=ucinx9BhWQ
	dH2GzHZ0HYBQClNtivRz7kTgtrC/O+XwU=; b=BrLsXMiMeGnCBh6lTS2PTslrCM
	QRKwQIVHC8DDtGhiG/KKL8tP98ibmq+LF/kl9Pzg0Q7c1gQ7QgR81OVge1d1ph3C
	exCAEpyo+DTugU4cGXETEADh1OK88gMloyvrWNC4c4lvthmJg70QINE8ZOURZgB2
	b98Tigq+Zo73mgxxYr1GneeCyWwBF/hmxdEJyWC+ypuSH0/26L2aJmw9m/uCiANT
	UI92Q6DEkzGlwUxqrTcSQ1K51T8YkAxdV4wyoPWfR5yMHCQ4fgcMrL0tmV/oZHc/
	00AqyaiEu7bI7GZUmK3eV4lUtaXPPsBH1lqldFHeQmvIM7qPQP3ZVGTSRnNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787937194; x=1788023594; bh=ucinx9BhWQdH2GzHZ0HYBQClNtivRz7kTgt
	rC/O+XwU=; b=T3ZkCI/MESUZiSXHw0/5/8ClfCTh/8kbgd39iqbpU+DQBn5FGMY
	bsUvJnuhDBVHLjAkJsf7CuY1nTIglWWPODK063MKevT41WIJ5adm0rXIrS2hjUu4
	Ph11bFhwaLE/xyLUXWqALBF+/G2wQI1vnMkJgtWa9tPkeWV+CuJvHC5hFPViL80s
	ov87ZV1ZTZi6c/gHWJ3/9Hc38+/0yHltXLU0d8RqvapTpnhoB6bbMa5QBTZ81XiT
	bNLQK/T731jJukxH6WP06t9tH0FXA6gZPecv4ej1eVMrJFYHYsA0Yv4tnp3R9uqR
	Y5Aw6XPWiXU190SRjj1Mfh4JD53oAtlp1/w==
X-ME-Sender: <xms:qsGRavdKaVgU2bz-rWf6TN4MYPCVv7TA5NIaoIK0XP8OGjg2AkQFAg>
    <xme:qsGRasrMtD0TUqEkgi4TMjceNfpkQGy8xGmaOdIAzCbXFTjCxq23qd9AhAlvwLwf6
    nfI6B-p7w2tq4vE5o8hOPan4K-7hSQmlYbPqdTSz37kN056V4Dl7cQ>
X-ME-Received: <xmr:qsGRal62ruDqO97JJmijzEcz1EuvvwTbwgz92LSrGb9UI0ZwiTTi6CVybgMSQzBhQVEIhlMPjTVCl7aH3Ve7FV_c7aAHTgtuYg>
X-ME-Proxy-Cause: dmFkZTGv/tzGpVyF2iokhtY7oYvpwHWgy9iRHtPpnTTILvbhZG21vaITPZ25q7T7GgMGIu
    xIKK3LqmDQOWd91xlMsZWYMLktGnnA56pePQJWRd4HCkIunHUXQAiBF1ruQ2aE7xsgQARu
    fV6am13XOhVx0S6Np7xP8WBB1EbWuWn1e8aMbJH5180J11Zjz2mo1gUavAVX83SHSLVrZF
    hImstBa0RjtKyGoUPoI2Rvwu9UnOEYi/6KBfkPywlRFKRMOvyobzV+6pdqbIwJsD5TLf4L
    /VdArVpaPHEg5cs3a3R+zg7FRYEXzfaRY3tMPza4FlDRhPPuUAN1AC2tZSffx+5dHi4PZX
    6KDSHmVcJODKCY6UOo3POu4wvvAhBb+psjdUtw0e6h7ylnpApJxTslLmse004NGc3RzEP2
    xNRF6fJXm9Qaz/ohPpKrLYGrI+7042ovnCi6EdyIh6W2hpPolELIMg+6Td78BB7so437wS
    rKN21W3hUasG2HmLISts+LbbENN+YACvwZOsPcqlYZAxnYLKPjF0UaO0Mj3ruWdIiyp2MW
    rlQQvqfkGH2vu+KFXNiQWFpCXi7tgPHL7Mr+d31c1I696gBicohe6mnQIuEcvM5WDcIohi
    X6DbGcSioJ1HFf5BpYOcjXit0y/MJnDu/eDOH824EpKUo1T4tCk0dRQ59/gg
X-ME-Proxy: <xmx:qsGRaqqdri3yLsMbGeOqV_tGvCiu6FARseSJq6LhBaEj_bVsphPulw>
    <xmx:qsGRavhYGYQD0fBpG-NpDSSn-Zak1W4vD6CKoA1rOwVZhh5fKkhQOQ>
    <xmx:qsGRasIy6yOifUjmfNg34yYsVn9cpFMdtlZh780CigP8fzhEHsp-0w>
    <xmx:qsGRanDyaQ9bjIb5EFzvNt0hI_gj_nVRPQQi8BnF0QtEOoFfVuKnyw>
    <xmx:qsGRasxnWNfpanQ_TY6n6sPm7K9JE-hat3neI6sc_lwPR-JrvoNmz_od>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 13:13:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 28 Aug 2026 15:48:13 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
	<xmqqjypfp2vl.fsf@gitster.g>
	<16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
	<xmqqbjan6q7l.fsf@gitster.g>
	<9335a35f-e9c0-4e62-812c-e5855c201003@app.fastmail.com>
Date: Fri, 28 Aug 2026 10:13:12 -0700
Message-ID: <xmqqpkz24193.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> I do not know.  My preference actually is not to introuce a new
>> option whose interaction with the existing --notes option cannot be
>> defined in simple terms.
>
> Let's drop this topic then.

That is fine by me.  I was hoping that you'd come up with a way to
add this new option with simpler-to-explain interactions.  E.g.,
when only --notes exists on the command line, it is used as the
material compared by the range-diff and as the material inserted
into the final output, but when both options exist, they work
independently, i.e., --notes gets used only as the final output,
while --range-diff-notes gets used only for comparison material,
or something like that.
