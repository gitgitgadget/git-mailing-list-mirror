Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC561419A4
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255414; cv=none; b=sf10OSgWOSE+2ff7hW3XkNEiSl6gd44JetqHoTmebRkmkmMJO4f9hvVTyPHIb4zmYgUaKJXFUl5FoTzKxdrqfLgzqxp8aqXiuy/fymtUk+Dz2I0IRJhvkX64ppYd3eiM236Sui2Nu7Q/po6DJ+WJjo4seMXCbcyiKxpoOuiMmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255414; c=relaxed/simple;
	bh=p7HX2j+M0nkI9r3gCYUt+3uHKxMxnktXa1tg3zgVzEw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NhXeJXKnyFCCHrRCL1TpBXhcOkp6FUCMFZi5fsIXSRo8cXrmzwOM3Z5wcB/+X/eIFcC5HQFwJPM0s//MH7CGr4Xy0boemoxivO7gfXw2NV1PTXxsKMPwAjWTR6OcIeYKk/g0Bm9YsLtAtPSco4r3XJMIoSH1jcXDmAj9bYNColw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qq5KTr24; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J6j/aTqI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qq5KTr24";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J6j/aTqI"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D31267A007A
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:43:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 17 Oct 2026 12:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792255408;
	 x=1792341808; bh=p7HX2j+M0nkI9r3gCYUt+3uHKxMxnktXa1tg3zgVzEw=; b=
	Qq5KTr24/E/IrCM1NXCV8jyl9wSAH6lBxv7y77OrMjPUc503ayQTaave+69XXws3
	AkvSeydwzrBrFeHYZfk5OLzVXWJwqmdmKizTJzVY1SQ3gsefNUAFTpuFV/AEf9G3
	4aF0Wf7BShupCvwputBrF8/UUpRp70jIUZyAqyjh03b5/Nb9s3BjRTzLQs7uvx5V
	hiVUYaFmDQFkmB5RHMcDRGewOn2mxlN/Jbu9ZlQCY5S3OOXEyuNfxfo9UrNr/vKF
	tgscDjOK1ee4azsGDPuDzshnDR2a0eppgtms0Ibn7dm80uGwung+Ifo/DmGZ6SwF
	O29tJIjmYy5WBOtFOz4wqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792255408; x=
	1792341808; bh=p7HX2j+M0nkI9r3gCYUt+3uHKxMxnktXa1tg3zgVzEw=; b=J
	6j/aTqITVtCmqCD82cGs6pDM2qAgnmoSBEQdAj8seoxZvPcrF9JJRIokXCktAGeY
	7cj0DQB3q+AvOyNL5skh3iQjAl5Q8QKT4rw9PkNp2sCZb2Rsa3IGwwzM4qFtMLAM
	Groff+ekBnpbsGoM1mb/x0nZRygIM9nCshxCX5RzT74SItf/XyuOGJJE4JphLrTY
	hZBOSdXeJEpdj76mWzTt/zcFPADw9e4MI5PUCFlA9s95YlLseqhV6ygYQMKRtTan
	E5u6SHTFyDEm3dtvQNwZ+wcG26hMYifNKOPHIDaxcRvYG4/0nPscYkyrTzmapjgZ
	IZpCebRrwyyjXRKzaG0JQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792255408; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:qP2sZN921agw989a+KNcymnN/jSgGHHwuIB/9+/CjE1tmef
	H+3Oulc1QXPJ3BRZCcnEXG/5ebr0pHVWha8BDWz7g28t9MYpANRlA/BoR3IdkETi
	MJMeRkUqqF+ehQRn24jKxqa2h0TAvAQ86UReGNjezRn6KStXgY2XKNm1oIA1qAE3
	VV9gVUYcHXRjW9SW12dtHnfsU9RfBIlPmoESZrELjvLrO8jYgEkKiN8c3Smx1SKN
	b3N3SU/jjAaK0JoyQkswcZrqTuEypLH+41KQVDBM09i7Aen4U/HFXL8WZ81OmvJr
	+Hp/pYGjKrSIj0sTAMRzlpeLSH/bj3p5yO50zlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZgMj/tJWdsJWkay2qMb3XhDBL1y0xhjZUOzxT43QHiQ=:p7HX2j+M0nkI9r3gCYUt+3uHKxMxnktXa1tg3zgVzEw=;
