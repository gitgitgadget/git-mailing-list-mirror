Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7CF84DF5
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315376; cv=none; b=ibKMd/mtkuRqePGrxBapF6Vb7pj+Syl3vtXv6EZLjxdY8vaZHKIvtlVWtyeOnRx1XApftPWFB4WrfABQ9GOQMr3otlXes8Z63hQ8gncuqMqtppMQ94SCAriVbcCXqKGGsQsck/PxvoLG8KW2llmrh5/PgbKc3fMrS3fBwVi0Ua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315376; c=relaxed/simple;
	bh=CDwLyDxzZFS8IUDlyRTfOOoqNcPRhX8eILzshzlGbFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ymw/rw1plTvk3nufkL+6ab4/0DUOQeoOlivpD5j5s+YBXm5YtTkU2l3C6/jm2PzTKZ+WNBa63SSMSRrUCWA5D5ANq681QW3wNAWUs3umz8IMeQYcRFyfz1pTfeTiritaGKHs5PqIXvf3GEeZHOuN4Gp2DEE9YcDNZmq0I5po6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IO5Vsg3o; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IO5Vsg3o"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAB1A2B213;
	Thu, 18 Jul 2024 11:09:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CDwLyDxzZFS8IUDlyRTfOOoqNcPRhX8eILzshz
	lGbFg=; b=IO5Vsg3ofPhcDLAdw3RkJX0gmvosJg7lMTWMBVcN/2Y5X17bWWsizC
	N26YGkCYSvnKYoZtNEmY1wgSipP/muVOnbRqr1vi9aXGwHGHwsR0ZrvKqZWeKeKm
	f1HQeSsyrpFqeK4SrEQo0mVp1RHP3jMo/onR1+LfjJwvUxOAzub0w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A295F2B212;
	Thu, 18 Jul 2024 11:09:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08DA02B211;
	Thu, 18 Jul 2024 11:09:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 0/6] : add more rules and enable on CI
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 18 Jul 2024 10:15:59 +0200")
References: <20240715093047.49321-1-karthik.188@gmail.com>
	<20240718081605.452366-1-karthik.188@gmail.com>
Date: Thu, 18 Jul 2024 08:09:31 -0700
Message-ID: <xmqq1q3qybx0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD14CFFC-4517-11EF-B625-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes against v4:
> - While testing out temp file as source for the CI, I noticed that version
> of clang-format on GitHub is much older than that of GitLab, in accordance
> with that, I removed some of the rules which are newer and not supported.

Let's see what we lost relative to the previous round.
 
        -# Insert a newline at end of file if missing
        -InsertNewlineAtEOF: true

I guess we can do "git diff --check $BASE...HEAD", if we wanted to,
which will trigger 'blank-at-eol' and other whitespace checks.

        +# Don't insert spaces inside empty '()'
        +SpaceInEmptyParentheses: false
        +
        -SpacesInParens: Custom
        -SpacesInParensOptions:
        -  # Don't insert spaces inside empty '()'
        -  InEmptyParentheses: false
        +# Don't insert spaces after '(' or before ')'
        +# f(arg);    not    f( arg );
        +SpacesInParentheses: false
 
This was to express what we used an older construct to express by
using a newer construct?  So we are not losing anything here.

So, I guess loss of changes to a few rules is nothing to shed tears
on.

Unrelated to the rules part, this caught my eyes, but

        diff --git c/ci/install-dependencies.sh w/ci/install-dependencies.sh
        index 8b01bfb89f..fb34ced8f0 100755
        --- c/ci/install-dependencies.sh
        +++ w/ci/install-dependencies.sh
        -		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE clang-format
        +		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
this is to stop installing clang-format everywhere because we are
already installing it in ClangFormat job anyway?  A good change.

Thanks.
