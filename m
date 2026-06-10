Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1443DA7F7
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106542; cv=none; b=kprKe9S7dj+a++wQkweYhDmC2cldHpqwudsyYTpGqNkwZOHKLaXXuoheLquWyepiy0KTR4ceeiTD30RyRHCnrqL2JEcN/jXt0ImLSa5/jX3WfinMMi2XAwetJdWhihsEdyt5M5lrhNN9hRr8Ri4AAu3mn4iUL4Ff2/0Jeg2AXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106542; c=relaxed/simple;
	bh=6Bd1h2lzaYcHBp+eT0C0/5ufVijria+5mC63vcOthOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OI7MeOCgVvUIdnjyNm2BIYKvH8U5AcZ5bSYceyytuxIN/w8mFRRINBRRfnk0ebKW+JZ9kOYXwydd5tfteSXGSyMbXF+cER/ZooDMoWodtGTabJ6GCbQOsRNy320hL78VeNicSj3SVYWVl9VHYprID770QvSa9uhVOpdnykPC1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kRazSPzx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xt/vV0zX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kRazSPzx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xt/vV0zX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BD9A1EC0053;
	Wed, 10 Jun 2026 11:49:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 11:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781106540; x=1781192940; bh=Wxww8MJzHh
	z0mtojnM73vRZu5vxvH5t5nmAgCm+n9zs=; b=kRazSPzxxE103SoUibiyHDUQWK
	yDJdMzh3F389yLN2tuILm0/v7EQC4JTrseCkzNCOIUobLJHA5TVj7ESpFAaMYHsQ
	SdqCVooH5uCBebBxINVbpj+1MS4POS6uFRmqW+rn2SUtK3LgV5MicUGnufRpCiXr
	WORR2zotqozWU4WATryzkHIKfjjZdg4V14Hq4yUJLpKlwSkjWaRaHff3MyJfYSWO
	hoKP/R+g6tlTWkQZ5JsDCsL5X5Uovf2V5RY5nn6MuqpmyLUmxdu9rAJ19XAa9cFt
	/HKxD4Dn7NJuBfiGAJl/A5gizJK5h7fEx1DhIkbPPIz1e/G4opFEOX5dvcRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781106540; x=1781192940; bh=Wxww8MJzHhz0mtojnM73vRZu5vxvH5t5nmA
	gCm+n9zs=; b=Xt/vV0zXZK6f/Om9KA+ac/x5XyEmF4XUCRKwsWZcRiaMqHFfsuX
	JRQ398ZxikkNDmzDEZq7hgS7GgzdG78QEIY5erq+VWSba6udOSKRmdRXKW+mKbyi
	auv7heupndMnlEZPOXIj/UyyEWGJNDYiVvPOh9g91/UtumjezWB18ySE+5qtQDbi
	ahXM2qaNyFl9ZWIYnxEFhDjKIs1GAolao1Ic6H96rLJ0Uj5pD0zO+F64+xVqk6OA
	UZjJBoNggtpiWOHrrka75iWKHx6MKNsm4W9/VztzLZHv9dQOojERi7mGNAjfQz9o
	oo14k6Hw40BivYQd0/BmHrDNmqlsgiV2MYg==
X-ME-Sender: <xms:bIcpakqr8k81QjBs888sPVFMcMVCmfoWgd-BCoZWN0O46IEjqBV68Q>
    <xme:bIcpahornofyETzglNNeAngnRYuXYcyjsWnr3k4i3depDwOSNc0tCTP3dconCXH7A
    WS-YqhfUNW3OigXfL7OEH1NE1AwgY5-Y0711hXuBhvz2EO9WNP2KQ>
X-ME-Received: <xmr:bIcpauPD844NWs94HGttuaXV1d23oag-DvzjP_hDJjcghLe4kdpgurfAmVHobXKYo9uuehpBG-bQLmcDHuVLgna_pFHOYfM7y_p_>
X-ME-Proxy-Cause: dmFkZTFP47rlsiL45RsDDUFIHp0aLgoyzAivDzd+Kj4R+Rb5a/MOfzIXUlKwxPIB1/PV+Y
    qs8vArq4Z8hE8ULoEBvmdzAufnOkK35IvKHRafDZs29d5miiOO+PdqrvhvO6Lk6r/qrN7b
    eaC7d0+jIaooGmvQ5vEP0ttGKXRxBdMMc0Cj7jdJ+i30rRce6B+2ZgM1/o8faskxnE14y8
    ZoyRCxVe/Lb3kfTzXzFXEGFs9RN+hGKQ7kLuMS+0vmJB5CP1VfKjOQGpGvg2UnlPiVj1vl
    0CPRcY+GqJ0r1QwyiQ4nSj0I3evt2lo60kSZ3bdh71v1O8+srDIqzOX3n1XdN+QpjfM3ov
    pL3/kL57eNa0hqU4SQTvPklUYbuhEG9h6Q7C/dCORLhNzdbS5feg3OqOwicfR3+hxks55A
    zc3cidm3R6jUtY5Vq5U+hhn8SNI/sICrbo89DwR4JlUKvrFVTYaqj5jGwKqLYkyM8iHKje
    QGZnH/O5bgEg85ot6kuL9PpAU+3zZjOTPoPSyjpfvhq+uxdXP1vUn4GT0oNGOb+YA3EyYO
    Hgjix3t7I6DMV5aEvVTCo7S7+OdtgnIMEr8bjpmUlKPquTzMVVxWqNA14G6OMRHajvM/vc
    +ZG7pLNngKF5Tckl2GtTKD3pR0rSstyUA434Wr8tolsqKQ74RFM/REj8jefg
