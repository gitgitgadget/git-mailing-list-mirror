Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B246AF27
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269208; cv=none; b=eTzAmmRKFxv/9rTjj/MYRavCSdYV037AODEgBpZMTinrysn5/Ycmuo+oHIi8lEranrghUa38ee7FsCaAVAP21RI58AEFhZC5isWtX7J4sHTdg125whDXHl+OKEQHd4ew076lqduWk2ypuRlFOgSo7xTWRpNU5IasAldcW21wDQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269208; c=relaxed/simple;
	bh=tOb4FcVNi5AVn9g/LTekAaYLnHyM6PZh2bb7OFoWuqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVp8TYmjW17avEUZ5EY4q1T7pZslnBO3aSFlDb9i+VYnEkKJ++NOe+LAHHE0gilNaoCq+jngTWydQ5lyESjp0sNu7E+7nssxeejs0n35MHo8Tb+pDBTzEZ2L0pc4goDHsomFsR0qKpEIht9WLfhIVTARBVGCaQUVCfqR16oTuFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eEobiZto; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSA/3OJc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eEobiZto";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSA/3OJc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 08EFAEC0174;
	Thu, 24 Sep 2026 13:00:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 13:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790269206; x=1790355606; bh=+/HQFKUYJQ
	7iYB8M190hw1GBikmDoBr5mvht2Juu/iM=; b=eEobiZto8IT1aL6HKiuU78inmu
	dwIuM9R8bKkfpHcrkuK8XG7f2TmfmQujOtm6gqD+vy5NSDeaDhEHhzlZKmP0I/Js
	zRpVV43OYIiQTYt2hMz8PAW1ecoAQJ8Y8Cszzf/DCHFvGQL9YDI2g8kPtq+JrW4T
	NKjbHWTd1Dh8zIDN1uDJeRIL7UoquW85C7Eqcsc3PMbnJXlxkbUf7rfUJU75Cps3
	YkJo1jOPDVnbvS9SFldUsDqOOtrRQM54j0oQUM/dm7X3b+PnJ3RRDplobIZ+v8Ym
	yv+OuILS+eHtIlEo13VCr/W+jMBkFYoYM9TwTI6BUlZCAPyGM7epsaq2DEHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790269206; x=1790355606; bh=+/HQFKUYJQ7iYB8M190hw1GBikmDoBr5mvh
	t2Juu/iM=; b=VSA/3OJcouNE+PtcNrKkJkCUSE6wanC+gCMNaI33W5WE2YruA7U
	8eEelYreJkYuydfR98dRF2W6tck2AIGBrzKqjaFypQhIAgvEz4M/WnGLfRRcNSuf
	lsSEeDAMdne0396W0e9/aWZ+Eaxz5b132Nv1++Dc4UfdfrKoCxpjzW7Z1VUFpQ01
	ey+8pECooXiienUebuweO2IILt9iG8Utyh2M6XTN5mRq9Urd6aY1Cjj6Fy6hwQHW
	ZMHlvVyN/ruwwov7oHFLnWMCWKedHbQx8Ccz7O9MoBtpRdwHQRHo15rcrtvXVzqY
	nSCd58VxH54GfyGnxk6fivHtsQ4ZHQlAbPg==
X-ME-Sender: <xms:FVe1agtp1VnOlRk79_0GERdf1wIncPRReJ6wRDDQ3whRB_NOHdZ9JQ>
    <xme:FVe1ak6TMw5l9Br7A8uqG_5ApnjO7N4aMFlIHZA93TMO7dBtbDSRhZb0nVUfAivjT
    e-oUnsdCqB09F5aWJCBtlPDgGxSruc7ly2TXpR5YAq4Pytw1B--qpE>
