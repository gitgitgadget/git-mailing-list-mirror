Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C153A75BB
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643049; cv=none; b=ZqHIlbIO3VN+VMEaPCXY2kdfLBZWIKaaaPKeqC1f/xetI+l3ykecmQuVXBeP+VoDKWMQ34H50AXO/xaZyF2dneWEqr4ygoQEHBXpJUhbo1JqOeasfjX1aoCAYeIXccmjnywttcbP/rndl7k5UKP49zujqaDhvAqnck53KU10iok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643049; c=relaxed/simple;
	bh=raXH3rUIAe9Tbob3ulz32ZB+F7xHyNtORHaz3hvha5A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HEDsVFm/gNzcuuzkFZT8b/T7TljU2A2+cbSjyPvF5T3jGf19gsjEL8Lo8dty7NVi5wph2knO6b8vVc3yxjQ153SoDvqXV4RsdrdNUPTCa0+2Xo8n2B5+aaJk6AAGP8yXkCtnhz/zpr2+eVjmDpgVx/6TImYhFNsPylXdei03GIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CySC7y6p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bxPrkoMC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CySC7y6p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bxPrkoMC"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id BF6F0EC003D;
	Thu, 13 Aug 2026 13:44:06 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 13 Aug 2026 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786643046;
	 x=1786729446; bh=h656gARCU+o8T7GCcdTHs98oxyN72S3yEkE1QZeCacU=; b=
	CySC7y6pPE6V0amyvYBJeDjruDaj8zf3TMs+yBQAkUvxrUe+SWSnJRHTBCjmz1+b
	jo1j7dkjdlprtuCFanIJ3/OUgaLHvwqIeNNIil3w290Dmb43KFNGCF4tO0UBcVAt
	qBbUN3W8eAcXXN1g9qRihrJRueQbDAsAMZ1cKxgEYCGdY+ZJrsqKWVeq+mGiX0Ym
	vfnd4nTTMjvdrL3TOWYdVt+z8xA8nHRC4h5AH0FR3FpMSRmzYjZRO7VZjR2wSGEE
	WwVJzRQqqvnmhkU5MGQ5cANjotBvBUPEGjAaYg01sA5wJ40Ylnl+26x8wR5CjG+H
	nuqh8nD7RpNjJzDOdnQCRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786643046; x=
	1786729446; bh=h656gARCU+o8T7GCcdTHs98oxyN72S3yEkE1QZeCacU=; b=b
	xPrkoMC4dYm7n/Dfg8paBxMyr8Qt8JqWxskB9Z2Hf4hvE9AZnj8RwyGMP4FG6Vc0
	6f3Nw95GeSfxQT7yZlRL+rOjFHdBhfYfx0t3fM85SHLsVUcvMR2PebkCS75y0GlE
	cBACXqIyYy98hFrUxMmwu/CS/Q5zBsiAMuE/71n+QPAKGHx1VPjwSTtvj7FhjO0j
	Cw+/Lm4FDVPNjq7qVWEoaD0dB+SjVHtdSVg+Xw/HaMqEQy4hY5MnlL2KmUC3c73R
	V/HmVZhm8jDoVbPlJySMfKxX0ziPuEgjB49J4WwMc3l/TXgjTU2y1CMCTw17tZhz
	wKuRgnu+OIIH0ITY4G+Bg==
X-ME-Sender: <xms:YgJ-ainRQ-WEJsvWW0EhIamX9gsVXJ_4b46TS2kytsymjTPf3sG6C7w>
    <xme:YgJ-akq4Jcch4yOvYYdbAz5kBiGiqIX5Z4Peu-s5S1JObBoZSdh-AYgtia6nhC9Zh
    StQQ3D8GsKWFC5xurJbVC87O3j0IXwwnb-KhwkbV_YRVkWeea-86Lw>