X-ME-Sender: <xms:raXTauS1-BIIKUXxyuRtFJZCW2zO4xSfAIyXM08OrVifTu4I_Cu85v0>
    <xme:raXTaukdD8nfzHImI8ZtSLKzGg5Nled4yZD1RzIG1AKWWJoQU8Bc-EC-kPRNiYkHO
    qVV4sH_YYIsnqwBJ90adA542CLdPZnjKAYGTZqRUmiRad3-yVzGleQ>
X-ME-Proxy-Cause: dmFkZTGdayGhQSx/OktXmWL6HjNzyn+uc4dx3QstFblIph9G/ceLpNHModbyBZC8E2wDH5
    dgW9PdI1OX73+DIqRt2PDaRJmJ0nmQJNlLpaRFdIfz9Ie7rObXw1Pv/tCRX0nneqvKRVfG
    Wj8493ZRFrObcdH9Z+LOctvlkLNeoGsKDndDauMX4EdhzHfJki1e26NbaLBGzQE5WvhuYF
    Bq5uKHskST7/CJ5o2pLEWPfiBSQWjKlWkdwxwb7gw4eGU0XAkZhmZhMptZHut5/yVIiY4w
    TeI+FrqvzjMMfZQrGiAdp6nCktGVU6r5YIFdUDQrUv4VqQ5vV8NKksFkI/iLPcwzTBJRBQ
    33PBQ7z6gnX4/Xg2J49uEGJBpI3tNX7GNyoRrFR/lKelrbTHuG8KRX02DaHHTKHm/9w22m
    xqv3JuBd43Jy9Fbh65QU/RDgc0n5GNymn7XZjGzi/1lXrtAhuNSKeWsA3PFvVOYUeNr4+E
    PR0dsAXvrwHzvY+m2ON5xsgLWn8ymbVFncYa7OttOtFGwXYUaVR8HfnsGT6AQKmSvj6bmr
    +nePLrjJqVE44HfNL0RIiFPJd7zmX6z60Hyhxkyo0z9HpyhgnUMaPZ1Nil7/FXpiN/DFKE
    qNCjc0rueC5IZh+1Xz0IJKYR4y8z6m81wlkXH/v0xQnKwiChFVe8X8JVrrAw
X-ME-Proxy: <xmx:rqXTatWQJUz3-wBRuSkAgcs94139gwJA2BnytxgpXfqTtlmWm5gozg>
    <xmx:rqXTavEyG-yoDnOqgT6o72pa5B0OGDluXqvyl_53pFp-VuQpiMS_9A>
    <xmx:rqXTapfzmiDwVIL3b9EjwvmQUi9k1_9bSQ3YcscqlEoL2S5cYLoqyg>
    <xmx:rqXTagK7A578GJiGRwf3IEZKabzBZYxJCIKlpu7HdACtSQblg_EElw>
    <xmx:sKXTao7Ygr0F9yNXNcteBkojMa-QQnBIjQPpe1fBWHAYtzkNiAC1OBod>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3E4DC22C009C; Sat, 17 Oct 2026 12:43:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdFTpIy9UMIo
Date: Sat, 17 Oct 2026 18:43:05 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Bence_Cs=C3=B3k=C3=A1s?= <bence.csokas@arm.com>,
 git@vger.kernel.org, "Jeff King" <peff@peff.net>
Message-Id: <3d9463a2-d099-4f9d-a380-4c5036da1c20@app.fastmail.com>
In-Reply-To: <xmqqh5ilfpfj.fsf@gitster.g>
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
 <CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
 <958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
 <2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
 <fc3de093-a051-415c-b40e-f9df5c914704@arm.com> <xmqq4ielirpr.fsf@gitster.g>
 <CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
 <d7450b0c-89ad-4963-9229-198f40cf72c1@app.fastmail.com>
 <xmqqh5ilfpfj.fsf@gitster.g>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 20:52, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>>> (Besides, the OP's grep also counts uses of
>>> @{upstream}/@{u}/@{push}/reflog syntax/etc.)
>>
>> I set up `git symbolic-ref refs/H HEAD` after my first `@`
>> conversation.[1]
>
> That is funny and clever, but unfortunately it does not help solving
> the problem that the @-shorthand "conveniently" squats there to make
> your use of a branch named "@" hard or impossible.

It replaces my want to use `@` which means that what you wrote
back then:[1]

JCH> I suspect that it is much more productive to deprecate and remove
JCH> "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
JCH> does not act as a synonym for "refs/remotes/origin/HEAD"). [...]

Would not affect me. (Not that I believe that it would happen.)

[1]: https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/#t
