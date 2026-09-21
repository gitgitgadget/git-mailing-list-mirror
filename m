Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812851AFE5
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790028604; cv=none; b=sUVUYIQXRCpdJdITzbNbnSWsnh7o60OhLspThzbNCPNxkxHfS0Zi2kGPGcM+ABXe+I268Ki8+6hMeVfuxQ+OKlfiPXWn2Vujy5/aTEZpO4b/L0HASLPmmb8ZAS3n+9XO5SFQ+fw9eqympFQXL9D169Vz4z5glpATo4X7Ja5c5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790028604; c=relaxed/simple;
	bh=+ibQkRvws7LAKaDouG6JUndyV/uQ4GYj4xONeS49yFA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d50lXPRg+WOc16gXfnJ47WDsoDN4yDNHezkO1fy0HJfVMYNxWKMXvqlox+u/O/F5AGvWe2C5J5MKAS/GnRhmROqBLfByg3eIPAYdwKv5oUkoIRRWgaKHIpV1RrETmCnaNXKqj6qZHDXQaFxVq+MkoP3zYsl2JtzUydeGKUAFIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BB+AwWOA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbAFRC1o; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BB+AwWOA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbAFRC1o"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A4DEEC0243;
	Mon, 21 Sep 2026 18:09:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 18:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790028598; x=1790114998; bh=+7Afn44U9e
	DZWeHXeqdlaeLTQHWw1Bhz1/fOLLzCfGk=; b=BB+AwWOAM7d3UDfQ3oxxdqkq/o
	/wiO/GHGU/ivEty0aTUIndDuxTgYFfaNsJmmNyjPWr3v1sP4KGr0puxSOroRIiqE
	vtXVs1Tsa1CirXjxcnVGPTaIPVXUN6suI6odNztSnGWuul+E4XyPWk8bucadhuPQ
	siZAoAqibRyI1OD9CNSkzp/qfPvaneJ5Hwi0p31hLTmQBktgGiKrvP6/zrbKdKu1
	wWzg+jAHqr6Y0j9haLZ1ZXBB4dSmPHb8gP/s01iX4lA+9Gkw++gGhGVgwBYqWusS
	xacE3L1gFrxvax+mzYnHYIcYJt1UvvIPcaabsH6zdkE0Xv/EtT3Ugko0bifg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790028598; x=1790114998; bh=+7Afn44U9eDZWeHXeqdlaeLTQHWw1Bhz1/f
	OLLzCfGk=; b=UbAFRC1oe0HxDWPCFbQMygBnGImzRjVABdRxHg3EOV0C+PDo6i+
	UOQmhs5eJKn6O25pamXFmozm/Y4mVvgGAdLRufE7b/Zb1Ppxka8ywmTpC49uXdn/
	cUaiBKyKQDQN5N34DbJxBRX0XNtIYDAreVmHD//VoCgFQphD8qlp0qUPcFJUBhWN
	0L73o3AX/praAysGEB8NP373t4zbpvYoolbLpDZ2B+alTGDZfnU3u24sdC8Rf5L4
	0XSxxROqeKcU54W6qAJOKZ/AYNWyp6Ox/cSNSbZmt2d3CfJiCCJ12VFWEHRJ1qBF
	6KTNSX8T5YczbOHLnIiqb1dEF5v3XmjNw4w==
X-ME-Sender: <xms:NquxardX_3hTgm5jiDPNcLh4CfG8qe0L27bnPZ3mfevKZ0GColFu9g>
    <xme:Nquxaoq6DC6p9ObmWmMYR_xWcowTvxFrm7ZZ-KbMNiQ5nVua8_dEYGgjK1LDFwMR0
    JaRiuN8s8Q7fD9_tBlxCy2IA3hWAMxUGTQ0-W5nchyEMpIxl-u5qJ0>
