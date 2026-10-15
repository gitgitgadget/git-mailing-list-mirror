Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7B3F9A1E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091598; cv=none; b=Aiy1qQG9GYSxrvNYIoXAap6+/Bqq4KKiGJ3iZittsaCR93GOTCZs0sYddLlY1NwbWejyTPS/AIcHiPTVBLxKaFZ5zLSZrridIFCjAw33L8hoe8hWSD3goDkgNexbf8nQPGIMMO+sBYAP0+71Bc8cbgRYiZ44InBIwIsVOK/XvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091598; c=relaxed/simple;
	bh=ugy335izvFmzBD4akHNNEDuaL2Czt8kkPzM26UdwHbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLv/lWt+A2wVbXWK4+i/IEtCDxQNxA//vNCzWWfVrVUa3GSs7fYRLStRb7sYezppFqAVGuKWvu18OFh26CmRpjGG7UvNccDI7uhw9PdGeS7Y8QrXan/Zi+S+nCH4zWBHoklAvKw/7Du44a6VH37auSI0aRqtn2E31WTnmAq+WIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBAvBHWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQTH+zMR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBAvBHWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQTH+zMR"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 428067A0121
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:13:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 15 Oct 2026 15:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792091595; x=1792177995; bh=s/Book7A+W
	/nakofFrYWgbw1IhinjuxWKgoMzYoNkN0=; b=nBAvBHWr9G/dffuwNEL8BMTzMh
	b/D3dSOupWBj7wY/7Lck00HCCGeeE/oZPtOaA3Sib8jCfWF80RdQdJfM3LBWvH1M
	+I2vp7nZh17RKLDuqIe7GpTBGpBTZj7qbApQW9p0Hj4HsVYVXgW3mGSMJ/KcP1dP
	rDjUL0aaFG1t9CXlJ0LUz9SVOptL+JQ3cw/658uNt3hc+ed7MFyU8GTww/1MhIY4
	F/bviXIfy0bWF9uZnwpUEDZc9Y/c43K1X6U4hs/Jg+6KmukpHtmz+PKemk8ZjmbR
	eTB4EpLXODhIUR17pEmXR4AoVnOYbwQT7D+AHSvsBjFu7qeFJ7BxLlXXU6Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792091595; x=1792177995; bh=s/Book7A+W/nakofFrYWgbw1IhinjuxWKgo
	MzYoNkN0=; b=mQTH+zMRbR0i3jnzP4im5g8uJG/HZPb2NkvA9x2ho2e5+U6H4UQ
	bm3fY4/Y71Ha9BbjxDGBl6GwY6IBphAifHd1yGP97xgr6YWwmpC9IViMweOSr6FO
	iTODEysg1vskzKGhytKhfCA7t8yIYlMkZwiq+uIwQzu8ZO6TqOKqo16mFz3iVTwM
	ohr6uZS5xttUoWj0fm9xA8rruxarLBprySuS4zUR/za3lZCZ+mbHSyjZthI5/3rB
	HQVFjESVs4USuJ3yq0hUgXnCIQjMsH2ivu4mHE1BCzD32MWrFdJNT+LHGww6DgMM
	pcsULXFDEjhTFcqeWyTZ6KzcEaJ71j68yUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792091595; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YHB4cnO5qeh7wCVro1EbG9/SJE8Agp981HTSbd0R7bNiExP
	wcJdrKBAGMSB4Oo3K8d7hw6R5LoF1h9QTRSuzRwo+MYvkK0+NYT9e5qsM08IQRNN
	b8MeXCh6j2htAWe4ssrlddtUF0lwUE+niOlgu8UyL0q6gXl5PmRamFt4FaqzdsMt
	Zl07xXsozXzSqP/XiVAzfS3tBjfrdcDpuRtyx1tVYNofhv09spjU1B9aR+62HsGD
	bSWP1PhePiMewg4R1SHL1MUfdKn6JHP/0t2blH0up2e6TnsMcNksZKkAQDMoj5aJ
	PK/L6SfHNieBcv2iAZNYXx9JXO04NBG+zu5BZPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NCMwv2uLMAQRcHj1d53/2Y4sfKh3y0uaD9ZIXK1x0YA=:ugy335izvFmzBD4akHNNEDuaL2Czt8kkPzM26UdwHbY=;
X-ME-Sender: <xms:yyXRan30SLNh1XDP6EaKzQMHPMk7hkphHMDVod2_DMHXqvqJKsxUcA>
    <xme:yyXRaoVrwqmE_SAwv4ThsKzMNJpG2ytFn2bBjP3t4SibhrpUJwOssDezb7C0sw46n
    9-I0dZJSUljh0qMyLWmVhzvBKAySUi-stwj6CZlnJx351EeUSjYRA>
