Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA672E764D
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779887; cv=none; b=mJR8XZZfFQW0KQ0KhGTINwchh+vLpx2vAMiHvwkDOG4GLcOUxqrMBWXGRZpmqaGMGhdP1RuGC3RFiAEh+/t8Cewd1ll42c60ZoyZIMqtaX0TQpfbPbdTnbp8ZAozLzc9KvgOeEHpA2Duug9QzDHpAGb/gGZGOA+NmVLNqc5Ba6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779887; c=relaxed/simple;
	bh=yW4owW1f/47fnwsYD1WsMggPFidumipHGcElCETrvE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYSIXgVySoWY6YETd9LxD6dN9OteQ1OOxaWqcGuf1d8eYeN5LvP2y/TG0uKdgRb3wH2svujEiHH6jnhQKDFW+ozhhFZvEmap+j94tQDMKdLhvW2f1gtmZRzKx/xf2aVULvCKjlVU1TTxYHXlPCtbEu/2JfmhECx34DRAbql3R9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5oZlkET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQQ+we6N; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5oZlkET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQQ+we6N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BCB67A0073;
	Wed, 26 Aug 2026 17:31:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Aug 2026 17:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787779885; x=1787866285; bh=+KIR377Cgn
	ExqdcPUMlpx1c76XVahTHd1nWRLeCR0Y8=; b=U5oZlkETdxDMppbEGRKimJrK0S
	L3ZCzM4w5T0iFmDDwj1RH96L9sJ1tLVdi6QThHRKbQpveCQERXIo5aEQGQJYM63C
	ffw3uKfSY05lzF1mj4cgjpCrWpUAXavKwDkvdW6M457tu+AGCMUbKmXGKOIlEDMm
	zoKf35VfBj69xYknION332J9YjSYKYcxRfBEOd/DZKPZb+WiQTsmsauLRZ8KzA49
	84n4i5904GIKDQ9FGTizu3rCAwEb9HGiGICCbEmZdK8pbE7p3pbnQ8ifS4OkrVkj
	0gJjPn77gRom9lJfPCf2dAhvF0APnYn6JT6uCLzmWcV4uuBLeYKP5ulhNf6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787779885; x=1787866285; bh=+KIR377CgnExqdcPUMlpx1c76XVahTHd1nW
	RLeCR0Y8=; b=HQQ+we6NpWnlRl8kK/wOPj3U+4o0wVjIoZCWqfAyKxrmezXT+hr
	/i9dL7JhZyHOo2NPCnSkC7wHT+4ufklTJdjPUoYHdOygYR5jAf0DfmxERqC7QhqF
	7dzJ/acbqo5EUlWlKg2zFFEjTSydyUJzU2g3FlcGV8xuvutmg4ejn6C/plmnzKtK
	EEx+q715SaivwTjBhckkBQYaosRGH43lSIwjGTWneqhmbwHJWGkNSBoxzwD9Av6W
	JW08ZwrlPz+3wEBC2SlWqgl+zUM327y6EuhssdW0A+PdCrSJT3AZtc9zTyfXbRu9
	ip3EXxEwMvs7+FV7yGitdCEgd34FEEQZicA==
X-ME-Sender: <xms:LVuPamO9WBo5R5ZmYnGYndqfbFaPCektfrCocoxrBrHED0Wfm1SDPQ>
    <xme:LVuPar9VYsa6XRixaYmC7Rx_GCSP8O_RMtRMwJdP5I1U7ruizZqX7MFuKOj1EiVdB
    A0xq8Ye726M3Ty2BcUAUACaHSK1gUnW-fdiKwgBnc6l-SLsCyDTLw>
