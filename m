Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666E3A168B
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443092; cv=none; b=b0Ms7V5/F1xCnkgy/0fKmqUnL9qDIePiT4u2O6N2gHWyLjbJfHaLoqsIud4QxvSzlUNwtct0jiklvN1VmV8huUA4AkovsbyQMeeJqEoXh6jnKybs5XgTMe9PYbaXfjt/UdAmTalb8eHm645whRmjuQb8QieWMtZsOxlEm/4j7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443092; c=relaxed/simple;
	bh=2XCZMfwRQPDS4gSJHXngT7Pv1SEHbdhT6NcfPgoOijA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qeUyLk/M5mDfJQkWC8W29TurD3twPTF2LTm1oguz6RHHg3xsXzZ1dDXSuMhoLuNrdc5jHpAcPFpdb/YCz7iQou7cwoF+e507Xy5NkFAbviLfcy/T0ZDs+p+/ReykYkW+RycXpYtcYT/QZQCaGRzmza+j2UxUjh2KJyCctU7BGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wGrRgJFe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FT6mAUbG; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wGrRgJFe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FT6mAUbG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE2B31400059;
	Thu, 30 Jul 2026 16:24:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 16:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785443088; x=1785529488; bh=qFoMvBiZBP
	OKB4l12UkhSWC/o2Z1SELdc2mfYNtk7PM=; b=wGrRgJFefQDw1mHL4QxRGi2632
	vwdqhwlPWqZp81x7oOjMISX4COZx9buansH3ZZRjaODRBf+1LqkXYaHXc2e79ZTH
	MaKMQfq2MwuQM4Qguq9SIWB6nKBjWkWUcCL3rrSd9Dk6RXrvb2JEu8KJsCdBZ+o5
	zPE43igP73TSrDqt9+XqvB9+J2W2vO0GopUWi4/aUIY2lGnt0FY7tfSZhrs5wM0N
	K0AcRmSaVHuj1+gJlXeu3v1BQ15WSxEu5kgsU/HnkP5wMt9InfW4xREp3PyCOVTQ
	tuWtF2DKwcA4YxsWhXnV3TTQ8KBIPa+tdj0wCmbReP5lHabtmZWDGOK1iEeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785443088; x=1785529488; bh=qFoMvBiZBPOKB4l12UkhSWC/o2Z1SELdc2m
	fYNtk7PM=; b=FT6mAUbGV8tp1gPbvt/Za7WvhNdbvF8RkTRTaW1rYbH1OnHCDSg
	SE9FVLmdqvR5WKiXJsFnlbQYrWv8OqaRw7EUTM7KUbu52UXSZQnEyLHEVXI1WLYE
	J1vhHKyDzCIm6J0cvx4o4U0ba9AoTTciPuu9GHRPjsTiNOmffb33aAj5KBc21IYB
	5/V/SB0zTWMLeVr0wgA5smrfxpwfuiklIVvL6uTA+DFR5U4UNJq4tvxZaNoxe3Oi
	BDL+DT1WJbU0hpoO7ElTHPAuCx/m98RGvSCt6Z9B/XzZxS2Tg2ymtn5B9jmo7QFb
	qNGt0blnWRE31uP1jUV0pesa24085fB17og==
X-ME-Sender: <xms:ELNratxOiEEbYlOsK-wyhF2m-15GGQ7uIbkD_I_T-zlfIQToJVPOMQ>
    <xme:ELNrakszhYohxCFnJdCroYpEklSpJn5XNUGJ7iuQt7NnDYmzgP_dKUSSvkHDs8LIZ
    vOrq3rZWPBl3mbzYHSyGTbc5KnTTMkFAFNjaAgndxpWS2GN792wfnQ>
