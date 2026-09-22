Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5B541E60
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084960; cv=none; b=pglxWVBXMb7TMkiQmn5E1BQXZMFoRPfGSJLmEK0JEDXSr+Ofkc3brnF0/O11qXJT2xO7M/QsKnVCPX6SG/JknJFlsFTSQUdv2vfM8pcky5ujlesK0v5aRF6nKWOnMFT987yemx6mJReXyXzyBqAC1otux/RCS2FSp1hf9cr8O1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084960; c=relaxed/simple;
	bh=zzo46g8wzutxIH7dWK20SfIM0T2edqWZhRK8dzhja58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5Cvcj37uDQanF+K5NnnG6CjRngirpOxKb0zX0tI21CAffAvxUJJ/ZOajMkdA7pKrP/L7/zlUXJ/s4TJiZgp83V3EnTCnwqmE3TLS0g7cTKnITEbULTEbjdhCPOl1jjvJKEDsqZazGC3WiomQmAyF0Zgc+hyuD2DnFeP/psqjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=czzMYTGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igkg9FYP; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="czzMYTGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igkg9FYP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D6F98EC012C;
	Tue, 22 Sep 2026 09:49:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 09:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790084957; x=1790171357; bh=Jx88gbBY8t
	2Kx4xeQ8suxgRhd+fDQfrpxxZX+qNtOOc=; b=czzMYTGP7J5EydjbiSnuUbJoUg
	wp1q3bmdO2hf00je+k4bU/E/50quGAMzb3cSHns2NdQTnzy78XDWN/KKi8QL13WR
	GpnKw1e02bww1GLB9fmLGSkY72CaQwyJVL0Yss3m1sOAQbVN/lofgqv5zsy43cjs
	TVq6D7DcePI6ImsCIhataLq7++MzqnDojoGUZcjBrOAQdq+2wRPZl9f964UA2fmv
	FCbH5X+fGsv2GIJi/rEdIAcrP7gjm9z/r/ux1rDtTSr9bsUgBQ3pXcJfD0mioxr0
	KHis/u6Euxm5sLZQzVEOMHjRwvRAMBo1dQYKwW5Z1XVpxo4KHqvrcY+qjxoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790084957; x=1790171357; bh=Jx88gbBY8t2Kx4xeQ8suxgRhd+fDQfrpxxZ
	X+qNtOOc=; b=igkg9FYPsCRSK6phR4HmoIDKXQXEczdtNC4yLGjs5H4su7qopzB
	2uVPztHaUELbPx5Ttyo4T8/aHsQNrG873kI3KhLbO8eAFVexWPqKFwPhKQ5W0csy
	lVS3Izrv1OlX3OIKipYjbKCL8efHUJngTYBKd4735gPOycgzB4rsdOFM6sKr6838
	sTx384kZQLsMLFG1UuHZlVToxHeXRgmmL4Xg4F7novHYVvDgI7a+me7V6bCj+YNj
	zwEQFZhPCCG8F6y5GuzPUxVdxClUvgUO1EZOxFcIW3HZE50lqZOawBfxpxzsDiZ1
	2HVytMyxGJTjcwEoJ2QMKUO/IGGokunavjw==
X-ME-Sender: <xms:XYeyajBDxegkTV_60xx1Mp2WFhdCa-KSyCadXB7fSefWim_xdMoH_A>
    <xme:XYeyag-zbJj4gG7J1VwNJp4yoaVvRO76cSdLT5UTFcOkwCff8STLD77mqCl9Nwj3y
    88PrdNfDjVrEy5Qkck0Q-ABgGWYS4zRTyjKJ4hQm7XEJkd90qCFdaI>
