Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F11C6FE1
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753454111; cv=none; b=LDE0W9nM8hhnRINYOcFrzaHR4rsok1CK+e9YN7FkKLOZVxLzt1kqlPZngghI8SXWRjQkuuE0FTQ2wXmTG/oINrsfZCzZO+E/gyeP08HjWJZxkT+rQ8L8xL6nGd6sybqnbTbwselkzC9L+2ClkkhOjBJ0TlfUdKej2LZ2WOjyj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753454111; c=relaxed/simple;
	bh=gG93spxzSWaRWqwBXTa+gsaXIUmD0XK2dQxpqcY1HB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M69shtFlu8PnFAG78ju+zJS0uPWJ35J2PbyrKCXfxyuiBRRj65Fa9LVbTYbIaIqZbmwoyR7V9jtBgqdsSAZZ+EChy3R9kDv5K/+37vHUM8hFzpmCecRJhpY6X4zqFeEIUmkcHUJx1EUgTShDNQCE8XYIV2o7eQzHI5GjguT3hLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q30sbz4L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilIvGuP5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q30sbz4L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilIvGuP5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D40BB140050A;
	Fri, 25 Jul 2025 10:35:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 25 Jul 2025 10:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753454107; x=1753540507; bh=Eg6JBbl2FH
	S9+sinjdYur0gR/34xo1BmY89+mz25AwQ=; b=q30sbz4L0KHvpLY70mb2Ixfsjg
	8v/QQNGR5/7UuyJyIIz3u6Khc3P5y1oYxfBfy7EskWLXNRQYH1Y1GQZVzZ7hsYjA
	LPu0LD/QrPi6FM52MdmlivsU1WlA28O3J/mls+vCOXE6eCpfrmzV3SAyoeLyLMhM
	GmlYf6s86Nfbla/5RZSLQMa7FdfuynK/vX2NLgJIlBZidDKU2sa8yhbgEPrVRHnE
	4qCV02N5WJZX46lT85TK4+CW0BgwsSSGxaftP0dgTPapqch80lzP43IQmP4i2vDi
	Hpzp+7mbg7IXhQOK6toiWA8jxztXvT98nZ4zmt/9KMqJ9bjZVXpp/bp6u2iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753454107; x=1753540507; bh=Eg6JBbl2FHS9+sinjdYur0gR/34xo1BmY89
	+mz25AwQ=; b=ilIvGuP5Crrq1hrPcOu3jde4WyGvtfSI+LQ7IY6VmtUX1pPwzYz
	2CoJU66ox8898SNIgdMm6A0Wzd7KJOqF44C+ZAMvfvVu8C/55IsTXC0ObqMWeUG1
	49PfL8klkoTe0x0+buadnOkgLX7w18k6+EN6EwPmIXte0rdAYs29EiEv1GN9p/+8
	T3+U/G97N+Ab0PLFGJO3GBJd19ltM+3gQ81i0MKeiP6OICDxUQW1lQ+JqG8VTXz0
	jxyFvrys+Qw3jwrN0NnxptORahU7zICwz/V8y2/qPgyISjQEEe/Rx0vPyp759qMi
	EpJftIYP2pRO2M2idwZ94y5KhSWl1ZGLpTw==
X-ME-Sender: <xms:G5aDaJ6u369o7v3kbt7RqytXnqZgaCDh_L1SqWE4847HdFVGqAp9Hg>
    <xme:G5aDaCbg2XlyOfZ_p0oF9De78UpG2BUqxy00Pq0raetp03mJWw9fUYJFHyB87gA5k
    kDsWAniKw5ENtVHYg>
X-ME-Received: <xmr:G5aDaG6-z73EeTJBLfgPI_PHsL0YWus5c_8AFprhjUCe8b-zFgW-ogE4yA-Rwl95fNiwQ02gAJNwBsfkWytfi2EH7CJGNpDLDSZ9g4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekfeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshiivgguvg
    hrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G5aDaNClCJ2MZ0gjJl2aewxroeHxr58B-fLIpVOArfYAmF-f02qlBQ>
    <xmx:G5aDaEfTY-F4sf9Z5TmznunBLA_QKzYxrSoXbCR86EjPhDsVZlU9qw>
    <xmx:G5aDaEIHAFXVLW0PuADUGnA4Qnjo91i5RT5m9CRFLNtC_wszBRHRWQ>
    <xmx:G5aDaH2k0Ruc4hLJzK5CjXZuZdGCM70NecMOjxglBspYnnZBVZvnvA>
    <xmx:G5aDaEZLogcC6_3RQ0rmhAD2XC692KJ66A9CzOdoIoYQ_PvFHYLqxY7c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 10:35:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org,  Karthik
 Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
In-Reply-To: <aIMX1nHa5E5Hn95g@pks.im> (Patrick Steinhardt's message of "Fri,
	25 Jul 2025 07:36:22 +0200")
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
	<20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
	<aIJdSCPEHoiWWxrP@szeder.dev> <xmqqa54tz454.fsf@gitster.g>
	<aIMX1nHa5E5Hn95g@pks.im>
Date: Fri, 25 Jul 2025 07:35:05 -0700
Message-ID: <xmqqjz3w5ofa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Sure, I can rebase this on top of v2.50.1. It would then of course
> require some smallish fixes when merged to `seen`. The below patch is
> what is required to make it work with the v2.50 track.
>
> Patrick

Thanks.


> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index bc7e7f5e442..d3f0009cb0e 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -4,7 +4,7 @@
>  #include "config.h"
>  #include "gettext.h"
>  #include "hex.h"
> -#include "odb.h"
> +#include "object-store.h"
>  #include "revision.h"
>  #include "reachable.h"
>  #include "wildmatch.h"
> @@ -426,13 +426,13 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
>  	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
>  	if (ret)
>  		die(_("invalid old object ID: '%s'"), argv[1]);
> -	if (!is_null_oid(&old_oid) && !odb_has_object(repo->objects, &old_oid, 0))
> +	if (!is_null_oid(&old_oid) && !has_object(the_repository, &old_oid, 0))
>  		die(_("old object '%s' does not exist"), argv[1]);
>  
>  	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
>  	if (ret)
>  		die(_("invalid new object ID: '%s'"), argv[2]);
> -	if (!is_null_oid(&new_oid) && !odb_has_object(repo->objects, &new_oid, 0))
> +	if (!is_null_oid(&new_oid) && !has_object(the_repository, &new_oid, 0))
>  		die(_("new object '%s' does not exist"), argv[2]);
>  
>  	message = argv[3];
