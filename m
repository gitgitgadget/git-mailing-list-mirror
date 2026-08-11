Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF4A344052
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462059; cv=none; b=oKSOqDLboXIxQiLGU5LO5Jg3JE5ZXajfV4a/hB0EYqNSHwbKhiDWzYpDPvMOkK+yKmjWzjaYzn+YfLkfgVu3CnAtAUt2zcI2ZVGhA4fkJjgNv7pccgRcBm25zjlGkvyWiR/CZ8cEJRQq5EVnN7ZGToY50hc8cKhY0kHathBC/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462059; c=relaxed/simple;
	bh=kowk9kvLm1tolY700WoblEM1gR8i7FkHWnxEeTQxrW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aafr4MPRq9iuMZrhSnvSsvmN7z69NpZGSoTOHztZckOMYExXHoLOSRL4xOeE+IvthqnSlCEq99nwn7vMvM1zKE7GCp/NRVuTS0eD8vr+dsqAVvmI2wtyazXyqWqY/242sO04xnMnTiKZoju3SYFqAFz9sjzb6aF5wiZjGX21jDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LF8eBYiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YMvMlS2O; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LF8eBYiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YMvMlS2O"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 04D65EC0212;
	Tue, 11 Aug 2026 11:27:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 11:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786462057; x=1786548457; bh=bsh2dz0Yge
	1SrfTfjf/J05TmRTMR6kzmPPzXZsAoSmY=; b=LF8eBYiv1GIgGdOY5ZzYvS9m+E
	PZh4DdHQAPnd1DbJVMiaeBd4iVwZ69xNN/3Xi4Wv7UJKzdvl2GSD8g8pMePcaBlX
	/bQVJxSQ+erDfPw41K+nkRV0492lB3pRDxvuOxKEWPnMdmq0ehnRUWAq9Iafm7Am
	W0BdVK3G6B2mQ8kwccb4CQ7PBKD3dtDXNvcZAaV5x/vfOVyvPrx3z0Dzgia04+jw
	eSVravw9jFUSdMX2CYIhSb/8xRfeSCmMxG+ZhhLX34HNjCYMe2G6x+BwP7mGlpnp
	jXc7/cv/VOqro0cPvxc3G8wD8uButUmpzI2QXz/sySzyEGC0OD2KQqpGmMww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786462057; x=1786548457; bh=bsh2dz0Yge1SrfTfjf/J05TmRTMR6kzmPPz
	XZsAoSmY=; b=YMvMlS2OWEJdtcfsWfYwZQJ7+eC0HEoLFB+iE0OMRcExB3cKM9a
	+xqxHs84GsRTuxwuUuDblSdQkEbdOyZL64l9fMC3JrwL0mxKBuXsN5ZGOeW676UE
	59cPNfA+x+kjVpMZQUlekz44ZZxnwl1Qmm+CR7+ISQZ8Gvl2gtgyx9FgeFL5YJdi
	xBPPvN1JEUaeeYy5sn0+0xcii4mHEb7WoWi7FP1MKWSojAMh0gubd8a3rcf0kIZi
	HvWt0zJnkmQAZ+I1khp/E0Hz7ToF1rCc2hC2TcFevdjhGACL9uC8Mk2Te/5k8dxD
	wWIpIWhEVuu3bL0asMG15bjalfMBZL/rFWA==
X-ME-Sender: <xms:aD97ao08px4w4hVtlIl4x_3OV5-wUIY8acC6pMDcMsZav74VvMjC3w>
    <xme:aD97aqE2xshHPRPS45yFvaLiAWmZQoCvh1XNrFtwsxHvr8vvbFUuYyry0ubSrefGg
    7o1t7DaNhbJiR_PFySsos8fK12nM7Bb4qC8KuuOVWZuorwNzYgb>
X-ME-Received: <xmr:aD97al72z_lS2rWxkXUP5Sxc0YzASp9Yn-XiW2aEAbf_JthdmNz4LiroEP-Z0caKTMLofCAumPWpetJpuQXmkrhgxUxIYl_ZLw>
X-ME-Proxy-Cause: dmFkZTGqPddLI1O7i2sY1egqp5Y4iYHh+LCFRFB8WQJabBh92782KlkLg59JwMcn0eRFkm
    yoIrZVckz+ZAC2Ganx2i0duq9VHaX/facaXedloW99r9qHHES8+4mQ0c95YNd4A8n1KL8K
    aVUGmrTIkGIbegbtNfLpfAQXt3E9HX9nx/9sy3qkSun5Ib9X29ycqox3w0Kqhk5gfLLGbk
    V+eAAKqBl9MEJg2Y9Ik9y3vN4mXCr+nuJRyRKuNr0TG3r3jOJtZ0mokZb3q1dmX9j6R1lS
    FnFhFpVG1w3ENO4XXDp3AWfbEJ9DOwEfVgrGPY/O+WlJWn6+kHMmnuzHQ110PyUdqdrvZf
    msMVMSAt15E6vUlxD/2q6HqyEaWg2GJBNyIWhgUJ6nOHpbolcGpS2+wfqgCmZPhSu8EJgM
    7EQ5A4LMWHr1Lh/fYoeQOzlfxQUuGA40IseBA4cEnhgmhHhUjgwQeUAjfIgavKk6tJAkBV
    6AqihJHSsY++X1uuPVQXRXIbdNBIBeGhfDyN+tTiDzkRDz49JZEjV6aRU64WbtFB35SNOO
    vrXv7niCZw1RyDlULlEwMa8JMFe4VbncWzVWXquq5HwxLVWWnt60PLaDRI9eBaT+M23Ux7
    EbEOQ3NAqlYg4WxfL4XCRQWTc28547rFAziwNstou1E69UXd+A93VOaWqivQ
X-ME-Proxy: <xmx:aD97agtorLA9dB_WqNpnx-MP1jXCW7smjSCy_ZC7aAJvJRx098K1bg>
    <xmx:aD97am5kR0BkQlFO81RrsNdX3dShGFEk31aqriugDoXo2mtENbbxoQ>
    <xmx:aD97arXknspZ8fHFIuM1vs4mJ9kE9-g9nPeMzsOjKsvP37jP1BEtMg>
    <xmx:aD97ao8S6VtA_mO3uGWXNpN4tJvaffqF0VnqmRAgzovop56UOuHT6A>
    <xmx:aT97agYVyXQUxGBHh_Icl1XZTAVbBxcb4WMFO6E4DVWcxHXBiIMW2fTY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 11:27:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Vlad Petric via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vlad Petric <vlad@drpetric.com>
Subject: Re: [PATCH] copy: prefer reflinks for file copies
In-Reply-To: <pull.2380.git.git.1786460606222.gitgitgadget@gmail.com> (Vlad
	Petric via GitGitGadget's message of "Tue, 11 Aug 2026 15:03:26
	+0000")
References: <pull.2380.git.git.1786460606222.gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 08:27:33 -0700
Message-ID: <xmqqtsp03cey.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Vlad Petric via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For local clones, try a reflink before the existing hardlink path. The
> resulting order is therefore:
>
>   - reflink;
>   - hardlink, unless --no-hardlinks was requested;
>   - byte-for-byte copy.

If copy-on-write works in situations where hard links are not
available, using it as a fallback might make sense.  However,
we are talking about object files that are immutable.  You have
no reason to update them to trigger copy-on-write at all.  The
only changes you would make in the destination directories in
the new repository's '.git/objects/' are removal or creation,
never modification.  Therefore, I do not understand why anyone
would want to use the above order.  Could you elaborate?

Thanks.
