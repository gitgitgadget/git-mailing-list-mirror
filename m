Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3E62ECE91
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787877074; cv=none; b=YbMSLIOFvOwoSVXZC7JC5yFUL5bitBZq3URSOLKPOxurUwYFuhxY2+SDM85ShKJe7O7SrQp9/rgn8i1/3jFG2eK8Rw8DgfKrrzGx5Ezi+p43xsJKbC4pOjVfLOHDoUZl3qplSfTynKR1s7h500+z05jMfQwLZcbxBORLGhlEWWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787877074; c=relaxed/simple;
	bh=vVjiGIDotiO4WSK3xeUFvr4XfeJjGANP5ML9cAy3/ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhyrev6S4qhMZbjPvPXBhxirpojLc5KZni8IH/5tNjWPxP7STEU9FyqAwa74HdyZRHd8g6Bj/NSfv/2LqklozTzLUd664KAs+EZx2wE9AA6K8y8UxJJx4IFq6g5yKUj1eguM9ll4ufagleI4TSUCsodF9LqApk/UhnMu/fLzc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XSG8UWm6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSMlsag1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XSG8UWm6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSMlsag1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 37CBC14000CB;
	Thu, 27 Aug 2026 20:31:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 27 Aug 2026 20:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787877072; x=1787963472; bh=FmCSjUiIz0
	KgPi8JuR42dhd+S3+RV/LhzowiN3DhN8g=; b=XSG8UWm6vKeMJraF6WfBTi8SwO
	G6jHVRQ5OmDYNb77i5SOiPRQxE97mFDQ/AXkLnFYQOVzXoykAQ0abmqNlklQKNX8
	xx2QM5R14J2pF1LQANy9ECVYnwGfQLt1jwIA5/kUaxs9B/8mrDw50ggmXLga0hDe
	kq+n99t80KXaV/wFS77WCPewp64DPi7lG0AZsp1/DuDuTkcJahBdSaPi50EJbhQf
	/OHUFL/tAsdpzaPPh6OB55HjXRJK3y5GIWMWE0qTC9NxYyaNZop9+x0cyQQZVlg5
	O9tIRqIBCqX7PcwoLNuCsykMMGFgtI3Yw2Iqj8BDZcf8NZhqyQW8VbImRbWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787877072; x=1787963472; bh=FmCSjUiIz0KgPi8JuR42dhd+S3+RV/Lhzow
	iN3DhN8g=; b=SSMlsag1MbACq7WMq4jP994MOCkhr83mbscY4O/FpTQtxYkyEER
	ZEjdZTeLxhdZzUg0rolwgW9zNlJxIME5hv83o9lmBiO+eIp/6/0chg+SkSuxx/IU
	vuzjO+5ATBvJIePJ29eMT49KuvcZTyqojQRO2xXh9HzxDo+xoHSa9/ryKDnmvO9H
	wYD3jCbvkD4wo8SG9fPPWXQ1AuSbhpvZMCy9WHJYiDSvBkbD1HEpXF/9s6fO/lJx
	hC0YFTPuRiKQ8e3y7KT0Xype9QwGzlZbzAxcW3IH3KkNpgkvVd6270r5OwoBD+Xg
	Ux4Sr2X8WqxxGGE7wOwXVsQBgYS/tQRVgoA==
X-ME-Sender: <xms:0NaQamuAWKJURwvuyFlLPNgrTBDSEOVCPlsdFDbhAJv7_o6mw8K_9g>
    <xme:0NaQai7HhIF6-GTtp9QgC7KDH6O0wELVn_fGLkcHI9sKa0b6OV3fP7py48ej_OprX
    t6Wsva_YpUS_s3WYb79S3dl_mLgDRgS1lquWrn62VaRc_UOwlrYpw>
