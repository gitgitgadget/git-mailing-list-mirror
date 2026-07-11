Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26131DED5B
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783804216; cv=none; b=PWI+62ydNYdI+KwIBZ1fcNc14Zziu+le51Z8b/NSUzMyzs+cwVye25WTnDkbfXxjzbHZX8iLUI/ONFBBFzad6BbPRDX5DgzI2iVE5uV0c59hTsww5PTp3qpeKbzmVsI2YNAb5BoMvW+pk3cAE+iKJNoN/AgtigTrXiFVdwkKJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783804216; c=relaxed/simple;
	bh=dtLpHxxtKGhbn8bYnlUW6tKQxDm+ZCplBWXk9EnkKS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmAYEnrlP4O9vcHF6veOP4/jEKGTCLto7ZCgNpMpCTN+x+CGGdfLmtTPj+juChoVQaGYwrvk4zS9xFbQCsiawg9pCAKi7dMfd8pZ2dwSjLtfEZQ3j22D3OM5cjM9p2a46WJN3Bmnn1rLDaWNRPILlxFFf5J7cZOrMRGmFVdLyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vXm3jjNY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjLI0129; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vXm3jjNY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjLI0129"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 944811400093;
	Sat, 11 Jul 2026 17:10:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 11 Jul 2026 17:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783804212; x=1783890612; bh=aEN+vCsjXK
	SminfSpiqaFQvs586Bu0BPZvKVfDQEHtU=; b=vXm3jjNYOdc9UhpOuxXULLMV4k
	z27y+s+4iFdhA0wCbhnjvtPV4Ao9hur5JAnDkFIz8u3/xlcnt3Szq4HTTeFU+k55
	GwgBGx+VMhluF3EWAeqXF3w+llQYceTwvjVYnbupRwj6hfn4XtkQO1mBdNcn+U+p
	qKLo+dKsAw+qxzH9VV4HVks5qUByE/YAgQ9iGdXXCvLtVwuCzKvqw96Nd6/QkvAk
	kzv1Hv407iAV/Eoiwhl1967MDlql6uLKvzLTStz5T/Tk74fyTZA3FupTPehqvT26
	AWRl2IIf/47AfeaxE3kPomw+StHYPlEg+2k/Y3RlG59X13R+edKfkWhiy7EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783804212; x=1783890612; bh=aEN+vCsjXKSminfSpiqaFQvs586Bu0BPZvK
	VfDQEHtU=; b=AjLI0129x85pQtl6ZQP/kzU/CEY8+9gysJYbMvc0LbgdMszyLQR
	jaG2Z9FAPW+oGC3NanaSxEOfad9aTXB0B6Gn1iozXbmdnISQeiN9h8lFyUJwcYVJ
	MpNIKLmryBXHXnuBnzFC56tA8CRU5DqnlQ/O1mKOrjXUqoIgdnaObX2rQZPA9ebq
	ekLw46IBiq46YexJxHw/nGiRC6ndD2eEX/DKlIpNMxrr+SNEu+KGSgqz+TVBxV2U
	hevMmUI006Y6DeqA/8HJ8E5OMXZ1NOO4/c47JtOqIeeOUXYnEr0HKlccmKpE+bYc
	7Ush7u8YGCNBZFidDVJarc61Qf3OdqCwb4A==
X-ME-Sender: <xms:NLFSaiRUIq4bgzOZXcxXoVhI8pWN7lAwOKjuG7-7EBtTARMAMAkFrg>
    <xme:NLFSards17x0cYAUTtJ5umfOX_u9M0Z4HFCyEBZv2E_dSanHfUCnKdno7SVIyBi5o
    GOT0g0PvUmSsWadoA2-7b7H56Iixc9wfdqnVot-tEiTTD0sqbijUw>