X-ME-Received: <xmr:Nquxah5xueK4eZ8iv-4XLwfRyjzBG5Z0NitwLdWTH9HfJrDAmBUqZ4-cOHV9dcbcnhj5tpS6EpQp_dc2Pi8hNUAdUmAAmSPFenv9>
X-ME-Proxy-Cause: dmFkZTEcCCatoEL52RZ1wjO3R3OlR7F1etZmXsPJvypknF4c3T9Lj5K7Y6ycZl5MBjv7i8
    2yzZ5vjFJ6u1PO4l/ATx7r5us2qoxqb+gX7ZLS3meihWBcaq5AzfsslT4tC+Fj1Zxc8Au2
    +9uYxE9Agdw6RrRaDhW7R8cxYKKFlJKJ4MGciwG+T5KAbNnaWS81t3D+sj7t0afnhEyqNi
    w2oCybG1PvHJ7lA2UtIHI0nU24DfhB6TiNVD1VhhzhhMi+3sO3doSZlcqDhbKMoPa5yuc4
    0mdjetc/To2YKgL6o/0VDnMPGpFNsfnIdBGHTu1lQc4z4p7G5KXVROJZ5p5cTRJa9buZhd
    1AnmQqtUzElRrJxSxe76aCTusTIVQCKyBrWK2W50ajWTzwu7FHi4CjWVGgSxg4hZoZvJks
    G0Zc3ddCJcSO1+aXcFkd9dvoDpM0tjIqQvu753iPyusuPWMIwJ7pVgmrgrSyTRmdwKrLdg
    n2NXKMIRCkn5F70+u+6dXqOxH+v213bofjg6t9ryT4/Hz69iGycoZtxo+wTABAWKoYrhgf
    fFsJzJ7MqaR7j1EYNCU9ust2JI4lrJGwcyMZ6g1tyKzXWJ2tILukVv6C3v3+3REHJSIvLI
    1PrRszv4dghc6X7xucfjSKF4lQ+O8Q8Btop3IHROFF51EdfxYhJ9ZFkXejVw
X-ME-Proxy: <xmx:NquxamqhCFl9uyUv6qjEjICJhVJnvcHDX9VTXP7CxFwStQ-iBPKRAA>
    <xmx:Nquxarhxy82SmQ43-vUeGdHMwRAskdaxoQAfj6rIp0Xbb6oG-GEHZA>
    <xmx:NquxaoI8_NchNrJwJUrLxbVNJbkKeAPrX5ilcIz0sfjDaWs5-hmPhw>
    <xmx:NquxajCZbYbxuwc-LVspeLENODv8PA5qD15ZSBHipBsbnTk1KNSslA>
    <xmx:NquxakS34SFVTVRy941gOFccPOtoctp98hMA7Dfqfi07Loh6Kk1H7zWZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 18:09:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Antonin Delpeuch <antonin@delpeuch.eu>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Documenting the governance of the git project?
In-Reply-To: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu> (Antonin
	Delpeuch's message of "Mon, 21 Sep 2026 18:08:02 +0200")
References: <1aee1829-d7ad-47e2-b7d1-1a946bd59991@delpeuch.eu>
Date: Mon, 21 Sep 2026 15:09:56 -0700
Message-ID: <xmqq7bkel0i3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonin Delpeuch <antonin@delpeuch.eu> writes:

> As an occasional contributor to Git, I have been interested in getting a 
> clear picture of the project's governance. By governance, I primarily 
> mean a list of roles people can have in the project, the associated 
> privileges and expectations, the ways people get in and out of those 
> roles, and any decision processes in place for important matters (which 
> `Documentation/DecisionMaking.adoc` already does a pretty good job at 
> describing).

I would refrain from commenting on how good a job that document
does, but the way it describes how our community works does
reflect the nature of our community, which is a loosely knit
group of self-nominated volunteers.  'CODE_OF_CONDUCT.md' at the
top level refers to the Git PLC at SFC as "Community leaders",
and that is the closest thing to an official structure we have,
I think.

Specifically, we do not have an official list of reviewers with an
approval bit or those with privileges and responsibilities to speak
of.  Clout in the community, on both technical and non-technical
matters, is earned through continued contribution over time, and one
interesting side effect of this is that a totally new person cannot
even know whose words carry weight before they are accustomed to the
community.

> If there is interest, I would be happy to try and document this. All I 
> need is the confirmation that people see value in maintaining such a 
> piece of documentation, and the readiness of project leadership to 
> answer my questions (which I would try to do in a way that respects 
> their time, using the communication channel they prefer). I would then 
> submit my write-up as a patch in the location/format you prefer. I would 
> of course be delighted to team up with others in this endeavor.

I am somewhat indifferent.  I wouldn't oppose it at all. I would
welcome a descriptive "this is roughly how it currently works"
document, but it might be hard to come up with a good descriptive
document.

Once the document starts trying to be prescriptive, it may open a
big discussion with different "opinions" not backed by any common
experience from which discussion participants can draw, which would
lead to a lot of wasted time and effort.  That is the only thing I
would be a bit worried about.

Thanks.
