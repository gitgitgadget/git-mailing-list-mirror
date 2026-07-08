Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D653FB7F3
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547888; cv=none; b=dzFyCO04CrT68pINqTQSfsvzFoPncQDHnGvRDebdQNpEpUqzlPHZJGS2g8Q/QHdpujNiafzrJvcAd5ESsC680EVUPMXjBF2EHSoy5MqmaH3FmlgkDt4aBuvwS4AFk2u1wxT88z3fMqwpYz15X83Fi5z4uA59Wj3bLSCIJLAxHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547888; c=relaxed/simple;
	bh=ajCLhLlsZeHDG/b/p1lw0v6MNBXGgxVsOOXN/vWI3MQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmP9VJSdgMWKKuLYG5izI96Dv5VnnKay8/pQnzTnwXIeN5NzJVVCvSIZuSMBC/OTndZPXlMJOv5u6xbOLTSr/Qu3E8jUwT6C9nLAnNyUdrV1Sab5FbqFR3KZ6s7arI20tFXKr8+Yk6pPhkKkc2Kwc1t5KWxHKDH2SnGOJZ73438=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xOvpbCen; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6a8EMf+; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xOvpbCen";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6a8EMf+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DA64B1D000B9;
	Wed,  8 Jul 2026 17:58:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 08 Jul 2026 17:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783547886; x=1783634286; bh=c4Ithyd1H4
	bPPrbGKSHRtiMkHLW8J9CqFKDQX52UYnI=; b=xOvpbCen9CWv9PraDZdJcoMbWO
	bGCVw0Dx48nRAMXgDcKaUPZWhIpSImiATdeNu7Jac5gkQmK9DRPleTQulQpJXG+M
	T+Sidp8DKZJuHRcGYxgW8pj/T1TlSoaNDD2iJtdoQKYU4Hz+S4igpmSaXHOLgJsG
	5RW0VMwgBKd1UqqtHeZ4EL7Sd5ByVd2PWROTtQyeGs0VXvajMrY8kcZ6yGLBM3cq
	BDHNdHfeDfep2t1XmSLume1W0N+IoBBI59XKMb5VrgeKxFPcVSQ+pYeg89DlkWdF
	BqfuGQWHwRivmhpm/ViH2C6IfiSvyiRO7OdtZbZVZy47OMVGDkWbzE6LgwHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783547886; x=1783634286; bh=c4Ithyd1H4bPPrbGKSHRtiMkHLW8J9CqFKD
	QX52UYnI=; b=D6a8EMf+u7HfNxOT7PkwyhkpZoE1zKwvzR0hnMCimGtBe51E5tA
	nX2lv5fozUTm+46B47Cob+xmeqRrozXiZb8trOKgU77tNiOsvUd+k8l1pnlACfqX
	UefAhNByhUQ6xzNy7jIjPeygwwwVV7ahyHH6FLW+AqODppOU987Fx6bLOwhqdL6s
	m0GuAvpNZpxecsqObDGCNcPJJVLmEVjll2Mxh5IRchral6Xsjr5mx7BPFdNelPuJ
	Ea7FYydOm8kvQIg2Q8p+57/dXm1Ic4lBJb9tKlDOpYMZcYUMxxX254J8+Q3Ir9Ut
	QZPZwpieVtkRCGQv5vAdlKKXJ8LKTlELqcg==
X-ME-Sender: <xms:7sdOakyA2uk-XbcDxZD1CB6fC9lzZuJWHH3Do-li1a8vEYoTivDHFA>
    <xme:7sdOavSoi3LIOPmNS5C3vitfr1IbG_jJXv8K2Ko0ESgqAMOnkxZ9GgXxnoIMT6ldK
    5ttOvrby-FXX_t1H3KblxGjmWfg0nKipFWb_FKS0wjyBViNqUJGuw>