X-ME-Received: <xmr:NLFSapoO3SbvgPex6VPfXSZRtZdzEs9iX0TUnWxeRy0N8UPS88ceIFgo11LTiawgNnTLmYmrUs97jhMZRnHNVjc5lAriIVIwqOzTF_A>
X-ME-Proxy-Cause: dmFkZTEoSr6poO5IpQTkL/jIz721IK2iZ4tL0SFAgJgzrr4ciso5Jwpbbx4dMaOziPPJFv
    XnBDf0/ZgsMHZPJXcfosqem2ANslDRUgmWDJOzZcXl0+6KgRGEwIpmYZipakg5WHAarN5A
    Pe508SUuMPFOh74bY5k67Ec5ahgy8WkpeUbXKFDicAopilj/5pRHbbK4fuABhcF5PiBvrk
    Oa+TDWtaS03NTMOWaih9bV/vYn25pQ9Q/mBUpOycDb0Ja2OTp2O/sN2bQ68U4HNDHgKRep
    eCNn91apfTE/FV6kKYbpSJ8z1RZ6TFF6coxI5/GxLpzpgVB9ko4MytfXbds/fwQ8UMClFZ
    +Aha9M7gnS83anFmlkTbKNxZk6GwwDBYlPemf1dV0x+azcCcBr3yxNbbcptcS3ml7k4XxT
    KEpPRGBue/rwVqX3PDx9lk8JVBcRNjnA09oMiYON7PPW/kcjJtC4+4NDmTK62A7qQWb0Tx
    Q5j3PGIjhB1C3KjuaUc41OXEDyQ+B0Sl3Zyq4xDrqG/qMQyB3/0uWYwwcCzyL03k6HyksW
    /cJH9Rkhh4hYbSAhbsO7pRSnKm41ud+/S0JOoZFcDPLcQe+P8F9KwRJXLzipUCszReXoZd
    5GYh3TQ22IYwIAq7CC0JextaPHTLUrqikrQpFHQ14+C79AGaVz5IEI+hMs1Q
X-ME-Proxy: <xmx:NLFSak8DIw37rFVk1qM6f7orO61pj4PBkWdSROsGnEjUEUqKIOxSpA>
    <xmx:NLFSatcxKwLTZX0RKQQcTQSbawos3nK2jPmzV64AxNZACk-_fefGhA>
    <xmx:NLFSamKBj64A-F29ITNRJppRUgzH0Bs1aC_t51M9EDtpU0YvCDEZWA>
    <xmx:NLFSaliZuJH0FjLwp8p0vuCc4yUUtgl7GZupJmVBixhsLCH9fewt_g>
    <xmx:NLFSapc-ThyN2KcamT3jmwsEp-76MQ7AXCtpBPVi6I1_8iOAmNP4MaRN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 17:10:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  git@vger.kernel.org,
  cirnovskyv@gmail.com,  szeder.dev@gmail.com
Subject: Re: [PATCH v9 0/9] migrate more variables into repo_config_values
In-Reply-To: <a7aaa57d-5250-43a6-9646-d1aa29328964@malon.dev> (Tian Yuchen's
	message of "Sun, 12 Jul 2026 00:11:22 +0800")
References: <20260708160300.8852-1-cat@malon.dev>
	<20260709161145.13349-1-cat@malon.dev>
	<DJVUGL8XA0Y0.12LN2COXI5BIY@gmail.com>
	<a7aaa57d-5250-43a6-9646-d1aa29328964@malon.dev>
Date: Sat, 11 Jul 2026 14:10:10 -0700
Message-ID: <xmqqjyr19qrx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

>> I missed a base-commit to easily apply this locally, could we
>> add one?
>> 
>> Thanks!
>> Pablo
>
> Thanks for pointing out.
>
> The base commit is 8d96f09e9245ddf80c1981476fcbac8c4bb4125f.
> I will put it on the cover letter in the next reroll (if any)!
>
> Regards, yuchen

FWIW, I think I queued it on top of ab776a62a7 (Git 2.55-rc2,
2026-06-22).

Others can find it out by looking at the output from

    $ git log --oneline origin/master....origin/seen

and finding the commit that merges the topic.