X-ME-Received: <xmr:XYeyar-_edcuIaE4ttuZfdWNO0Yybf0I33wnw7VcjquxLPQNJ3wzVEDl2m9b0HxpeKRS_fx7YZMeD8K2bXpCXmAJFmBMSoJktmEI>
X-ME-Proxy-Cause: dmFkZTGtc9sFKojauKBV8bJE8PnAa9VrXB9Vev6rLZdSwu9SuMBOzXr6hWU6HweNEbyH08
    i8uMyO7ZjGvtTCxP1f5ZutLMZDvdPZdEUHrpfdoXlpwbaFCQzMGFyHHrwWe1HwgdIXUMcF
    32nV3z70Bp0bo1ptkKH2iYyqezJHc7HgaERBh2PqsfSK5glF+BOjYVmZ8tJxFuhWGBtAMd
    w7GWhoNyrVR8LGfxlBCDhQLq9s0IKAYhiK5IHIesN0s6WdGpES6mmFs7ZVqDvuMhMQymim
    LfEgw3DHvGdtQPMQpDS29IOt6FtShzyzeZMZFdK9qMXZ50pyQvTydLWNo4LOWL+mOTWRQH
    aBTInaoeYYlUbJPbZ1SY8JcYO8N+FEX+vQid5xG0GgPtiB6o0t9Xje1uHbVeaFAt3brsKe
    l4Z22g6nJbYTfU0gAnAzDSm/WSgUb9Qys6yH+Lqsylm5aNNPr/6xCqruSlDamD3ZZSGkK2
    lNknD1fBYqzzF1PAQdsUAYbZnVVaFohrUTvO81gz4EfF9SGfsfPah5sLxq6r2EgHuQyY6u
    mdql+y15wBfc8MHyQBO7ODzc66HOLD5Zk/6LKXYpR5WB72QKN/FJ8U5EdB0OhDMdYguCSp
    AR28tgP/bRKiS7E+8GmZl8rLlUT8yPDzawxmuURFOTkSlW2rg2EFqPfFtJZw
X-ME-Proxy: <xmx:XYeyavfB-m__RDXasit7Xc2olkWDdi3036bASpoE_Wa7LO0uBVOBKQ>
    <xmx:XYeyasH7HWSburvXFiFHUYJY8t48Zy8pIR9NCDnhinBBHLg4RXzYeg>
    <xmx:XYeyalcYcQ--9PC9ojWpadcRST6Jr56jAhaFw9SjkXjbmYqJXXMpMg>
    <xmx:XYeyauGQDH93n2rIJJ-10r6XJgvfwuQzOcLMAC8xJFPsVonFP_3_QQ>
    <xmx:XYeyavhP7spJcLg103CLdFAL4Zd1LH4LjQ5GLoY3qTRd3Q86wncG1K8S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 09:49:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> (Johannes
	Schindelin's message of "Tue, 22 Sep 2026 15:25:57 +0200 (CEST)")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
Date: Tue, 22 Sep 2026 06:49:06 -0700
Message-ID: <xmqq4ifhgzvx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 21 Sep 2026, Junio C Hamano wrote:
>
>> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes before
>> the final Git 2.56 release, but otherwise I do not expect any new
>> feature topics to be ready before the final, so most of the
>> in-flight topics will stay cooking in 'next' until then.  As
>> discussed at the Git Contributors' Summit, the version after the
>> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
>> year.
>
> Would you say that the following is an accurate characterization of the
> timeline, so that people who need to plan dependent projects can rely on
> it?

My outline was deliberately limited up to end of this year as I am
hesitant to say beyond that point before the meeting notes are made
public.  I am not sure who will be releasing it to the public and
when, though with the open nature of this community I believe it
will happen soon.  I do not recall anything controversial in the 3.0
section of the meeting notes.

> Rust was treated as mandatory for v3.0, and the explicit check for
> objections drew none from anyone in the room. Compared with the
> contentious portability discussion on the Git mailing list, that is a
> notable signal. It does not establish that the portability problems
> themselves are solved.

It signals that the room was smaller than the list.  Or enough time
passed since we discussed some minority platforms having trouble
with Rust the last time to change the situation.  Or little bit of
both ;-)

Thanks.
