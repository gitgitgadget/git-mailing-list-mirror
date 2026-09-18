Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C814E9C2D
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743263; cv=none; b=jz6vFqGjcCFvP87JevVlg3BY7gm+394pkdR4HDD/XbjUNqtgjARvZ5c5LFFq+CnI78IFLeUSuq9YpufdSmRWwfoXjn4eaL+N34KavCxvEPR+JvCUIbIIugeArC63kL8rOZDSiovsML7DHLKqo9IJtTGl5OPD7UauavPreCER91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743263; c=relaxed/simple;
	bh=8gPeV9MPvq8fk21X+al6+DTp/G+ug29O+KzrSkt1B2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=V+chwyqF0Fz9lwsJ7XAnc3kEzx7XxbEI7t4DI21NeMuwOlJDI/U6VqY5O+KbYV/9/h/MsPGWB/RoNdxftKOEEHuIazwdu4AZPW94I24U8iLZlmBgXYQ1VWnIVH0SZtb5CK5/jir4UGglmLWiNgjxCHkPKuGEXWPOSBBoTjrzrYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fpMKsZ4G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftxPWow9; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fpMKsZ4G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ftxPWow9"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 0555E1300446;
	Fri, 18 Sep 2026 10:54:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 18 Sep 2026 10:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789743256;
	 x=1789746856; bh=ScDZ96NfDOsQESF2nKCjl+Vp9ovaCwDM+DNU2lKS0Os=; b=
	fpMKsZ4Gjv9MII2eJtBRKKsHA82LTY7BtRllWMid+Bkhctjf6u1/GBB7Y/bfM08S
	K4xNYIbK4O0GvYzqwdWU45B3RNCWKmJjerjlaAZurAPietXkb6Sr4DNZjoKZlaJE
	LwzcnkFVxNbWFOFSBwuJ/8E911k9KB05OEviWruApsgn/RDydaEWWiAUHaVnrMMk
	yQC7TT/6AiwO3AXP1w8XPCW07r0DKH17yLbxxeh24ytxX1ccRKWEl2qmR/OQc0CW
	nFG4Gv7mN/KnV5D+rDLT/uwfPpWhss2jgks0Yo1Mwq0EkOd4JcJ4ViJJIduEvQ7a
	cmdieL5WjZIxbYE3aQMMNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789743256; x=
	1789746856; bh=ScDZ96NfDOsQESF2nKCjl+Vp9ovaCwDM+DNU2lKS0Os=; b=f
	txPWow9JdCZhsiBhtnb9ymfSXx2IEmrS07vqd1cDE1jyMru5gU8cjN+szhIPclmK
	rSmyZN2sibLHbtOP0w+rtybPeuIv2Ej82pYs1P+a45eUSRj9+3WxZNVhKgxCsljt
	zNwD0uAqNOd2UfHTg9ORlNndrxOjByOn3aEKa5958uQpNQ1J4zcW4PUV5rfFW7V0
	q7gaBg6jucYCjogOTdWAFNMX1k6WpX0I3/ajM8qjC77tssAcj2+5CxWAuKb/WrzR
	CjiWd7l4CB2CC0A3SWi4Jh7P6PP5Orz49fmQyOR6Wn3SIGMWxBTnRPJpuRyIeL0S
	4ew7zEKp8zDT+3LFMcHEw==
X-ME-Sender: <xms:mFCtao6l3e9HvsmD8WmFexQ-x8WWZe1_ClLQn1GelqP6Q6Z4Ba_33Q>
    <xme:mFCtahUJ17igDya764WSV1OpQ3dtjBo_Nl9hZfJQOA_VRK-DFLfrsNBzVOIjVsRbA
    DvXODUX9Zcnc1xaYJpR8tJiSF1tI7RfKUzPBbJigz8qtTcGBGm5oe61>
X-ME-Received: <xmr:mFCtak3Eka9DJztYnL7G1Rn9Ct1HFw9O0Hw921l2fcaMnkb31FNwPm7jbsURnB9dgqSuDxSK0aJkwU-Go7FpeceZcg>
X-ME-Proxy-Cause: dmFkZTELmlSWGZztvUxhtVC3Arm9EWc1Ygq/8sDDqumaUqNvem0dmHgyMV84Ll03XNdoCW
    2cHZrJdxsG8So1e4EtOShTiGEEWO6eGkSO/3CKkV6azIsWATwYlcJhC7asjqF/nb7i0sWc
    xxjY5VlN9pE/ydIcG6jSQdEoYn7zHOow+sf5vjderBYW0oe91Kjcl5kvk+ODXDDilHEPDk
    9gscOOvOsmVAmvqUv9L9FTRNQekkCYoIgbQ7yivYEX0tzJhBf79l1EVTNCqBWrAsW8tKqK
    TsGHW8pkXufiFtDU4J7P8RM0YvThK+qyZiE69fp+IT/XorgpmvU2pwBSWiHmggpSr4nUei
    g0afrYcKXWcBolbkmL1uOrbJ5m7S/AnfEBMzLrcYJXRlfnqXZz5LzkxvT2HJimkr5CkjId
    NgT8g513C9FKOCi8O4sJJYfaC1hjWkIYDaM3recHDXD6L9633xrCFKgV/PEE5fI6COw9IM
    fI2hdNOzzYyL1zmx/7yAlPfoMx2VuELjXJsw6pjOKXBKPrpx9UlmmIguGhSGa5WQfb69qr
    BFEjwxaXe3MR5fgK545zPkZwvszAzJghZPDGCBVlFCKW/jlw1i8/Ic8HMwuA03qS1GM85U
    EGtbQ0AJbMHuutWiFkW05EJG+mg3ScEW9OAhHC+R+nsEycRGcIdoprxlUJPQ
