Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5153A75B2
	for <git@vger.kernel.org>; Sun,  3 May 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777845591; cv=none; b=pgyV0T4ohNH+gHmxk2dQ3CLGZSjvYhh68hiOntGNzyIyY9ZHXWp4os9wxuAA2FMz/6/ejuWBO45KkddHaxJpqDorXTztsnZdU1+GOpif88YcznbHyDnh9o9qZI5I6+egHq1sTe7mEMPk3Wr/09+Czx3R9KfA4dv2D/Sy0Zlyynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777845591; c=relaxed/simple;
	bh=dzpcxuRjml/igHSbQj/YfSlamcnrTjwUuXtqCmkn36g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXGAZ3IH+Yvv62/Beui7jLp0rOW8Z/LRGzupUi+CjfBW4X90Z9Gk/5pVv3aLOgmH4TXbCyYV/SOoLrGWkwxJ9qdhp5vlEcXKrtcNiLajD7a1G0iytZTasGONt4lx7L/PzEALARmNSWhdm/lVTguFpkTtj8s09t4LDoCj2N215ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AtJM5xYB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=svn+zX+X; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AtJM5xYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="svn+zX+X"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42B311400095;
	Sun,  3 May 2026 17:59:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 03 May 2026 17:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777845589; x=1777931989; bh=OUcohOzuo/
	Loxoc1CDv4OSGIP82xn1p2S4sq7FbiIb4=; b=AtJM5xYBvluHaijMhVFyNSsmn2
	O3WxLwShskFTLzDbs2I2eyBPhZy6kgmMkfdQUjwTPclvrMiz+oIADPK/2lBxfNRf
	7nQWaWHlPxJKs+ub6WNyfg4RK5IT3YdSgI2jlrVYfNwSAIB1+rJTRaOjRDKbFE64
	XBbOr5/rZsw8Ds3qLvFjungbjRwpoJe6W0MXL99IpDisQRstTY2Fub3jbwEbj3Os
	bZHKgMgfAUsNVivGn4lh8aJI8NtrnL/sMdW5FST0Vhx0OvFITiMc3zD+ic7OBLeR
	Z/+AabBm+QJJQLSPBFUYEqhdAPfHWjLjn78G5nwXJSCrcrzPrVoF1hjzoN2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777845589; x=1777931989; bh=OUcohOzuo/Loxoc1CDv4OSGIP82xn1p2S4s
	q7FbiIb4=; b=svn+zX+XcsaxR2cSdkvhKRxGCCUOyyuijGt67pFhaSjtQeZ+Act
	1l0p1t88qZT8PnnOUTgp1yTjPizqpMTNhNcIdBfake7iLRk8c2ZkJydQx643Ou7y
	RZHWwHoTbJCKLr8+jW6Kk9KJ+/ksRJ32/xMP3Bax0UoQMVFdKMGdd+kDxf2GsEun
	+xLd0fgA1hCzNJuVUbKjnoVDbuAU5Ir2XE7ZUUBxTnBTfN13GBTXG44ycdH9WmAj
	M5I3Z10bQCoLhY7wIt+FEkoKUBvrae4Y6K46b15HOY+2P1LCY94k6//UnGLfwml7
	VBKCeI0ClyUfVe8mJEtR1cz/3/MxkfREa2A==
X-ME-Sender: <xms:VcX3acVV9CmUKudhN-QgigV9BYF_q1c12RW_ZD6dL4UFFMDy0x-m9w>
    <xme:VcX3aXlD4qyLNA4o1V0LEDA2lWs1n1BOd9ebizXoZvBMnDv5M9k3ootVry0ABNrSH
    ga0IvjTwVMRMSF786J24vw80tJtjuT_GYuzW9XYT-PnF-wHin_SitQ>
X-ME-Received: <xmr:VcX3aVZ-a3Q4fNN0uZ8TJqe6APkaW9ziFhky1MYRfaHrgk52M5-ZK8LSsRDUZnaGWEngVVWPTWJsf2pZRgc8PwDUl7EyQVm7tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgvsggrshhtihgvnhdrshhtvghtthhlvghrsehprhhothho
    nhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VcX3aaMcrglQX_RO6Vi5RtI5LOeweAIQneTr26ngje2fr7DvSaFCzw>
    <xmx:VcX3aSbZYfqyBpQ_NhZH-HQvnsaeqFLFZtF-XQnKL27WJxf8K_tfYQ>
    <xmx:VcX3aQ3nX_bjWbgY6RYueQi4Ns8aqEzvGsc2kwLDErFLuUNvD4_5EQ>
    <xmx:VcX3aQciUt4NqQ01pUFE4ZN7WIet9i__6C4LK9zRWKbhZbXmf8_XVw>
    <xmx:VcX3abYkIRsCA2P2Y2qONLg3yRG5DcQmleqZxhITaLs4_QazZaspcAfP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 17:59:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "sebastien.stettler" <sebastien.stettler@proton.me>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rename/moved status unreliable in ruby
In-Reply-To: <026b84f4-7052-4d5b-a9ae-c2487569d1ee@gmail.com> (Phillip Wood's
	message of "Fri, 1 May 2026 16:30:16 +0100")
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
	<026b84f4-7052-4d5b-a9ae-c2487569d1ee@gmail.com>
Date: Mon, 04 May 2026 06:59:47 +0900
Message-ID: <xmqqo6iwrw6k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Sebastien
>
> On 01/05/2026 06:05, sebastien.stettler wrote:
>> 1. What did you do before the bug happened? (Steps to reproduce your issue)
>> 
>> when moving ruby classes between namespaces they are marked as new files and the old
>> ones are marked as deleted
>> 
>> if i only change the class name it will mark it as renamed
>
> Rename detection is based on how similar the two files are. Looking at 
> the example you linked to below you're changing a file that looks like
> ...
> Which means that git sees that every line has changed because the 
> indentation has changed. If you want git to realize that the file has 
> been renamed you could move it in one commit and then add modify it in 
> the next commit.

I've seen this repeated many times, but it is misleading to give it
without qualifying when that "works" and when it does not.  Such a
"stick to pure rename and make huge changes elsewhere" strategy
would help your "git log -M [--follow]" and possibly "git rebase",
but it would not help all that much if you are doing "git diff" or
"git merge".


    