X-ME-Proxy: <xmx:bIcpaqxnLCh5Zdt4JRTb2wu8k9dr6KApU9O-Ja4P39Zjc_a5_u1lag>
    <xmx:bIcpavvh3Wd-ZFaQoAG5OARISSR6EIcB6xQXxEBSM7RkIGoUdYMf3g>
    <xmx:bIcpar4He96fXAqAuwHf8_pCNs8sWixnBszqSiG6l-VrdJWUgkAjuw>
    <xmx:bIcpamQTarIUGXLyIVdT_q2opusff9fEGJccv4QT-grQOH5sANpXKA>
    <xmx:bIcpatuDup5_jGcqBHmRy1KQ9AF0zLwuRIflzyc21W9dN2U9J9rCzG7z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 11:49:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4] remote: qualify "git pull" advice for non-upstream
 compareBranches
In-Reply-To: <pull.2301.v4.git.git.1779372367317.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 21 May 2026
	14:06:07 +0000")
References: <pull.2301.v3.git.git.1779282625696.gitgitgadget@gmail.com>
	<pull.2301.v4.git.git.1779372367317.gitgitgadget@gmail.com>
Date: Wed, 10 Jun 2026 08:48:59 -0700
Message-ID: <xmqq7bo6xuok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Enable ENABLE_ADVICE_PULL for push-branch comparisons too, not just
> the upstream entry, so the "use git pull" hint prints when the local
> branch is behind its push branch.
>
> Spell out "git pull <remote> <branch>" so running the suggested
> command actually pulls the ref the user was told about; plain
> "git pull" would fetch the upstream instead.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     remote: qualify "git pull" advice for non-upstream branches
>     
>      * Don't suggest git pull when we have no good command to suggest.
>      * New test for this. Asserts the behind line shows with no follow-up
>        advice.

Very well written.  

What does not happen in the "punt" case (the first bullet point
above) may deserve to be given in the commit log message, but
otherwise it is very clear what the change wanted to do to the
future readers of "git log".  

>  remote.c                 |  48 +++++++++++++++----
>  t/t6040-tracking-info.sh | 100 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 140 insertions(+), 8 deletions(-)

The code changes look correct, and the new tests checks the new
suggestion as well as the "punt" case, which is good.

Shall we mark it for 'next' now?

Thanks for working on this.

>> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 0242b5bf7a..91cbb8775d 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -646,4 +646,104 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'status.compareBranches behind both upstream and push' '
> +	test_config -C test push.default current &&
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test status.compareBranches "@{upstream} @{push}" &&
> +	git -C test checkout -b feature13 upstream/main &&
> +	(cd test && advance work13) &&
> +	git -C test push origin &&
> +	git -C test branch --set-upstream-to upstream/ahead &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature13
> +	Your branch is behind ${SQ}upstream/ahead${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull" to update your local branch)
> +
> +	Your branch is behind ${SQ}origin/feature13${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull origin feature13" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

A good test that clearly shows how @{push} is described ;-)

> +test_expect_success 'status.compareBranches with remapped push and behind push branch' '
> +	test_config -C test remote.pushDefault origin &&
> +	test_config -C test remote.origin.push refs/heads/feature14:refs/heads/remapped14 &&
> +	test_config -C test status.compareBranches "@{push}" &&
> +	git -C test checkout -b feature14 upstream/main &&
> +	(cd test && advance work14) &&
> +	git -C test push &&
> +	git -C test reset --hard HEAD^ &&
> +	git -C test status >actual &&
> +	cat >expect <<-EOF &&
> +	On branch feature14
> +	Your branch is behind ${SQ}origin/remapped14${SQ} by 1 commit, and can be fast-forwarded.
> +	  (use "git pull origin remapped14" to update your local branch)
> +
> +	nothing to commit, working tree clean
> +	EOF
> +	test_cmp expect actual
> +'

OK.
