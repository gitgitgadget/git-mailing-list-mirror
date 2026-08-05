Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDE3EE1E3
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921223; cv=none; b=n4lCYzeoI6NP3doMOMzpF2AqLEHe40rZdwj0xwIHe1Iz4wJonybC8kL+SNqBCx+kBjdc+Cv5fGRh8MNAZEMyS4yHBUnr37PgWDehNzYJ3ENlr84KfAzAKF1VlDznhBmA47MHShlTXcvqT8iEHCSvFcLuJSex4H+6mRqnZkXaNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921223; c=relaxed/simple;
	bh=OKeIoGkWVMr4WXOCpyAbibm3C94gxJVpfXjDytBC7M8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ART30MZR2pD9gh0LM6oqe55YIOdrD3vTG/O7NQsUh8Ng5eQVucRGQCWQz1nJuVT9+y6n1lXJC9EXc47BdmIO4WrhCDv3+UIh9MATiAnr3ThVx3yim7cP+SYAwMN8PEmf8E0kgQd1bQSvhiJ4+VzbX7D1D3khesoHb6GJgS5wyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hOGarTZh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huDi9JTH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hOGarTZh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huDi9JTH"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 66E52EC0094;
	Wed,  5 Aug 2026 05:13:40 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 05 Aug 2026 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785921219;
	 x=1786007619; bh=OKeIoGkWVMr4WXOCpyAbibm3C94gxJVpfXjDytBC7M8=; b=
	hOGarTZhRz25DfpqGpoFxedNqf+IlCunewrHVOL15j4EhkayOP4DuvMsq+zkcr/U
	xtJbMvLAsmlvsjcfshW/33wr95O6FtI6NjssmBufTt1iQU83hAAG6i8O9ZJv0ttH
	b4lO1AKVDmNmxFUNYmp2HAH/0TS1RDJxV9BOI4ZHx7xpYhAnUkV1zjKgCOBJNx9a
	I8znU+b357dgrgCeIAPvFezMS3EL/4StmwdMHeUATSmuuqow8ESut4k9lJ4wwqRj
	RQ/4grfO52+TppL8UmPwXaz3jCx3BXa0IKYIP0g4PIYz9Co6wjZPq7l9HADWB/Xu
	wZMi2R3sGrTb5z6s8ZC71w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785921219; x=
	1786007619; bh=OKeIoGkWVMr4WXOCpyAbibm3C94gxJVpfXjDytBC7M8=; b=h
	uDi9JTHwtpFlxT8VBEogunJJdwEOqEE01du5QSdsi4veXSXcBLPTXXlJp87w3X0U
	ea+/FaU0a0WN0oMHWYDjOJnAl1d0ERd65h4LQKLWNNzlGgzGH0Iz6svGcoFFhtyp
	iUWSTdKlWZupTb5EPOfj9T0Fiv+Eid4q8qZ8Mqdk/U7ouvJqsy12ltoeK7/fZb6R
	WUSwyqrYUz1gscxrWhP0tRIe7p6paNt/XVBAm/KLT/Fs+VMon9ElPOUS8k5ida8G
	Z6YPrLW7C5vPfGNO4nSCDCx80glIkYuXOl7VKfEsUBvNyY2JScxiYzM1tzAgT/Sg
	wBE9+JVuU4Y9cZtYzeFhQ==
X-ME-Sender: <xms:wP5yapvRyG3Gam-bKAwdHz7Mbmr5xHzx7h50wBjwBl1FNcnxZULfcLo>
    <xme:wP5yatRURatzI5WEuDxoZIAvbDnDB6Ww8HfxtBWycwlEROJccG5R9AIKf7I9Pb98m
    eI56pndD1-g1X75GTdIqWEdrEz9FPjFjEsmmaqHDWYixPR65gKl7kI>
