Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2B35201A
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331345; cv=none; b=Yu5lNNw24xMCvqq4ACTXzwOAqi+tYRkRJtGvR2Wu2O2TUNJJQmQdZxUAUZAVbruleTFzJPsecT5vj+rEnoaKtoEBm2CQoo3KSNzpiAIzGnbyO50q0V9/hGLcVfqR1w1K/Ohz3uD/l86EkPVWqU60oGGJ7BLqodg+HvZqkOrUa2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331345; c=relaxed/simple;
	bh=l/vzGrw9+WnDviC8lN2ij64LltlToYWZ8Pam71MZX14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKkc5QqcB3B1qTl8rGovdcj5nCpGObqn5j7ZpYkYnFF0DUqTxr3UOzsWs0dqOp9iWZMLF7iMoh53TOlnVyAWTP3G9utLYRxOdYg8AoDc+CeGnqMZHTRdbOZdNPSE2CjxMRUJiXPcKmlElYCxx7DkhjbEwHci3UBMj+CZzgYSJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yxO9p/Vw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BA9qVQEy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yxO9p/Vw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BA9qVQEy"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78D527A002D;
	Fri, 21 Aug 2026 12:55:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 21 Aug 2026 12:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787331343; x=1787417743; bh=h2ybIJPLJ8
	bNJWLP+VDbXgQhGEG4Zi8isvoLFIXAhl4=; b=yxO9p/Vw9fjrBUAb6RqXWovXDp
	8QBtnzmetDV28fnY/1uZNZKp/5taK8DijqtSzF/TrfBXV6HZM8TNdnvjzRz160RS
	WgQ06qalenJwBAjLTo9wbpFE1+F96jbviMMvgLS13nkHWvl5J/Cg6wdfhMlA1+MI
	4TL5x2yQOaMETyZZBSzHE4AHoxJCmzRyWcqAjJXDS2Co5BXcDNgrgSbvZt+H65FQ
	BibJhJ/X3fhgkK0jOh5Wc98B7ZrZ091bWAJTHPw3IZK7WoVjfL+Jg59dRmtUsReg
	HwVVgvEn86Mn5cOL2g04yuZ7QDh/SakLWoNwmea2bc2Sqqru4VAO1Qb0u3dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787331343; x=1787417743; bh=h2ybIJPLJ8bNJWLP+VDbXgQhGEG4Zi8isvo
	LFIXAhl4=; b=BA9qVQEymYOIhu7WLg9IZo0/XmIlQQGn3JbZdbtqa4eWzr1/hbp
	kicpDK9HBcvafyc3L7cRvCpS9NWYkrw9C2fpKN+jS+CrA4GuVSwg2QzUY0yrOMiB
	Q9xaRk0A1U024A8DzuG+kUdMPsMDTcF3Bon5nxl1NCmAAHo4Gw1s3vILjHvGc/xE
	M12hOXgKzQa8cJ9XGsOW++Fym/GqX9vXk84QgshcgDFMHPIL6g9WeahTyA1XeDLk
	Ij0z4Mi5C3YxwftI9gkpCVyFXL4Zi4qptaRvWyHQNqK6cARXNFq5eSN6UvMxk2Rd
	e+Uupf9b3ld5s7fQmUBtTwyp1FixDR/Myxg==
X-ME-Sender: <xms:DoOIarB8wREVkHHgOmACNtZXBqW0QHTedbwzuLTmK6cm6EHniSYAmQ>
    <xme:DoOIaq2mldtFr_mRX6TyU9BklLqJnBTDS32hVCwofzkZmWLtxH8eydEuBmakpNJ76
    wtmkEP4lvdWny1tLZYQq2UBC-S0YiOVQUq2jw-an9wiepir-vljkWo>
