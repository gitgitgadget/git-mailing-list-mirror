Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C351386AE
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434777; cv=none; b=PNmnfSwz/cJcYb/umZyEgYwCr4j0P7em5jOpabesbTNkIH3z/0niXCdMSg1Nq6YnZ/BpJFjrriiuIdIAp1nLigQ5kHTriLkzBGE0KaCawtcrfwJrjVXo/tUdBDa1c9StZT6kReUe8kTZPLEs4gPYtUUXDNiGloXoErljWV7DXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434777; c=relaxed/simple;
	bh=MnuV9284ACKW/8ye8Trk55T6OdgJJ4H5fm54tqUakjo=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID:Content-Transfer-Encoding; b=Y6jHTqEoEADVi5yYZ6V8hy4CXEX/WDD0mpU1hIgddW61QJ/Z/bzeNUMSQ4YTbJQ2n9BlNzTk0T2ItXA4qZvgzW9ORMn+AlYO4HXW1epmhSVDwHNUUCL8TYeSWrLCJ/3Gn1Vi3npSRzu5ZujXKpS19eVb76Ig50uYdm3D3UhL/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fbLOg+vT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fbLOg+vT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47F1D1E708F;
	Tue, 16 Jan 2024 14:52:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MnuV9284ACKW
	/8ye8Trk55T6OdgJJ4H5fm54tqUakjo=; b=fbLOg+vTN8901jwEK8yPIIoGVr2H
	dX2Sl9DR85J2yG7Ffik2k+AvrRBQUuiJizbE6hgb3pwabC53rzj4pYzJA1dh1XUD
	1UeZatO7PC/JtmlMk5X29wOKtA5s3hNYmcfH2ytw4FKJwknn79daHkLEC0ep0k76
	r85D0AsOT13mQT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BC021E708E;
	Tue, 16 Jan 2024 14:52:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C44D1E708B;
	Tue, 16 Jan 2024 14:52:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Achu Luma
 <ach.lumap@gmail.com>,  git@vger.kernel.org,  chriscool@tuxfamily.org,
  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  steadmon@google.com
Subject: Re: [Outreachy][PATCH v5] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
In-Reply-To: <41cf1944-2456-4115-a934-aff2306a26e5@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 16 Jan 2024 20:27:13 +0100")
References: <20240105161413.10422-1-ach.lumap@gmail.com>
	<20240112102743.1440-1-ach.lumap@gmail.com>
	<0d18a95a-543a-41de-8441-c8894d46d380@gmail.com>
	<xmqqply147bj.fsf@gitster.g>
	<41cf1944-2456-4115-a934-aff2306a26e5@web.de>
Date: Tue, 16 Jan 2024 11:52:52 -0800
Message-ID: <xmqq1qah12ej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D638713C-B4A8-11EE-A1BB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 16.01.24 um 16:38 schrieb Junio C Hamano:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Thanks for adding back the test for EOF, this version looks good to m=
e.
>>
>> Thanks.  Let's merge it to 'next'.
>
> OK.  I'm still interested in replies to my question in
> https://lore.kernel.org/git/a087f57c-ce72-45c7-8182-f38d0aca9030@web.de=
/,
> i.e. whether we should have one TEST per class or one per class and
> character -- or in a broader sense: What's the ideal scope of a TEST?
> But I can ask it again in the form of a follow-up patch.

I personally do not have a good answer, but those who are interested
in unit-tests more than I do should have their opinions to share ;-)
