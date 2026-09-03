Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B8349B19
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788471618; cv=none; b=N61UDY7T7HMazhl4uj5lGjG/cQ6quaKIutUUa97q1G4xDSR2xLSUrV1UBNOpVdHQwcjeKeyN1D7Aehv6OSOzrU2oSrjvjuROPUaF0KAJjj80beo+54DRwSzIn0iFOBAuI3ywkQHkqRyuqx1tzk6LiNCCERMPTtzZiynrQXFm5mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788471618; c=relaxed/simple;
	bh=kPlKf/0fW8cMADEDMtiZDra+E+gkrEIylTFdrh4bgfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iQD1Ny8l8YxCsabvSnOahuiZc3nTNx8Ag0KElt580hyki5pSX9EQsA+TK1/5/C3wh4hvB+/Mn8ZdNcgXE7RPtiVw1wtdO6HaSwO67K9ptC5DJbe/eJ2E8jCst8XIiTaMXpqtONd0WkyKYw9p0oz9SdagPhPaAkuN/a/gdS83WVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KRKo+ekn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elLSjcgx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KRKo+ekn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elLSjcgx"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAF1F7A0169;
	Thu,  3 Sep 2026 17:40:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 17:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788471616;
	 x=1788558016; bh=9RPpEVqP4WQAlsawSs4l4LWjTUbw4D+DWphxbxYI9gc=; b=
	KRKo+ekn8YiQY9HmVJOB9dfkKf6XcVjC3MvT694kZQvgd0f3JdRZfGx8W8pWC6QB
	SLcnWYnpQMCIkcozNe6z4w2wQLhWMQBp2Z8+k/UPD6VghqnF2qW1U0aV9/XQDdmD
	C03p6G8PNY1o4MUUuMjF374dYhJE623uvTyQguly8LARPa6yhXe3EY5AOURqsAur
	Je8qv9HyG0ZMQNmHbQ5AMEOI0yGnJPqVk1Y1GHL7M0BJiWk7BPPyrwmjP8izjm7+
	O6b5ILV7JDGuPxIJKQVTpFXhO3wpySTOkwzjqI/x4Q9rIIfwpeYyQvxFBDeGUrAG
	OPe4htt+HosjPlN802KksA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788471616; x=
	1788558016; bh=9RPpEVqP4WQAlsawSs4l4LWjTUbw4D+DWphxbxYI9gc=; b=e
	lLSjcgxjgveuMM8ciTaUAGRFqo9EUde1ZZ957piwM0UBkMugo1AwKu7R25mB4HST
	wqQesNUZCdVE3vyTa550XXb8XbVvZiIq3oiaTxU6OWkynsJ9msLDqCXN55MHqLR2
	fQLvUGubyEl3uiPxdtUDT+eN9Mppt0iwGBawgf9YgSL7XDH7WzC/tlbzj6Qwwes3
	knxaIYChfuBFhfGbtVocoid8oAU7DZA2HcCUH0GBrkmgAUT3wY+uXBrubMPwxAyK
	VCwjLgye/FCKJaKgqvzsvMi9+gTnx7+UuAVVAsYshdabqDX1jc5XNhxOHYx2g7JK
	Bjelrox5Yo7GElRYw06uw==
X-ME-Sender: <xms:QOmZaiCxr6HWD5CcCqCLRAoVXC4D_1IzlOzgbdwQvSpi2SkNq7Jpiw>
    <xme:QOmZaj8iQ2yAXwcqPZAI_vzq7sxaP0lPUyZOPckfD_iXFSwtDptM67XiLQVS561t7
    jkt46U_42we3yPvq1pFOKjreZS7Q8cY5E3pqFhfXhTC5m9p0p5wc31->
