Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A4502D4A
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776929; cv=none; b=DLEezFnsWbBOl7fvV+Ss5Fr3CSU4mrpicFAevgAarH/AnQoFXB+4+uM06MfrMcyGpqratnaCi7bSFqM7YPuic5VssQVAJ3DVe9oSLB6fd4LKLmBj2w8me689EcROnujbUBrDmcKpseIudz6fVtNmnWGyla1Zx0Pb0IGdf82todg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776929; c=relaxed/simple;
	bh=S/i5UCmEYUF8a/7L9Xso+NQjwNVohOWxZYLQw1maxPQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sw7M4mI/iXqiyUMpT9PSU4UFdx4tLFm0MtAgWp37LXi6iyq8YrKsnQYxVNxnB2oKYed4VbP2DiMAJeUgQCwI5y2E3y9teG65fGnIJBsvwuMXQN9dcYK+0fa+8Qs5ECRGUHxMw2Hh0BUdtlmC8WIqfVtbJZGwglpebp81RcXoGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=XgyeVdtG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lG3VnEcc; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="XgyeVdtG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lG3VnEcc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FB8CEC01D7;
	Wed, 30 Sep 2026 10:01:37 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 10:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790776897;
	 x=1790863297; bh=Y/MJ3pNbnoD7N8WzbmRphhVAHHqWrg64Tm50idsRl2I=; b=
	XgyeVdtGYzv0E/5PiADqJtzyeLYRbMYpOUE5SEA2un0b9NOvUELcdNOdN0LS5pFE
	NNO0gd1MyYmZMHtCC7bExymonzBC4HQMZ97lvGTb0D/iKGKs/GgBJ1JDHow+K9/N
	cxU0CGzZP6NciWzN3PukfHybACW85OzuGZd08/AlUe4OiED6u7l6QOzSs3qhtdb/
	WRMAKi8H/PCLwm/cyRVDbMiZkw7j6jU55enBaa3H9B4VymW0uF02Eie8esQBN15P
	xE9by5ongIWLO8q12QS2X6JNERTsrlxWTgWTglJeTbEuD5OGQJuVW/sd+uXIsWxG
	80GTdL1sW2fN68ZbQz6l/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790776897; x=
	1790863297; bh=Y/MJ3pNbnoD7N8WzbmRphhVAHHqWrg64Tm50idsRl2I=; b=l
	G3VnEccAQ0USwqzliAC7YPmtYdl+/s3wMW9eDuqPtkZJ141JMLXAnFS3tPdivueM
	Ay7yUi6DR1Qwn13h2UvbxioOUHxI1fOGE2iBBG98Tab49tkxzM5X9x5ltEjnB5vF
	cU11ACNr/sP6JjlOyC02LL7Dh4rPGuZrPHCHhq26346pc7xmaDYijFcp7dsOZfUT
	MFxA8iDR5Rgt/wmLaWn9UHUuCpiwIe/Wrc4BsFtpymxO3HLTAXx5pjXqrvr3ezKS
	vwwJ997TVsRZJ6Fw2GDbZO69/AKr9j5W0IzKaLfwwTGFbLf6VALihiVqafM47BQM
	kNltoG31ueahshY2/FH+g==
X-ME-Sender: <xms:QBa9amfYUeYnxMyDKQY44n3mDHUX5DLgSdVIpJigBMqDglbEjy4cRA>
    <xme:QBa9arCByEW2vclRnDt4a-T3ahtpLoVPC09SmdVs4fODgjrPv_PJPZOgedZAvqY50
    ccqsVDFkx-9BdESZDpCtVA4PeIjQtwPbgB7BeX8kPO8SvHWHCokEHey>
X-ME-Proxy-Cause: dmFkZTGyDdxKYJVYdISdIUxnu7VGHa8S7QaWsANs5AUnemOjDeQ6xBKj8q9krBab57fY7R
    vK6zY8IFxSct/LQlmTX3WTeoxTdUXh1FyEVuhK+xjeGjCfdZHsq/nH2uPbiElZcxjgTobX
    Be0nhJfZ/KiPdmsN8LSPZNPRfkQTi1MF/xU/OetmYmIsbyLS8rudUdk3y67PmGtJDCqzYq
    yuvg1Ajlig4o7qtU3eNcuJ5TJCwZdg0D7iCkQRC5Cdq64pt6x7TWkqlMn5GHzpAtLneLrk
    w7asO9xFyq9V+6boNWIwzkcUUX0AYZbH2jKycwezyzSHOjkKvLj1MiAKmg8ax0wyCivUXq
    nZdricsWujd4EVSqyimnNCJEFIYaabUxi/uaLm92Hn8eZMBhqPy3eJ6NoNFTLwfbNhk8OV
    WXizCfIeKPWBQkcasDMySbvgiDPIIkrqJYCaT3WoRlMwqOsjHO9+XN6MBEj2h9711VNcLe
    hqu9ZVEiqSNF7CfIv7BHTTreQEj+p3O60gou5Y+8vBMURvrUvgu/Ij/V5ddh77SYj5RwJm
    087e72K4lE1I1PxuXF0ayRBD3fAFfAd4T4zVCB2sxa6i3OHZvaMKr9fPbY1UZvFxG8sLBZ
    JSm+ZsSktUi8rDtp77JLEq9aYZVXXU4RKAWesA1aBBKFkiFh0Yb2KuERsq6Q
X-ME-Proxy: <xmx:QBa9aiFNtKU_aYCy0_U-RCqJGDW1t8gGrOjLvfNFiA6gV4jDHXnnsw>
    <xmx:QBa9ahKLnBwPt9ljJkzpzMw-1697-AUaRa2rdLFEtcFB0nmQfXmIog>
    <xmx:QBa9ammYclGuCnmujcR3Ae9PKZbX6-82QBucp_aXv2_FWDYD63OXWQ>
    <xmx:QBa9apSIG4CzmIwXNS9xuOEal293OUMt17AZCwlPTNyxV2dm94JGMw>
    <xmx:QRa9aom9nGPNTsVujfAV61huhylB-yAJONZMNkARRbIYU1gy0lIL1DFD>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CEDD5780075; Wed, 30 Sep 2026 10:01:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqO-TNe5d1d7
Date: Wed, 30 Sep 2026 10:01:16 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Tuomas Ahola" <taahol@utu.fi>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <fea59b5f-11e9-4f86-b04e-346a3fe0a757@app.fastmail.com>
In-Reply-To: <20260930060038.mY0JV%taahol@utu.fi>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <20260930060038.mY0JV%taahol@utu.fi>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Hmm, the normal format would be more like this:
>
> 	doc: remove gittutorial-2
>
> Please note that the words in square brackets are dropped by git-am(1).  For
> example, another patch series of yours is currently represented like this:

Thanks, will fix. For some reason I thought the format I used when
I was working on this last year was `[doc]` but I was remembering wrong and
it was `doc: `, like you say.