X-ME-Proxy: <xmx:mFCtam1GNF2oCaaDL3ivfWcjaOCZQawsaZbqBQaSCV0nvrwueFx4NA>
    <xmx:mFCtav9lZYNw5vbyND_BUHSeD5MhAJjDS658XE3srFk2TGVB2BNmsw>
    <xmx:mFCtar0IdT_NIVDwpOQaUrAhd7OkxndepRh87tm8u-1My7J6PmFkHA>
    <xmx:mFCtak-QvYyU2TjO7dF8ZgeWnn6UA9xEYhCLMC6b-rgR6AZJme51Hg>
    <xmx:mFCtarfrETZCHn6O1h8RiYpSzpClYtytd3kddjJjonlYGTrH-etRS9dM>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 10:54:16 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 10:54:15 -0400
Message-Id: <DLIJ195ABVQL.3OD6QX7D3VNBE@fastmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] Update t/t4001-diff-rename.sh to modern style.
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20260917195436.1102981-1-markchucarroll@fastmail.com>
 <20260917195436.1102981-2-markchucarroll@fastmail.com>
 <xmqqjyojowzo.fsf@gitster.g>
In-Reply-To: <xmqqjyojowzo.fsf@gitster.g>

On Fri Sep 18, 2026 at 3:10 AM EDT, Junio C Hamano wrote:
> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
>
>> Subject: Re: [PATCH v3 1/3] Update t/t4001-diff-rename.sh to modern styl=
e.
>
> Documentation/SubmittingPatches::[[summary-section]]
>
> Perhaps
>
>     Subject: [PATCH v3 1/3] t4001: modernize

Good suggestion, thanks.

>
>> Old tests were written in a different style than modern
>> ones; for better readability and test error messages,
>> update t4001 to the modern style.
>
> That is a laudable goal, but enumerate the rules you followed to
> achieve that goal.  For example, a few of them may have been
>
>  * Run everything inside test_expect_success block.
>
>  * Write the title on the same line as test_expect_success and end
>    that line with a singul quote that opens the body of the test; a
>    line with a sole single quote then closes the body.
>
>
>> Signed-off-by: Mark C. Chu-Carroll <markchucarroll@fastmail.com>
>> ---
>
>> -test_expect_success 'setup' '
>> +initial_setup () {
>
> Why a shell function that is called only once by a test titled "Diff
> shows path0 ..." below?  It is customary to perform the setup in the
> very first test_expect_success whose title is 'setup'.  I doubt it
> would contribute to better readability to change that.

I went back and forth on that in terms of readability. I'll switch
it back.

>
>> -test_expect_success 'test diff.renames=3Dtrue' '
>> +test_expect_success 'With diff.renames=3Dtrue, patch includes rename of=
 path0 to path1' '
>> -test_expect_success 'test diff.renames=3Dfalse' '
>> +test_expect_success 'With diff.renames=3Dfalse, patch does not include =
rename' '
>> ...
>> =20
>> -test_expect_success 'favour same basenames even with minor differences'=
 '
>> +test_expect_success 'rename logic favours same basenames even with mino=
r differences' '
>
> Here you are failing to follow your own renaming rules to start test
> titles in uppercase letters.  I personally wouldn't have chosen to
> upcase many of them; rather, the majority of tests in this file seem
> to be named in lowercase so I would have instead made sure I'd start
> them in lowercase as well.  In any case, please be consistent.

Good eye - I didn't even see that.

>> -test_expect_success 'rename pretty print with common prefix' '
>> +test_expect_success 'rename pretty prints paths with common prefix' '
>
> Meh.
>
> Neither way, it is grammatical at all 'rename' may not be plural, so
> the verb 'print' may want 's' for third-person-singular, but it does
> not make sense to use 'rename' as the subject for "pretty-print"
> anyway.  It is not that 'rename' is the one that prints something.
>

I'll try to come up with something better.

Thanks for the review! I'll send an update later today.

         -Mark


--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