X-ME-Received: <xmr:7sdOarU1HAYCyECgqMlsFSF6OKyfRa772AuDnaVfrUIcqIuoCltK5oCdzEMWgij1ZgV3p7q0i_HcYfPSIgSOnRHY6nxfbLaXQAtfyBk>
X-ME-Proxy-Cause: dmFkZTEIYRbqd8DOteio6ePbxZhtjPR+T9fwMO1RrKOyOdDU01SKvLr755gr4/omUpWwGg
    LFPmQxjDzz3kxE6y+vIeP7cU22rTHtJUaewhIKxA59GI68Jw/4Zzqkdj7DaO9QdJHsdvJ/
    o5xFhmtl9rBM7IiUg8W9UbxHKXQqwbjoSuMLCaYmtyMwruUTSVvaVAmPpiSOomWgIhU8uN
    WpWloZBOgt6nvtRYU8paNDyTKMbZwmrd3mP2/i7DY33M4jQ0Tj0wSm2mvxn1r0qW80vYS4
    Avlxra5S29LP0IoH2fAqPOHBnQA4LdpaEKbBl4p6ATNAhNKws7Vda5tWfgTS+i3opU7fCE
    r3BLN4LvS3BX7HCiyrRO2E4MhgMZ8v4ntiyOWZgFW0X3lHylCrYNQYDXGYMEKgMQ6V9N00
    JDDZFvZdFEq/6ZF5CEqh7ewvcsrLcXROaK680yRaceY8qm+F5UPk6OAV70ykuTUST4z5sm
    Wet6KzJND6PnWvR/zJvV+ULUFRDGB3Z2qpoXu0uHXjTJzaCJ58rbl3FaaGN37L3gPLJG7k
    2MNDJ69qfbQv6WWvbNBmwu2ZB4IT1sA+wMK90+ajN6lyUNtHwu1rYqe5uCsNgeOUgc9hnj
    Hh+smnQN0bBNxfQCb4cdkpDReS6vrFaHr07aM7B8UmdpIJoEMHgX3bDIscOA
X-ME-Proxy: <xmx:7sdOahaKP0QyGLNA7RENvxr83jQAM3m5c5RSgl6Bb0qfGTL5GBW9WQ>
    <xmx:7sdOah3FpjIDX8Tk03ONmdnHraRmuc8SQPczT6WIU5ywQ9Z7DwI1BQ>
    <xmx:7sdOajhJbJHppLbMAAXZHJeOYlI_Lfx0vnVUGxMnrzgoxH-ADp1ToA>
    <xmx:7sdOalaQbsznZ_6IIpWht-27qN-Pqt-XMRys0QJhlbNEhX9mAja8sA>
    <xmx:7sdOaqUe8AjQP6SokV7hqNumpySdKj1qEirU8ddBKUucud0wbHzIXmKv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 17:58:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Henrique Ferreiro <hferreiro@igalia.com>
Subject: Re: [PATCH v2] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
In-Reply-To: <pull.2353.v2.git.git.1783546933992.gitgitgadget@gmail.com>
	(Henrique Ferreiro via GitGitGadget's message of "Wed, 08 Jul 2026
	21:42:13 +0000")
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
	<pull.2353.v2.git.git.1783546933992.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 14:58:04 -0700
Message-ID: <xmqqpl0xqh3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Henrique Ferreiro <hferreiro@igalia.com>
>
> Diffing the working tree against a commit with a pathspec can take
> time quadratic in the size of the index when the pathspec matches a
> subtree whose entries are the first entries of the index.  Fix it by
> having next_cache_entry() record how far it scanned in cache_bottom,
> so repeated calls no longer rescan the growing prefix of
> already-unpacked entries.  On a Chromium checkout (~500k index
> entries),
>
> 	git diff HEAD -- .agents/OWNERS
>
> took about 8 minutes before this change and 0.07 seconds after it.
> The same diff without the commit, without the pathspec, or with
> --cached was already instant.
>
> Add p0009-diff-pathspec.sh, which builds a 10,000-entry index whose
> first path lives in a subtree (100,000 entries under --long-tests),
> to guard against the regression.  Comparing v2.55.0 with this change
> using GIT_TEST_LONG=t:
>
> Test                            v2.55.0           HEAD
> ------------------------------------------------------------------------
> 0009.2: diff pathspec subtree   7.16(7.12+0.01)   0.02(0.01+0.00) -99.7%
>
> Signed-off-by: Henrique Ferreiro <hferreiro@igalia.com>
> ---
>     unpack-trees: avoid quadratic index scan in next_cache_entry()
>     
>     Changes since v1: adjust the synthetic index size based on the EXPENSIVE
>     prerequisite.

Thanks.
