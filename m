Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A01EEE3
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455744; cv=none; b=AnssIuiTjKdU3fK6/CNYZe4xxmnd07FL9MFu0L95ahZOByjSo1i7tj6cS7PmZ/A00b2bGs3bxr/YLPVSARAbM8aA2o/+WzpUJTCv+kK3JpfecP2vHZyg8T99kvEdIP6wNbJoqBhAslnCRbCRDPd6GkizSeL80ZN9t40RI9tFjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455744; c=relaxed/simple;
	bh=kwaIKD6FpLGZ0lvzOD3+RmD2qsEzex2iYOLZG7+/lE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sh5RLccZFrh9UNKcs3uNcQFg9eXuQfJ9D4tlKpa8U7gsV9mlP7R/Ghx3GzFOj2GWb8q9Pu4WUHYNfpFfa/GU613ATtgyfISlC84c8dFdwWHATesqUkIWmX6AvMFOEV5RvHpSEh5iS3kYko47nTEhelw1UGAdSwgLx4T/xVRAqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l/y/Dql2; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l/y/Dql2"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 67FA834C0E;
	Mon,  8 Jul 2024 12:22:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kwaIKD6FpLGZ0lvzOD3+RmD2qsEzex2iYOLZG7
	+/lE0=; b=l/y/Dql2mQRwyr0uuTla9EophfByjDylKF9J5fjkQSaArmSt0EW2kK
	5IXaYS/h7zi5LO8rSZS7K8JaF/JeInTMjBUNzjwQAP02K5Uq2/lItVmnVO4qwExS
	sUmMM7rjoEVqrOvhkx9iCfoDvw/mnH75/TVF9xdgwQKEt/qEgw0IQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5ECA134C0D;
	Mon,  8 Jul 2024 12:22:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E0CDC34C0B;
	Mon,  8 Jul 2024 12:22:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  chriscool@tuxfamily.org
Subject: Re: [PATCH 1/8] clang-format: indent preprocessor directives after
 hash
In-Reply-To: <20240708092317.267915-2-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 8 Jul 2024 11:23:09 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-2-karthik.188@gmail.com>
Date: Mon, 08 Jul 2024 09:22:17 -0700
Message-ID: <xmqqle2bkg5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F371302-3D46-11EF-9B2A-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> We do not have a rule around the indentation of preprocessor directives.
> This was also discussed on the list [1], noting how there is often
> inconsistency in the styling. While there was discussion, there was no
> conclusion around what is the preferred style here. One style being
> indenting after the hash:
>
>     #if FOO
>     #  if BAR
>     #    include <foo>
>     #  endif
>     #endif
>
> The other being before the hash:
>
>     #if FOO
>       #if BAR
>         #include <foo>
>       #endif
>     #endif
>
> Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
> our '.clang-format'. There is no clear reason to pick one over the
> other, but it would definitely be nicer to be consistent.

When I experimented with reindenting the CPP directives in
<git-compat-util.h> [*], I think I saw an existing violation in an
early part of the file.  Outside the borrowed code in compat/, we
have these:

    $ git grep -e '^[ 	]\{1,\}#' master -- ':!compat/' \*.[ch]
    blame.c:	#define FINGERPRINT_FILE_THRESHOLD	10
    block-sha1/sha1.c:  #define setW(x, val) (*(volatile unsigned int *)&W(x) = (val))
    block-sha1/sha1.c:  #define setW(x, val) do { W(x) = (val); __asm__("":::"memory"); } while (0)
    block-sha1/sha1.c:  #define setW(x, val) (W(x) = (val))
    diff.h:	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
    diff.h:	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
    diff.h:	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
    diff.h:	#define COLOR_MOVED_WS_ERROR (1<<0)
    git-compat-util.h: #define GIT_GNUC_PREREQ(maj, min) 0
    pkt-line.c:	#define hex(a) (hexchar[(a) & 15])
    pkt-line.c:	#undef hex
    sha1dc/sha1.c:	#define sha1_load(m, t, temp)  { temp = m[t]; }
    sha1dc/sha1.c:	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }

Should we clean them up before we start adding these rules to the
file, especially if we plan to run the rules for stylistic check?
Otherwise wouldn't we see noises coming from the existing lines that
may dwarf the new ones, whose addition we want prevent?

If we were to run the check in CI to help contributors, I would
assume that you are arranging it to only complain about the lines
touched by the commits they are contributing, not about the existing
style violations.  This comment is not limited to the CPP directive
indentation but any other style rules .clang-format defines.

If we are not checking only for lines affected by commits being
contributed, then perhaps we should exclude compat/ from these
rules?

Thanks for working on this.

[Reference]

 * https://lore.kernel.org/git/xmqqjzim197j.fsf@gitster.g/
