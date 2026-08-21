Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AFD47CA6E
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787330568; cv=none; b=Zn+l8omVASPbJF0B97Ef5C+OfjGw3PdjO+hVYGQc7I0+yfTLQJN0e86Hb2M9reCLoEAe927mGcuAL+rcHSlj/y2ny8ccQnARF8MfpSy21UtXWyDu40VLLo+PxkkCwA42La5bEZ0BZfgTR3J3IX6w0pj4dxqQlly7kRDsAVNd5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787330568; c=relaxed/simple;
	bh=nw/Fs8eQngkdZ6BWWTJwvaYZB+kB9XsqcvpX2V6u78g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=USBDW/hLsZDx2+0i2a98osa+eTUsjrq1Le/Du0uUs3WtMlRPVWJ/Qb6qK603UOk10vvEmYLpGWTY5HuWWViP0hll5bVua3lc6Dx51La4cI9xlfRAWH4UxbphuUf0zKnJtyN1Cfp+feXzGLtS7OQcAGZ5Zcwa/0QlTA4VFw7l/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ku/71p3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXZn0q4Y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ku/71p3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXZn0q4Y"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B43E47A0038;
	Fri, 21 Aug 2026 12:42:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 12:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787330563; x=1787416963; bh=kuEu2uv61y
	0sbydTqZ1/qLv0Xsfbh7A9cGMQoc7BWTo=; b=ku/71p3jmvITSLJXxD7W6kbdfl
	ar0R91ZR4e4Y+rXJC95Jf0B9s2P5VEnXh8OObLzIenvWmo6yHw8Px0cSVbqd+0bn
	QBcrLJjpXHVHE4rJKodFnC1aoZlbz76ipYx7XLPuM7zH252Uqq8ahgDoUPmPAQvj
	BisxhAQG/GJwqZ4uKfzv2iUuJbwsa5dM+io14Ck7uN85fu+G7sm8wYuYFvvFveaW
	O8eXi92F1Nrg2XwedOaZyPx++bIo5FX/3tTYOCPflSolklpghOE23kVeHMqodaZx
	hnAzxZM7cAJqJC7489x3f9j1Ghce66BOgSkRfL/3265M7U5PdT6y5XAdzxYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787330563; x=1787416963; bh=kuEu2uv61y0sbydTqZ1/qLv0Xsfbh7A9cGM
	Qoc7BWTo=; b=RXZn0q4YOk4AafZ6ktaQQAGCPZsE8r92zTANlHWic/Tr4W+PIuX
	/C1g8f8jQSm/CqkDimdI9a8iI3ly2DJIh2IMfOe+rflsHj2JQiTEvtf+aBqP1gmA
	a47xr4T4L8cPo9pjzSWlN3KZro66DmvqaG5esy2QN2nfKl9+L/2iV2eizkbgszYz
	mJjk/slN4Tg7RcKvbzcINSZfo2TZi1VY8SOVyygWhW5MYOudqOGEYlWvjs6klOe9
	KAft1EawghUFaV5z36p+YsOM6Zfifvs6glSXA9KQkxuThbd+xA01uPvBQCgaIkfg
	dcSvQjO1P1PLUCxN34JYBxD+alWBmOXvS0g==
X-ME-Sender: <xms:A4CIahkvR9_7zB8I8oKZwaEOJg-hRdZFokBbK9O0vI4Ryvyl4gGjuw>
    <xme:A4CIajtq2DlpRF9RZNQ7Jx7cIhlp9aaNe0zBSNgMasP4kvPDaSwrg-oah7IHW9RZD
    qI--YboGloEu6SYpw6yDH2sZjyaHnAgUrKhyl-gOgaeW12NQ06SF_A>
