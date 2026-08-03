Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB94342C9E
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772969; cv=none; b=r3SOSJet/Sb4XNz+13Zlv2dZg+aiWpWM6x2gufMQ8fZbVZusEWvyrTDaNSy3HvhH7D8ks8xAoEsfUG/b/mS5WK544hiJPQ53ImyJf2LpP1LtobTlWXm9tJ8ykU15nJEB29clNAqTd+jrxq5u3Xan+hMn4TQT3142/URu1BJPDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772969; c=relaxed/simple;
	bh=f5JNcQF2+l5ZdKYdX3RVOFWrizTyi3PExYBXTgtYDwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfqm6tzknaZfuICvAO3tv0nFNkCzqUIRT2o88UYbAzYVp0TiFPRfPLmnrerjJEmHtykeDCBSTfmYnq7phKpbYH0KeLmyso5vO2GG+yrVHBry4ws7hNOyHPuFzA/UKo75EDZYm1U3jsqigaoieutWei0zV28h+9ubC/bmp0gUYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vM1hmSGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PvjNV7GU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vM1hmSGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PvjNV7GU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F5F27A001D;
	Mon,  3 Aug 2026 12:02:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 03 Aug 2026 12:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785772967; x=1785859367; bh=zpQxoAQd2H
	sYMtogMGsCuA9Lfeqz0d4tziGwZGkh5os=; b=vM1hmSGxIhdLAcLjn5qDysCrUs
	spYJLdQ7D8jFZ89NHbs/KaG8BG5pX/5pqccAb8KK+0XMVcIjZcT6LQDAS9yG1lqp
	HOk5uzDlBXzmtCoCD3Br+F7Ae25+nMHB0HpDK6K3M+7GzaH0KrOitGStTN8MXop4
	YksGOK1MOlXNu7dNoZmjoi8KLTYpjHVDAgsOFD233XUDtdFnGSgt+3Ef7DuW50wy
	9xH01tMe51nUCq6Yxv858LkasOdvE/8vBK8lOLCCcTaPnGjANSPIP5TFlrmGVQPW
	6h95VYSk6YOm3iiTRQ2XD8BIUb8H929hZa2rFp9Tz8kU03rEs8E+FsrtOz0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785772967; x=1785859367; bh=zpQxoAQd2HsYMtogMGsCuA9Lfeqz0d4tziG
	wZGkh5os=; b=PvjNV7GUIk9zAqlEsPpP6Id0g/qeEe1kDvPO28zdoQ1cI8/SUlw
	a6J2k1z/2XEGAqPObugiVRjvmOBz0QZ3VxIhPxV7ABK092aBpy+BU23B3QC9Fv2e
	WEHxmzTaTrMoxaYNf+GMPwELSaE/WzQWf9l+D06ZpuTADapvkO3NIQcexSqqVG32
	w+H+V/bX85eDgJtYUSo1F84JEdhJ1Irr9QpFFG0eMDD9SYUFSL/+zjgKoh8KD1R2
	sGgwj0uekXPcre5gsn6m/9S2iI9xuaYljJvzPWEAq4bHh7uqhjV1LCcBSCiY3ouw
	P6G+/1FBp0VpW2ZugkZbeY3079xSsDTrU0Q==
X-ME-Sender: <xms:prtwaiudV1LxxOeeQLwFzgPXU2RgwZOPX191h7Yd__98O-GvkXtVvA>
    <xme:prtwagz9E9ifb25i2UIbF3o3GQSZ2FWWPHgRU-jaZRprWTTq8wOwiiSzk3Ohs3oD8
    PJBBMQbphGgvkfjEB_8yO9iXHWj8-nK6L6bEohqb_QNMLr7Ibow6f0>