X-ME-Received: <xmr:0NaQavIqYies1DEkpoH90Lktg3nkqgXNleQgyxt6YVQo_Mr3YKjyKm3s0lYm65opZBEZrWfzxSI3prBoFMLO0FISP5AUO1sGNg>
X-ME-Proxy-Cause: dmFkZTGTxKsq1XuXQF09GFgMq2AB3DTal8LYIJJbDGEgMhm/z8J17a4LBdAA4NgNDRPRhv
    LzlDRrCO1pSZ28mb8Cu3PVWXQOvXzR6QjUFEHh9ONhND79Pwl2obZugV2jY2swAeDel5fs
    gAa0EziefJMnqlVEae82HlcEntSWTijJBCIR6y3cfeOpoSHhkHSr/VtZTt99dGTfbFuZDt
    si9tMjzFAbRaW7xjf6+FDJPDdjuo8ncbAqt5gAMDCxXxgUxeSY9rLF4NOdVxb3bHscbFoY
    58025itoz4K2GC+Q1R67R4emX+8xr0w8l6C1HTwZQLvh9iUl1DZ5UtpNVqY3HG5N4bB2Cx
    Sc3/rNLR7jaU4iOTj7qapbEChz84ptW1SvQ+WSufhyW0js2aFJ8LP6VPR9bvfnaeP6XiTy
    BPVWIGdmnwFKo/0pfuoYC84CnWRI6CGK+T9tJTTYCqMVVRr31pl5z6YCEwtR9f0jb26unr
    z9VsDZlJ6CKYxxFKstiRjkwnlXP3bRwJgFL61xQWdrCVXJCUZQgebj0baGSYWhSR+dvRiX
    QeXH+YVQpY1iR3CerBzsy8jBV+i57fle6Z71x88RC1gbOHkMykZb/Z2HMcTiIZc+8YwSir
    wKOVt0pjvWhhivgObnN8CWdq4+45p3lAWLi4QHCGMJNss7nl3bEJPitXZuuw
X-ME-Proxy: <xmx:0NaQaq44RFN37ypsEGbZA14gWFwYz5xDkJk2d0oFOYE4ywBWmGup2g>
    <xmx:0NaQaqzxwU1i6Sk3QoxE60f6SqriObDzdSvLcrE9DQip7hdq8DcXWw>
    <xmx:0NaQambv1Vf3mbKctvofAWhLtrEiSRc44CADOZQW56LAtw1w3DgU9Q>
    <xmx:0NaQakScBy86Vjw7E2TfmF3gEEYAS3R7iGsOqmXnS4pq6wG5cDEvoA>
    <xmx:0NaQajBkSfmGpzAMn0fVE7fjSFxUxVwO1pRNkpCJsEEYsZr-cLV6d8FE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 20:31:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] format-patch: learn --[no-]range-diff-notes
In-Reply-To: <16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 25 Aug 2026 20:36:50 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<format-patch_learn_--range-diff-notes.c5a@msgid.xyz>
	<xmqqjypfp2vl.fsf@gitster.g>
	<16315616-097a-4fe2-8665-010e424afd8b@app.fastmail.com>
Date: Thu, 27 Aug 2026 17:31:10 -0700
Message-ID: <xmqqbjan6q7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> Hmph, this is a bit too complex for me.  When I say
>>
>>     $ git format-patch --no-notes --range-diff-notes ...
>>
>> I would expect that individual patches would not get notes, but the
>> range-diff will include them in the comparison.  But if
>> --range-diff-notes just falls back to default (i.e., inherit what
>> patches use), would I see the notes used in the range-diff?
>
> You will not get patch notes and not get
> range diff notes. That --range-diff-notes
> told it to use the patch notes which you
> just turned off/emptied the list.
>
> Code-wise, the list of notes is cleared so you
> you would have to change the --notes implementation
> if you want to keep a sort of shadow list
> of not-patch-notes-but-RD-notes.

IOW, the design of how these options interact does not support the
usecase I gave?

> And another problem, or fact, is that format-patch
> does not show notes by default. So what should
> --RD-notes show? The default notes?

I do not know.  My preference actually is not to introuce a new
option whose interaction with the existing --notes option cannot be
defined in simple terms.
