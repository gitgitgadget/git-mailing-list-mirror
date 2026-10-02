Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164E4AA414
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960636; cv=none; b=gv5tMt9nU8giIsQMEDnFISq6LKEWv+EZEa2V+/jWhMwVthgmbJu8FqY9fwXPVPumHbBO+qbHIJoxgCY9qBJe3WBjsM62ov9ZvDC71z1O0n5gTCWyXtfBgTG78kaPySOuOyLCBd4AmSW3zGFQMC6iGAEWsAv8BKmYV58MJx5hnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960636; c=relaxed/simple;
	bh=NKD3iUi0gsMxl1prr3aE3G1go5jwm+VA+topZ5lT/LM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HdPtJctokFS+4LRVlfALG7rxWX8oF+xsX/OzlxwJvvCS7hLdORbXSdbl/icXPRe41kCq/sAaLF5/NjVuxRuU6AXHwR2Pem09SUeTHJzuGtIaATotwG076BcDNVBQpD/h75Qjtvg1gNyZ3c/mMQkSJ/jbx7XBsqtJQ+FgXbLgy1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z+sDdOyR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yRK1cQPQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z+sDdOyR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yRK1cQPQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ECB17A0160
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:03:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 13:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790960633; x=1791047033; bh=4OV0HCY6Bd
	KFrtYElEM4tRAffUASobxVvMZ7e3Nifnk=; b=Z+sDdOyRqIo0a5cc7p9KcHsjZ3
	v1Goy5LxeVWVmfdjgjMSFuuobPHRKpxayChUeMCpbplLhtAxZtR1WNN2YZskUbrI
	fAflq0Hh9JYoHFEZGfBiJMGsbl3UQlJLrqNAhGH5VsW1wv14hkjSJmmtqsxSnw2l
	Cj9QEDXjZ0jshYjhahNa6U5/JBc6c4963cQl2N808jrhoW1/w77Zc2wfqUZ8koEq
	hDqVCfejfnRFUCcK0reyQVkqFzjIFRa3RHbFMBjFWXf247nJ2xt2l3xbCEXY0NIT
	lxfr3omGKZzl1vO0FPDJ4qX+GPDtDLcxKCVJFVO8nPFhoqyobpp2znccDVxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790960633; x=1791047033; bh=4OV0HCY6BdKFrtYElEM4tRAffUASobxVvMZ
	7e3Nifnk=; b=yRK1cQPQMa88EPH7yQ6oglaEAa8sWyh5snL1trCPh2fWkjKjdM0
	89Gr630vZgpGUVTwKrR1HyM4tAU12bOKNeC//X4xK+7u9hnEm8zAzylf5hpbCGRH
	OUlMSeyejo4Z7NNpyVzW3W3RwYj2HpBoYzOE5daqnV6Ol9XG4hXhcx5n81W3JCHI
	+KPbaj9mbBGIK48kED1mghJYM2GyLj1HMSYFhh9sQjLpExMjI4KXKzjBWILrgIch
	Ej7nNrYgEB8xi4uldDJHFL6OePNKsphLO4scRZohvoqC4XwngldJK8N9Ow3lHQhO
	qK7Qld2nfHlCF///Tybloa+j8rW2UNoUMRg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790960633; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xGyKKxx2wwNWrHWAa0SaXHy5Gkf+FW6egt7hYwk/JadCM2y
	jrBRMojHPkizpv01ElrfpQU0x+hSnuRA0ETCQsZo77/x/I6qL+in9soMLaQUe5Ri
	i9mlblyxXXIw/4mlQZQBcRwhG7dZtiaZyNXv2OTE9j49CRhIW+17h0DKW+jc1nkH
	PT+hudOvl0tEN+ER9LcWSPStn0XMQJyfZ8GYkHU18uGcJTbOfMVP0qa463tnuYsV
	w1HHPtHPXmZ6ZnO/dghgQHcwcK1IDYMlH2LM35Seb03T+1ZvNghTyYrze5OuWE6B
	gDy6E0XfdP4Oh6zj5YUJLHx3TFNbYNMinyn87fQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:U+XcZon95BCGno0P5Mr+jTwqs7rj5mR+vw6cL7MKDdg=:NKD3iUi0gsMxl1prr3aE3G1go5jwm+VA+topZ5lT/LM=;