X-ME-Received: <xmr:A4CIav_PDMxXZYtgooEgJQwuxBhla-xt9klyoxbHj0NztS4OJRBrgDFjo7uU1NnEuuAf1B7n7AmL2jXvZasBjLwND0jzJiREJw>
X-ME-Proxy-Cause: dmFkZTF9/eJQys3egyAQvlLiA2crUJB4rTMP6xNRGkeIPZTZhfly0WgtNrda1n7NkCh33l
    fgNTefXHdQHouMwvWqencWm1JHX5sI1fkgBawWpny/w6/4vTHLPsb9crXypBEKAk0S/4ka
    pM+UwC06GfxUooTD9PuYQcvw2owkHip3une8nWj4VrEIkARFmgKrjzOyZQYdrWdIi0l0g8
    VxlZgX/fdCMFyi3FCTnNwsjeuBbg3nrsBRSpV2ExYb/XDGxHGHjob8x/8jYlHUHiWoogna
    rrYxTUjD2tq2q37tVS7ICcUhH4mrXATv79H51Rh7C0HX2/cx61pxibTUZtgmh5FZmsBVBC
    T2MvSIAYXFVB10bDvnS/kycGa8DrGaigRDsYdg2Yrf1G4qAfFhstJrlsrt2aaZ99KcoCwg
    tfdzrdq77Lql5xCCdaAynNy9hreFBE6WYSEH3aCWcRzHZh6SYCYZwZ1RAvinZ/Qi091dVP
    ts2K/THtSaAt6mM9MJPQAkEa8iyr11xFDGLS66ahBiIfLW9Cw2uxmlPsmnjbfX1/CdsT+I
    elobyyEHOZ71pogkBZLVeCBKwM1cAlaAKSMZwc+pm5FiMq6SJsb6CEArqHSNzrRG2RkhUb
    ShCzYD0Cdy6S+NTdmvdAMEF+sNvr9tdQ2CooMecLw5cUplFxBZX0qvpnF2wg
X-ME-Proxy: <xmx:A4CIatPTCMtzaBJJ9EmWYeRGOXk8MFCVsIkRFsaHlSNgjHy3zxWlFw>
    <xmx:A4CIatF_q9YNEZw7aF5EDAKsddqj4TuSQqJQPIDpXwZTdPKrXou5-w>
    <xmx:A4CIarSLg5IaP5wxCBLAgE4DRLxrx_EUUQi5xEizCqRDResm1QonOQ>
    <xmx:A4CIaqt7r8mcMKa_9cLhOvpOZPagIShNYGCDeq9EaWG3_DHug5t61w>
    <xmx:A4CIascbVFxjXTKLl5EKAPE5KnysCIwB2u24Vb4_bd1dzo6p0nj7St-1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 12:42:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Lutz Lengemann via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lutz Lengemann <lutz@lengemann.net>
Subject: Re: [PATCH v2] completion: zsh: support completion after "git -C
 <path>"
In-Reply-To: <CALnO6CCr+CMhB6Pxo7KHExcJ7PBcEQODEJa_PmfguCr_WYVS+A@mail.gmail.com>
	(D. Ben Knoble's message of "Fri, 21 Aug 2026 08:31:46 -0400")
References: <pull.2155.git.1781710256081.gitgitgadget@gmail.com>
	<pull.2155.v2.git.1787144872870.gitgitgadget@gmail.com>
	<CALnO6CC35iuyJpKZtkEN7fGuGK7zKd_jbebyZdKSQ1pyfOBRZA@mail.gmail.com>
	<xmqqo6ewtqs8.fsf@gitster.g>
	<CALnO6CCr+CMhB6Pxo7KHExcJ7PBcEQODEJa_PmfguCr_WYVS+A@mail.gmail.com>
Date: Fri, 21 Aug 2026 09:42:38 -0700
Message-ID: <xmqq5x13qvb5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> [Footnote]
>>
>> * Look for case_clause in
>>   https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html
>>   and read from there.
>
> Oh, thanks! The Bash manual doesn't admit that case in my reading, but
> it clearly does in implementation. Oddly, I seem to recall several
> years ago that both Bash and ShellCheck would complain about empty
> case arms (I got in the habit of writing ": continue" as a bit of a
> comment). Anyway, TIL.

I am afraid that the description in POSIX itself contributes heavily
to this common misconception.

Section 2.9.4.3 (Case Conditional Construct)

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_09_04_05

gives a simplified syntax

    The format for the case construct is as follows:

    case word in
        [[(] pattern[ | pattern] ... ) compound-list terminator] ...
        [[(] pattern[ | pattern] ... ) compound-list]
    esac

and I think that is where the most people go to learn what is and
what is not kosher in the standard.  But as you saw, this simplified
"format" contradicts what the actual grammar, described in Section
2.10 (Shell Grammar) has (notably, you can have linebreak, which is
defined to be zero or more NEWLINEs, instead of compound-list
there).

https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_10
