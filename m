Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CDEEC0
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702633; cv=none; b=oTg9oTbPpgyUMA9BoHqsxlW6lKhAL8AYcHBa1tnBZ1917lc9A7oB6G6GCsJQiqdN/ZtGoV6gxOZJoaFbKhty6wVsazqFMPmWXziXupDYHURoNvID/hibLEPw8BKH/dMj58beqUzYRiNxvi9cXhgS55iAYALH50+dWvGDk0M0fNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702633; c=relaxed/simple;
	bh=8MdhQ11Pd5r8TsjjXKGIPa6kIZ+mK9dkDV8lnMaPz7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UK4sqzJ+qkQwaPlrvmreVJmgYxvHX1vgV+pRxWKJTUYKUa2vDVvesJcb9wwAvOao4j/Q0bLfg70gAoyVv3tFMB7BLTmylR6h7DIGewtznhQ7KTsFelvVv1LE/DJzF7YbI6OdKOmbo2CsblTabVY7V4eEBgOj/0e/tIQHTiPwaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OHBC16Hq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vkmwcbf7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OHBC16Hq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vkmwcbf7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3EA814000CB;
	Fri, 10 Jul 2026 12:57:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 12:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783702630; x=1783789030; bh=UHXcDii2Zo
	zJK99Il8RT6yEls6bl7PjW4YZbvcz9gr0=; b=OHBC16HqjFN7/Y1Vbp//Y8ynui
	6c4Sz6TMPxorSWJ+GU0XJkBFWIyupUpC5Jeh0+nmzyq3LTSMqW9jD6i+soAIUehe
	8hcQtF00XZGoubuGtAKlmxUFJFJpo1RTnNSywEjK4G7pX5ff/87DAoCds2rJMaNT
	MJZWMEoqoejLdKaOPb9GcDQtDTDd+pu2z1NB7/nV8FMFayy27i+QzDXdLCCp/m7x
	ZMqC+hD+ZuJapNDQN2yWtTC36HghjUlyHZlX2AhcFgjRzIw8lFFNILOqa4WVK4SK
	Fl4TUuOddlYMYUvrXBwIVcn2SYztZ5K6pP5lvUlCo4Cp42ahenUFCc67KMBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783702630; x=1783789030; bh=UHXcDii2ZozJK99Il8RT6yEls6bl7PjW4YZ
	bvcz9gr0=; b=Vkmwcbf7denbATsFR1Gch8T6PT0Cz5att9K3Kk9cgSofXOJxP5R
	RAzs9kqeoklmmoFtsiGv4KSaoi+CLyEe9uCbS2Z2ROtrVaSGj8Mb0JRJNOi6xsQQ
	FVd12vf5AWUaNhdblnyB0oaL/rqYlEZ6FUAEzkb4cwAGViid0DS0KIOZnyfTS8Se
	JUWGvMOSUgllSxUqgQ06bbo+eZ5KJkQ+CcJXHansWLMqFGPOiQvVr+LLP7/ezmYj
	wakWJpdVdWq+Aqyfti3SeP8V6/EpIiUr0SjjcdRAZU9HBNMaqlOLexGfy2jjbTxX
	DQJbXS6CaM8qucTUptke2twOp7BL6qwGSDw==
X-ME-Sender: <xms:ZiRRangMikCC7p-EeVKJ5xFahPH8qAPrGFBOr5k0TzDCwpBRhWkBVA>
    <xme:ZiRRarcWbcJ430cOuhY0MNrSG_3dCoR1gzEAwpAZ_m1viJ934-MV4DLtAvYIAwnBI
    I8xK3eB0zE-uNO6n1xRYMPR5uCp-yg95fMyRRox56E99ey-Tmsy>