X-ME-Sender: <xms:-eO_arCKfanicUcXI33fl_hlk3mapXSXqtgB2jjo1_hrKo6BfiNhAw>
    <xme:-eO_ao8kICGHsdhSwKOvMCdVzWzbXSSx75OQt_mczzrsyeMAcBlX43nrw8XYuO0aY
    VyrdLtNMAnfjkLIrplCPjT_u0G8al8pN9CPQTyo0Ge3IC_xoagZdyg>
X-ME-Received: <xmr:-eO_aj8T2uXXcVkvqItYdzxMfVC4Cd-3DinXDMPzdlKF2R8bB6-llVJeMIbTDb2Qcz6CJ431FCwiuYgn1Hsgnx0R2mx_8KCRanJM>
X-ME-Proxy-Cause: dmFkZTFl7we3xbvLwXQjhxIUSdr6x9l2FyNwWMvE3VYbPWEEkpMgjxWTAVk91g6IM2WnPs
    EjQgJRfVrWvKa/9qzjAW8Y1uPBqMSgjSRkwSuk0shUNk2SvNegla+3gFESPBmt24yZyovc
    aAFD5c7CUQdJyi8KxFKxvxmV6+5feYVK/dflbw7fQxHsiwn4T5v1u6OADk8xSYvddih0qp
    OlgrikWQTf6mEVWBkixbnT7ububdd5otwNXV3CNpSFH08kxwpygyQCFdtKFmhutwqa89SY
    Z3jYzuaYQNiVGdkzURFdijWcIg7qKeEzO9F3nRp0xA5FC0xU4Gj4wUMweEDUs0FaNt76AE
    BKwBeirpgFximQ+oomoFiTJUogxqQRCGmNaf5WUEVbZmfV+hAki25THhBD/w4gFnQwJDfy
    69PpvDNRkUCWDGQaGvt0RD58uKUxQTTpoLaGXiqAAUFpEo71Nq6JL5NuN9XofOV6JJBQDw
    1gEZejRw3eYV4sSQhfj4nbAPSjW4mqfr8ofIt0fUGXz41yKFKK8zCGpTdwudIHyU6L3XwB
    GQWx+mKma2/mCo8YrJ+7Qh2MhQaXEmCgg1zf01OAbWx9iVui2zBeFL921yjgcZh5N7ndv7
    0qhU5dKqWpHe3l1bAvKM4TWDfzambGE/Qt9l44Z3cyGBfzyw14Fngup5P7gA
X-ME-Proxy: <xmx:-eO_andPAxTYPKNRWswhvGmr2u_GQ2ABKRtg2jt3HplVCxjaqqJw2A>
    <xmx:-eO_akE741yhVID4zjJ4Gk-k-Co9nC0J5NCSB8pREK6TFTWY9XfPSA>
    <xmx:-eO_atcherxSX66PIqJPrKuk86Oh1UK6wQvn3lQpy8rJeKEowkRXrQ>
    <xmx:-eO_amGcbgzvVRBoM0dXJS6JC2BLwjl4wrPZFN9F2m8_WCHF4Qfqhg>
    <xmx:-eO_ao93RNPz5dtJCHgJDTuzcNnJ32I6R8xp6JboOuBu-kN-ZIraiQMz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:03:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git
In-Reply-To: <20261002165407.36721-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Fri, 2 Oct 2026 22:24:06 +0530")
References: <xmqqv77l2g2e.fsf@gitster.g>
	<20261002165407.36721-1-jayatheerthkulkarni2005@gmail.com>
Date: Fri, 02 Oct 2026 10:03:51 -0700
Message-ID: <xmqqik3kxceg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

>>* kj/repo-info-more-path-keys (2026-09-11) 7 commits
>> - repo: add path.cdup
>> - repo: add path.git-prefix
>> - repo: add path.grafts with absolute and relative suffixes
>> - repo: add path.index with absolute and relative suffixes
>> - repo: add path.hooks with absolute and relative suffixes
>> - repo: add path.superproject-root with absolute and relative suffixes
>> - repo: add path.toplevel with absolute and relative suffix formatting
>>
>> The 'git repo info' command has been taught more keys to output
>> paths of various repository components (such as the working tree
>> root, superproject working tree, object database, etc.), supporting
>> both absolute and relative path formats.
>>
>> Expecting a reroll.
>> cf. <CA+rGoLcRRZPu8SD-vZw+rEjVzKO02=nMn_x+4ANJX7eh9jgBcw@mail.gmail.com>
>> source: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
>
> Hey Junio, I have sent a new series at the message ID
> <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>

Will replace.  Thanks.
