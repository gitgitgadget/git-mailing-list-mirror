Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9942E736A
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452951; cv=none; b=pPssEjB9KqrCR1A4zKGnmrA3WXEOqTxKZs8ooDnrylunBLa8BmZvZLxT23EwUeBrCYoyJxGnRUqSrBvpXSyywXMqxC5mMWKffptH0kXjrnWwLngcRJJXxaOmsD3OJd0ybGsp5pazBvQbfX7Ii/aetdfnRsXwsbh4sWNwalMNAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452951; c=relaxed/simple;
	bh=1I/eb4xVUdHpnLXTFVT6Tv3mn2ucrtgiASb6QRHi+DU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBr35/NXIOcSaurbn8DA7gslaqhcWirz7I0bYDgX6p0AEiEq1kpeaWzeQDyE7sPjH5dpFx+6g05VCHvI3XWSAGz++dgTsuVpUV8K2TZASmI99nRKim4CUablpySaDdew3OvI8oSOiH8wANstz1Vtb1kE+R5S+4Fmaoje6jHl22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jWJf1WN0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5hVIxy6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jWJf1WN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5hVIxy6"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id AF12AEC0116;
	Tue,  7 Jul 2026 15:35:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jul 2026 15:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783452949;
	 x=1783539349; bh=b6mdrdtPSbYsZ4+KLNFlWo3HW9V3tLqXFUqzCcXG2Cg=; b=
	jWJf1WN0oKYwvtuMIj4rBNDMsedPOoa23afkINZ+7CLbQUU1fSZQ7yVN9HS4N+Kz
	LEObzF0X8UHYnLWJuJLcwJeN4DEuGvBh2vspl12lyq75H9VpCH6r5ktazXHfGmXp
	dmxL7OFT+f8HKhlMZMi3iBBYxqDtTNk0khfAm8EEszu0m4RrnyKsxVcigDZME0ge
	Mz7inwco2NqYt5W4B/aG3CXVgBkSwgAdHuj7/i2K1FN68lvixmHPwhVhqtMl2MhX
	p97t30dYHfCt1twLDw+7h7Wv1v1DbhXJWBArHS2MS8Yl+Ku9xyaDjSSU0JcW4XzF
	m0eEV3+LeTyd8dUmnCEVLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783452949; x=
	1783539349; bh=b6mdrdtPSbYsZ4+KLNFlWo3HW9V3tLqXFUqzCcXG2Cg=; b=G
	5hVIxy6YR0uy4u4t4Vm8Ixh365GLB8EW0z0EcQYab4YUMlNr3+U8vBXitSXfsH5n
	lEycsQhNItFuSCIh7Gz7KVhEry6z/GCcckiRm35+KDuppGFGL+AGzGVhJzMqZTBz
	0oR6OJ2xWvVeyoMwGyUCuAVTpUoOSsipmBBP5WrMEym0gu3/FSUbyBTcM8VkOzR9
	0cYQOTTF/SJnm8VzULyCthz7YNqJ701a4Apxe8vKuHk6eeivINCys6HvMyBdtFaU
	NGDNaZV4Mn/5pxviXEh1TOR7M3pRbHcKYmrtpGbVc0UlqLbJfJnGTdBLleRuqGbc
	2jNDKSXYb+rgK4hDxDgEg==
X-ME-Sender: <xms:FVVNaqAI43lUM_VGdKQa0XmywStNfLFbD9PfVyQhpYUlhJRqmOyNdw>
    <xme:FVVNarZSF66w6UT2fPt8b8CnALLhTakuFp2bGBLOA2OWPfeI-Sg9KWIoY2HqZVaJ3
    DsY99ygQCsPbdyVNqSGlhk0yhn-sbzXfe-Q7lK-nOxFxrfNrtXEdQ>
