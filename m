Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A122606
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101827; cv=none; b=KBJWfZZjaGEJwgIlS4DYbzfMfj2wMgR+y4mez/M30FLJO307kkCCVygQZa8nRtYL3K8Wcat+JSdzCXIZ8DSXe8KbpKlMavqKei5avYMk39NKInq9mYFUbo8iVVSsjvk86noLxhRr/I79pJUJBBv6FgYCAAzxXXlcezsN2GUA+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101827; c=relaxed/simple;
	bh=pWe0sxQ600rcVqmBzNCs4C+SNW+TX8PWB58SfjPpX5o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oSOfNfZIYcKJEmpZcz+3MwzLzz9b87scAdsrXzLFS8ph+zJysvNDyaLq/mOV/4Tv+0REYLChXjpX1uub4snPgvAG6Un2yfoCbFBw01ios3dt9pxbTznBi3jHnjQdZSduJVdDA7/tpqjxJ//josj6k47oc7deUBPUddyG544DhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=RT5KJoQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F0dl+5kX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="RT5KJoQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F0dl+5kX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0768F1380100;
	Fri, 22 Mar 2024 06:03:44 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711101824; x=1711188224; bh=a+dAdIW2Ha7FqCejsy8kMS6mhWXnmFGJ
	xQUwTGShAH8=; b=RT5KJoQyWxEnYMzir+x6igLF4dJEseCcGF442culS7kJMxKs
	vLMWbYMaZT3UHH7XpOdtSX+UPCTfDHc+EmGX9I7Z61e0Uk9GTm2qmd73osFvY6Rj
	E1tXkmLoKmKuv3wzhOBxfkEGlSx8fQFbP9DAuun1M3ZVO1rFqDKOzEN+q1MahPoF
	TlGoc3a/pXKaglrnv7cC/94BM1MBj3XppwsJMXNAKak8t35L/vyMiD4eceOSBgNU
	f1SXz00QV92S+uetM18n3c3vd1FauNNZkAZ+DUDSCRNuNo/MvMSvzgZu/aiyhtK/
	BbtFtVVQWsBNqvizd+zGbLtnDpe/b9rmLhsb1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711101824; x=
	1711188224; bh=a+dAdIW2Ha7FqCejsy8kMS6mhWXnmFGJxQUwTGShAH8=; b=F
	0dl+5kXb4qwWnSDUkuuQF6jpj5bKe/csIWm1+PSceXe7fdOkKNyKyEYaYfncIyaf
	2QgJTVz5wBqwV3737fC90n+lQ8ahHfh+slgZnkYdi/tjPQ5SA+AFWc+M7Sh66T49
	yBEGHuvFe4DYeXr3BA0+mAupKGcIkS09s8ntvS71G/DwGUwr7LqelVO2W/KLop1i
	Z5HgfqSzu8mtn4KmoGkArqFvm3U8+vC2SIzopakdbDO4DkhDqPN6KJG9MWBfmsYN
	fCKEF1zd5Zq9kC7z55xEcvROfBom7W0GL48It+77WjjazsJLqIHYAqi2oUvjliFc
	h+noRpuraBBEVlf8CwcWw==
X-ME-Sender: <xms:f1f9ZR2uMdI_mO12D0Wad5jdu3X42eFOZLbeD-_rMfojnc1B17GHAFM>
    <xme:f1f9ZYFMRxIe5npDJDYfF5E76Y7iMH7SHO9p-06osCMNqFiSvVteAuez_h3fTwgjy
    cJWcxmXIRv2rVVZPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:f1f9ZR7RYzPd_vIaNhGBNiySl_6yUI9D40cM4CRfuLReJt8tXC2tHQ>
    <xmx:f1f9Ze1p7J8U4oeZnuqyonbeL-P8bdqkh-cG6WivVoNwgSMAIEFH9Q>
    <xmx:f1f9ZUHMk-f0IywBWcHlyI4g1Owkaos66qM7LugQhkdmI-DoIPgzQw>
    <xmx:f1f9Zf_5Qo7-WZRyhyD74ADSXHDuvON-6g5SBbRjByQ7RDSovQTIhQ>
    <xmx:gFf9ZYAAa1hF2PTWJMfnXUEa9U85atfvhcaAT-GxqIGYa6Gt8rAqLw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A7CE415A0093; Fri, 22 Mar 2024 06:03:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a4d6e5e-5640-4230-8651-8e0846b383fd@app.fastmail.com>
In-Reply-To: <20240322095951.GA529578@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
 <20240320002555.GB903718@coredump.intra.peff.net>
 <20240322095951.GA529578@coredump.intra.peff.net>
Date: Fri, 22 Mar 2024 11:03:21 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Jeff King" <peff@peff.net>
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/6] format-patch: fix leak of empty header string
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, at 10:59, Jeff King wrote:
> On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:
>
>>   [1/6]: shortlog: stop setting pp.print_email_subject
>>   [2/6]: pretty: split oneline and email subject printing
>>   [3/6]: pretty: drop print_email_subject flag
>>   [4/6]: log: do not set up extra_headers for non-email formats
>>   [5/6]: format-patch: return an allocated string from log_write_emai=
l_headers()
>>   [6/6]: format-patch: simplify after-subject MIME header handling
>
> These patches introduce a small leak into format-patch. I didn't notice
> before because the "leaks" CI jobs were broken due to sanitizer proble=
ms
> in the base image (which now seem fixed?).
>
> Here's a fix that can go on top of jk/pretty-subject-cleanup. That top=
ic
> is not in 'next' yet, so I could also re-roll. The issue was subtle
> enough that a separate commit is not such a bad thing, but I'm happy to
> squash it in if we'd prefer.
>
> -- >8 --
> Subject: [PATCH] format-patch: fix leak of empty header string
> [snip]

Hi Peff, and thanks a lot for making this series.

I=E2=80=99ll have a look at it this evening.

Thanks

--=20
Kristoffer Haugsbakk
