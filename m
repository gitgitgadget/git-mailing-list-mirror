Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB75448399
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248593; cv=none; b=aUX9dRqkbeZcWoLxkljYaC0kFZ6MUMtl4ez8yaZ1FofFDq3RDf19ElK+P/rcZ5WYDf7E4nH3nIo95TIZJ/RfxPXAT38Y5kb2IKp1FywMmk5tufoW7K6SLmR6wEoaendi6i8+KEfEz9yzMx0085cptlRMxAfDPpsAht7DECK8qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248593; c=relaxed/simple;
	bh=WPHSTFVhDf5R/14m/xr5+6HBA3VUTNal3nIXuGEDgUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTO/w3Pjz7DhaXmu79YSgwSU7a5HA9Sq+3PXslE2cIb7p7ik1Ll+PbY9BEcF0/yyEq7zdrQgUnY8gIcxl6jKBXO+zZfTQJg6B9mywWgxYrd2PRcssah9FQ/ilbdw6qyQL0VbEg8T9Tr0jb4wdVR3qkuBA618BIqp208Tz83eJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WSohqaCU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pMwXiXsg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WSohqaCU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pMwXiXsg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEBEE14000CC;
	Tue, 28 Jul 2026 10:23:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 28 Jul 2026 10:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785248590; x=1785334990; bh=zwcaUA3LaN
	TV9iwhIS2JX4ymCTth92YqADbhDaB6vFk=; b=WSohqaCUnOYhlS+b9OC36vAi76
	AiSvht1/1hf95tKf3sgdeDJLpilHX3bliU+bvlFZ+iI6VSxEwOzSBWiS2U/ahH+V
	w771t6YRGbOZi3WCPvgVONRotCWX2p3rttAD3IEMvyEdn3EcYuSgg4uEFKRGs5JU
	4HZsUCzd4ZzrAWYaaVVnAE39SHhNR+IGEPUTbKbvLNaYkSwnhnvQXo1aha7HiarW
	vqpqt+5dY6dH9ikLK2UJWQNbCCtQzNr10s3NfUTOkPR3dUgradu3Ro5biSUxcj/G
	32tHZfzYj9f2Ak8GkPZKX/ajfL1ZpcSrCr4YpDJuZK0YtbGyUfEysPj7qJPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785248590; x=1785334990; bh=zwcaUA3LaNTV9iwhIS2JX4ymCTth92YqADb
	hDaB6vFk=; b=pMwXiXsgj1JgbdRvVhEIs1cRX/Wbv7Vd7VbOJRDDu4SHA2ZR6pV
	bOJ4IIRPxKJuWOJMt1GEem6ta8EwL9uCgXvVoA5SWNydfxVzmXN4jyHZHb8Mzq9E
	VaHaOxVnqNVcCLjjewq4eJCdsWQGYsx8E9RbEj8K/c23B7alC4Coq6NzwKDmb1wo
	EV96RJnHxaUDUy/85sc4Gw+uhc7MBPyNeUR3wW7vNIPp48qpQYuXCL2KjUHvuwBb
	uBiCkiQj57AyMYBPrM5iN2dfm0LR4Z5wpkgS2ia/cfgItUr7ZT49l7zwy+FnXmlj
	27BAd4IF7cKkXxs5M294miI4gh0QZhvYTSA==
X-ME-Sender: <xms:TrtoakEoLPrFqKaqxa4T9fPwQYMsEuLYndydkVK3jrgIEljEK7lx1A>
    <xme:TrtoahDLVKJFftQsw8jY_tGCkbe13rtiFjwiK8Y2jky7p18-BC52uUZsmGY4hzL2Z
    1SyIFwD6F98d0eagOakVMc8_ekIWtPvTqHOUDzQdGfs48oZ200WFw>
X-ME-Received: <xmr:Trtoan8wDqjVGOxM9bnP_MizBT-ILVgJg9O5DytJhHFRYbTBVJKGlpA4GbQurwin5YIxzWSKBvt_GZ3RZaNSFOUh9-LmmkRrig>
X-ME-Proxy-Cause: dmFkZTGyZR20qAQTlgnPBd8/e+X5h1C5QhMIo+0mu6cJFlQlj8b2ry6+uSDTOnW+Ua+r96
    O1Bm5h2wKvlSqKRXtgELzTjEClroc3PU4ezGGKX9FoQmHQge1IYTJWOGYhgRi7HtQtR9mZ
    uppq3oOwm1oUyH//WMezpP7f1pzNrB+lbQ681qyVWZa4F+Ucvc+qD0gIIoZoQVDMeCsfdj
    Kl4tlmFslq9Z7rQkoB0IREs0LnpR2cOIZfObiaYBoF6d8G8f0jS1Gq5o+G11OFckkb99MT
    EjtDxaM2WjV5xhjnXQpbaS8e+euecctV+Ns5nZKJBIZAMtP2esZ/9okC5lPDnYmRz9SHmZ
    30gKjRVsABdZeh3eU/GjmwR8nVKc59Zxu4//5n61ZoyqDPElOCUpn6Jf9XdSueUE+CbN9g
    oFreD9tWenNcKQSvLdX0BsfToRatxjDt8uy6P8hmI6d4mF8raDvxuXRaoLd9YlKOTRWTG0
    IWBbFskcWx4tPP83zUM9XhmNk6UHefxpov4dkYdIokA7NdmgaDkaG0tsKB6YfaoxEjeEzM
    WPvwvXDEpgyW3YRft1GoSh+UsgERtCJjkUwaFXNvHM6/1N19wnqBnOP6fkxAtnOXI0ikid
    1mgdfGxeuehpGx6513xxt7Pz/tYqhRtl3SSrmSVSMm5Opk26zzn2R+RBDyCw
X-ME-Proxy: <xmx:TrtoatAvnggil5BhxF4ZkzPYlhZ0x5ah2J-2maQia5O2DY0mFrinDw>
    <xmx:TrtoasQKhaR0-UdMwTJ_3fs-B0ZmOBRniBQrYz1kVS91QurXBZWopA>
    <xmx:TrtoakvMMQhzQ2cxBcdA72qiOSMskCGXoHmaDfdiT3NYlCmEQiCbog>
    <xmx:Trtoao3U66fOtt5ucNaZ4CB8beRW1ramBNwMrYlJC959qTioSdckUA>
    <xmx:TrtoaupLuoCszhmriqLl5WshR4wtSGwj1eBhnp5u0S5SQ3dtIuInd9nH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 10:23:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
In-Reply-To: <8631114b-aa6f-446e-9710-92c400320eac@gmail.com> (Phillip Wood's
	message of "Tue, 28 Jul 2026 10:36:33 +0100")
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
	<b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
	<5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
	<00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
	<xmqq7bmhycxq.fsf@gitster.g>
	<8631114b-aa6f-446e-9710-92c400320eac@gmail.com>
Date: Tue, 28 Jul 2026 07:23:09 -0700
Message-ID: <xmqqpl07fb1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> But stepping back a bit, is having a HEAD that is a symref and
>> points outside "refs/heads/" an invalid state?  Why are we catering
>> to such a configuration to begin with?
>
> We allow HEAD to point to anything below "refs/" - see e9cc02f0e4 
> (symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13).

But that was about a low level mechanism that must be more lenient
to be usable as repair tools to recover from such a broken state,
no?  I thought the end-user facing commands like "git checkout" have
been tightened long ago to stop users from getting into a situation
that needs repairing in the first place.  And that was why I asked.