X-ME-Proxy-Cause: dmFkZTF5WPs452RTKuBq1m9P+5ACqCMyW0b6nCLAeUfwvMYjxHthmqc6Qy/CqIYNa2DjZD
    sWoOGWhwWyjJhjgrtFIuLVyxvzZctEIxciNLn5F7H2jwNkDWzgGDf/sq4KKEor0utt6xRT
    yNrVhJ70IZmLCiE9PSjeqzfB7sp+Cs0GDS4v8U5eBAKnk5hoN/deOIE7lDXUjBx2Oh/Yb/
    yVmfWnpwgKss0/ZjF2BNbDO1Iu60hd2srrHATKJq4K137ccKGKVlVTzxZlVwHl1ZCwE2aV
    7KnKQ9LTwxdhdaCA4fXDwM7aha/fVqQBcjG1ln1KI9y+XmkZet2m8wlNSZuYS4UeSScOU/
    U7Hl71aE5mUl1/gFzetJaZz2rSwa02aFO7zbIhWB/DBvOcaDuSQaw2/4mmaVC1uopCALLU
    prDML44fdSVxv0r2bXcnuOCR2MPrBd+r1ERD+dA7/gQLBgykm/6sf6r3Lh7YLx1SLuhCtv
    ypBfeCb4pmBKaNK7AkegQqaAYDJRhFBgEd6FPYgPeQ0q6N+IyO4JsRs7vHMurEKQVNvo1o
    Ix8hxgaUoWIly0rtQIVVf2z/+qVFUtlLNnB9CVnBiniL6mJESoEw6g/gaWJK6A5fXIGQZX
    V+ZB4Pyq2SWetYks3cExOfexM/aV72hwFRMKmj129j7eq8Vj6pNyvkzoDPCg
X-ME-Proxy: <xmx:ZAJ-aoRqhCNQ7OsSrrdD3RafJYM_ZvErRgA1pxQ-IMjkexdEV56pxw>
    <xmx:ZAJ-avFhsaRMADKR7RiPuETvADK-Pvx4VEeBtrRdcqVNWH9Vyl4e1Q>
    <xmx:ZAJ-atEIJyym8eA4QxQuw9dgiWRM6JfzUsw5n6z22W3OYXptjIb1pw>
    <xmx:ZAJ-atSlZsx5ZJybyAaMTSkeLJnCMZNTwySqQD1lNNf21JuGP7Oi0Q>
    <xmx:ZgJ-akFGgjnWZZ__s70BsB_VLmhwDIJ2I2r5JZBg-zafytEMzJjbh0B4>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id AC1A322C0072; Thu, 13 Aug 2026 13:44:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Thu, 13 Aug 2026 19:43:41 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 "Linus Arver" <linus@ucla.edu>, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Brendan Jackman" <bhenryj0117@gmail.com>
Message-Id: <a4956b42-62b0-4649-ba5d-79e7647df985@app.fastmail.com>
In-Reply-To: <21339fd9-9fcf-46ea-8896-9fde56cd1f29@app.fastmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz> <xmqqcxxyt4op.fsf@gitster.g>
 <729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com>
 <xmqqzezhb73q.fsf@gitster.g>
 <21339fd9-9fcf-46ea-8896-9fde56cd1f29@app.fastmail.com>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026, at 11:20, Kristoffer Haugsbakk wrote:
> On Fri, Jul 24, 2026, at 01:48, Junio C Hamano wrote:
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>> I was reviewing the draft of the What's Cooking report and noticed
>> that this topic is among a handful of stalled efforts going nowhere.
>>
>>>> If you want to stress that a line with only whitespaces on it does
>>>> not count as a blank line for the purpose of this paragraph, you can
>>>> consistently say "an empty line" withotu saying "a blank line", and
>>>> you do not need to have "(specifically an empty lline)" there.
>>>
>>> Okay, I=E2=80=99ll make it shorter.
>>>
>>> It felt too long for a simple concept indeed.
>>> ...
>>
>> And it has been more than a month since we discussed this topic the
>> last time.  Will we see an update anytime soon?  If not, let me
>> mark the topic to be discarded in my draft of the whats-cooking
>> report.
>
> I=E2=80=99ve posted the next version now.

And I=E2=80=99m sorry for not simply sending a message sometime in July =
that
this topic was stalled. I was _not_ away from the computer for over a
month, and I could have easily sent a quick message about the status.