X-ME-Received: <xmr:LVuPaiQq5uxTAS81Z0HSD0XKcWy78z-z4KBj1Ed08wHgtb01C7xFOxUIhmM67GURGg7BS83EjoOKULB3rYJlltYRsQ2UypczhA>
X-ME-Proxy-Cause: dmFkZTFp6E6lPDtS+eWANXmdl+S+4+tNE68CH3TzRV9dq1bcN4llZw6/K2pP+SROmKssFH
    cvB1YgsP3Kqz7PkCPlqDLfSUSfwtCC6/zOHed6wy+qP2aX71fuIp1LPVWOZuVR8fl+fQCL
    +5phT/0TOxKgFNeKI1FO1KdF7m5aee2gcPM0U9EA90Vlc6tyX99zOzKBxwiIr89ht3jOs9
    mqJngL6wQ7ToKJEGgaxUFerEQvBcaYkkkK/DGKf2fGf5hFdIoY23zvavOkd2+/NTogvRnd
    S6hge2ozwVxONHQGU8brRqTSsz3sVvvM48eWL8SQN65htIWgaKfrKfrLA7aQSsqig5+/UK
    5AlVFNsoInkYe9wzdHDuC7/MHRyMibKVYE58zts/zA2rwrjtQvu2EmY0ugr7J9tDvdH0EA
    zcYe/5lej/OoFCWh8vyKl9hjLQgq21gvqJxGQRhBZa2bwFGmGeAOCPl4H7eOyI0S7RhQUe
    P03WPP8lJPE39dealNB3vbfw9uL+dnjbZymwtN+CnclI+eLSKll1UmIBwI5IlEFK9DGLQd
    BfLSZSUL7JfNhXT/tYnb/uUPhdaNrdaqw4mV6JsATU2+h87nAW/9uVqFUjg/FI9sNizd3h
    0XZKSmi7n8IVNatdQtE9V7jDXP1WxEtRMNyC76YlAzwqYw0POnPAjktR4f5A
X-ME-Proxy: <xmx:LVuPallXLJL_ezpsB7LsnAqIgoG1SuNPFtqYL9lk9MvfdbxrZeihJA>
    <xmx:LVuPaqRcqHTPKsjNoUvhm7Z0OPceJsDq99P4fgLx6jWg8NhvYnfdhA>
    <xmx:LVuParMXsdwob0bQf8A0K0U8SGYBaVscvuKLFRRJijzYgiDkCQQqGw>
    <xmx:LVuParX8oK3GG604lQJBH_ATJJZ5LIhUIopV5U4ykn4kE8v3nax_TA>
    <xmx:LVuPaiT5o7XApG3ZC7QBq1peVK4wFVPFuuvFMPj3Oe7w-1z7RJ2F_lAt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 17:31:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: erik@cervined.in,  phillip.wood123@gmail.com
Subject: Re: [PATCH v2 2/2] commit: allow -c/-C for all kinds of --fixup
In-Reply-To: <b3fc743abf5d35fbb23c7483836de292ad5bffda.1779792311.git.erik@cervined.in>
	(erik@cervined.in's message of "Tue, 26 May 2026 12:47:44 +0200")
References: <20260518112225.73172-2-erik@cervined.in>
	<cover.1779792311.git.erik@cervined.in>
	<b3fc743abf5d35fbb23c7483836de292ad5bffda.1779792311.git.erik@cervined.in>
Date: Wed, 26 Aug 2026 14:31:23 -0700
Message-ID: <xmqq1pbkefh0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

erik@cervined.in writes:

> From: Erik Cervin-Edin <erik@cervined.in>
>
> The previous commit allowed -m and -F for all --fixup variations.  The
> -c/-C flags were blocked by the same higher-layer incompatibility check
> that previously caught -F, namely die_for_incompatible_opt4() grouping
> them with --fixup.
>
> Drop --fixup from that check and route the resolved commit through
> prepare_amend_commit() in the fixup path, mirroring the no-message-source
> behaviour of --fixup=amend.  With this in place, -m/-F/-c/-C all behave
> consistently across the plain, amend, and reword --fixup forms.
>
> Signed-off-by: Erik Cervin-Edin <erik@cervined.in>
> ---
>  Documentation/git-commit.adoc             |  9 ++--
>  builtin/commit.c                          | 13 +++--
>  t/t7500-commit-template-squash-signoff.sh | 60 +++++++++++++++++++++--
>  3 files changed, 71 insertions(+), 11 deletions(-)

Sorry, but this topic has been hanging without getting any reviews
on the list for quite a while.

Any takers?


One small thing I noticed appears here:

> @@ -1341,7 +1346,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
>  	die_for_incompatible_opt3(!!use_message, "-C",
>  				  !!edit_message, "-c",
> -				  !!fixup_message, "--fixup");
> +				  !!logfile, "-F");
>  	die_for_incompatible_opt4(have_option_m, "-m",
>  				  !!edit_message, "-c",
>  				  !!use_message, "-C",

This blocks -C, -c, -F from being used together.  But the next
opt4() covers these combinations already:

  	die_for_incompatible_opt4(have_option_m, "-m",
  				  !!edit_message, "-c",
  				  !!use_message, "-C",
  				  !!logfile, "-F")
