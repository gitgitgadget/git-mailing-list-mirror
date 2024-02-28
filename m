Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E150363
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079235; cv=none; b=RL3r7pdIAiwOZIakM2w3zl4A8r5wqIAK/m6dfZNnm2RXq/Q0LRb3aHxpqJuw5ZjJafEC/e+rIXpH556eSIRJe19410HOyppAeUceQLDU1kN6Xv/fItEmROdbK/7dvQ6kr4EfJ28ulgeXj0JkTRQyvD1YEYnUIo7zPFZZjlyHdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079235; c=relaxed/simple;
	bh=+bgXiXH+pM3VjGddqIqpfcY3V5gdV9deFm7IlW0HWI8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=qcOTfJ7jjFrTeCbZmtJxR6VwCMm4efRM442aMX9w3AiuPtP5WgjbMg8LVmWnVxfGMhrGCoBinAr1EJPszf9McWPbepv8G8MfJQdBZ/clo3YUf11ND/edL/Ne4ZL6whur4tGRPKCiqctrw8/4Uj2/njtgNaDnubyGp5q6J/hs7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=gwSWeUP0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2uYuILG; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="gwSWeUP0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2uYuILG"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 28DD81C00094;
	Tue, 27 Feb 2024 19:13:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 19:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1709079232;
	 x=1709165632; bh=pYcWGu2zVcghnPYfFw8kAvvFXnb23OV+k1FfuPiDwyI=; b=
	gwSWeUP0cwHHcNxSOIYjmiQZxdU5deJWWw2B09yoCOmymh0gdwJqrYtsERubJtMy
	niEXhvTfnXrXaTKb2wMpHwJyH2shibDpQYIeOl4d+oB9BeITyV6fRUq6ttmzMem4
	iCcvRIjuBMioAbuW5NEROC/GpWKkddU4fYAF9J4iwciI+RElPPeNo7fWG0extTZG
	sQSTqS5xuE8/Igftp2Q9UDj2npR7NaTALKx2vozN7p3rddjWnNo2fBbwO+r3tEBQ
	iIYTe60mvyEXzBNHRoGBSTgBZNJCLQwjwq1oDw0NOMEAEMS8tDOOEl1lSyCdH6vO
	6pt+Oa9yisGOfl7IQKZuug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709079232; x=
	1709165632; bh=pYcWGu2zVcghnPYfFw8kAvvFXnb23OV+k1FfuPiDwyI=; b=p
	2uYuILGeyLsoWi4zq1iIjGgTkVpmvuzlKTpqSaE5HE2hSJAiaF7vecuzHWRJJqGN
	f/JYM3hgKa4JTD87dIs0AGAMOsveQEduwqLnVCa63eJnL5Yq1A6ntPPHO/I9+3Qb
	fOdTroOnKzmJpSJ5rIzBMAYPpJMFyPmUcGAzqVBNBeU6c/Wy+l9Mivz3sVbCqh5a
	407xvcsgQQ6Bv2wfYDrYdXwa2fPGjmK1UKaE0LlXu8KH6uKm3XolgPWw7Qosh0yV
	ccheAeL9kWj0saBk3fDIf1oCxWcJrJPLArbSjBbXcYM+JcTuKaRhDcVLdNAKUl3s
	1r1Lkhb1lQOvDYXB8sOcw==
X-ME-Sender: <xms:wHreZUd81hDfunbCZBxerq-MuxVFy8jCRuCqWKh9OQwNzcvStv4dxg>
    <xme:wHreZWPQZEqUv0NHIADg7JTBvHlG1rnTOm6ZYQbg8X-VLphQaOkrVdVhaWlFri6zC
    8wmXLHjTdUU1xDhRw>
X-ME-Received: <xmr:wHreZVgEyiw9DBv9D1r4u2aG6j7zGJvWcovIFJa8eyDR9WHYZBNCyyvMxoC-Qvk_MGrmpnuJPQ-SbQ3ReR1-KmxrqpR2bG3-gf0-bSfL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeeigddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpegggfgtfffkhffvuffofhgjsehtqhertdertdejnecuhfhrohhmpedflfgrmhgv
    shcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheqnecuggftrfgrthhtvg
    hrnhepfeefjefhvdfgtedvtedvheehueeiteegkeeugeekffetfedvtddttddvgefhjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmh
    gvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:wHreZZ9V7idLzQc9BrG94_ls5ljbXAHQpq0vWk9EnZSRc1t08Usw6Q>
    <xmx:wHreZQsTPy7TNl_6E8MNZOhWOhz0xjXnScFFzMfSLCKZba0kIPcOtg>
    <xmx:wHreZQGaAfWoZl45T1XJVVHdNQEI7AmvFA3Vk7y_EiNar3VVnuEbDQ>
    <xmx:wHreZZ5WV3XoQ_Ug0AYQzqG553yYvFewTkiOZ6Tm7FLWOIRMdoVXZ3Jr4tI>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 19:13:51 -0500 (EST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 11:13:49 +1100
Message-Id: <CZGA0UX31LAO.1QWOAGQ6BUKIS@jamesliu.io>
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
Subject: Re: [PATCH 11/12] reftable/record: decode keys in place
X-Mailer: aerc 0.17.0
References: <cover.1707895758.git.ps@pks.im>
 <f0663c1d62d13d01afb1fa6c3760a38741bdfc8e.1707895758.git.ps@pks.im>
In-Reply-To: <f0663c1d62d13d01afb1fa6c3760a38741bdfc8e.1707895758.git.ps@pks.im>

On Wed Feb 14, 2024 at 6:46 PM AEDT, Patrick Steinhardt wrote:
> -	strbuf_reset(key);
> -	strbuf_add(key, last_key.buf, prefix_len);
> -	strbuf_add(key, in.buf, suffix_len);
> +	strbuf_setlen(last_key, prefix_len);
> +	strbuf_add(last_key, in.buf, suffix_len);
>  	string_view_consume(&in, suffix_len);
> =20
>  	return start_len - in.len;

Since we're using `strbuf`, there's no need to worry about extra bytes
for the null terminator here right?

