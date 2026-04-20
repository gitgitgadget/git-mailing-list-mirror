Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B32D8DC2
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682918; cv=none; b=FeLnRo7cjW1V9RoVgXSGP9OKJ42x5FUGZmDoJrLufVN4t1uUPtp7BgWngh5smWzUY9pEC6lPrxzzgz93YvVwLFzJ0YVxMdmAGUzopcMfOIuIDMnIQoLZq0WLZCbG09ayBSVtZteHNde8uX9HH/ChBBNIVGnen+Vhuocx0Z0BPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682918; c=relaxed/simple;
	bh=SpYXvVVWkOoYIx36Ca6sq3vUWctSMbCTLCGnT0ApOsA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kcUyC/RVhvKzVuILCEHqzTckQQzGoabEDA+9fmpip84v49gVCcr7lAsBPZXgug2m2m7QlsGVsJzFxiatQLB/QzPKNinK5cg8/DgKqjvxVeMfjp5uxkKbINbccNg/3AB2GnZf0BGw6JrEmfNqtpvErfmLKRiVb/Pf4zNfdGXL/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KPDB1fmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fCUsIGn/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KPDB1fmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fCUsIGn/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C19AD14000F6;
	Mon, 20 Apr 2026 07:01:55 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 07:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776682915;
	 x=1776769315; bh=MR3eBNyM0I9Wdsep823KI+JGuQX//tUnMazmj+sn+xY=; b=
	KPDB1fmANWxW3u+nARdZhoV7mahWKLF0wpyXwukC4xW5eat62We4eZxEJ/edobdj
	6g0MvraKpxh11u3wercrlUeuygAQAVpmR0PL70dFz4oBSzi9BvLrzXAPOX+ASEfT
	RHRcEQ4orbrgFTVAkyepE1nn/f1FZ1r1Hf7hFQ5c150vrDPlWo6Baa25RUklK2b4
	3CTDo6CQYxBbWa+jlabu4etW3kzxSPzcoRkJz9NWfX6hOmkoHK924mmdmS4N49JP
	HHfbiK8xF9L30rTfViDIPFm54px9OKGSVqHhcdK6T3ZpbhRCs/Rs/7mP88gHQLfG
	dpB6f4/M6KOe1SkjJkjGNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776682915; x=
	1776769315; bh=MR3eBNyM0I9Wdsep823KI+JGuQX//tUnMazmj+sn+xY=; b=f
	CUsIGn/gwKjieTr34XDhel5cCEsbBLC9U2rmoprsbe9jMG/0+k8Ko5Qf0It/V3mp
	CRwaQmCbSZJsYJY9NlC3TA74yss/spzTdP5CE1nwCMYs/Wm/Mi+qd6lKjO8aozb4
	gJr2sCjzm4iG6tACd1VBsOe3xZVPBrBWUChueLpVYU0q9G/ylj+6wtF7Ejg9+enK
	MSp3UgPHmJ16ylHDrOH3d2A+YfNc3oiN3Uq65Hd9E8FpDctXz9LNLN3pu5tHc/DV
	F5vPZu6orEsYKVlVYnB6+HwLZ+DCeHirrLsoI/8HTM5y1o0L5pDOXTouQxbXlXze
	lAMgSI7hflAc5Reqc1NHA==