X-ME-Received: <xmr:DoOIat00aQYihrggMCO8hCvm2loEC6xUbnSPK6j4tmhWeJ_3TexF3hvCqcyqNm9EHPPoYwiwsW9D1xKytUYV5ENb2pWrKn1pEw>
X-ME-Proxy-Cause: dmFkZTGKOIcpBHGH95U/LstTX7geYaGPiLQ32uebdCeDzvFWMufPy0Tbnb8u6JNcY91Dzp
    lSywUWrjlYUz12HHdZAlotPYLDPQZO/u4B0pvXT75gsTnd+O0zlN/rjPC2xFvK2pks4YCt
    wLdehBvFMXjnOGEO4+fSfsFzEqDDtfssh8prMlJO1IStsILm9FJn0O9lNVCzeO7wyXe0hz
    bi1tYfVqsE8ig2VVYkKBPKmZJH5bPh/c1lfpgmZAdc6F402QRl2ftzQRVHoF/FecP7lEL8
    lPKT0k6N/15PKG1QOq+VJOmhL5OmMBtdV4ow85ObaqzdzSUQ9ElQScDalSSfxVbasFOSiV
    lrkg/I/i3ivjvjBJYNnijkgki1+thCGRK4G4wif3Ov8/OPcmJ5bISa9BfWVnC7oOU0EM9S
    IzVObtEZsiQ7rlMnLfboN9oSgk7wYyMONkOLZpMlTSSWzF34YXhTyvphoC2q0JlFu9RwZH
    QQLR6oIhD+zXiP3xQHri1RAPpN5monxXPKO83rc7+AUE0A0rslAAI5R08y5EXJZGL1eX30
    UyO1lqVpmg53fWoL7rw86wCtWz4ugLJc+sz2aOfPhAMiyHOeEj34cCWtXw6pKGd0jVM3xI
    NYiza7RllUL26eb6k4xQauXvMIfOd3+AYaJCGg750lgiemgqdoRk3ZXUWEkg
X-ME-Proxy: <xmx:DoOIavAuNjH1YjQl87gbdw-DyG3ljAgPatjRI1xl8tDVzddWOpj2eg>
    <xmx:DoOIas4ShhVfXNE0r5Wr3XGABm3fNBzl8lWJb1vxocazEvDbuLmJoQ>
    <xmx:DoOIagIasZcyEbby0tE9sOE9VRV5bR1zj8RF2ME_Zt_M7N7-dFjgaQ>
    <xmx:DoOIatu64VQhltieheSwKvaPhFeXv0fgNAl3_cW0YlxiA5PFNTQWPg>
    <xmx:D4OIauJQZSnmnQnPTlOp2h3GxdAvJh8NlBpzgPoBVn2Vk_0xbf7hvO3G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 12:55:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] hook: introduce the report hook for git-receive-pack(1)
In-Reply-To: <aohXatWhxCAUQTcq@pks.im> (Patrick Steinhardt's message of "Fri,
	21 Aug 2026 15:49:30 +0200")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	<20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com>
	<aohXatWhxCAUQTcq@pks.im>
Date: Fri, 21 Aug 2026 09:55:40 -0700
Message-ID: <xmqqy0dzpg4z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 21, 2026 at 03:34:58PM +0200, Karthik Nayak wrote:
> [snip]
>> - Exit 0: the hook's stdout is used as the report. The hook can
>>   rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
>>   client while receive-pack itself exits cleanly. The client marks
>>   rejected refs as '[remote rejected]' and exits with a non-zero
>>   status if any ref is 'ng'.
>> 
>> - Non-zero exit: the hook's stdout is discarded, receive-pack calls
>>   die(), and no report is sent to the client at all. The client
>>   observes a sideband disconnect and reports 'the remote end hung up
>>   unexpectedly', treating the entire push as failed.
>
> I was thinking about this case a bit more. Should we maybe handle it
> similarly to the pre-receive hook instead of dieing? If that hook fails
> we basically update all references to "pre-receive hook declined",
> whereas we could update all of them to "report hook failed". That might
> make for a better user experience.

It is a bit different in that pre-receive is all-or-nothing, but I
agree that it makes sense to model a failure case after how it
works.  In general, it helps to explicitly tell the other end that
their action was declined than let them assume that no news is a bad
news.

I also agree with other points in your review, but I consider the
above is the most valuable input ;-).

Thanks.

