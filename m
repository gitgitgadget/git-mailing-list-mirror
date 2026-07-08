Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EAB1A682C
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474140; cv=none; b=OvYmtB63p9NOSQgE659y2nfLHhrr7cGgxkqq9TbmKCRQhH8t7cOJEV8ViqDGKe+JlEhwaFG6CI3RCaeRgGwN+2NeQLVaYadjkuGpAcXC2bfctu1YQZZJAJUDK4JaPwfiemdG/N6syYt+JhP+XdyLBAU5PdOErM7aeLZcLJakmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474140; c=relaxed/simple;
	bh=lCh57zYnnnRJemYrUvSoBr2L5MXV+U180JV9ALZ7fO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mPuL3fT9E7G6YolXRtCbtDW9r7G1PIVIsZ5BW5+ll7TnDnNeaKvinC5zv/1YPqTnY/K3madGKFwOWINDUgk8ayA2blkmOLCeXhB/J49n4LEkFwqfYMspgosBcjC6u4VmrROxI7Ja5BOEIe+56yjHhtsbZ6jRMkZm1dtcolsTF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t9gzwp9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OT86XbIw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t9gzwp9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OT86XbIw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B91E71400096;
	Tue,  7 Jul 2026 21:28:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 21:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783474138; x=1783560538; bh=rTZ3P8aCOi
	rcUSCN8hf1y3/McsljlsZ7O42s6TqtRD4=; b=t9gzwp9sSyi3yYfSWEhqT6GhZJ
	LpY1lzky4HkUTV+D7k+ijVBsdfOpmmtOO+0SIz7dax9/dZ42kBwMGEjOHP20vVi6
	SwN62ZAWM41w0or34J9vuEX2xHHm4DrE1httw9WPU6T4YkWC/R5YNA5INGfMviEA
	/jQyluC6ckl670YyLG6C8N4dAFYjemmMxKrd8QiWTEKDsqhQlIXr3vVuPStQmMzK
	FjiSb4HrNSgL4g90mSEIwuLlJqHpr9y2qEZlWipPtNww3Ea9JXXj8yEB/bhk2n0b
	l5yFH4QF0InZharMme2NYoHvZkvtsriHiHrXxLzfiUuheHsv0e8EYwDzWM+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783474138; x=1783560538; bh=rTZ3P8aCOircUSCN8hf1y3/McsljlsZ7O42
	s6TqtRD4=; b=OT86XbIwxPrttPm2zf03jPQzlYCMpcdblfn0S7aS0f/HT9L45r6
	5jTqRniHs4zrmKGyrOkmzlFr6f+jSFE6h8B5fMcqUdjxnHFt8q7tyqAM6FEA+laO
	pJwdgHrOFiNoxUYeyPV7IfcGdIbBMqyqC0VQ6UJ2R+VfMU0dj2D50APcD/iIcxRh
	X77bS5z/ONkNnudJeAcAzCIbTnLuWRwOpW5i5DZlb8nWeEEWPKuRpETVqBOjE883
	nGzPdRdTxvkLxChgxpnAjdQqB7TAFfki7b1AE8DQqe9ZMSl+5YPpy0vbCX8t1zp4
	lDWfy353EexYk3WoC9rXl41l6InVC1/AD7w==
X-ME-Sender: <xms:2qdNakywDSbi3pQkqA3f-6P8RHvvEl5Yk0YzaEGU2E7-9swfRUdqTQ>
    <xme:2qdNavQYd1H7NEbI7VKdh5Z_h4ziaRwFJUuaC3QHGj4V-58Hl2Jzq9vunmF5_rpIu
    _3Cj8jezjtkl3jb24fwBnv8lyRSCsybxioMqELAshZPPJozWJ8N4Q>
X-ME-Received: <xmr:2qdNarXl-rbnA_Es3qOAqt6Eiq4Z6wuBjcfiuQbunSNIJ4w092VFo6F2tMBT3Gg48jQeI8Xe0x0p1vJlPDRmKw9qwEW9OjsCnPXaz0U>
X-ME-Proxy-Cause: dmFkZTEMRoKt32IZoiZBTHAV+ZQtFiKr1InLzWcsnJ5yZZDSdMTbUyD1xB4rYtJ0ndl76z
    nV0xFZ6FlGGVHHUsJ1QuGttuZuq6+QPGt95L8yOOyFw5ffyW6dwnLq2ZUXp6GigjyMbrOQ
    2AHn01fyzOoJGRDY50OuT2RKurgHjKhTBflQe3CSy9c2n8N98SEiadGztZIPWYbSnpsBDh
    0jHLwddLSLJeOuKIWSUJqVtVcl75aGYWz7LotKvUih/gWOCBvHTiZzmJRmkBDMcZ5pjsLk
    6aqAePlumJL5WV4Luqk/ks5P+tA71Jdn39JpvdIIi+9gdxC+2cpanBckl+mPXVne2HIdCa
    xDw6HSfEN/62BPCoZcVP+jb/ZnvlG9plQWzrL8eZsmW3/7QwubKl6VfhEjZICuSL6DkakW
    0y5Wqz/bf8rdvVzZ399YEwe38q2N6gxWMj9aQRVqQbSMJmnNFkIP/VAEr3XsRSWIdConfc
    +XuTLueVBTR7J4iOrmPF9DkMmnsCNpI5aZLShU9wh3N426Gs1+dQ+ijiesgDQWJs1r9aUQ
    Sll4atjdsen5tbxEP/juPD4y6B1/wEP6R7JlQhCxvPhOlS83vWworP7+9ul9IjN/CRuOig
    2w/v67KtAiQ1sHlVTtDpAsU6gEnDuEYH+v1nrUbzcVj9J8n5slLZZIelNA3A
X-ME-Proxy: <xmx:2qdNahZ6MOVrgOiBxunmT0wJCVV0fzBQuhyAT3_Muo3Yt3_kCJGlzg>
    <xmx:2qdNah313HAU1UmHnXmtjpMBCc0dKQU16c6tAQqwB_uSB4wAlHzhlA>
    <xmx:2qdNaji5nv0k15n1_82BIfe4eiBEA3fxpaVT6YbeE6MCpZqck4QSXw>
    <xmx:2qdNalZAiG51go41Qwk6Uqqz3BFfhcBo0Hz4WG4TyL-VMLfTriEATg>
    <xmx:2qdNap1quXaj8kVgtDs3PiM-i1OdU1dU_qr72w8S3oY2yF2sisRB8Tht>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 21:28:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] t1517: skip svn tests if svn is not installed
In-Reply-To: <20260708001557.3581080-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 8 Jul 2026 00:15:54 +0000")
References: <20260701212442.1430084-1-sandals@crustytoothpaste.net>
	<20260708001557.3581080-1-sandals@crustytoothpaste.net>
	<20260708001557.3581080-2-sandals@crustytoothpaste.net>
Date: Tue, 07 Jul 2026 18:28:57 -0700
Message-ID: <xmqqldbmxo9y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The svn tests currently assume that git-svn's option parsing will always
> fail the tests because it exits 0 on --help, not 129.  However, in a
> future commit, we'll expect it to exit 0 and the tests will then need to
> be updated to succeed in some cases and fail in others.
>
> We therefore need to have t1517 determine whether the Subversion Perl
> modules are present, since if they are not, git-svn will die on start
> and then it needs to continue to expect failure.  Add a stripped down
> version of the tests in t/lib-git-svn.sh as a prerequisite we can use
> here for our svn tests.

Perfect.  This is stripped down because what this models after is
broken in the statement that this version does not copy, IIRC, which
may deserve to be stated here to help future readers.