X-ME-Received: <xmr:yyXRaqIhQVQmuP1Jfhc9l1-JCjy1EMvBH_bK-j16ysCYKsOc5xpzwQuMx35kef_cgalBxZilPXj8dQHC134vkNtlhz9jHi9-Udnu>
X-ME-Proxy-Cause: dmFkZTGmnbajsMS7PGK6KfQyoESBKwP7LPmIaCPpgYa1H6Td7udS/3flB4mhM4G6RTIJDv
    jC+7+nJbiOpkj+B7dAGC1wcKqL4OX/gTc/AnBywBR0RtatzfenbgmYpvMkHBtFLSDeYn7m
    fZv6+8jVF2pF1U3bn39TA0FUShQJVXgfFSW4IdRoGBWzBFMewYznFwByLMssaTMGzzckp0
    HtBKiFwcWT4OEHNww4n2v4fzswNz+2I+qN70evXysdF6v5leFa0gB8rlQlHTT4M1wdKeP/
    BzG5hl96Nn/geD5uSA7D1BSExZlBiSPcZKHSJnlXfNHr5QYE/RIraF/3Sf69rJuTK+WsjK
    4GXATPoPfDn1QMHEeN628OyP5dvUqe2fnxvb9/3cBV9kOMqs9PBfD3IkTVcLMCH6QCf+h8
    w1AlS9eTqBNk3uC89n0tZOh5kniQzmq2DEHfC5OSGNrRLYV3p4xd2+YxGWoets0WuyJOIp
    9KHVqXDiJaCpa8/qoBZh39H1bmC276FIjJUHnyUKlCEAcNv/1bFPTFq/l5jPQTimnw234t
    cxtf1CFABBKLkj6QVNrz/V+BuVU5E1w4T2eaIp0/5jvsxTN+wKoy26CyKrZaLTCQPSPCDB
    Vf1ncUnfYL82/nVGd6DOBz+59nEZQ1YcMA1rQ/QdAbxlyVFMH56sxf4WzhuQ
X-ME-Proxy: <xmx:yyXRai1M-m_bQqoVXzgReM2D6LTUbP6JRl36DQRnEyO5yiunMWPeJw>
    <xmx:yyXRao6xMxUi348THui2RftS3TvkC14nU0jvJ5P7fJ1Ck7GL0PMiOg>
    <xmx:yyXRaj-NvZ0RbsR22n9xl2bqHb5U9hUQ8c6WvI5Nujvv5isnxoDX6w>
    <xmx:yyXRanUZisICJyQJGi4y187FIG9zt6VjEe02ASGFLrU6NbsNk197zA>
    <xmx:yyXRakKm5kbcYJb6Lm3FGH7Y4XKrdyoJoTgITo43GBp0Zj_2FCatnscl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 15:13:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: gitgitgadget@gmail.com,  git@vger.kernel.org,  karthik.188@gmail.com,
  mail2venkat21@gmail.com,  ps@pks.im
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
In-Reply-To: <20261015133624.82112-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 15 Oct 2026 15:36:23 +0200")
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
	<20261015133624.82112-1-haraldnordgren@gmail.com>
Date: Thu, 15 Oct 2026 12:13:13 -0700
Message-ID: <xmqqse26n5fa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> The general idea looks sound.
>
>> +			if test "$storage" = mixed
>> +			then
>> +				git pack-refs --all || return 1
>> +			fi &&
>
> I don't see any reason why a test would need an if block, we know what data we
> expect, no?

This is three tests implemented as a single test with a for-loop
around it.  The variable instructs the single test_expect_success
to behave slightly differently depending on its setting.

+for storage in loose packed mixed
+do
+	test_expect_success "start after respects directory boundaries ($storage)" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit --no-tag base &&
+			git update-ref refs/tags/packed HEAD &&
+			if test "$storage" = mixed
+			then
+				git pack-refs --all || return 1
+			fi &&
+			git update-ref --stdin <<-\EOF &&
+			create refs/tags/a-leaf HEAD
+			...
+			EOF
+			if test "$storage" = packed
+			then
+				git pack-refs --all || return 1
+			fi &&
+			... real test in the repository begins ...
+		)
+	'
+done

It creates a tag "packed", and packs when storage is "mixed".  Then
we create many other refs, and packs the whole refs when storage is
"packed".  So during these three runs of the for-loop, the preparation
part quoted above behaves this way:

    storage=loose	no 'git pack-refs' run and every ref is loose
    storage=packed	the later 'git pack-refs' packs everything
    storage=mixed	'packed' tag is packed, everything else is loose

and the test checks what happens in this repository with refs packed
in three different ways.