X-ME-Received: <xmr:FVe1apLUswacE6QLhDjcSv40nejdOpvAtIIHcuHiDqM0PLy4f0axsDLFwO0BKYh58BexC6t4zQXc-2mE6gqRLUBwnITqM2zpkxho>
X-ME-Proxy-Cause: dmFkZTF98zI1z6JavXPhAF/5xuP4JS8NjHNiBMhZsBFHnUpDtJYATsuO6bac6NcjjDhBBO
    9VBNR+cfFe/JbKkGlk/pHcMpAdUGk06dISN8XgOj5b3Qjq3jPjNgA5VcSsXsMnHw36kqWg
    yyMeJMazJ/nKNQ7Ja812OTxqmyTKX1W9GChRvtt0qGpC0iVdIx57lmqGGlhhRT2VyGtMJ1
    O4mNlxXItidqF4IHu6sUT8z0Z2yB+kULBSXxUlm73FlcZHsVQ8uYPZf/11aAckBYaiiWKd
    8Brw8dVWe+WOEieYws/y9BMTFaS1aBvFE+nO07twO17ss5V4rgy0TrbxorslTTtVw62ZiR
    dhdfMJhKu4r6ZbydQNAmreXXd3xHCAvOqUoFbS6RuXfsFAsIdTtQv3iQgqVVRucyho464C
    s12LnDalkh1SpEoQ07bk9Ji1SH+4QpBk/OOzZLah3DGUAZWMoo1emZSWkYyUg53MrD2ie3
    oWFUSZCVHW9UUNbEQaeZxBJ/FVgwuGV11WMSrfgPcp0D4A0ShhXk6sVeXbZoIFOh5sUWG3
    iHCEws/fTKvP3m2WIbD+PO66F+Ky7fPp6aXpw37w3nuNJhIDLYu4dvvgPm6LE8PuzT6Dhq
    NKfPFcgpQM08ByrXLk+v6iW4TKR4yMEXWB830ETjMh8s86h449kCTUy1V37w
X-ME-Proxy: <xmx:FVe1as4x7-Z-gMYeuHZc7pRqfwA2Ze5PujEEMy9qo8orrc7KrTbkVg>
    <xmx:FVe1akzE4DJ_4NBIu0gWoOp1pTRd2RQxqvvfTXArmO9Nw1MvMhX17w>
    <xmx:FVe1aoZdsYISwyq2-RHvLqyiQQfKfgmQDgJ3nUJ1YZl7jfDfvubUKw>
    <xmx:FVe1auQ_5tgDVZxiW5Zx7-s7Sj6TYYmmu4Vx0Oy6iQpSU3pJaSIr2A>
    <xmx:Fle1anepG1JMSnvdBF5C3xvmYdMMUdNNIDU1dcpbp7mSVWSIDGiMAuE_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 13:00:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Git v3.0 timeline, was Re: What's cooking in git.git (Sep 2026,
 #08)
In-Reply-To: <306e7563-c356-dc59-c14a-ff8e99a948ae@gmx.de> (Johannes
	Schindelin's message of "Thu, 24 Sep 2026 14:29:01 +0200 (CEST)")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5f34a5a9-9f72-b725-666a-94798895d122@gmx.de>
	<xmqq4iff5ml0.fsf@gitster.g> <xmqqpky346fr.fsf@gitster.g>
	<306e7563-c356-dc59-c14a-ff8e99a948ae@gmx.de>
Date: Thu, 24 Sep 2026 10:00:02 -0700
Message-ID: <xmqqy0cq37ql.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> So the above is what I have in mind, shaped mostly around the
>> consensus at the Contributors' Summit (or at least how I understand
>> what the consensus was), with my preference filling in what was not
>> firmly decided in the room.
>
> Thank you so much! This will make it much easier for me to plan out the
> Git for Windows roadmap, such as switching to Rust-based builds and
> integrating Git Credential Manager v3.0.

Note that I consider it risky to treat the timeline as already set
in stone.

In particular, if we find that 2.99 needs a longer stabilization
effort, we may need to slip 2.99.1 by a month or follow it with
2.99.2 or even 2.99.3, and 3.0 may have to coincide with one of
these later maintenance releases.  Anything beyond the end of this
year is in "we do not yet know and we will play it by ear when the
time comes" territory.

Thanks.
