Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A84D90BF
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448975; cv=none; b=erSy6InOsHK68k4fSm6BpMGngROAR5enttB1IHMMBCKIZ5X8PSyNHX24KzEbD+p7KBDbaXjkIPsM0xeQZ5Xy7OVrw7VZIvO5t27nxz23CfhqZNvFsvmDFxWObMfhxNrF8U+MxXh18WrKZiZW4/R4Xg5daSqvPxm0nbjiD6yltCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448975; c=relaxed/simple;
	bh=L449m/V5fiyzGxhckziANHZEEOgsZjpQwZCdMj/OMrc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=L+BSdfuuK2LjNfSN3whD7d/CUIj5bwOX3wwsfKRNDj2I29G0nuyJb16E/kY0vKBL9x7sPuzRxT5QogIduR4NNv/XjvrdPR5xdGyIpy8RSKhffDCSJFHNlqpW31EjNjCWKftiYMmqvvANtM5nWJ79w7Zayubgi3PS7YPDvkLvjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LOpLEDYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1VEJ61i; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LOpLEDYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1VEJ61i"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id F11AEEC02C8;
	Thu,  3 Sep 2026 11:22:51 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 03 Sep 2026 11:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788448971;
	 x=1788535371; bh=LMWMFKPW25jXpug+zTA/jp3y5ASWQWb1i9aj+6KsiiY=; b=
	LOpLEDYY3l82gbldCd9K05YDlNRRD8nKM05EZW50TDw6RoR0coMtyGAcqlnnf6lC
	XNgV4i0vk7KJn5bUaZv4V2QzmzUa5dN8O0k97hji2I3o7sAOs3GqzupWpDdNEvlW
	UNcKx2zShF0EGCyxIxAxcJ9gitjcK9iRH3j777dvCo3fFK8NhzKggpkuAmsXiBkj
	tkbCIGqMWas2J9CNX7Vbbo1ccj29j15Co+BGnnSKoAPGLz3hNgfLBXbXZtjBOWGC
	OAbk6iKC7itlHnKtrWpT6b8O+uc4ZyOu7CDlzttf6+q4YUsJTDigfEJOy99z9Z8F
	pcAjyhpyPob/VyCzuF9ejA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788448971; x=
	1788535371; bh=LMWMFKPW25jXpug+zTA/jp3y5ASWQWb1i9aj+6KsiiY=; b=g
	1VEJ61iC0wnmuy9nFmr5srMNQ4Ys+GZIikuQLdG9gRIqfV0ySysfdFxU0datK3Jf
	SgL7jhzi8Q2OPuv9Rg5KP+JocAAs1twMnO2+4YBs+siHk+kcwaE0HeCO0+qZqaey
	6KjdxjuLly0v7cmHswe3FlyKF7Kry02PO6m6V2Hnu56itf4Wto/ir30TYPawe8S9
	WELbUdm8i9iSU7d1bZi0FvQ1k0NYmMzBzNB6q/+ZwTbRIXOzBKu8P8vsu8Fx/Q6k
	HJytGnd/4M+SRB6h8AHf27LAb1q0YJ5+gMGp1EQ0115vz2q5lLKP883tWpoQQN8O
	1Qp7eAsqaQoLQHLcVK7DQ==
X-ME-Sender: <xms:yZCZaihE04c2kbbl1UoeUAknXj6HObmGSfoAfaMrtf-5xjNgN-91NbA>
    <xme:yZCZat3IngSj32lNEeEhHDg-WY0XOS5-y1-kCW-Yt0qfXYLBsRtDTCa5qspAWXgh5
    L4MJ66zYVzgsQIRRpDIGAhAymgUM78mfj9gOWYuTCr16JoQMHMzHxk>
