Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838330BF4F
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598094; cv=none; b=W6myajL/UVGtnvYVo/vGxi+/M1HNr6Ht64Q4vfeyi11CJM8G1lKuKbF+ZsgaY6FfmHHI5kJOOoDqPlmOB0KhMqm+JZXEmw985cR7SPm+HZe/f+Km9whKivBGmspjiwhjeGFGSGZPKMLUp+XFf1DA0VkPE+hztjx8b+EZMkkj0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598094; c=relaxed/simple;
	bh=g/zyXzRJUnFCHISJjCUHCiB6wyOHJQ97LrzbhxwMFhs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M2tMCbEYdHsJiSh8sIAmFKTCfYrKpbh0WX6DWuUlLRwh6JIxXsZiUz2cuRn579FTCwZGvA4Rwmm0vfAhvNBy+jbyKGwxiwZonVojM0HjO06PyUjyFgnw0o7hcwy9gYhly6ojNyQw7lkT5/OZUCHjQ9pFjR5Q6r23/f46rPZsd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=QH4cAlMy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LHdclA7d; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="QH4cAlMy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LHdclA7d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 23FC21D00093;
	Mon, 28 Sep 2026 08:21:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 08:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790598091;
	 x=1790684491; bh=g/zyXzRJUnFCHISJjCUHCiB6wyOHJQ97LrzbhxwMFhs=; b=
	QH4cAlMy9zON4KzWqQsmhvlg5LbZz4PXdaXjffm/9EV7hTOwl7nGP3oroQAqSQI6
	pSkLmrRx3YdYzdgNL/ZLDtkG20Y+htmzq7TuBTAup04cSaOfH3RwEjOIxKZzfifm
	8Y4tM5WxtFDvyoMn3ggB7pCuZVZ4XLiYrQqFK81M9YepIoTg+7Q/wzMEzvCqCwas
	z0cpAZ/Gx2W9z5P3vXVyTtjft+MeckS5T3o70owkOPSCx/V8DVDw6B1RL4BC9ueg
	HmEdJR4qFcTRyE4JwGRPMDbI9RY0jPFku5MU3wvPAlzAZMTFcZoYq2mTiP+vESfL
	G+sKz9v368i1On/Rcpvq7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790598091; x=
	1790684491; bh=g/zyXzRJUnFCHISJjCUHCiB6wyOHJQ97LrzbhxwMFhs=; b=L
	HdclA7dO3OwhmGVFS1KmY2yhJbeDPtPwEack+yMYDFSXY+3PImjWz3fq/zxcM+dG
	DZmULbP67aelnblT64yaaCKTSiCNab9+35P9mVJrlIkj+GOsYXbnUvbo9eihVw1K
	JuZJ84B6ZGB+xSDNL4+31gEWBaugy4UwDBjkaZW41MODOAWyNMoZs4iyHggpl0a8
	J7ujtw4F09LxZiBhnGS/xJ3ovxAdXE1ibs1z7ldwtRTMwhO5Ok3MIMjwHmR+JT3J
	NftNqYu87DjVSaTGlMoM1PwIc2nWgYwZvG4VBuPbyCOVezjxwk+mXHEZBFewfBFT
	Zj3z5ru5V/nOYXZ4uX44w==
X-ME-Sender: <xms:y1u6asnwOeMSydKtwEWG1nvCHWSJ8Eiher27vfxwqijoiqQjcdZEpA>
    <xme:y1u6amrv2vDBl7sLh2Hrf0B-_ZhpYs1zIATYEED-f0h9Ef4z8oel7IWf_Q9EnR2ng
    o3BSMO7edyLQqWztapxNrsbIUeiumlJkM_jLmf1tiWJc-IgZlybJsSs>
