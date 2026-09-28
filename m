Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C414FDA46
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630710; cv=none; b=FmpiMbKLqHtJdBGeo0W+LAMQH3z1ErSygDBc6BiqvE1Qy+aEDP3Wc8TEQvDiWNjNtSAjY++Vrkb/OD3EhIVHgxo8X7TgTV3+nKc6CD+oqzgNfEpSx715ainPBlnjhXFO/Kbi67QyGG5F/Lkx+NskWlUgBSRW5KVPmbBD0Oww0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630710; c=relaxed/simple;
	bh=as2WoJ8Bu4IknErNL/2S6in9XyOFP6vilGXZ0U3Z+ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BAz0bUDPgE8sEeKC+i0E7XRXwLNsizkOOxTqtm6EFMaDKhUgSxDke6koNbsiOC0elhqjs1Q8QLntfkhUMLWVj87HbHaLtRuQ77DTiHqlYFFR76eUG45HtvMvIb3UmgrJaN3Tw30kXdnturyThOanNC8mAC9r5ipkwJ8yPlD7/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WqZmPnE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xIIn2dZ3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WqZmPnE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xIIn2dZ3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3474E1D00019;
	Mon, 28 Sep 2026 17:25:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 17:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790630703; x=1790717103; bh=6aHq8jkjL0
	NJsD2zxfWVonhowutjksuSg8njd6kHjfk=; b=WqZmPnE4QUeLATZ/zLHclBemvE
	CuCTi7VeJj6YlNxKrVpxr/zwkA8FCuOwsK97yObvmnxVEotTJ6W5QujNrfWeadNL
	GC8fLDJdxzNNq4NZ5N9iUwFov9sT5sbNiGNHRuSftPLAwDkSq1cOgo56zZAjljzM
	XtOQVKbhYr0RnkQlkKqxdRe0pb0SM4e3lFffo5pNvf5vD+eEtb+AoQj84AQRmsgq
	TyAZYsXkN5AMoj60i7wDOQR3pnpi5r0zeUJ6SQhwCC3CJlGCHKOH5wuEzCa6TYkF
	0pGNNwI70ICh57VN6thdSPJ5c+7NCK3sIa5XQpbIqImuQjYQQ4jQgrfxl9fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790630703; x=1790717103; bh=6aHq8jkjL0NJsD2zxfWVonhowutjksuSg8n
	jd6kHjfk=; b=xIIn2dZ3ElSOVS0rInaexMfGmiElFHrkK+L4TvwgRaGBdF3Rbv/
	rT0MI82suqY03o2AKX/6gIJSGODN0XvQzp9Al3RknAA0yQ9zNMeoHMdHPS8pn/62
	NWz51VUzv6ayqAynJNHAqU4Et5PmznjQ2nS2uhz/iEWcJF2UImesqhLE8JxEb0l6
	yunrtMZtDryYgZRzATJjFIN1U+QIncNfsyBQ1tFRWunKGsCszCe2KMhIfkRNn0Yo
	rHUNfAAU5UzGSJoAxs9fVuqJmUvbiPOJV7hDSb48xGYq3hS1wwi2R/xOUNg303IC
	GNT2aWTSdNbwIXJmPQMqBmjEI7vRtOJSRZw==
X-ME-Sender: <xms:L9u6anQrM57T1Q7w-q-1WfA_Sdo9flxNJBL4NHz8LxxpTPUXrQschQ>
    <xme:L9u6akRL1p414p3ojMzW2KHwFqyD3Eu9xCm1f30HPlEE8F4dOI97B30TOZAEb31za
    XjDMOQYS_XZBfiUMuhkuSgpzi9jEnk1d3DgH-MoA2c9joPCzjxFKw>
