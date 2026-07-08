Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337338424F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486339; cv=none; b=kdnvMtamg4vd1SRXHLYSNydEOu38XQkNZdUgJs+z36EudaYShvna1N+pVlS3X8hvsDygVWAT4cNHgdxKdHnbgtuMSh/BD5k9jxno5/D2SfH6hKQlVB7bWk6Q1vWACxiAVs2uHmO9ndZ/jisvf77StKjGPZTU3wgem9LjlJXZHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486339; c=relaxed/simple;
	bh=O2Rr0pUVU53WQG2D2TmZXq1Wnin9cuAqS9Oy7lhEhx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0ED0mv/9y4i23HJgVeJmQ6phl+L8TQD4Jqm8tw9UlxkFvoUkW2NasgcMgGWQ+aaoT8p6pveevWPQQ2q8D8v+4KDqaqsMUJwqHzsovFtOMCDAiNFNGL7rXaqQehzBlteHEblM5JNus3lL1i/jExTYoVF/H//g5lEEPtW6wtrNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YyXW6Ja5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOoqszV2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YyXW6Ja5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOoqszV2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id A1422EC036B;
	Wed,  8 Jul 2026 00:52:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 00:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783486336; x=1783572736; bh=iv5XL14crd
	4zxigl5+D0+1WFdbPVrn7+2OK8TbtIhlU=; b=YyXW6Ja5WIbUNToI1J1L7PS/yH
	O2dP9F66o2XoQ9hwx1STXfZpfH1NgzRJtOjVCM1gqQIiad/SqsFauvK1ackcAoXZ
	5lm/d8xLVlpC9wEB73t9uprgHGe2rQ+IFfms9C1LRzyOVDyfpW83nybhV4IOm5X3
	ScfQXOkq8Jbz76pLe/mfKG+C1I5fzvwVILgUxYRRjxjxXkiletOTI6yhk3sNtaJR
	2MVtZ65EIPFEk4yZlKanDESjTRw+nNp112g5OFYF7p4YVXBEX+0TtVxm3kqYf5q0
	wnXfybV1lOH+lLRkhPdQnfgSjHrz+/dCT3W7EdDmAMIZHwdH/Je542nUT52Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783486336; x=1783572736; bh=iv5XL14crd4zxigl5+D0+1WFdbPVrn7+2OK
	8TbtIhlU=; b=LOoqszV2f/7cDRs0UTiXDmblGWIhtAZrcfzEAeD5vrqWJSQGHId
	PSAUfhLrHRocE3yA5OQay9mZ8TSImICYJGEKmENYjsfZT9+OUMrmT2wyJEwe702P
	8B42kruhP/K9aBu5Q9mWd72dzaeyQPLlp3l0jk8bspUgmKfstL11X0IR6J75X16u
	Q93J7mvbnHUtshamJYWHU9C9bF3NYEw6yoMeJTzabw3B+gi+LdPOf5ljFrhc5WYD
	VQ+FLvcdkhFyHNvHZSPthXIGFMXFFFmT9hQFwsFYjIUDt3ToVSuUCTWIuW9UblZS
	M2vE4R7c1GPB+HhArsq1LiS5jf7evIqiFWw==
X-ME-Sender: <xms:gNdNas17LUX1PIk0VgEADm2FI2MTMeJJDMKl4ySK8qBW5DJ5iAWxgw>
    <xme:gNdNaujbZepPn7wp0vOgRDKlxlMhtkp7wICSbhv89F42BjavmkG1ZKZ54-Dr4f5Sg
    _bU4dNjeVWs8YwbLPQ2vFUBzwmVMN5YsAIuB4k3vToebgw6nr18IQ>
