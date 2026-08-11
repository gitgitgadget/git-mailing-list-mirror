Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2514713B5B3
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465861; cv=none; b=KWeFst/nsKqBBd0Z0oX0mea7LlunbUHMRhxZCLrHy0wBlzU5ydphunhbxxSlQ7NETNjOaQyc6Hh2YXHpVkFxXT/xTpl3o1frxNd6MyQCS3wfgnwlVmf5+2V6rb4A4DbGkU8gbl8RCLmcLUOSlrHG9kAZ4pAY7p8A/qy7lFtIAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465861; c=relaxed/simple;
	bh=RdkDsvYyq81cwPhAc32FwOxVRetqVDpT9kkZ3QNqK9Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uaEYP7rFk7XxABAc33vTx1mSPmLAqxiD+DbU3HuZC8pFs8ksJptFLdeDWvnjG8WFkuEGqVZ6KBiBuyevqv9UsClGbUSCoYd7z/UkVgj8Ce132b47FlIqLFK0fhN0FZHnehun9kAPdtYxAe3X+GL6Cg2WmkfXAy3QB7hkvCPXbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HByraLkz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G2UhVweX; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HByraLkz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2UhVweX"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B76E1D0013C;
	Tue, 11 Aug 2026 12:30:59 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 11 Aug 2026 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786465858;
	 x=1786552258; bh=CSvvUk65HU/qQICC0FYNPQC6SFcBTFTXZpNbnRF6oqA=; b=
	HByraLkzNi/regN8Ri/+YDzgBAvMtomdb0pG5C4SPZcjBtndR6wWwb2R37VcxnbO
	otdT4VKy8b9bU8U7R1J1OfkWLG/YXZM/qB9U/ouPB8B6tUeaCxchnoDt+tPKxNXQ
	4+hGp5Sbe+Cdyc3Oq++xIoijg2piYwmsSiOVpY13WgCyEZ3r8MA5diFVkFv3UzFX
	lmzYh2Qnb3OqPfoqlt8ScYmUbAJHPuhAwEF9d4b++YDbsTvckgjIYg/REfn5WCX3
	GhUVQHEoGnlv0vgaBCnGpBy2H7ZnGFaWEFTxenHSThSh8WXuCpNO9DzPBOX6DIcA
	9bcTUyvTlPZ+aUBru55qQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786465858; x=
	1786552258; bh=CSvvUk65HU/qQICC0FYNPQC6SFcBTFTXZpNbnRF6oqA=; b=G
	2UhVweXsZgEGk2IcsuPZZEyKQ8JDJYTIAh62I/mzs9LXoxcdmdx2YZp2nNa/r01C
	eAWUPb7cOvWOUQuUs7YxvBlXqSzOnUaBBtHzU9ydhNGX6DrccfpFFsAwxWApItqE
	QFPPYazdPCwcOxkdU7sFhC/sHk1hTzlCDahz04FMugNdfHoEHPB+Sez5SSpu+nSm
	eFTHWG/4+afclHaNXMPjBJbIfwAlx6nh4OLtKmGww6tV3aRiQINJg07vcAnNK7G9
	Ptgy5FRNJli2VN8OJqDX7qoBa3znBnTUyPLK5c2WqzztJTjuCPLxudV8POdCg62u
	mOsmVKKdsQLsun0Qj3eZQ==
X-ME-Sender: <xms:P057aqYsxva5M8NLWHaH3YTbcnFUcrsleLpdB2ysiHjx306NuO7UO6Q>
    <xme:P057aoP6FBeYDNOTmA5wrEuCz71qYyHYm9AtODwz-o4W-kupWputZEe9596YAwVbu
    -wMebydAMfqyF42t_9282Br99G_ekcmDef79NHCEq6lKx0Qczlf>
X-ME-Proxy-Cause: dmFkZTEx0ykU6OyRGQ9n83ju25nNhbwyMXNd0d0w3fOOMcBUdGuaaFrsuB/vwbcK4TioAB
    CXns29iJ8CMBvjviV65K70w8U0AsDYmKxcf2L79UackcuPpirXW0cyMZAFrIf/Qi9vMuyf
    XJzjHbypR437RfFWAWiVGMmtqKHgfPW2uF4xr/JSlWCqE5NSxfzu+AfNdK3xnkZpwb49TI
    lwJteBk1wo+rU5YxQq6tIXhj2o9rgrGr40Bwv3ym9w6WgpHZjXxSUecN6OfszbFASGu96Z
    FFnyUIr/D5gid+K+XGCB401iruNvbuuuqF+b50vu0coqN7HSwjF9bIVko+QeYfHbv+x5Zu
    6TAtLrrJ6UP64ZBN0r0eT4kFKQEFCutyQgeZMVMqTVVdpfChELjeqtLRuXjsA0JOQL5nAx
    3QA7CRuNUl2xM429YN4KmT6YINbIcM1vDJ82ry5ZE7bDM+mWWKi9tCtWc64QqO0nepM5yh
    oPIsXxnYOUiD44im0ergzcRlod3RlIyGU9P6zRFHpS20Nf3oN5CxaE+pLtyKGVqMBS2bUK
    +eqBUd8So0wreT+9/RMWthWlHojaEzIhVh/aWqNaoHPgt6e+HMEBKctS3RYyHlTzXGLf5Z
    H5UN5kZqBalmcAxwgDtM0Erxiinw7Bl0ZGT7rlnKB60APyrQtm5cbdnZUerg
X-ME-Proxy: <xmx:QE57alEJLauv5zuU4viydjh0Y_nujS5W_Gb6CkCec7V2ObUbP84f5Q>
    <xmx:QE57aoQGElUES7SbEGQ5RCyku3ocCBEKDi5tg027ZUam5gVcCDsXSQ>
    <xmx:QE57auvb_c10z1-8_jn_MQ-3W-OGPPniPFaeqjQJix_6g-9bpapXyg>
    <xmx:QE57anyw5-wFrqfipeTkaSraehZeYnX-0B39XvScryKVMmJk_zofwA>
    <xmx:Qk57au9qPp6HawS8rJhEVp7BNvCnMDsZhpj3-XxZ1S1c0FeXidCcsIaQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C3ABB22C006F; Tue, 11 Aug 2026 12:30:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzsVqDuXP2Wg
Date: Tue, 11 Aug 2026 18:30:35 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <d81d6e3a-8489-4aba-ac1b-d678daac5ee3@app.fastmail.com>
In-Reply-To: <antNhDECvV5Kynsy@pks.im>
References: <synopsis_block.af9@msgid.xyz> <synopsis_block.b37@msgid.xyz>
 <ansWZxZ6lB0tYIJD@pks.im>
 <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>
 <antNhDECvV5Kynsy@pks.im>
Subject: Re: [PATCH resend] doc: format-rev: use [synopsis] on code block
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 11, 2026, at 18:27, Patrick Steinhardt wrote:
> On Tue, Aug 11, 2026 at 06:23:18PM +0200, Kristoffer Haugsbakk wrote:
>> On Tue, Aug 11, 2026, at 14:32, Patrick Steinhardt wrote:
>>>[snip]
>> <subject> is highlighted in running text when using (_) or (`).
>
> Ah, so we have different kinds of synopsis depending on what it applies
> to?

Yeah, that must be it. To be honest I had neglected to consider that the
command description part uses the same syntax already... x)

>>[snip]
>>
>>      i.e. the format `"%s"` would transform some commit object name to
>>      `"<subject>"` without any termination. Like this: ...
>
> Makes sense, thanks!

Thank you.