X-ME-Proxy-Cause: dmFkZTFMN54UBmpcVf/o4aDe8bPXPHoTe0P5InJe0OP+ohIbg5ZUzXVodZMWDW98fDblUr
    O7not4lZ/KFFiD9bFEWHx1FWD+iKyT91UkXcyA/X2Qw47l+qFTum1cquVlQK4+FdVtvnyK
    YSs6h0mH6WhXUELz6frwZ0VANfy3hcXZsCobSUhTf4wiKUDKnWYTOtveKXBZsyeHfiuHbf
    aeyZ+pR2X1bF30eVr9ghDAFFsYjX7O99Kbp5ic1z9yp+a5WvLpJLy8/vG8QgxSMS0NcBC3
    MXBEZ+bg0YcDNv/XPaw47f2oXZf70mEodKHlmm4FfYmFdLRsKghDJ7EqVBWOyXe7B8nMpc
    40wsBSujM99JpVI7i3c1q2vhZXv4iDPjHRlDdSom+4wlHsOqUpBTYhZRrk7oeThV6Bj2O5
    +1qNpFzt/EwUZzFWxaQ9bqQnORIaFh+CxWyflH35KbQCoNRu9XCBKrA8tVvrbJLPPO9VeK
    1vNVfIdyryoMas9UA8660o8LUMeAoCvPGc7bKSk+H95gEFpCShnsY65nLnEKS3xaxxJlx6
    GCWlxqfsury4hpuhSrJf6oCPldqySxaFVpnMfX59v7QGvTJ0/FADnKTDZOFvswrTmCuMED
    dxwlc5CvlEjHdCsjIUi+YQCVmw0F0f82f5MV1N6aHjNGx8gxApKGnmgsog1w
X-ME-Proxy: <xmx:y1u6ajQc9pvYVCkt7rhajqRuOc3mzMOAAeoZNO7HG6uRlWXELSVimg>
    <xmx:y1u6aisD68Q6EJVv8-1qcp-NXaHTl1pJ-DYGUznqX5M_fXsT0d6h-g>
    <xmx:y1u6agZ5Uxxe25xQuccRrSofy2bGabQP-CoGcXb8HaUkLqKgOJcfeA>
    <xmx:y1u6avvWZXGGWBH0RhSHhLa-8RRuuKk-Ap_CE3xMcQnrA6MQjdEyvQ>
    <xmx:y1u6aqZinXIUKy-Fn6RSBdEHZoYwOOMEo85jSKIrPsYftshxTWReXDDt>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB8FA780075; Mon, 28 Sep 2026 08:21:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGBSJuH7AubZ
Date: Mon, 28 Sep 2026 08:21:11 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <7004c3b1-2100-4a90-9815-2a679ceb25b2@app.fastmail.com>
In-Reply-To: <xmqqv77tt9a4.fsf@gitster.g>
References: <pull.2416.git.git.1790105342890.gitgitgadget@gmail.com>
 <pull.2416.v2.git.git.1790297546771.gitgitgadget@gmail.com>
 <20260925082723.GB1493716@coredump.intra.peff.net>
 <bd5d9451-ac5a-4274-9a7a-57ae99864fe9@app.fastmail.com>
 <xmqq7bk9wa4y.fsf@gitster.g>
 <4c9f0480-768a-48ba-9753-b4d34188b1a1@app.fastmail.com>
 <xmqqh5jdur4c.fsf@gitster.g>
 <17c46e4e-a4f6-433e-8eea-c1e4eb28fdfd@app.fastmail.com>
 <xmqqv77tt9a4.fsf@gitster.g>
Subject: Re: Rewriting the Git tutorial to cover less content
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Dealing with broken links is easier as we can just remove them.
> Noticing a link that points at an unmaintained stale document that
> describes what used to be relevant but no longer in today's
> environment and replacing it with something more relevant was what I
> am worried about.

Thanks, this is helpful. Let me try to rephrase to see if I understand,
let me know if I'm understanding wrong.

When possible, it's better to split up changes into smaller pieces so
that they can be reviewed more easily.

For this change, it would help to split it up into two different patch series:
"remove tutorial" and "add new tutorial", where the first patch series
deletes all references to the tutorial. If we do it this way, we can
both make sure that there isn't any content that we regret deleting,
and lets us take a look at the documents that reference the tutorial too.

- Julia