X-ME-Received: <xmr:gNdNaiQaT2-aQnNXDGFD4zjP3edEAEPrHx18ImQhEAWL11BwTeXvq4RDx63tPEGJY7jMo8JFBSLaVVjW9vkKDC5P22cdUXCUc7LqB_Q>
X-ME-Proxy-Cause: dmFkZTG1xduJ0dIilBT7dfOcc5Zcm2qjD/195udQ7mg2YWlVXZACc1qtjKMbDVbZq+5HjA
    TNy2h+q+6mmlGzsIZfz7MtOZ1LGKCGMLvlUWoQK3x+O2EXIBriHlzRVSfkF7b35bBZkJnA
    m+0k+uQunP84X4WKI3ga4CoHTDXQUcO8ihvhh2YtO7e89bTPbl3OkAe8VexLiORF6voyXm
    1XqiY06igmhJvlMRXDGSIn8mq/xc390CUCygs+O/Piximrxqg2hyxqlSYv4h8R03WMOllQ
    ++8DQdz1b2hMaFJZSIND2wXFtYjPwyomp6LGI+IPODkQbWesi+Tn/mTpDMOAd4zoX1KhbX
    mqAbU2naw53qqcSS8oZ6S8GcleLsaKENv7jp+kPXqUwtOP9lyGm0z9vhuSliWhO/UnsQM+
    JxQ0GkiTk1mlANVAm7Q76zPviWgcrk8DJubdK6/Zt4BGXWdsxCjX+jBX3Jjx3Ak+J98/Z0
    Flzf+iTzq0C7VG/unnv+/he2s//B1LjVbRZ+hpvJRalbV5p9008jGdyi30YyUgGTXZV6EH
    IbqcHrwHSqPPpKc85cRN6LjvTFbObM7A4gDFZhK3ccNQ/4CoYTQl+nAHI9dcBsNSFuTC3q
    nS14bZWuoQXyqzMa9H/S4z4CO74WZjY3h+wOUj98MhzxN19lB398PepYHQFw
X-ME-Proxy: <xmx:gNdNavj8JLCP4TikMGJ8vsC4ptqVVKNzFZXnPJSvu3x3mOFdDhDAWg>
    <xmx:gNdNai4BCOpE-z3cI-AVdX79NxPf3TcUM6PX_4v7RDSWcIpAW4l2Nw>
    <xmx:gNdNasBVcduBx_nPHWpHAnxSwrKHd1eCk0MKdphzPncBrvoSPkjHuA>
    <xmx:gNdNapYMHz0I95QAnP0OlgFYp4tT49eH5800G5K0xAAi1t1nALiJJA>
    <xmx:gNdNaih4HmeVr5HajC781IVokkZ2vucu8F1NpXrLTmjnpCiTSfVE4G4S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 00:52:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
In-Reply-To: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
	(Michael Montalbo's message of "Tue, 7 Jul 2026 20:31:24 -0700")
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 07 Jul 2026 21:52:14 -0700
Message-ID: <xmqqechew0ap.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Montalbo <mmontalbo@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> +  A discussion on the list might convince you that your changes are
>> +  not such a good idea, in which case you are expected to explicitly
>> +  retract the topic, to releave the maintainer from having to worry
>> +  about it.

...

Thanks for improvements.

> Finally, maybe a rule of thumb as to how old a topic a topic should get
> before a "staleness" update is provided would be helpful, or maybe that
> is too contextually dependent / would potentially introduce some
> unwanted scheduling contract?
>
> Overall, I think the explicit guidance is helpful.

I've been working on streamlining my workflow to manage the "What's
cooking" report, and writing down guidelines with concrete numbers.

 * When the discussion seems to reach rough consensus that the
   latest round looks good for 'next', the topic is immediately
   marked as "Will merge to 'next'?" in my draft copy (note: I do
   not want to spam the list with "What's cooking" too often, but it
   is the document I work from, and it is updated multiple times a
   day).

 * After no negative opinions are seen on a topic in "Will merge to
   'next'?" state for about 36 hours, the topic is marked as "Will
   merge to 'next'".  I will merge such topics during the next
   integration cycle (note: I can only have up to two integration
   cycles per day due to time constraints).

 * Imagine that a topic was last updated more than 4 weeks ago.  If
   there are review comments on the topic that are left unanswered
   by the author for more than a week, and if nothing happens in the
   discussion thread other than inquiry on the current status, the
   topic is marked as "stalled".  I will try to notice and ping a
   stalled topic once or twice, but after that I may discard such a
   topic (which by the way I really hate having to decide to do so).

 * After a topic is merged to 'next', if nothing negative that needs
   fixing is discovered for 7 calendar days, the topic is merged to
   'master'.  I may shorten this depending on how complex the topic
   is.

THere may be more, but these are what I can think of offhand.