X-ME-Received: <xmr:FVVNal5OGMvkjOV4YsZW4w2N5wTF0vUiNRHnxj3aSC8fWFQHYJc2QFtLtR_w4Q71rs1_quMwhkWMfEY_vEnFguG7heWnu3EDldFmPLw>
X-ME-Proxy-Cause: dmFkZTEFBl8SfVO3XA87Hb93FgRh/OyngoCvXVYA2c3bNgLXHXy/Zft3UTmZR1Aa55symG
    kGPS9gIAwY+JjEOz7eLFU5/30/icYUKavVd2xZf/OOmh/Gpa3wYS3A6wUYWM9jvjv8tJMb
    H4OIXF1A7UrWyavSNrrGORKAfgvlBEh/lsu+T9PoVuvwwkXVIdyJ/ymOhoKTQgvcsIBa1I
    gCjcXqaDNhxbLyzacDIXItUWAwcFpZnorl05gdjxw/eJknEeBsEqYQDIpLJcdA4IZlUDCi
    8cMxil2cqYeJEjdnLANs2gxCeqS7NMYXDIBx9dREACiBbb8gX0atssUsPd08eZqSssvCho
    OhGQ0mh2QkHQFYS78GCvvceLQ/LnSsEcCMgczyM7mN5rHm/WWPG0mpsUAGQa3zpBI0D6Ks
    /CXC1N7cQJ6uDvrr6AQG0snTv4sFHKYb0b6UC2jwuFX4RoDTggjTyfWv4s2+MGhh5O2Otv
    4KbTfCRot0sxSXCETmfrsHmH5r9hGxCxjXvxl7OziFInmWFJ/+KvczW39UDliTWr7duW8d
    68yj5DHvFPJyrVurZUjR4o2Q1HJHxUJBmJrthdOn+6Dgwqt9MMB/juXUoLrGLDHKo5170p
    t024qMT2KztQy+e9SBRThzZG1fTHoNM/ivkhOigi3apMSEyQLHs78zb20KDg
X-ME-Proxy: <xmx:FVVNakb8CpgXqJ8dLeRsLywsjIL57Z2llVv9xpioyb7gk5uNdB_yIg>
    <xmx:FVVNasgK8hT8rQjrdtr8yIslvP4pRjWLw6zEjKPwYBkHRkk8AjOk7w>
    <xmx:FVVNat-gGsXLZgXA5all58t85VrwD6Pw1EQab4r01pOMTG-XCS-e4Q>
    <xmx:FVVNavogrN73YFEN5EK37h87NMa34HWe5Rb6e867c07mcUNGXmridw>
    <xmx:FVVNarBB5txXkThXGyVsEWRvfOORV3-TDeAFd3b_wT7rumKMIYCrdIgz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:35:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <87ldbm3kh6.fsf@emacs.iotcl.com> (Toon Claes's message of "Tue,
	07 Jul 2026 17:09:09 +0200")
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
	<20260702-toon-git-replay-drop-merges-v6-3-78a07cdd0382@iotcl.com>
	<xmqqbjcnhjvk.fsf@gitster.g> <87ldbm3kh6.fsf@emacs.iotcl.com>
Date: Tue, 07 Jul 2026 12:35:47 -0700
Message-ID: <xmqqy0fm1tkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Definitely it is OK to leave it outside the scope, but I am not sure
>> if reverting a group of commits that happens to be "closed" and
>> happens to contain merges, is inherently incompatible with
>> flattening.  If you have
>>
>>     ----O--A
>>          \  \
>>           B--M--C
>>
>> and you want to revert what happened while the history advanced from
>> O to M, I would naïvely expect that I can arrive at
>>
>>     ----O--A
>>          \  \
>>           B--M--C-B'-A'
>>
>> by linearly applying the inverse of A and B (in either order).
>
> You're absolutely right. Personally I'm not sure why the limitation was
> introduced. I've done some testing and I cannot see why we wouldn't
> allow --revert and --linearize to be combined. So I'll be submitting v7
> without this restriction.

Of course, postponing this is a safe option (at least for our
initial effort) *if* we cannot reliably detect the good case.

For example, it is unclear what happens if the linearized range in
the diagram above contains M and A, but not B or O. We might want to
distinguish that scenario from the depicted case, where all of A, B,
and O, as well as M, are in the range, but the current code may not
be able to do so reliably. However, if we can consistently provide
behavior that is logical and easy to explain, it would be ideal to
lift this artificial restriction.

Thanks.