X-ME-Proxy-Cause: dmFkZTFwLcCwBNj69gPzBmDsIqqjGXDrqCXAmQc9dp/yrK/bX6Fj6fdImewkTge1ZriKSG
    k2e3IfhYVVFq6geDb3Y0+LUNp2An9yZH0JkxPEYQvg8dyzu7HAbJ6vz1Hgd6aQbVsnHXRa
    fxBg4MT6ZRp+pdfj7+5oywRA/McSnF6/hOqTPT6gpAUJoWm7K1UPudozqm+Xc8e71/6gT5
    8Fu9Br5Q4Vr2bBsH1b8ZMSegD002v2NJo1jRXDnijci8OHUdOuIg39DkdWvLbz7NlA7EqA
    yU+2VL09IRIChjclxMujVYmX2TJJ0mmy12bT7iKmRnEAV2RlO+GL5wLbuuZgXNnhXALIT9
    Hj0CL6aBVrxFSrivaOjSIeE4tp1AAIYv+WSyKg6VKeEUUYtAAu3Xip7iO0OX3VQrbxVywF
    XsTymUzTvwhPGAr2gmECjbg+g44CwrbDDbf7/lju/sBnyhx1QjI7z8xthb6H8fUpCwnUQk
    z/PNmWHSBGAjzpP0ox+O9bP2QJ699JnMTA3/zZ+GVTKFa7SzAf7dHeVA4jQVU2qeEK++Ok
    bcKWakTZjDVgd3RYk5Ign/xiMQ7lDKCAxLe/miEVRnpgTwVLYuk0EU7h50ohpU7b2z9TaO
    8EXc0ZWDP4Kn6NVRKXgnVfYNdVM9hK4LpcCvL5s2CqlWoNHApI15+lhqmZpw
X-ME-Proxy: <xmx:ypCZaj9aft0ZcLWksO-DnfiHx1iitS2s2eDgbKjRqtHJJOb45_zlmw>
    <xmx:ypCZaneKv5BI6Y75appWxojISVSfBc1RdmtWQGBD-oK51J07cXs_fw>
    <xmx:ypCZakFaCvo6RL3v-Vt4vBBvDbwSpiXQwUwc7kU8cmUeT7vZHm1ISQ>
    <xmx:ypCZatdU_F8JCW7YwLZ9Ktb6eKjDYARpV6dXVr3EGdfr1mWlDfNZUw>
    <xmx:y5CZaubZYG5qUYW-x_FMrR5U6g2bFknPAbySVUWDhm8atB4jZY2GWd-h>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 708A522C0080; Thu,  3 Sep 2026 11:22:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA0Zomq0_rWw
Date: Thu, 03 Sep 2026 17:22:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <ca525be2-2cb0-4f0d-ad41-a6bebcf87e4c@app.fastmail.com>
In-Reply-To: <EBCF44E8-9952-454F-A164-0B7CF273FB30@gmail.com>
References: <xmqqse40ei5f.fsf@gitster.g>
 <EBCF44E8-9952-454F-A164-0B7CF273FB30@gmail.com>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026, at 17:07, Ben Knoble wrote:
>> Le 26 ao=C3=BBt 2026 =C3=A0 16:33, Junio C Hamano <gitster@pobox.com>=
 a =C3=A9crit :
>>
>> =EF=BB=BFkristofferhaugsbakk@fastmail.com writes:
>>>[snip]
>>
>> Nobody is interested in reviewing these patches?  They looked more
>> or less OKish to me, but I am not the best person to review this
>> series, as I do not see much point in this experimental command.
>> It would be nice to see reviews from those who are more invested
>> in seeing the command work better than I am.
>>
>> Thanks.
>
> Reviewing these are on my list. They=E2=80=99ve been there for a while,
> now, though, and no promises on timing :/ my personal priorities
> shifted rather quickly for the weekend with the recent 1Password
> announcement ://
>
> PS hopefully this wrapping is better from my mobile device,
> I=E2=80=99m guessing at the width to hard-break as roughly 1.3 screen =
lines :)

I appreciate it=E2=80=94thank you!
