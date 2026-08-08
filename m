Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5292D7BF
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219325; cv=none; b=CcaHh6S0CemM+TPk2LlRtTfL+G+ndneS7imQc1E7Wso3D7pwG/4IkovVRuIgUG4JkI36J1qEunJkGmIjGLI39vpuSrqjFhLh2xnt35vhxNNKdGDORwd4/Lle4seXSCA3NI49MbR30t5ebc02GtY2BhEz9XVsWSx0hqRzD0ABGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219325; c=relaxed/simple;
	bh=kKrCK2z2QML1EiGCgWhxmGK0OyMWHI7S9Ksqp23XeBc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CInP5ohydzS/p1E4s+rhVu1NCUBkhrCYAL38OSRAqeRNm3zhjCCBPNE50ZlH4TAtVCE21IG6+FNQOHANwYX44ldWDJ2ujtggSEOy9tsvDfIuFG6lDf3i9ys2Q1lS+nalyX47S1v7b8uzsmIh+ldfzv+jomI2bqcsFnIab5tSyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V8ESNxBm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ef4FYBqi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V8ESNxBm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ef4FYBqi"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 741B3EC00A4;
	Sat,  8 Aug 2026 16:02:02 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 08 Aug 2026 16:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786219321;
	 x=1786305721; bh=kKrCK2z2QML1EiGCgWhxmGK0OyMWHI7S9Ksqp23XeBc=; b=
	V8ESNxBmpFxRESFc4QAvWsSBHWSjh4pRzpOPBa0uGHQ0YEZT33nm42OOozmI/oAD
	hpfXmRQSuLy6ZKgs9C3ZaR4Qk7X1/oTnjTV38Jm/SCNO8MYkslL1NZ8KGIVZPzPo
	3ecqRk422uLOhrIbmAdSglmnNRAAtPHWF11DhW+WipG04tCupgrGkVKj4iWP7NXk
	HNZq65LsuNIUxve2Wl1TJojXprveAK7vtTtcJmXrlUxOtTzLlezs0bMOWA7ErXh9
	NH647WUnHi/o2LVZjgavRHUas7pjfOjEnbgQSwoOrVG3KEmB9DnMV9daVBqFSoog
	zEc1V6H/B69lEumAL9cPsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786219321; x=
	1786305721; bh=kKrCK2z2QML1EiGCgWhxmGK0OyMWHI7S9Ksqp23XeBc=; b=e
	f4FYBqii/68U1PMUJjk+w4P2iixY0REIOihA+P9r58Bn/xYUQ16TS6f9HWrn0eQL
	zTMCk5z78dbcW7fg+i/DCQT5nF61agA2E7X02ORsqr/QZlOHLoQXMIoeJ0rOfvOJ
	PrUkCH7dXPM/QOg4Bo2ZO2Os5+/KAXlnG4XF9W/GOqCayL5kBg2IjH98Zq7Ticq2
	xVl6pidiIZLdoQed3X06qMD+Ckq5L99K1S4TuDNSVLlBFAFX+fWarO98BT30ON+E
	j1etnmWe2NoMzu5kDF+g/LC8HXA7cAHXuZTYa30xmyN9iNg/QPCF4W/Q7QxQd1ly
	Ls5y+v2NbW1sfknMIQisw==
X-ME-Sender: <xms:NYt3arKOSIx4o5lB59NG9QViXocsuNfVYozdsWT5sYC94b8bfFBTaW0>
    <xme:NYt3ap-Bv65qo9-yVK68kFB0fEXcAhfdzvQyW1MFs4ivVac_HDVfkweRf4FtkZgt6
    6srpHjktc4rlYv3VmSPgOtsz8g1Lu1i9Qf2yl6mnmgRHOuvFMlmzj8>
