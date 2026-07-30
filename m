Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3726324E4B5
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380292; cv=none; b=LvkwaZVYq8eB3MHl9xUPe1C5hQIU/Bm1Wih1Yf8IvKJksPtLfUOpgASAMbiNK0XRp1HfuM7uGhSflkAQZXmugAUWm8v/oer4sG4vsUwIhkeAt7NX3mZhhoeBwgvHewmN/Sn6/kY2IsUCaXvy1hzf7Pg1Nu3T0aAkxg4b88csb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380292; c=relaxed/simple;
	bh=bi2Z/T3Q0Lj3ZDDeHrjODxGcfUzkSn/52/+3sNJ2q2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0F2QV5c3U/2NO32j57zmRZAAXmiHcbfJ5bhK0WPeLyVgDfjt6xCL53qy5Txm0JmXHgoHIB2RSpkSvSf5oYjTyGnb2tATU3wKCpGH3qvDnNlQXmpSwE0sn3v/pX6IeHtzJLNTGPzujUSYeLFuxcoKjgnTiBm+ZZJCWDl2bwE+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m+AhaogQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RgUAmWd/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+AhaogQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RgUAmWd/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 470C11400364;
	Wed, 29 Jul 2026 22:58:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jul 2026 22:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785380290; x=1785466690; bh=P/tnkOobD0
	fFcGfJCgMnlcKdkgWsiTMAizgy7ooh4sg=; b=m+AhaogQASXPA8gMpUI0+cRdFI
	8OO3emaZOugXjCTIjwnwof9t3cmJWnR4wGO+rKH0gaXoBQMBcsmdRfa0fFmpN/L4
	dhxtN+4rpoUUBwcDcr5qlJOdtU1dSFeWUmy5zoQ6xqLgXkTIACXwT2Ey7oP1ninA
	XMKwbozKooQxTcM165QqCRIbHpO4vsuKj5pBvTKMFmfiXxGf6pslMKB7nL9Wplz2
	ulEY3Frq+q+fMCw/3TTh9nq2xjMz3E0r5D4ln+35t+5CToLR/7yCwPsstsdPrnNx
	+Zi4DYTN3O8J2j2lSxjTO7cv6Me9NH6YH7LJlMnTFGw7105hD8a0xY9VzXwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785380290; x=1785466690; bh=P/tnkOobD0fFcGfJCgMnlcKdkgWsiTMAizg
	y7ooh4sg=; b=RgUAmWd/9KvBs0jyoy+IbU8fkNXZt2ky2OmoAflPY7xF3bAyemP
	vhfTgi+KiX8lPP22yVqzIz09ezMBExF2dsqGNcnLBmDMmJ6w0qJhBaNQZqbSo+E1
	rZJior2pGzuxTx83Y9xBX3hCvb4F59OV8m+H7LqXux0mO+8S267oRz7VHH7QR9Nu
	xJQ6rwNc52WIcQzF81R8u2ZRADyla51HLEJdXTiiTBgTGCGPePGzxemRL6A6zSR2
	R6Pe+TIf/YZeE+Pzi6hOtD5QOhPRDgWe/jM4ikHvYCJ8yft8y5ybxZeAkWZ5OaNN
	rzrHrC4z1Do513sYvGx3q25V9K3yBKutIkw==
X-ME-Sender: <xms:wr1qaoLEx6urj87rFCxVgJDkYgIDWSmr8nx6LTyvp1e_Db_brBej9g>
    <xme:wr1qavBdoJ2ZTwb2sJjLdSdpXzqYG4P8KcHsCAOFJBiMkpJaSM77BeOcrTxRv2qCi
    SoD6P4E_j_MncwQz6M4Neui0nl-NF6SHUK8c7PD1WfaI90VNviyQg>
