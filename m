Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91F368D6F
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544569; cv=none; b=XqjbflXqR3vPpIHceljZ3kGpHUu/RoterWPjqNvHvwM1d0Ba+LwJE/R00IGFqCH/TKd1rNNuCWiLi0VzcyUz7RLID0ArVwlViTEaJAWLh7wPM7o/JLmgqiix7GyY5EfYof2SBboI0x7w7dOKHKGqxbJ6SSmPJj7HflQS0w8dW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544569; c=relaxed/simple;
	bh=IoRFbFQnTYhKFdY33jEIfTbFX2DTNqFLEI+MB31q2TU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZYENO92h96/I2ZCEHBziyUduJSJZpjh7UtMA8bFnu9gRN3RS89yTwcgr1pNX28h01XZ5D7xYqwiPENaaBh6j/cdNgtSnhMsR+b7hBOZZWiDJdknq/zo9M2mTNmzKvvk2OXwK5D+Nyrec1RzA1N11TaEdZQ8sN15nfiISNEysUwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nHm9iSOW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3CzddvA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nHm9iSOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3CzddvA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F2F14140015E;
	Wed, 12 Aug 2026 10:22:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 10:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786544566; x=1786630966; bh=+kVMwil+sx
	ZZ1AmURcFJyAhHUyXhX5JOH7bRjDeMJnw=; b=nHm9iSOWqm3T9djubhgqOcUmIM
	cWAtoUBPriyZjTBfaatZRwVV2hsnp5EqHLSpx+Y0e5lTnZxZLPmtL9nqiQ0AJg6+
	Tnj4uOER6EQRtnF9mcg9nlVfVlwt3TMtuscvD+paNkZeA8BkwbyfYJ6OpJoB5nii
	HBnHsxLhrrZ1/cvOaz8Dc5msbcSO9vkJm6Aisz6oC/USzsmThg38T+UTkS9L5W0p
	sjNEnJCk/+aQr/K8fTCrjohdVdMm4EVIbKATrASDBbY/DQatoZ1Ubt87mwni4ZyA
	QEoGgxTnK9uw06JJxTcypGH1VepraX8TJjEIiqd+uc21jM7FZuVvg37Q8s/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786544566; x=1786630966; bh=+kVMwil+sxZZ1AmURcFJyAhHUyXhX5JOH7b
	RjDeMJnw=; b=Y3CzddvA2oK+oSDGMDbvvR6VBh9O/MCatRthAQ8gKoYedX8CTWc
	a4SKYrv989RvxBg9I/isrZ6L5el/ZCtuGFsIIYK5YgGrlYBnX3LAQGdEoxU1zEzy
	O/ymnChU0APiECoU2KDdhtkY/wGQTmMLvg42BZtSVN/ovlDwEatAbc3x3JxDXm3n
	xLR+VD1KrnPXyU10wRGbfd2RS5ou2gsbGMXwI/wvX6nf0Io1Z9ZI1+C7Lv5mEBLQ
	7UyCVZK44pAWhugH/nCO7CSlUFCAQAZXfug+EHVLKdXr5w3yWjFfNYzxmyQ0EKvg
	+sfPuwCfT2PRwOxAP5xZvTSqB/Yz450ekRw==
X-ME-Sender: <xms:toF8akXFBsdSYJiAg2O96ttWMTve1dBZnaq3RAhuXmQRE49zbmg0Eg>
    <xme:toF8avm86OeTXiJvthG1KhPXMO5rzr5aXdznqLu9-2uJcTbgROjmW10136KHSGMxe
    HRgTRqm0XX05HebiVZYZD__RFK1lH07XfOXO9k61IGvlb16keLx5WA>
X-ME-Received: <xmr:toF8atY5VmkUdERKCrljIMR-eFYWw6f3TSeoY0zvdGk1e1tRWcUbaDwl02a-PaWI5dA7AZsf-HtyJji3xzDgXvi9ynYao8VJBw>
X-ME-Proxy-Cause: dmFkZTEpLWOc0eeddQowTMuB/lrHNv8ouGTF43rpcxugPEA0utjQ3ZrG8bt9KkO2ZcLMsp
    3gOD+ebZBtWPjXo/tWEUUeuLnztDWjAr0Mb6cL4Tqcidx5njMha+ScPJmqRi3vyDSdGIlK
    Uj7JuwaFrGL3Xd4XcMKORnQwX3LUs/OF98ljdtiWhyyMHfpl3z1V0NLRTz35rYukLh/WFw
    9Saw2fEjgUeoCvPE3Vx7khPM8DdfCqLsDQOoL/gH+HPm+NaegWKKxBGeuYDD9l+fheydpV
    moTcSFn7nMrrEk8FHIqYba5/2A/8ZTN27vd0GCvmBfX8YPRqYHx8utIqJpWptKfw7yyMMe
    4Y/koeSI2V2wWYx4XGR+edfforKrPgvbkyvV5FyD5UDwraloZOsyfDB+ib6BdDVlg4JDUn
    t98V0mE3Dhzsa01sOLFOXoY+/pm2kP4w8zBzORlFjpJQP59sndQDtM0LszGuhpulaHSgoo
    OaLEIeViz57wma/kozXof5cxR+l/b1pTj9zxYLY2XGXgt3ugoRt5Y+7kfySTKOe/f8EaJE
    a6GbB5MO/VnHzGZd0aDcqK8RPDapCaAzBkt0ML+HnpdBdJUrClHjeM6lkMN5bHwgI+kQBW
    8/lkhATTe3KZeOnPQFicDearnzOilF+ctuOVS431HCr/KA9Z9NalKu3qCVig
X-ME-Proxy: <xmx:toF8aiPyFBCKZZ5I_z5NF01meL6h2Fb6XLSuuy2gmPMPSumLexpR9Q>
    <xmx:toF8aqbA--nXdfuPjJIs1EhGCDzGKg-LFUCL2T4MM8eoU4qMwLAmAA>
    <xmx:toF8ao145KqjLaqMxuWNi6FrsgsiMaK63zjyGIpCJ1kAI3TcRXtdsA>
    <xmx:toF8aocVffc3GFmPWCWKOVAaSiTqgOgyzF3pdexBLiHTJzunw_wbaQ>
    <xmx:toF8aqv2KdWGH3Fu0SgHupYY-9r3ZIaoOaECVAvEqEhH5IceXIhTBL09>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:22:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@github.com>
Subject: Re: [PATCH] diff: avoid misleading statement about -l option
In-Reply-To: <pull.2035.git.1786516958048.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Wed, 12 Aug 2026 06:42:37
	+0000")
References: <pull.2035.git.1786516958048.gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:22:45 -0700
Message-ID: <xmqqh5kzzadm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@github.com>
>
> In commit 6623a528e00b (doc: clarify documentation for rename/copy
> limits, 2021-07-15), the wording around rename limit options and config
> variables were updated to point out that only the quadratic portion of
> rename detection (or "exhaustive portion of rename/copy detection" as
> used in that commit) was limited by these options, because exact rename
> detection and basename-guided rename detection (which both run in time
> linear in the number of files) still run before this limit is checked.
>
> However, the short help message wasn't updated at the time; update it
> too.

However this is an end-user facing message.  Can we make it more
easier to understnad by being less precise?  "limit to exact
rename/copy if ..." or something?