X-ME-Received: <xmr:ZiRRakceDaJp37nRlnHBrfSnexNnOA1Z7po89ntyeLWWvt6pcIw7sfYT4J4rQ4QlDkgUP5T7_UugzjisfNPJsK_bvPdkkU_zV9YOUvI>
X-ME-Proxy-Cause: dmFkZTENMrUIag1y80ks3y6Gej5/2N5plugUEJes8kQ8t1JuCOCjIEcgNBFzrjyqCQ5vya
    NkAZq5Ch5vu7XjvYyen8sAyMB+xVHHOb2/563PRzWRDYjw0rfAotRTWirLNKDKhBqks3Im
    40LsktI+kNK1006XqIcDe1xRxyRogJsKuE8v993rYvDRmvhBzC1qjU2WzpK5dKmYO8UesJ
    eTEQ5KhoSzkqgd/gCbyFoY+OBYclmazAjq7wgK6TOD7Xim4QMYobFZbkOls3knv19gQ0z7
    j8jFOVtqforaNM737cZPd16JrSnT6xMjrbhi65MJ8RbSWWzoA+kfqIXDHv7kTDZQM8kEVV
    oJxNRnoKAcQjVS/1oSOceRzrCaKEw0XyGTAN/jbR2+Q83A103F81zw9yYET0i/2/SXJlSU
    RRfvjnyv+htI9wAGwhJ/Piajya+2rNUsEhMQwj/OgKv2QP88BMw9zMiGdHt2UmhIqmS2la
    UQKmLnXE87X+LiX/B2wfbU3GpcPsfVtD1zHrML0LIbp0oQWuLnoZ7OvfagdjPPNquQKbkR
    NTCd013O4zeTAECCuYkmdLSaHLxDs5wDUBl+hLezxK7etv3R5P+KyCM3I8RRViW9fNdg/D
    cVVO10x0T+Bz8bRsHajDRGpvUeet78yI2bYZUevY4Tp0c5z8FI0Qs0e3erQw
X-ME-Proxy: <xmx:ZiRRat8xCC0K0KvwXVva2H0d755tXzQ45INKEexgoQFoqYQxXtOYlA>
    <xmx:ZiRRaokRQU95F_VYEV6aL2-P2buAOOqJuhDJkfC8C5NDPr6iS5XEjw>
    <xmx:ZiRRan8OUzd7mgK0U3Zom93k6nI6XGqyJT6kd6y14H-_ezoQyHc49g>
    <xmx:ZiRRaulPShoH5VoghiMo76T_UM-N3A-eKJCn3NBxmZv80R1tDyekSw>
    <xmx:ZiRRajksZZCt9yVJxNyEmQ2-4v318Kjux1k97QrXDsqW40w8x8OUIMKR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 12:57:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
In-Reply-To: <alCN2Afi4gTSSajg@pks.im> (Patrick Steinhardt's message of "Fri,
	10 Jul 2026 08:14:48 +0200")
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
	<xmqq5x2nlwyg.fsf@gitster.g> <alCJgLcjXKEgNwFF@pks.im>
	<alCN2Afi4gTSSajg@pks.im>
Date: Fri, 10 Jul 2026 09:57:09 -0700
Message-ID: <xmqqo6gedbq2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hm, curious, I cannot reproduce any of these failures at all, everything
> is passing locally when merging "seen" into my branch. Did you maybe
> mismerge the changes in "setup.c" by accident? That seems like the most
> likely reason as you mention that it breaks lots of tests, and "setup.c"
> is of course involved with all of them.

It is more than probable that it was what happened.  Will retry the
merge during the integration run I'll make later today.

Thanks.

>
> For reference, this is what the final result of the conflicting part
> looks like on my side:
>
> 	if (real_git_dir) {
> 		struct stat st;
>
> 		if (!exist_ok && !stat(git_dir, &st))
> 			die(_("%s already exists"), git_dir);
>
> 		if (!exist_ok && !stat(real_git_dir, &st))
> 			die(_("%s already exists"), real_git_dir);
>
> 		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
> 		git_dir = repo_get_git_dir(repo);
> 		separate_git_dir(repo, git_dir, original_git_dir);
> 	} else {
> 		apply_and_export_relative_gitdir(repo, git_dir, 1);
> 		git_dir = repo_get_git_dir(repo);
> 	}
>
> Thanks!
>
> Patrick