X-ME-Proxy-Cause: dmFkZTGbomfYV9WaY3kSR1Gq6iI/JzQOBrY3QoPwyNBzs4RwB3R6LM/ORoq/R0LE7CEfrc
    yluorW89GD9L/h/Tk8OfG7g/5AR85ZXZeXG1kIUZBSK8wiGvnfV0tgRTmunS8vMMYr3tbf
    62iLNhgMmySG/k4kWYxXVE45Qlsj/OYYqe0P7vhnEPNWxYKKLKVzCHE4v8bp67l/UJiY9K
    t288LbEhwo8WWJ93f2Do3fQFk1jEo/tYICGFGaBBRAwUehdBOxfk3YVzg3EE2iFFNcabsV
    TIAWwums4Qt1mVsfBzGs7M6U8hipuKeS09wgp3z04LWiHcarmbbmdcsg/DBIyUf8roKZDv
    m8ksgBcjZ2lqPUbb04utQ61IKR+YqaYZvxZS9YKCUd64OlD7HaZGF0GULhoMFC5lqYX9jk
    o8Lt38kdLsMNPh+KaW9PumXJvb9q7r+hT4kE1oKgPA6Y0d29rYk/bS4htQ+5NVHgTJmxkN
    4MqUfHyFg4tiQOVkUKvcuiDXCQgJgoLiCsCLNf99kuiBe2pKFD5xZqaByHpQWqdgmYCIZi
    3H630WC6LWZNIsF3T1GAz2mPLsZcApc8o6ht3fGT0aVLp/br3FPwPK3NG253sP424zHeBT
    WnrUqYCwahm36Kp8EPKgNrtd6OvliCyFVFmJRKVJXP/reYA4JndYdJWfFIjg
X-ME-Proxy: <xmx:wv5yahXlxt_8ADjfjKNN0liDOOfyb7C7ogRXbSmzkXiU69iDTLajww>
    <xmx:wv5yavZ1_DemGFBOgb07M2bPuFzFYx3qlSgdiy71D38aUoC_LBbf7g>
    <xmx:wv5yan1zgmigSpSbpK8xWEBQItO1bweTRUTOUYV8iXFiCxXZHucx0A>
    <xmx:wv5yahjIH98U8BXX4pkNhIRSqdNI5nap4AQEk2KRUiuUzC9wd9Vheg>
    <xmx:w_5yajpZE3ZvXfN8x9rZRQeSsGqryxzUHMjaMeJlYpKDZRog_hbntaI->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5AF6A22C0061; Wed,  5 Aug 2026 05:13:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AU0jXUOk-qtB
Date: Wed, 05 Aug 2026 11:13:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <ef423f09-11dd-452b-9459-1baf017cde6f@app.fastmail.com>
In-Reply-To: <anLvVAyckm7S9Vo0@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <ref_migration_warning.b0a@msgid.xyz> <anH3k9PvWHMpWLT_@pks.im>
 <7f34d9b6-de00-44c5-a59c-11f154e7a64a@app.fastmail.com>
 <anLvVAyckm7S9Vo0@pks.im>
Subject: Re: [PATCH 1/2] doc: refs: put ref migration warning under the command
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026, at 10:07, Patrick Steinhardt wrote:
> On Tue, Aug 04, 2026 at 09:09:25PM +0200, Kristoffer Haugsbakk wrote:
>[snip]
>> By the way, I think I looked at the AsciiDoc admonition reference[1] =
and
>> saw `CAUTION` and `WARNING`, but now I don=E2=80=99t recall why I cho=
se Caution
>> over Warning.
>>
>> =F0=9F=94=97 1: https://docs.asciidoctor.org/asciidoc/latest/blocks/a=
dmonitions/
>
> Hm, interesting. According to the docs, WARNING is to instruct the user
> of any lingering danger, whereas CAUTION asks them to act carefully. A=
nd
> while the first bullet point is merely a limitation (we cannot migrate
> worktrees), the second bullet point is indeed a warning that concurrent
> writers may cause harm. So going by that I think that a WARNING would
> indeed be a better fit.

Thanks. I=E2=80=99ll use Warning in the next version.
