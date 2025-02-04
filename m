Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B802153F3
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687216; cv=none; b=YhNfVSqJFK/ux/gfJ6SvdQLxcEiMfC26nv/2baL3f/ZcpTarRp3N35s7YaV14nyA8qzGKHResBHbfr+h704f+P+Ke9cAm1Fy2Hiv6MdiynADFiKzofAQx8sbhKZBOi2lyXXwrXYDIqpCzQDP1APNkGJAnAkGfV2vMaYq40hC3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687216; c=relaxed/simple;
	bh=8Hw+kEnsu28FkdS8KCGrZb9UFx2pqvK2bmE41efr6vQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MPgVeW0R7Cox1fnH+YXTz3o0TblCovi7e0dJHOjkMdLHCRILWY5+OH5f6Q0jvZqL+kZWpcAu3RowjfKu2WwUhTOydILLtm/jHvF5DyLfsg8M8nz0Kl3MUFt7JZSjV2eO1oa9LBUcdkdwI7iIE3OS31fWXwW61gHABh1KnGlqKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mWmidju2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LzNBBfRR; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mWmidju2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LzNBBfRR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BB16254019D;
	Tue,  4 Feb 2025 11:40:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 11:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738687212; x=1738773612; bh=7BqYTX78iq
	OxtJPVCo7VRMWevQYYjMq4FWuy0fI92WQ=; b=mWmidju2H6FBi42Yas5x2i4U4w
	u3s4ZbUhVorogJSmuaVVUUh07LbgHigAXUCSvmJcL1jgyeqNtJzfzXSS/1dE8Xis
	xQ8q7k/xetdHo6wP7HYxXz0344/ixnuBCZ/sVoT4GW6sYYR5l2/8S6otDuExFwfH
	ECw4dR/9kPIbrTZkD8/CAuPUtKleLMQ7nzq/K5XizhRf59uEyorimpAv74MsGrAd
	5ATmSZPwRqSyd3a9p4JsI8DfV9tTittGII7L/JhoHcO96Ty9A5o8NyACrC0Tx/bx
	GXcAcvytkWz+6ugVV1WeE2DTL7LPllMiySCOOfZvHUeUihNcve+6SW6fDSeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738687212; x=1738773612; bh=7BqYTX78iqOxtJPVCo7VRMWevQYYjMq4FWu
	y0fI92WQ=; b=LzNBBfRRNhRdRLJBPsWyBMVvyQe2Wr6zhbffeB4zYwX/aI1kQH1
	EMmDmb5GwFc86yYPPu8F1oc3kHxrrO/ZcQz21xrxajVH6g671dRVf0hMEX1Rtr25
	R1Nt3TgkBoXtNxynZ0Y6YzBRb8fUj08oF4P3rZHxdQuCTeNoI1AvD+KeWuZJOAF1
	6ss4LufvKeddU8TT9qnsJWIunu77LxiEYYT+29f36NPzAemKzlhPbBByRNy72OAJ
	z4AeyGgB9zYNAmLj2bPavqCU1FhdpnmHDFpoetMbVXw3uEsvJlQYTpcmoB4vrw1L
	XHzG+9364KfATtjsA1aGaruSo7cMIiXcV6g==
X-ME-Sender: <xms:7EKiZyrU0qVgzNUcDKnZhCKifeJsO5JSGkGJfnbT5UoYnXLnxUbTLw>
    <xme:7EKiZwouEFAejSXSvJgXVT-4_12jY-XekA4Yp070x9sCTsAo5m1A2nw5gIcsEHjVr
    CLdPfZsDUobZ4DjEg>
X-ME-Received: <xmr:7EKiZ3Pu2LQKBxaRMljNoC-cU7utU_WlDIb-JnWOtAvnbVQwnrznH5CctQrV04j_GGTaBdSgmcuSSeh_BCzRsZcp0LqmwrE0qqdJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7EKiZx5FgLdcAnY7qg0A-qQXXzafnSpcPN6UWkQo3u6-aKjiWMEZdw>
    <xmx:7EKiZx4molcObJ2F0G50OeWKI_DOZbesLi6HEYqiicjL90SXjot6rg>
    <xmx:7EKiZxjL16andP8J5PR3zk1rdYzQwlNCf9wQOU_f8ei4gHKFo7fF5Q>
    <xmx:7EKiZ76aFmeXKHA3reGXTx3HYNb5HrNL_KixpjFNfnQpRusjjCU8ew>
    <xmx:7EKiZ02DbQgtPmO9ONmkay0pBbraa8C-FxFLQlH8S3g5hyZKhUXSVcmS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 11:40:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
In-Reply-To: <xmqq4j1a1wvr.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Feb 2025 14:33:44 -0800")
References: <20250110053417.2602109-2-jltobler@gmail.com>
	<20250201201658.11562-1-jltobler@gmail.com>
	<20250201201658.11562-2-jltobler@gmail.com>
	<xmqq4j1a1wvr.fsf@gitster.g>
Date: Tue, 04 Feb 2025 08:40:10 -0800
Message-ID: <xmqqikppvf2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> So regardless of what the future default value of core.quotePath
> would be, I am not convinced that it is a good idea to octal quote
> any and all bytes outside the ASCII range in the rev-list output.
>
> After all, "git rev-list --objects" would show such a path without
> quoting, no [*]?
>
>     Side note: the path in the output from "git rev-list --objects"
>     is a hack to allow receiving end to compute a path hash, and
>     does not have to be strictly reversible, so it emits verbatim
>     bytes but truncates the output at LF to preserve the one-line
>     one-object output format.
>
> We do need to quote certain bytes (e.g., LF cannot be allowed
> verbatim, when the output is line-oriented, and we use C-quote,
> which means literal double-quote needs to be also quoted), so we
> cannot mimic paths emitted by "git rev-list --objects", but I do not
> think it buys us much to quote non-ASCII bytes these days.

Rereading this I realize that I was not quite making sense.

A short version of what I wanted to say is:

 - The output format need to do some quoting anyway because it is
   inevitable to make the string stuffed as "value" in a space
   separated list of var=value on a single line.

 - It does not really matter if core.quotePath allows us to pass
   bytes with 8-bit set (e.g. UTF-8 outside ASCII) unquoted or
   require quoting.  The receiving end must be prepared to unquote,
   so it is dubious that a new feature to ignore core.quotePath is
   needed.

 - We do need to quote SP that cquote does not require quoting, so
   some wrapping around quote_c_style() like quote_path() does is
   needed.

Thanks.
