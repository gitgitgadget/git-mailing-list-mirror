Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8C726D4CA
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299261; cv=none; b=JsOD+lZw1+/7C9LXjG3/28qKK6gcXv4ljHEo08CrB8+6klWYOUINbUjUOjKH4WZcr9/yEjD5ZeebkGLRmiz/i5tdhx0PXkcsoPRoSsRxePm0MOKg3D0AB7EkTqQqQWCsy7qqdpZ9aGRevZc6lp5eRdj4tRBaYvYhJXRlNBpDvsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299261; c=relaxed/simple;
	bh=zd1JkeSjN9+1GrCIdQcvG7YtmqUy3lTfe3o03nM899c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=COngXy58Epoq/QEvMGJjsUkCQqR3y8WCCQ/qbe/0qCEFuPI0PZ0b1PljX4SNvUNZml0bUYKxkUzFj8BRxgihMNk8fDw+qkeyEpqtD/+m7mMkLGq6s0ojxhzSzdXGChE+Ukw6J8gzI9AFa9AsuuWuTA65xYbNneOhugZqSDJRw9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z+YlU40d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WEn+fWa2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z+YlU40d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WEn+fWa2"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id D84A41D0008F;
	Thu, 24 Sep 2026 21:20:57 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 24 Sep 2026 21:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790299257;
	 x=1790385657; bh=y6dj+lyiEYfoIBuQZEysSx5Izwu8UeuwoIVLbwOavLg=; b=
	Z+YlU40dEFP2RBvI3gRFR8me/w6V5S0pZDZ4XA91zPAG1rX4fIKp4U9iQeymJH+8
	B78qCqq7guIYB1gJ3ky3AiqtqO1OAvXE6EoTtOYUvLZ3C+lcCD/scSfklS6rdvGE
	SkTBGVJIT7OgOBjVJwdLzyNa4xbNdPIsHF4QdLevAn+CTVVeg+KAgIg7ngiDdvAg
	3RjB1YD4lGwA+4spHoJcTZAek/f491/rQoHtx5KWftr+S8BDqnyfFg5zs7tHErzs
	G3R7qLE3MAFoRxIs4qhjLphEGAdEnLj5CYEUqTNAweJqhUZgJd6Wb2stXCS7rQPV
	QNmNZJRhNJ0w0nYrEWS+FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790299257; x=
	1790385657; bh=y6dj+lyiEYfoIBuQZEysSx5Izwu8UeuwoIVLbwOavLg=; b=W
	En+fWa2iZtIMZbMAFYg9seq2t2+tpxjNoYIGQLAGaFdXmrTZvr9bky5dzfe91bhJ
	fXK6dkxDE0iaitYxosSSiBUW+nAeqFJDlSpwZ0XBofZFUyfb7JN4swn9BSwbIbH2
	qze2VdQFYa+dgoh5ntu7lp2ANQXNYSrNdFrBRHmIeV14QxiVJhJjMDwfzJO0icA5
	dJ9FZuE1lLYermuTdFLIvk3V2xSv2NvmHTjY2jnry94TNutoG96sf7cMnJ3ZuafV
	6gmOmhOH+yaURvaefSpPjLO+Ht8J5i0i3k0RgRzyTnv5fQZHT9wis4Bc2jZ+lshr
	q41QV9dtXAZLFrUahg3Kw==
X-ME-Sender: <xms:dcy1amA_gaHS2X7cMm1A2R5H-oZEjRsMaS2vxWS6ZVZBQIJwDw6enac>
    <xme:dcy1arUPB2sTbFtgxE846ndQbwVuy6Gi4gucEClgq5_N3WH5_sd4e5quxau8AmSNK
    pwwFyWOqQ_dJ7LdQpQ3QfYojibhsGckdFMYR5truW5qwfWQ1cgY04I>