X-ME-Received: <xmr:prtwalBVYQvXW3fJHQzx8y7qVzv11-zpGirjCnkd3NqnIfleBs3tvfeeu4gZAYDVXsFn_bzLD_SjSUNUZ2o8I1OMttD2N7dmaQ>
X-ME-Proxy-Cause: dmFkZTGc3mWhY9hG98sE4tFYF69biO/rx1a5EU1MKWkGMxRuGV1ButwU1E2eUucj3gOyXN
    pTm47Zouq67sMQN1JdMYDN3JBNMkURQcPjfhGUihOEMNaC8dFaVIzhZCajjE6EzDHmPG2R
    nSUkjCsRRbNoWrFhBzgJ3O4F40VXNv+rd3bvlbrrdxUbkM/mNR3Bpzwx/X95IcZMQbYudD
    U9G7zOtPKqBjWN6dhPTmvPsRlSJJrNB7p+c0MhheRPA/gw85sfFYvG/koSRmRxWSeuOsbp
    Anx0AbbxbfHeCMykNxeNmqOnJ3CJl/x6gFKYE0/+mD8JA8tDS0JXyowMPBP0GWJBwu6tka
    pR66tnhzlP/J+RZD5tUq9VkMmt8taRzo5PYEa8uoRJFyaZpdnpErtNqK+gWtLvsUb1D+Lz
    EQEh4733pJnN2wI9AqAMqlYPe9RtSTYLwBRNG3x2I9CQ15BM+gh0J6cm/eh1jMBIOWqbs/
    9PP0jVzAN34xUoW2uklOsFFYIsVauAkdoDIm9Ue4V4+QmzqSgEs5LNvhzfeHTfaAqT0loN
    Ewx5toYd3lbaAzga+Hba7+bG5pzqdMOs2xTk1SiGZdfmRLg2Jc+U2q2vEoJe7EWuiWIRHk
    7XAihW5B4pOa59qcUzHXweV1QFoQGypNsdUNUIfz+TQP38lqZNsPlXa/4e5w
X-ME-Proxy: <xmx:prtwaudRB-AvSnaZSqrM4jx4166bNdMoQIavDxYxZ6IXPgULkg_PyA>
    <xmx:prtwavnfr9eozYtvTasjHFnV8CPCKZuNcOQUNfMmys3BxQZ-TV8ITA>
    <xmx:prtwalEXdj9ljYPVPJERrr_tQpZqqTvqEOaIy_hy10gKi-f1f_S12w>
    <xmx:prtwan6PKsa24GV4JzyI7zuokjy4GhrGmolIUtiR564c4SBsZP5uGA>
    <xmx:p7twauItwm6BuXK00-Fh1cLqIrHO14RbkD-KN3U9P69LnYqNYwaNq_dC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 12:02:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Matt Hunter <m@lfurio.us>,  Harald Nordgren <haraldnordgren@gmail.com>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2026, #12)
In-Reply-To: <f00673cc-afc8-4a4f-a668-e22c53b46181@gmail.com> (Phillip Wood's
	message of "Mon, 3 Aug 2026 10:05:15 +0100")
References: <xmqqfr15ruw7.fsf@gitster.g>
	<f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
	<CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
	<DKCKB3HW6VJA.19CQLPOHR6WTI@lfurio.us>
	<f00673cc-afc8-4a4f-a668-e22c53b46181@gmail.com>
Date: Mon, 03 Aug 2026 09:02:45 -0700
Message-ID: <xmqqfr0vyyxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> If you raise a point and it is dismissed without a convincing 
> explanation then its fine to raise it again asking for more details so 
> that you can understand the reason behind the decision. That often leads 
> to a productive discussion and an improved design.

True.  But because "convincing" is not black and white, we need to
be careful a bit.

> That precedent is unfortunate, "--reedit-message" makes sense for the 
> "fixup" subcommand because we are reediting an existing message but 
> that's not the case with the "squash" subcommand where we're 
> constructing a new message from several commits. Given how new the 
> "fixup" subcommand is I'm tempted to add an "--edit" option and 
> deprecate "--reedit-message".

As "git history" is marked experimental, we can afford to tweak the
UI for the better ;-).

> Having thought about it a bit over the weekend I wonder if the best 
> solution when squashing is to default to looking at the commits being 
> squashed before deciding whether to open the editor or not and allow the 
> user to override that on the commandline like "git commit". If we're 
> squashing a bunch of "fixup!" and/or "amend!" commits into a single 
> target then I'm not sure its worth opening the editor...

Hmph, a base commit with an "amend!" (tells the machinery to use the
message from the "amend!" commit only, discarding the existing one)
is clear to me that there is no need for further editing, but if
there is any "fixup!" (code change, for which need for associating
log message change is unknown) or if there are multiple "amend!", I
am not so sure.  It does make it confusing, I suspect.