X-ME-Received: <xmr:wr1qahAyAI5MvxQRBRo4XHjN9tBil7DA2_6ocAX4V7yPooJ9FSkYJNadjodv8HP3mIS1WPaIH8sqW02eJDtcjP8sDv8EAWZ1kg>
X-ME-Proxy-Cause: dmFkZTGmIQW1oKx4muOpeKYaw6epKCuMZyxWqDsdITeIopLoMFtuRJLRFM44yk4H7wl+P4
    TKUj6THrffBmHHRjoZYppy8qPcDdDyZYKTDX78qAkVVDwHAwMqy00UuSFFzXX0Zla1sHc9
    AHKBQ+T+aG2CcKs7NJt37P1G3wiEaT8DC3u6LHNN+KxLJL4bu8GCl5nVTghy79dRZ5EDhc
    WTmaJJehFsn9Tv9SxhiSVH0zz2cwf6QgmHB3i3UAyrgOwQxk1koG9Txp275ch6qtKICfne
    yP6iryi3bxOwdI7zXl19nH6s7kGA+lF3qjFy+81XurMst/jjhNz/aTJ5PD+bpvDrz94Wpm
    U3elnFw4wSbQiHOVRuBEKw7oAT5aY8EKYiVCJAu8DryTDmRM1TbUaf/XyyMoWm07hnxAO9
    3Xurg+fmpLhVdmcof3K393/MukTzWAlWt3LkWH6OLIodBAIPjZ1u0F2kpS0smgAx6oZaK2
    bGxFNGtCn8OkT4ftbVwHAEzjqsQTub5rXxJibPD9JdWZbePAeWP0JQUtlU7avMh9Z4MX54
    SSu3yIFLwRLQBJpVAPM1Z+tA8QqMUPepr/2vCjaii1KbQC4UobkK8FBI56KL5jzr+mpUrZ
    wGrZzDPPW6SOy+Uc4/aIlGVwiIXIETt6LnNgvaHeO5hqfXwW9WptvwIbAj0g
X-ME-Proxy: <xmx:wr1qahDbcC_KXKTf9ev2ISJ_Z6ao9cWVxcvt4t7ihfteG2NDjN_Q1Q>
    <xmx:wr1qaspis58LQR60-B_4i7lbLtQ_pKzrVRa6Olt2ntJk68s39nc51g>
    <xmx:wr1qarnlVmxeCKAYfq_a9xRIium0_nm2tWnODVXy7aLaRMxrz1ziAg>
    <xmx:wr1qasxNKb5GRHHhT2G1MC0_PaB3dDCDqZ4hzGdv-7ZbuJamnp6cbg>
    <xmx:wr1qatYqW8qL_LDWByKt6R9meR-ldr9zyy49uTiVVu5GHslT63VvgY4l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 22:58:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Lin <davidzylin@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  David Lin <davidlin@stripe.com>
Subject: Re: [PATCH] builtin/maintenance: accept "none" as a maintenance
 strategy
In-Reply-To: <20260729194006.75317-1-davidlin@stripe.com> (David Lin's message
	of "Wed, 29 Jul 2026 15:40:06 -0400")
References: <20260729194006.75317-1-davidlin@stripe.com>
Date: Wed, 29 Jul 2026 19:58:08 -0700
Message-ID: <xmqqmrv9mben.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lin <davidzylin@gmail.com> writes:

The author identity uses an @gmail.com address, but the sign-off
uses a different address.  Assuming the preferred address is the one
used in the sign-off, you can 'lie' about the author identity by
starting the body of the message with an 'in-body From:' line:

    From: David Lin <davidlin@stripe.com>

This must be written without indentation and followed by a blank line
before the true first line of the message body.

> Commit d465be2327 (builtin/maintenance: don't silently ignore invalid
> strategy, 2025-10-24) changed scheduled maintenance to error on an
> unknown maintenance strategy instead of silently defaulting to the
> `none` strategy.
>
> However, `parse_maintenance_strategy()` does not recognize `none`, so
> Git rejects a valid and documented strategy that can be used to override
> an existing strategy and disable maintenance tasks.
>
> Accept `none` as a valid maintenance strategy and add tests to ensure
> it's accepted.
>
> Signed-off-by: David Lin <davidlin@stripe.com>
> ---
>  builtin/gc.c           | 2 ++
>  t/t7900-maintenance.sh | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 46999a99ab..3d1e39d46a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1922,6 +1922,8 @@ static const struct maintenance_strategy geometric_strategy = {
>  
>  static struct maintenance_strategy parse_maintenance_strategy(const char *name)
>  {
> +	if (!strcasecmp(name, "none"))
> +		return none_strategy;
>  	if (!strcasecmp(name, "incremental"))
>  		return incremental_strategy;
>  	if (!strcasecmp(name, "gc"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index a8d691719d..130c971b15 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -1022,6 +1022,9 @@ test_expect_success 'maintenance.strategy is respected' '
>  		test_must_fail git -c maintenance.strategy=unknown maintenance run 2>err &&
>  		test_grep "unknown maintenance strategy: .unknown." err &&
>  
> +		test_strategy none </dev/null &&
> +		test_strategy none --schedule=weekly </dev/null &&
> +
>  		test_strategy incremental <<-\EOF &&
>  		git pack-refs --all --prune
>  		git reflog expire --all
>
> base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
