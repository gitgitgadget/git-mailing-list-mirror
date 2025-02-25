Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07670191F95
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740527148; cv=none; b=Lz3/4p8g8JzofQ6jeIt9bDPtvNGdyeqNAXnaJjN/hCwcqORPZXUiOGNnhEXXX2QhS7QO6Ir+7PW/giMZvAOvkiekQST7t+ybaYb6d2pV+tJe6VfM9JEyP2JkkndB0MSnAg+ClLpS9grKS5rV4SX9NUsQRGiSFFCzQMHmunla9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740527148; c=relaxed/simple;
	bh=CLlbEnSKLXntkuz9SLDaJnzcOKrGQTQ32bsgxJ18oec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asnHW/C1v0cFjySyqYlmwwtrv1F0aD6zoAHIsR5c/RWFfTgS00DyjwqKJQnWxfmVqB402FbXgQQHY47l9t3TccCzjmRmLqOyEvO6WMXmllYn7FJg2KJ9AIaCS8ekEpoQXrLm2okTd69Z+NKdsCXHKikVYYfesn0LVbVgilAjFDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E6GEG+M1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ND6udpzW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E6GEG+M1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ND6udpzW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0D795114016D;
	Tue, 25 Feb 2025 18:45:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 18:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740527145; x=1740613545; bh=dFttaKYzL0
	PDUJ4zpjcThY3ex+DLkGnloKi9Ry3ncDs=; b=E6GEG+M1GeIBb5agKBs0Ol5c5B
	fF2ZlPx1Ir5oV219BGvfJZ61QTHsLD5/qRi4r2rbtXSzySWdt4lVDftYMZoY8D9U
	v31n6tnApNHk03hrdPEBA9n4+ISv8acSanDr88q2JoHqqBqHmrzm3RZJFtPpq/qr
	HZxyCwgPwMXp3cRUr+DgnJG7bKzCGa0cqs9LmDh3+Os2EdIrBUQXxcpGBvoj20mI
	kOUwVpNy+dl52lhPTS99O0yh+E6Ur1xlQtxi00ygW3QXnahH2BLdjE5CWjAKZXbF
	w0VCosqvYL0M/Gvck3nLClmqUQu3efXQOtIInkhIWX51M8FaJcFb3eOYOXHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740527145; x=1740613545; bh=dFttaKYzL0PDUJ4zpjcThY3ex+DLkGnloKi
	9Ry3ncDs=; b=ND6udpzWDqtxTZaxWqbbQB2LF7Pxo84bXS1ex0o6JCvrMO+NCzu
	t5FmIg7Lxf422VYy1Pz/F9imG2UHnMT1DV5i2pohFT43neHhJIvBwif5ywhGe/r0
	jJ0OdmqG/ziYfEd4LV0w1+Fn6ZyKeTUMNjB3y8dPRH3G+BNvMhM8w4SLiliH0X6D
	U9aIvleaG81uNwClbEOaziR2pU3lFB9uUFuz0SskPOjEj6tpaZIITPnlFmYVDZjU
	/aOIRoCgwXXLmMU3uoDp68rz+c9Hbutz5WyPrP5kC2v8ziGWuN/F0j7APmX21+Ch
	SQVZ5qA6EjMxsWcHKTti+waH7JzopgyKDgA==
X-ME-Sender: <xms:KFa-ZzVX2HT-DaHm6y95o82GP9oQZYILfxGbbqb6DrJxaiKM5bQH9w>
    <xme:KFa-Z7nbSMEBu-qi1WHdYQG7uNG6yqyPsK0YMRRCVRpP3dBeQOMcaQoBF2KHchu0I
    dzphNiqinTzusZOjw>
X-ME-Received: <xmr:KFa-Z_YbWrWaqcnXzErnZXL-CwngzAiObG8_3h1rGANhMydcDFlXvvwhngqqbVP_fg8_UAVOuJDEkDC92lRIMkQ-dt-ZVyEJEK6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepjhifihhlkhesjhifihhlkhdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskhhoohhrughi
    nhgrthgvshdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilh
    ihrdhorhhgpdhrtghpthhtoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgu
    ghgvrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KFa-Z-VXKIzsjq2IcghuLfDzXoDoqg0GaTah7zYUnt5LWnLGIn0V7A>
    <xmx:KFa-Z9nuhMXSvFCK9990w8C5sSzlHskxWoKVG4bQO6elMrbUUnY5GQ>
    <xmx:KFa-Z7dEI2cCp30RRAVG0ax_QeeQYvkzNumyOMeb8ftMT_e-ccOT0g>
    <xmx:KFa-Z3E9Ehcp8NHXHSKjH7B1w5KwWm1Ld0GZ4nfRrCO0Q3XJe3Vl6Q>
    <xmx:KVa-Z_7tP-MQb5TVmluhLNR1nJ557jL7eS9-FVvGvO5Zlw05saIHRpgX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 18:45:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jakub Wilk <jwilk@jwilk.net>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Robert Coup <robert.coup@koordinates.com>,
  Christian Couder <chriscool@tuxfamily.org>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z714F8mLHZcoHptI@pks.im> (Patrick Steinhardt's message of "Tue,
	25 Feb 2025 08:58:15 +0100")
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
	<20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
	<20250221152644.o5ni6vn6rncvmaq6@jwilk.net>
	<xmqqmsef9mm1.fsf@gitster.g> <Z714F8mLHZcoHptI@pks.im>
Date: Tue, 25 Feb 2025 15:45:42 -0800
Message-ID: <xmqqcyf5io61.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 21, 2025 at 10:30:30AM -0800, Junio C Hamano wrote:
>> Jakub Wilk <jwilk@jwilk.net> writes:
>> 
>> > * Patrick Steinhardt <ps@pks.im>, 2025-01-22 12:31:
>> >>+As our documentation mentions, these directories are not to be found in modern
>> >>+repositories at all and most users aren't even aware of these mechanisms. They
>> >
>> > This isn't accurate. The "branches/" directory used to be part of the
>> > default template until very recently, so it's found all over the place
>> > (although most likely empty).
>> >
>> > I'd say: "... these directories are unlikely to be used in modern
>> > repositories and ..."
>> 
>> That's a very careful reading.  Thanks for pointing out the
>> distinction between being found and being used.
>
> Indeed. Do you maybe want to send a patch for this? Otherwise I can
> handle it for you.
>
> Thanks!
>
> Patrick

--- >8 ---
Subject: BreakingChanges: clarify branches/ and remotes/

As we have created an empty .git/branches/ hierarchy until fairly
recently, these directories may be found in modern repositories, but
it is highly unlikely that they are being used.

Reported-by: Jakub Wilk <jwilk@jwilk.net>
Acked-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/BreakingChanges.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
index 7c388e56c8..042709a461 100644
--- c/Documentation/BreakingChanges.txt
+++ w/Documentation/BreakingChanges.txt
@@ -169,8 +169,8 @@ started to migrate away from ".git/remotes/" in favor of config-based remotes,
 and we have marked the directory as legacy in 3d3d282146 (Documentation:
 Grammar correction, wording fixes and cleanup, 2011-08-23)
 +
-As our documentation mentions, these directories are not to be found in modern
-repositories at all and most users aren't even aware of these mechanisms. They
+As our documentation mentions, these directories are unlikely to be used in
+modern repositories and most users aren't even aware of these mechanisms. They
 have been deprecated for almost 20 years and 14 years respectively, and we are
 not aware of any active users that have complained about this deprecation.
 Furthermore, the ".git/branches/" directory is nowadays misleadingly named and