X-ME-Received: <xmr:L9u6ajROLgnC0d2nYVqjf7dLYioVHkbqrZ3hPcAhYHDCIdDomDT7NPRJTBHwiQdMXWBz4R0V5-zVAeSakXzSSihIJ75TsEHwCdAo>
X-ME-Proxy-Cause: dmFkZTEYCf7ydsp5WXAUXd176BD2wtS8mHQRzEfJ68xDVu7cg6YMwBbxFGDcswjYKrlHkN
    zgtd61xUXzhp5leS4m8ihs+z0865/7I39wrTY8Lh27lfWmDD0GVJ/WggZFUr8RwHyStr0Y
    B9IXK677V6tW2F2DKn3Y5fJ6sK9bMJD+a1xbDiCXu+BSkH1XAZ8TNC1keG4cMWu/1puzrW
    BETRwM+oukOAXpPyPmbjZvYGSQG4yJ46T11qgSFfx/Aq+Apq2L2wUlQwdDWLpjJttGiFOJ
    uN9utFcAHSw7zLk2HExti8yblYgTbmK3VXIGFxRE3hSXYJ8kaNtrkLnZ3eMQ57Sfz3sGqY
    NT3qaExLI+OCZDDQkwRQ3DA/T9KS9x/qTAXesw5aaXB/UetKBn8hCqyYaWu0Pky8smGp3b
    5gDZYF8RDBMSSTmG956kp2mFTNMj9fjpSmxJlYOuvY9Ap6oMM59aJvCSKBpZyiFWVmotrF
    J0G0u9nWuPk3OPaOz4QYNKU7TXdEfKcnM8s0Ko9sKFJxG+7q43PUDApCPGxp4MOh76plsk
    wRFs16wRZzuhEuA/+Z+Kysu8F7Wf4gRA2cHdRzBDZ2n4xIuo5JG8r8ck5DdLcbiazEqXv7
    bQSZ4kPxzpsX8NBqxreJljIDJ5LmJRYJGGnipqkKTET0uYq4CTQdW4k8SQLQ
X-ME-Proxy: <xmx:L9u6ah7B_-cEDI4Q8bCcmsgj7RyJE_qNqkC9mLF0XppR2KcQ1tzD7Q>
    <xmx:L9u6an2HCp_cZ29RWiBJPFrBa_lh_TSbGuP2s6wvsM84M7eK9QF1yg>
    <xmx:L9u6akBGq9AZ1jV7-t_JqDrrT27tyGAf-JT79gaDf8rN9ONeHzujyg>
    <xmx:L9u6aqOqe_TXF5hhd-s5MubigUgwVjx4bMAbljb_9iDxG0nDf1Vt5g>
    <xmx:L9u6ahRUQfy63-PdcFImoKI6xOKJ9GEkKzAv1Utq77jDNC_8p9Zt6Jyy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 17:25:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>
Subject: Re: [PATCH 5/7] [doc] git-cherry-pick: link to new merge conflicts
 guide
In-Reply-To: <cc1af300-d296-49c8-98ae-8b30ef11ada3@app.fastmail.com> (Julia
	Evans's message of "Mon, 28 Sep 2026 16:58:31 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<03a6b43b5803e6bd9ebba1a49c34cb42202a7f44.1790261062.git.gitgitgadget@gmail.com>
	<xmqqpky1uu6t.fsf@gitster.g>
	<cc1af300-d296-49c8-98ae-8b30ef11ada3@app.fastmail.com>
Date: Mon, 28 Sep 2026 14:25:01 -0700
Message-ID: <xmqqh5j9kr0y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> My best guess (based on what you said) is that `CHERRY_PICK_HEAD` is
> only useful if you're cherry-picking multiple commits at the same time.
> Is the following an accurate explanation?:
>
>> If the conflict happened when cherry picking multiple commits, you can run
>> `git show CHERRY_PICK_HEAD` to see the commit that Git failed to apply.

You do not have to limit yourself to the multi-pick case.  If you
make it a habit to use CHERRY_PICK_HEAD, you do not have to remember
exactly which commit you specified on the command line to pick when
stopped by a conflict during a cherry-pick.  This is especially true
for those who have already made it a habit to use MERGE_HEAD when
stopped by a conflict during a merge.  Not having to think when you
can mechanically perform a routine task is bliss.

