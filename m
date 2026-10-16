Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D2C49BB5A
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175744; cv=none; b=LjlzXnu5J0w277PM//qWw38ze7aVnDWood2jaTkpMIAJFwXWjZJsD6uSN5ubaou8OQSKNewhrhDynh5rHsq5QM4Au3GjqIL5rbJHb1MPVVuAC/hi+HvpaaYPUKgtiHXT7iANXdsLCVFGDJN6iEYVZpEy8hH/avqMo7Njh4P7ODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175744; c=relaxed/simple;
	bh=eP+Bex6WuUPP/Xoary5Hm9U23xK+6yMoplv+YlAKcxo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ld93805h2GLlwg3FcSrjIf/v/rYH1X1T19EI6hv802TuTa7vndg+pJMZ8qe95oNTAcbOdQoncAraIy2cSvs/+vV3C9pDDrVr/wk0CoZJJVRif5fVkt4nAi4rHX/SC7UTcVvyNbnnhZm7q6YcLiDESmkb0HoIpnXVwO4eRxvZxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=eLKOObkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1uUSGal; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="eLKOObkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1uUSGal"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D319140012D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:35:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 14:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792175740;
	 x=1792262140; bh=2H7JuzbJnXEQjMONsJT6tK0SSLkraKNmgkpJEyddBVE=; b=
	eLKOObkpmr3TJZKtDoVfGkevQuOP4J9OmXtUXkfhgRcXtrC2fhaCRaMrVFFl2aXx
	oz5TzBEGUUZxsEsOjQspGLl9MEZq1+kqxD8UEhSKahrljwalvteVxMB59ANfQdZ3
	MgElaRF3rKF+jOp/98tLkaKYYY+LDEwp1S6uGhpn2+9xZXfjZ1GwgtDd8hhWdCez
	HFjKE1JGYEyJRhvJiKEld/KxvgJ3LVPjqm7dIqYFs+lMrBir9Q/MlMbeapkVVbld
	BVOW5wwL7v9AamXPgrbxeyp83vTfT2bHCvjsBBwqUXPGxLjyu7YqCPxlNJWP+z61
	r2RZJfAZwSHVOxzVZJJb/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792175740; x=
	1792262140; bh=2H7JuzbJnXEQjMONsJT6tK0SSLkraKNmgkpJEyddBVE=; b=O
	1uUSGalcJ8TLhoZjTRLDcbQH4+5dIag87toJyIGdk7LXyW1x9S4buWCdNyauGKqo
	WICuOuHvgwuw+j5qUrF1TwkAxDucHuYhPzkFrUMoawoPOPuqIECaU/eznO3ooQH/
	T65kBUCMV5wQIv03kn5vyMQdPKTod+jTyMalZmxAPiPLqRPfM4LvZ8O7eVzvlN7p
	EPVOEj0vcSjYyGHbtzZTCpzFtqdPdfVU2WyW4ndrLul5AKUOMy4agdfYh0ufaj9K
	R/MWHAxyc634khVmzY5hxQDrsTOHRF6Qof984klJUc1aabXNzUu2cs8V7IPujkss
	xHXwEPpsuzvOCa4ZOFNdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792175740; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mLMnIiBfmHKVx1mNhtp9b4047Ozt8QReyDQ7rcB6wI/6qr9
	KLowppzvVrs6zXbAm2z5p9V43C7o9asAj/dDMexLGxyvBg9hnMkUKqVDLoTl5nLd
	0OsF1C6kT21b27H8lJtZBB+TKYoLct9x0RThIe6mBG6NN8CiNKx8+XrKXB4GXVxe
	4zLvNR3ESpqUMXoXG2CMoTMPECzxGE+5d9xyQckHtFZ4fV8mzQI/trRQPz1s4Obh
	xlRkB53l7boNzPq1JgQYVdAjE+95je4O5GKToeAnE5cxLbCHbhzqUnA9NoI4F0CL
	fd0ghFM8Zdi5CuMtyljP/3/CpY9GYdRtf0zfGCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cw49xxm3PzoHjWPLlBFCyipk9PIIAVY0PYoXITSirfQ=:eP+Bex6WuUPP/Xoary5Hm9U23xK+6yMoplv+YlAKcxo=;