X-ME-Sender: <xms:ogfmaared6zHZLvghrwWXwpD39C5rBetRnNVbRyzQvCFBblmLEMOMAM>
    <xme:ogfmaTdeXa3A5_PdKvpYJHpteYNHR5Pwzph3yWZbgdL-bh28xBtEBnBZGl9yOXtXz
    IzsMVz1snSwOUtDch5G74YeSSew11JLm8I1_eTdChh0IWYCnqLmPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdr
    tghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjuh
    hsthhinhesphgrrhhithihrdhiohdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ogfmaaooIvG9oirR7guRVNc0BNlds8uGwniKLBGTDm-XLmcR8A8QFg>
    <xmx:ogfmaUoKhCX1zMKvf2osCD-2Kw2rNLS5zlFXvUDgUMjqnarxHvHEGg>
    <xmx:ogfmaRYucsUbP1cMkZwwakjERkc_Pt8Lzu-Ajat5YKo4urmcPFItXw>
    <xmx:ogfmaa9DAWpoSG-05UjpsXI3fMB3_SYfVaOWXW3RKYvvaPuexhHGeg>
    <xmx:owfmab4GwSnkRd-LHbqpLftvy2mEAjGbvxayi7xihMLU4IGaQ1do2zS->
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 95F531EA006B; Mon, 20 Apr 2026 07:01:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwAT5KdOwvBo
Date: Mon, 20 Apr 2026 13:00:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Patrick Steinhardt" <ps@pks.im>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, "Christian Couder" <chriscool@tuxfamily.org>,
 "Toon Claes" <toon@iotcl.com>, "Karthik Nayak" <karthik.188@gmail.com>,
 justin@parity.io
Message-Id: <5bf346c1-0577-4b9b-8713-6053c97c6121@app.fastmail.com>
In-Reply-To: <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
References: <20260419084840.33986-1-siddharthasthana31@gmail.com>
 <20260419084840.33986-2-siddharthasthana31@gmail.com>
 <aeXZOAtILSr638LG@pks.im> <491a27af-3ea4-4978-9d51-9c540ad31589@gmail.com>
Subject: Re: [PATCH v1 1/1] rev-list: add --missing=print-only mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026, at 10:57, Phillip Wood wrote:
> On 20/04/2026 08:43, Patrick Steinhardt wrote:
>> On Sun, Apr 19, 2026 at 02:18:40PM +0530, Siddharth Asthana wrote:
>>
>>>   static struct oidmap missing_objects;
>>>   enum missing_action {
>>> -	MA_ERROR =3D 0,    /* fail if any missing objects are encountered =
*/
>>> -	MA_ALLOW_ANY,    /* silently allow ALL missing objects */
>>> -	MA_PRINT,        /* print ALL missing objects in special section */
>>> -	MA_PRINT_INFO,   /* same as MA_PRINT but also prints missing objec=
t info */
>>> +	MA_ERROR =3D 0, /* fail if any missing objects are encountered */
>>> +	MA_ALLOW_ANY, /* silently allow ALL missing objects */
>>> +	MA_PRINT, /* print ALL missing objects in special section */
>>> +	MA_PRINT_INFO, /* same as MA_PRINT but also prints missing object =
info */
>>> +	MA_PRINT_ONLY, /* print ONLY missing objects, without the "?" pref=
ix */
>>
>> Makes me wonder whether we'll eventually also want to have
>> `MA_PRINT_INFO_ONLY`.
>
> Perhaps we'd be better to add a "--missing-only" option that limits the
> output to missing objects? That would avoid the problem of
> "--missing=3Dprint-only" not really explaining what it does as well.

The original `--missing` says what to do about missing objects. I find
`--missing=3Dprint-only` to be surprising:

=E2=80=A2 Do print missing
=E2=80=A2 But also do not print present objects

Why would a `--missing` option dictate what to do about objects that are
present (hide them)? That looks tacked-on.

`--missing-only` is better but has the same problem, IMO, of dictating
how present objects should be treated.

From the cover letter:

CV> At GitLab, Gitaly uses `rev-list --missing=3Dprint` to find missing
CV> objects in partial clones. The current output mixes present and miss=
ing
CV> objects together, with missing ones prefixed by '?', so Gitaly has to
CV> post-process the output to extract just the missing OIDs. Having a
CV> dedicated mode that outputs only the missing OIDs directly would
CV> simplify this.

This makes me think that I want:

1. I do want missing objects
2. I do not want present objects

Which makes me think that something like `--present=3Dno-print` makes
more sense.

Just speaking as a user and not looking at the code.

>[snip]
