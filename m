Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A93793BE
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104283; cv=none; b=tGG/IPqqBhnnZuig/91bdQHHz9sOyejqn5r3NzoTi7Lz9RorIauTP/vRoWsP3zvuyX5Z0bb87I7B6tp6ueN7f58Sfvv5BEQBVsREOiprP/oM/MI9bLgml6jSLI8D7m0YuitBOoTxvrHO7XK6Ko0yygNEX+3HqUrww/rbFloLK9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104283; c=relaxed/simple;
	bh=DSSSWa11cUNZA4+4MRBifYWxyDzUL3yMyeiqX1yuUSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nm2zvxWJtU9RNJsarcKSfpAXiOqk/F4s2Enx+KmCWIE21rvNCw2Z8gbPl2JwZ7vlFJ4foN+McZLkmM3+4RM8jun0IYjKEDIX/w4prqz2aI2ODkQybJ5FfGeUUbafCGBCuivadS6B20t88qKNX4omTqWRZ/pIg0GXTW+8Seus10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EGzn3VrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sxv3eS6p; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EGzn3VrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sxv3eS6p"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51F0A140019C;
	Wed, 10 Jun 2026 11:11:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 10 Jun 2026 11:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781104281; x=1781190681; bh=Pfmpvpo4gG
	q94Ljg23hH5ZQs3g4M74aqrdIb106rIVU=; b=EGzn3VrSlWEZTLEIgEybFKRhxn
	kW+0YStuPeG9vnc9+sS2OnBALJ7UkeatDzlytYN7SJ4ISXgoToMJSJqVSU3NOF0A
	n+38cHfgnK+SJa2yDuBMiEoK6N+lsXqxMGopUpPyIUxBHx2udM9Vh/tbvX/OSMwZ
	PtGgAsodjJuyOLtscZBPjPYzHTQRdRycWyK2byLE1tKwpVEN5Z21V6FrtPhVzRqg
	FJ7XCN1agJwaGOORjmWmXENYykj7zFejjt2Z35CLRrOCGmtRyIkE7uEjhU/fB9j4
	Jwku+5ta3noH473a5alV6MYxumrt0JBSXQXcjQXAgURKWJqqT4hqryRLECOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781104281; x=1781190681; bh=Pfmpvpo4gGq94Ljg23hH5ZQs3g4M74aqrdI
	b106rIVU=; b=Sxv3eS6p7P+lfnEcKRHrHc3E/FDlT4N+vjPmRh7GgpZScMrBEyf
	0379fJmLBjWLvsL0gekZyPOMTtSsXVnrM0/kuQGg6sdKOeuGNlCktIeWr8903Z7v
	rTz8+dToYrwXTXj/6OgRJ6y/3lNHX0a3UnXD+exXd3/Vj2fqXObyD+bW1+g1tdPK
	fERtnI5z7cU85BF78RsfHgKQCPfL5X55qW7UI/+Ntk2OxVddnHm9NPFSN0NKQeM7
	TphzewUAr2mXQaqvAB9CnX7IHZR2dE08uAGeQuMad6trBHDZDcOOKgFPpIrOcq8O
	sTd1JgKWQW/+qTJ+aRxp6OYIYC2RmmUcthQ==
X-ME-Sender: <xms:mX4pahYjUJJp5PfKw229R64UPXwaKrDEHne3hC3LGGi7c01MM8EQ9g>
    <xme:mX4paq-UoOptHM0b_1bgrL5Jh2FwGDJS2XZAn2aI86PLOnPQoI2mss1QxLBRj0FGG
    bzzkfWeBt6sQajUwvqFDk8QSH4OoO8n6G7CIkRDuuJcITdZgIjG>
