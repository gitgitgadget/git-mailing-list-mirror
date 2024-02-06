Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DB1AB7FC
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191698; cv=none; b=O7G1RB9lS5xRkP9ZK4JNGBh70ttH7iYqxBnmQaBN5tE5wNmAOvDF5XuZlX4p5gXBDgR7WJkb8duCnlMGTSMNpKDaP+P7bmWByujlLYCC1U17FBjIjI2C5j0hJPqc03XrFR/8ryhv9OCVq6G4eUF97DSLenYdSI5AklUKDHjiqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191698; c=relaxed/simple;
	bh=U1/nzOv8xUSoGcQJ0r6aP4PoGAYDVVWWoGRgn0V8XAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AF981vDwtKTEZAxu9BqBm6oS7+1hL429yShZRzK7bo6dJMC6870/yIsqkKIHimNfg9Eh/OtNbdxNXVsTjxRBxw16AcUwS32G6PMCAzrCst2+3F6gM7jJfLH6uL6js/RBSr45DtK33vt5y+xT7fNgCZQYsgP7kfVq1JfsSdrtSa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sVlQUt+w; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sVlQUt+w"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 24E981E114;
	Mon,  5 Feb 2024 22:54:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U1/nzOv8xUSo
	GcQJ0r6aP4PoGAYDVVWWoGRgn0V8XAs=; b=sVlQUt+w7pGy8uW0ibKFsDE6tHLS
	MBrjDkrDd++JIjkXWbvRYj3QQHD0tZAqgyfF1uOVNVPtff+89OC3m9252dvuqHzA
	JPSvtIZ+w5w5JySK/cvNYhmXaHBW5hTTVmnRVWqYvS8kxBE6r1+s4MqPKKiexcT3
	Sn31p2nHKiSBOHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F8ED1E113;
	Mon,  5 Feb 2024 22:54:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0296F1E111;
	Mon,  5 Feb 2024 22:54:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  Jonathan Nieder <jrnieder@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
In-Reply-To: <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com> (Vegard
	Nossum's message of "Tue, 6 Feb 2024 00:14:26 +0100")
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
	<20240205141335.762947-1-vegard.nossum@oracle.com>
	<ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
	<xmqqy1bymru0.fsf@gitster.g>
	<b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
Date: Mon, 05 Feb 2024 19:54:49 -0800
Message-ID: <xmqqcytal01i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7A93B1F6-C4A3-11EE-ADE1-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Vegard Nossum <vegard.nossum@oracle.com> writes:

> On 06/02/2024 00:09, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>>=20
>>> On Mon, Feb 5, 2024, at 15:13, Vegard Nossum wrote:
>>>> Link: https://lore.kernel.org/git/0adb1068-ef10-44ed-ad1d-e0927a0924=
5d@gmail.com/
>>>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>>>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>>>
>>> `Link` is not really used a lot. Junio=E2=80=99s `refs/notes/amlog` w=
ill point
>>> back to the patch (which is often close to the =E2=80=9Csuggested by=E2=
=80=9D and so
>>> on).
>> Good.  Also, is there [PATCH 1/2] that comes before this patch?
>
> Yes, kind of -- that's the testcase at the root of the thread:
>
> https://lore.kernel.org/git/20240202091850.160203-1-vegard.nossum@oracl=
e.com/
>
> ("t/t3515-cherry-pick-rebase.sh: new testcase demonstrating broken
> behavior")

If the first one was NOT marked as [1/2], it is customary to call
such an "we thought just one patch was sufficient, but here is
another" step [2/1] instead, and that was why I was confused.

Perhaps it is a good idea to squash them together as a single bugfix
patch?

Thanks.