X-ME-Proxy-Cause: dmFkZTF4fK/f8ZUblzg1CA2KDOBaVaWbxmSfpEE1A8yMVx7Fz38ULlWgLsOvUZZEgmelGe
    UN3twzgD8dKU68oqAe6lTdLXp0JRjdPFTTZEAFVamJhiUhQItn3SDJEkOLzroB18qrjlX6
    NPE4PKdferbRiIanHrjruZl3Rsu+vQT+IEEvHDPDlZAtbVd41xd43VdG1G/IenY1kM53IJ
    mizRWYALEmJ6EmQatbyjrTbbJaCn894Se8NhnP0ujFs9SAXm7ANGkozQ6DaWcWSCN1GeNz
    Mi1e5sE9sL6bS3Ldy8xjRcr78DrtW2zaCfl4BrpHHm6SAUhpnqKki53RiIUXfFRe7fpgi0
    IduSvH472hf4tYLkiQyxQJ9Cg4JCxCKqx4NoBrFJVfWa6adnq6RcDscfcePYekI8M5r2P7
    L/UN4qXDnZ2I0Le3uggtRZVF89JkIksGsPxhk9URqx9+8V8xQZYaUY6QK40Oas3ZVp0I8h
    24Cnfi1av+bEXR6uFST3yc3X89GW/P786uj/G4+YAZ2a9XoWFEVqhrZWrs2LRfaHVuJzqI
    r3kzvaZTJivIRP0w6B5YDY/KsLihc87N7y/3ME601txZMIoLQXx5Rfrq0VU2hnuF2mETIm
    xSCF8kNHYK8r+O610XUucbIBeXdIT+/oW3wNLYoe71XPdsyAWdB2cMXjeX/Q
X-ME-Proxy: <xmx:N4t3avBehsU9bEN0hrU59_So-evPDq8ceLHf9CLdCrcMHxJM6n7pQA>
    <xmx:N4t3amN6cQd2o4qtg9J0ih_MhTFMJqds2aVrCvjJbkgT8mTrk0u8hw>
    <xmx:N4t3aoziPhSKkf0AMFyAwPbzpKzW7CwyVLKA8VWu1BH03prwVnrSrA>
    <xmx:N4t3amWdrbH5Sz9zSW3aKUyQ7U2IFWP5lpvKHqbig3viaZGRHOezfg>
    <xmx:OYt3ao4RlsFs75v1m5sco9TIoUSnIog9fThLEG6CSl8rAv_oja2KGzue>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 913EC22C006F; Sat,  8 Aug 2026 16:01:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Sat, 08 Aug 2026 22:01:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "Matt Hunter" <m@lfurio.us>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <9422d16f-0bf5-42be-9248-38fd3d0f7b1b@app.fastmail.com>
In-Reply-To: 
 <CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V4_CV_doc_int-tr_key_format.ae2@msgid.xyz>
 <CALnO6CAmM4r2uiuBFJcciR_94KPRSJoCOsuNKeqTQ0Bt=Puvyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026, at 13:55, D. Ben Knoble wrote:
> Hi Kristoffer,
>
> Apologies for not returning to this for a while! I haven't read the
> whole v4 in detail, but I reviewed the final diff and output.

Your reviews, in whatever timeframe, are very much appreciated.

> On Thu, Jul 30, 2026 at 5:18=E2=80=AFAM <kristofferhaugsbakk@fastmail.=
com> wrote:
>>[snip]
>
> A few places we use an inline list syntax ("=E2=80=A6 (i) stuff =E2=80=
=A6 (ii) more
> stuff =E2=80=A6"). In the added example about ASCII trailers it is use=
ful
> because we make reference to (ii); in the initial part of the manual,
> I don't see any references to the delimited items, so I'm not sure if
> it's worth numbering them.

I did adopt that Roman numeral inline list style for the example based
on the existing one.

I=E2=80=99ve always read it as a stylistic choice. So not for the abilit=
y to
reference them. You have that ability, but I have the impression that
most inline lists like that are not used to reference back to the item.

This existing inline list goes back long before this series. Changing it
would mean adding another change to an already long series. And I=E2=80=99=
m not
sure that it should be changed in the first place. So for now at least I
am not going to pick up on this topic.

I will wait at least a day for any more comments and post a new version
with that fix to the commit message.

>
>[snip]
