Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62B37269F
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450656; cv=none; b=A7/R63+vGJsRQj19a3DtKhCXu930C54S2n6Ii9Xb+LbZrBl/VT/G4TVtmHEknK5Hi+xd8RInm1G4Ylta97jWWJmXwgTIJU2FQyfiEpAvLX9CUVuAXKkJM7vDsIif9hofm3CipS/6CQL5+PnHaMKrh2Z9LHy4TiG0OS13Mb3QB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450656; c=relaxed/simple;
	bh=3KtKeVFykHJPhtb2RETCACdHSU5ZcV7igiP2PgJqRi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLaDGd8gU2gdoJLHhR0P+3TCOABZLP5oLcjAfeM8GyOTpr/XE2D8jhO3A+Geo11dPPxoORlJ/DxXDAoA6x9E/LdRoDMdoiZUcERXNKplDL9Wuf3UaPg53CVTnfaAcyIAwOxxJv3zAzFz2FLUfbzKgDGr29MjqAx722qe2O3FENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=fail (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=acPrno2V reason="signature verification failed"; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="acPrno2V"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1wUaXq-004jiP-ER; Wed, 03 Jun 2026 03:37:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=U1o3gqyQzePl69t5cfuJhTqXJIKg25kAC296FTNQdmo=; b=acPrno2Vy+f9AZQ7/Zf0xVpm2v
	HIyLwZHUIbTikp6WRt64vSDeXCUbLTQY9w7rcbEwv75TZsagduSxJZK1CXKYTgln44VUx8GXr1Z0S
	ylsXT7JZiht4Lf/u4wAPDqNfS3PYwKCV5xsylFLI8LWw3WSG+s54IRaPRFzdHHp5H6JzNvMH6S919
	Kf+6rFbrHTmUrBT0Z/capCEqBzUekvmSjgh8DElMioKzYVjM4NsxNTIUQkRqgjVTaeVLgy77mP8cw
	uBO5vwoDQKlO3R7/MG4J9ofUN6c8dA1Wz0ymvbaTARF2fd65qCIm0KmrGgX8/b+SUA8gKpUHKL+mt
	xqYqWh4Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1wUaXp-0003bM-Lh; Wed, 03 Jun 2026 03:37:21 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wUaXo-00BEs5-9R;
	Wed, 03 Jun 2026 03:37:20 +0200
Message-ID: <0915b5cc-5cbb-4cce-a832-147f85d4ff1f@howdoi.land>
Date: Tue, 2 Jun 2026 20:37:16 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
To: Junio C Hamano <gitster@pobox.com>
Cc: Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org,
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub,
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260215201748.889866-1-ask+git@howdoi.land>
 <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
 <27104.58166.993109.63505@chiark.greenend.org.uk>
 <a1a07433-224e-4477-ae8a-3875fa98faf8@howdoi.land>
 <xmqqv7c13o5l.fsf@gitster.g>
Content-Language: en-US
From: Colin Stagner <ask+git@howdoi.land>
In-Reply-To: <xmqqv7c13o5l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 17:13, Junio C Hamano wrote:

> I am tempted to mark the topic as stalled, to be discarded for
> inaction

No objection. I'd still like to see this reviewed, but we can revisit 
this later if interest develops.

> While I do agree that avoiding bash-isms in the main part of Git and
> sticking to vanilla POSIX has merit, this particular one seems more
> like an artificial limit imposed by dash than sticking to the POSIX
> as the common denoninator, at least to me.

Correct, this topic is a workaround for an artificial limit. The limit 
is Debian-specific and was introduced as a downstream patch in 2018 [1], 
[2].

This git-subtree issue has been reported before in

   <CAN7rbOve-EFOGPjr1wrD77r-3RQ+3+qso82_oV5Qud-skobL7w@mail.gmail.com>,

   <26263.63341.878041.155047@chiark.greenend.org.uk>,

and probably other places. These are old reports, and I haven't found 
anyone there still interested in a fix.



Colin


[1]: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=579815

[2]: 
https://sources.debian.org/patches/dash/0.5.12-12/0009-dash-Fix-stack-overflow-from-infinite-recursion-in-s.patch/