X-ME-Received: <xmr:QOmZai837NE16aBLXf2ddX0fDCpakPlfA1Of-ozSoxvtM2BZF3me-Jcon9_7b50-sjMxSfa9d1HnPlncyswqmIwc8C7dixxh3w>
X-ME-Proxy-Cause: dmFkZTF3Cq3XjCeJugOuCpERPYfYhrZFCtNq+WNl3c2FZmvLeV0eSHuWkp8r9BiZiQWjN/
    jvp8YDPUflXftHHjtgL5QMPF9q49cTe9b2ep5021qgcc8oLAViW3cVg9w8h2jmtPWV+eGO
    kfIjCCR/o0ICkNWZaEcZ+wVF4r1kM4DUNFQsDkR/zxOurN1uJISz7+pEB9dUwUW0dakv4b
    3wuJ/AhbctiTzvzFLFTFVkuOYVtYQdShC3T9uI/ElPiyRnWftebu6sTJRbhTj9oQBFljR3
    gxHgyAgo3LWZyElCRv+dD5UM9JGF4FGCPYdW1dyhJGGhVdrds9PDlNNqshyIFF8nFC2me1
    4pHC6/8JZWomSpVQZSwtsHmBHEV9f3Rms1DyM4eYm78My/o0gXcunSJ4aSldzs276sECQg
    Yju+xjtdyn57dCYJ1CSfCV+RwXzWZAoyrkBxrcl0e1IDWzCJWe1JVWLi2+UeS34ocLJeAX
    kWVxR8IVxVWtV/lMK5/WRCDNwxpzFogMcCYiZKYDCF2h1mpBP9sF+Ml4yc0MVMy7l/bfI5
    id0xhyB2cjJUKHiT2Xn4J0YaVJ+L+r2pCl93KaU9c3iR2GvtEr7+wLZ/dm6jn7ydP+6vLF
    G/QXfzM4T0FAgfmoP8sF6PvThkkkaJRhFkR+Fym43eYGTxIu5efLv9/REUqg
X-ME-Proxy: <xmx:QOmZaqc8RiVWexcbsqIqpXUqO2eKIVFKCmYvQRwf4dCRZpnOsYFIaA>
    <xmx:QOmZarFYux9ZxRFsaIlCl6LN5yPCrkHaj33zpSdi3s2E_MeWZNolhg>
    <xmx:QOmZaodKMSChOfzgc2Azv_BiWS8d_OUQWDGVILsphdNEZC81gdwPeA>
    <xmx:QOmZalEPOTI3CbtgumiiUf8HHA17rKT_G_wLZSVvQHHPUbP0fKSANw>
    <xmx:QOmZaj9xO13r770Q6taewdjv5NZBaRTtDCj6llQJ6roJI1FMSqWhKHza>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 17:40:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #01)
In-Reply-To: <CAF5D8-tfG87wuAimom1Jhqpzt_U7MNzo+kmZ=hK=iQ_ECR4cYQ@mail.gmail.com>
	(Yoichi Nakayama's message of "Fri, 4 Sep 2026 05:51:43 +0900")
References: <xmqqjyp3f7mr.fsf@gitster.g>
	<CAF5D8-tfG87wuAimom1Jhqpzt_U7MNzo+kmZ=hK=iQ_ECR4cYQ@mail.gmail.com>
Date: Thu, 03 Sep 2026 14:40:14 -0700
Message-ID: <xmqq33vq9fpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

> On Thu, Sep 3, 2026 at 10:25 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * yn/worktree-ambiguous-remote-advice (2026-08-27) 4 commits
>>   (merged to 'next' on 2026-08-30 at 8e7670286a)
>>  + worktree add: treat multiple matches with --guess-remote as an error
>>  + worktree add: improve message for ambiguous remote branch name
>>  + checkout: improve message for ambiguous remote branch name
>>  + checkout: extract function to display advice for ambiguous remotes
>
> The following description does not apply to this patch series; it appears
> to be confused with the `yn/worktree-add-no-dwim-with-b` series, which
> has already been merged to master.

Indeed.  Thanks.