X-ME-Proxy-Cause: dmFkZTEdtov5Gmwrs4UId16ZA1v8RZw4jM3m5lZKdkvP5jHe6hJBjZIEk3c+hEnGyxzHqs
    N2W+bfkjwG3grQEV+liF4EDRwuJ5VgLcte2kB327eu9R8F9KSqIQPrJv2ezDM8LLkclOJF
    /sI18JqqmD48zOv8/EB+cwX43hG6ALlHg12PAf3ZhLqeLPnFAyYPApzYf+VgM7OLn/bn05
    76i+MAMJshYLD2dGK0Nn2DISD0pSOFTnqqoTkEJrunxaTIkfaAx7tu4CyeTinObwUxxxmv
    XUizZHND4PJbZhOGWQZ0b9vx4ErTyMBo9MBhojtk9GFlTxJA7aULKkgEpH9DajxesF/Nak
    S4OcTfIjDecl5Rn3Ra3qWapklYXb9iJran+1qmTl8Gh9VLcSYnOK40F+kq4Lg8eA96ePMZ
    Oqo7aMD0qwnuZB8l62xDL9Y0qYzEq34+ZfwninjlIhLEuJrhMCRhln4mMMuXQW1KKxAVv8
    KjS5NaA2bOiwuCBU/byg6eW17+1xZSNtGfXpDErlYTlsw+uDVQprPSfWR+kO/34JX/jSIJ
    B9xyZSaZj/z3o/0cEsMI4/9d4bl2ddWC3g5H2ykMz2F3u7VAoz9uRsUcRrmvAr3WwE+MEV
    6F7Ja+XdO2vJsKW71RPdUHFSCTZoCVfb562F9Mo6i2cyJ72aNaUjg4iNOZFQ
X-ME-Proxy: <xmx:d8y1arHq-zhAnnV3ytHKIlLOElFc00xBn7s7RywvW1dVeUP59RPIVA>
    <xmx:d8y1ap0d6_bGLp-x19fcU4nfBOWekrIqHhgi3nseeE-Pl0R_iU3UUQ>
    <xmx:d8y1atNmiAbiOXcLhjusSmSG6EXubfT0C0t_hANIJ51fRD1NrYi6Wg>
    <xmx:d8y1ao6z9Ry9xK0GK5CjwDiIx9bETWUglmB2oLcidcbaPLlP-coCkA>
    <xmx:ecy1aiowtfENjGC7m3h_iYHRrE8RWqx8vDifuX3iTuR1bTbiqfsBSOfB>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D396E22C0088; Thu, 24 Sep 2026 21:20:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQDMfuU0Qh0w
Date: Fri, 25 Sep 2026 03:20:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <0aaab5ec-d488-421f-b99a-330c1a851fb0@app.fastmail.com>
In-Reply-To: <20260924183523.53201-1-haraldnordgren@gmail.com>
References: <ap50kgyenpRrsqln@pks.im>
 <20260924183523.53201-1-haraldnordgren@gmail.com>
Subject: Re: What will come after Git 2.56?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 24, 2026, at 20:35, Harald Nordgren wrote:
>> Well, same as there's room after Git 2.9 we also still have room after
>> Git 2.99. No reason we cannot have Git 2.100. :)
>
> I agree completely, no need signal that 3.0 is coming until it comes. Once it's
> out, not a soul will question what number the release just before had.
>
> I have a list of breaking changes that I would like to introduce, I was hoping
> they could be considered before 3.0 is out -- otherwise I fear I have to wait
> another 10 years for 4.0, I would like to change the default values of these
> config values:
>
>     # Autostash by default
>     checkout.autostash=true
>     rebase.autostash=true
>
>     # User friendlier branch sorting
>     branch.sort=-committerdate
>     tag.sort=-version:refname
>
>     # Better diffing
>     diff.algorithm=histogram
>     diff.colormoved=zebra
>     diff.compactionheuristic=true
>
>     # Compare branches on when push/upstream are different
>     status.comparebranches=@{upstream} @{push}
>
> It seemed a bit presumptuous to submit these as a patch, but maybe I should to
> open the formal discussion?

Changing defaults is difficult. The code changes might be small but you
have to convince many people that the potential disruption is worth it.

On the other hand, or on the opposite side of the spectrum, a tool that
can read your configuration and recommend better settings would be more
difficult to implement but could be easier to get buy-in for. This would
be the next step up from hardcore Git users and folklore spreading
through blogs and whatnot, thousands of users setting their version
controlled (of course!?) global Git config one advice and word of mouth
at a time. Just a plain old program that reads what you have, makes a
report on the tiny little part that modern Git practice has an opinion
on, and recommends the modern alternatives.

I have of course seen this idea on this list before.