X-ME-Received: <xmr:mX4panldZoZoKRqGS5ULGnU9k91GqvSDvFtXI1p3d5_RcXk24eos0ip_BSnzXOTVoE3f7p4Nxs6pzimR-Op-8S96K5iy7vB3c-ck>
X-ME-Proxy-Cause: dmFkZTEPNgjztxTHLn4gIMyY8ZrdPuzrvq+LSnPDG9YMB+FkBznvB3zgz+/hrb+ps+gNlL
    qEEBVb4DRcw/Aqn1ze+2Dqt63kfTvAEJcjU6mVJzFtjpQSfrgLxSAa06vInYc/fpUJQwYg
    OYlNvSrBscEqvKqaVRxJ2lzzDjv6n7CwC4bpgY+uZ/jX1TtNd3zybQ2a9ArUjjTVSzazxt
    TAzPqP9XR+iP/XsfjeARxBunkZd5+YrPHGc0hCnVI677F/a7wYWlpevIIlbqPdPva7ibxs
    6rzy2Fb5ebPHqMIPr7ZTefD5eXaayLlSRiSOmZ865BFBfqKe9O8DhmM+ZmyaHh7qDEEQmB
    oOCmpJqBKWSOVoU0D4I0847j76R1jumhpmZX6n5gEYDvMZjdGAhXEjXe86i24WdZguPIwJ
    j5JMLDCHJ/KME0PCgrUIwdHxafqqsFUNuYIv817ttReApSIsMt8SUpwvIjG2uKdwTz3E93
    qMC7bRzBd7KBAeMlkr7fYRo88OvT+EfjZx/VIh2mO2gdcE91R2xF4FNVBtQL8qVexCifxS
    myX9A2+yEbEQaItE3fFKuA8LLBACGrv5oJemJjvfcNRuJ26tuiP6zg/3nO2/deYJSeyT5A
    9kjB976lsUvdEvL4Br3fKZSZhR4K4OPb0OV9Z7X1mq9OoDK0XAtqCW2iv0yg
X-ME-Proxy: <xmx:mX4pavw3qVhLh-fPUPglWWYAWaKhkuDzMI7U_umpRzPgm5Cli_J_Zw>
    <xmx:mX4pah5uKW6oG0wbF8uFy48pL9Z7JDGeGGSQymD8FVBPmbPeW3OE1g>
    <xmx:mX4pavWM3LnaMznPhotwD-FnzRfPF_J2E0B2iVbugHWxZTM2U_FaFA>
    <xmx:mX4papIeb3oXFn4DGc9OcDz-3sHApXx6p7hBkOdU543Q9g0NrQ2fHQ>
    <xmx:mX4pahuzS5g2WCrcCFQhJHZO14Klz6p7UUhqH-8Mad9LXZRJfVHJgq1f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:11:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Elijah Newren <newren@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
In-Reply-To: <877bo7294j.fsf@emacs.iotcl.com> (Toon Claes's message of "Tue,
	09 Jun 2026 14:25:48 +0200")
References: <20260519153808.494105-1-christian.couder@gmail.com>
	<20260527140820.1438165-1-christian.couder@gmail.com>
	<87ik7s16sg.fsf@emacs.iotcl.com>
	<CAP8UFD0r96KxU3kW2khJ_MySgtv0ZpU26KR1vNimp_FwigQfXA@mail.gmail.com>
	<877bo7294j.fsf@emacs.iotcl.com>
Date: Wed, 10 Jun 2026 08:11:19 -0700
Message-ID: <xmqqh5naxwfc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>> Also I think it's easier to explain that 'acceptFromServerUrl' is a
>> different mechanism (that allows auto-configuration, contrary to
>> 'acceptFromServer') if these two variables are independent.
>
> True, although naming-wise it doesn't feel like that. But I no longer
> gonna keep picking on that, so ignore this comment please. :-)
>
>>> What do you think? If you disagree, I'm fine with the current approach
>>> and I think this version looks good.
>>
>> Thanks for your review and for being fine with the current approach if
>> I disagree.
>
> Thanks for explaining, I still agree moving on like this.

Sounds good.  Shall we mark the topic for 'next' then?

Thanks, all.