X-ME-Received: <xmr:ELNraktBbi4yYJDWBRBIfJQmQr3dc6bjuuBqUjYeWfP0x8uYqfDiiFIVWrKXVRNnY5GfqdEvpUyANJ2aJk_PC3P5zitpJ_zyMA>
X-ME-Proxy-Cause: dmFkZTFai3rTaRGNHcrrwF6cPuiAJtVeXUeqUNlo1hn8GGM7n0+/tiEaeZc5+9HumdSs6N
    BzOEQ0AAvtpLPERerg2PR2h7NekPU+a4amX14vCd13HsUHwg35CJM18HTn9RZGm5Rk9McX
    pjv/vKvt5gRVxDtm7tk9fUa26ENXwuM8Yxh5pBcKU/RAIt56bMjVled3Rx+ESHOC+7fEIF
    4dgaKwQf7vMIFLzV3OYVjer1+E1NWu/wQSg4C5T12X+Pgq4WGXOltGqNustDrGziLiih0q
    PFSI06QXeiNy2dD7Fj+cSK4rY/3V7J0rzDe7LetuRALWUp/exMzyLIGtH71v0+jOybzjMl
    S2mQoBpFL4Ui0sxjwbopCjZM9/zkvl6om3fK6O7o/LI5oiwx7WvuZUAonk+yYrKQwPvre8
    R+sOfF9VUsBjxUMAmoKmsv5nmH6aGiRQpQ0teaFSFUpMy/ydV/QipoxbJl1WElvcm33+Dn
    sbhnnjnwWMYXbcRjVamCk/zK8P4IfGk1jis+j7Nyjx58hSDZ6ic5cKmAgmnfUq2XzYPW6z
    1/afhIe3URtQYFNbn2wgVw4qRmvQG2F9GodEX310Z1u18zOMaZWcruDyh/UTRbQviyPVxu
    pvN6OEbHRZqq/PzS0A2hT7eRvs/EYTb+AFNRsrs189BjYOnyrDBYI8lkCzVw
X-ME-Proxy: <xmx:ELNrapOyiffstvs8A4RkcjNB6naMPU4gwBFX1TQz3-LPR0PIOmDkbg>
    <xmx:ELNrai2W9p8Ejpwxjfc-HmCMxjnWPDjPEdyqdkgsGYBEw709Puq62A>
    <xmx:ELNralPg9yjgrynS9gJI4D8uoT4UNBWWejcRxFfGGl1XQcCEv0OrlQ>
    <xmx:ELNrai0fbFkpGLS4logJGkBFchHv4ZvzZwf9VcdKnGNcQB75ss92YA>
    <xmx:ELNrai6WTtwYSvAsPqoCiFF96yb6kC7gwtPpecHHsaD6WWrOLYotQ0nU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 16:24:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nils Fahldieck <nils@fahldieck.de>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git config --global: doc and behaviour disagree when
 ~/.gitconfig and XDG config file coexist
In-Reply-To: <CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com>
	(Nils Fahldieck's message of "Thu, 30 Jul 2026 20:18:43 +0200")
References: <CAAdFe9yhBk-WecVzCTsjQ-4Z3AZAbpP+w+B076ouM3qX6d1WAg@mail.gmail.com>
Date: Thu, 30 Jul 2026 13:24:47 -0700
Message-ID: <xmqqo6fojkds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nils Fahldieck <nils@fahldieck.de> writes:

> 1. The writing claim is inaccurate.
>
>    The docs say XDG is used when ~/.gitconfig "doesn't exist".  The
>    code tests READABILITY (R_OK), not existence.  A zero-byte file
>    created by "touch ~/.gitconfig" is readable, so access_or_warn
>    returns 0 (success), the condition is false, and XDG is silently
>    ignored even though ~/.gitconfig is empty.
>
>    The condition should be described as "when ~/.gitconfig is not
>    readable", not "when it doesn't exist".

I do not understand this part.  If you have a file that is not even
readable by you, it is not very useful and no better than the case
the file did not exist.  Also, if the file exists and readable,
between a 0-byte and one liner ~/.gitconfig there shouldn't be any
difference in behaviour, no?

So, "when the file does not exist or even if the file exists is not
readble, then it is not used and the other file is used instead"
would probably be technically more correct, but I am not sure if
such a change has much value (unless you are trying to be very
pedantic).

> 2. The reading claim is outright wrong.
>
>    The docs say --global reads from BOTH files.  The code reads from
>    ONE.  git_global_config() selects a winner and frees the other
>    path.  There is no code path under --global that reads both files.

The documentation needs to be corrected, I think.