X-ME-Sender: <xms:e27SatvU8mORPcOzfbDQ9YYworhB-3QdF0WOt397N6fm82pI5Uz3Zg>
    <xme:e27SahQ3FLk2ZfiLHWpOs05VAOPDA0jflDkttUHP97TCs_vxnzRNjR9hmpgD7u8-X
    Gzx8BdcA58OnnrH5bWz7poFJ3fbd16odS2IGfahX52uuoi-csrhH9Kp>
X-ME-Proxy-Cause: dmFkZTFQGmPZRSTc/qvA5Ey9elQcMpjT4scuDnoxu1FdcUtNqCZ+oXzpIK5QWsAQ2xuq5e
    YFdpAcsw8N1MVHUlFJAbCSF69hSP/unFIRe3rchywyNFSEfiLBGPZBetlMklxkOlwiiZn9
    Omkb9Yo9+Y4TYVhO76R7ttRCJaob/eUfgV/hDB6CqM9/1A5rvTxqbQn1uPvLrRmsNpuB46
    Oq0h9JodGFlIXpAD2dtqxkjdSdnyVXsdFa0rTJpgG87OmpVcXQMU2+XhmirxwvdKBqWRWE
    PafniUTpfAERwIFL3SHhvVMyxpWm1ryzBDJrgRAK4TdvSy/6o1dNCFt7PhuGRog73Yrson
    ymARLvcGBFd7TOdFezZIRk+78JP5tvfIs7jmzaLnYP8tWXeSEXL0DLHeMY6GXLJUhDFnWL
    ec6y7eYsnlJ6UV5Y3uWWeZaGrsbBJfNq9qoqrHlYlrpke2FNeQ/FfOznFcut+GUdp+kO5N
    UF7B6BD+XMiasslARZFKAMPYduhAohp21LgvfV3ClBzUS4gofGFIuEtG3kctrAk0acKd+G
    kBmNNOziwS00Sae+AIn1Bf9iJPuJ7JLRT//ovwrRy+ow6d9tMKZHnkZbCjDq6ulu4MEbi4
    JQM1aVoG7LUUaQLaPzCQIEs1yeQ+MVwpLr0k7SdyON3/fpOVRw5er+qCApdA
X-ME-Proxy: <xmx:e27SalXUWwgJDXKhqAdaTgPD3Q0zH6nrGamZJJIDvns-6rpRR_eFwA>
    <xmx:e27SajbUWV1iVVJ9pI4tnc8i3dAk-PCEufkGUhzHhepTgENVI-geRQ>
    <xmx:e27Sar0U8ZYofbCOqm3WpMoffhHoSyqQyBkZ_5Gb1xaTYoJU6QTf1A>
    <xmx:e27SaljwGTAj-RW9g-d8jcfZopnwE5JjqfCTlZSI5vRNiJRRVVXA4g>
    <xmx:fG7SanpNFyOpfMnWLQqsTNHb_iIfFWoxhPInm5_ElZHhpaNrPxGsH074>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4C0F782738; Fri, 16 Oct 2026 14:35:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Fri, 16 Oct 2026 14:35:19 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <7e888746-4220-494d-b8ab-00bdd5da5876@app.fastmail.com>
In-Reply-To: <xmqqzewdfuhm.fsf@gitster.g>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
 <xmqqecdqk2qr.fsf@gitster.g>
 <01232f89-6f57-48d2-b6de-d51c91b6fdb3@app.fastmail.com>
 <xmqqzewdfuhm.fsf@gitster.g>
Subject: Re: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 16, 2026, at 1:03 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> This is a case where if we really want to make sure it's clear, we need
>> to go get feedback from users. There's likely a better way to explain it
>> but I don't think that this conversation will result in an improvement.
>> Really doing a good job of explaining HEAD is a pretty big project.
>>
>> It's not clear to me if you think the current wording is unusable
>> or if you just think it could be better.
>
> Then let me make it clear.
>
> I do not know if your version is unusable or good enough, but if you
> are going to take one version to guinea-pig readers to test and
> polish starting from that version, I think what I gave you would
> give us a better starting point.

I'm not planning to test this version on readers right now, no.

Here's what I wrote in the first email in this thread:

    Often when rewriting these explanations I go through a process where I
    ask users' feedback on the old explanation. Here I didn't do that
    basically because that process takes a long time and I'm working on a
    bunch of other time consuming docs projects so I did a quick rewrite
    based on my previous experience explaining detached HEAD state to folks.

    I thought this could be a nice quick docs win on a topic which many
    users find quite confusing. If the changes here are too controversial I
    can drop it for now.
    
