Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CB279907
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886588; cv=none; b=Z2feLeVE7DqcTacXgJo9TkYwVkiMuaahj1VXhHP3A3cQinmgObh6DpIHQvZiWFtWx6JROmypIJbAOZbHJYbHFaluaimTBueMZ1QEhKCMrus2d39ZbadWzx4HGL54twwYKgFThmd/tD0lXtwVJRKKxB4iCp8J/WDGol3am9RbFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886588; c=relaxed/simple;
	bh=AOvz8WjJzbI5Bcy7QMj9hlYkEli/a+T6FISBkZ2+29s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bf1rs7KIXBR1J67FLGeVxJyfavA3wkEBPpml90xZZb71FkpJntF/R6zBAVvweCTjaN8G7+tUl+0+c7xysuDQzGCi4CvvbohvtcIKtBMuQ1Dj/cK9ydxchjqzR4+P6thcXn9yDZJITYgprldddolXsBoTtesWfgdLaNs07oQWFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MZ9LrxIc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZtFKMoGq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZ9LrxIc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZtFKMoGq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C33E1D00133;
	Fri, 19 Jun 2026 12:29:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 12:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781886585; x=1781972985; bh=Gi0QjpoG3X
	WjbrK1k0Dp8RbST7kB04faCYNU1nq3Too=; b=MZ9LrxIc3vZRI3bE7subVhcmD0
	MpmtF87QPQIZdxvhi9MY6FooQtGFmYBnnsTvPSYXoCnbe2ZLbXX9ePBNYVdaXyEW
	jNY60+VPMyEzAMxvxP2dKenQUMGtYZ+T/j0jd606wGpcP7OpG1sPUPvI9JWUyBbb
	I1TfaafcTUsubCM3MMxKLMjjngfE29ON/EIoDy1V+8gWIssXRYxkhaPiUE8RCeiA
	l4EGDZng8mxMYO5iRtUgOhhNzQ2jRWW0YwzbTd29E+rzHuVKHTFagem2xU2Km3Ju
	kEuVFPVkKpJjTCVAHyIhD9rnR7pk8xcUAruCwDaM6VhV1jg0J6cVIeiR9hgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781886585; x=1781972985; bh=Gi0QjpoG3XWjbrK1k0Dp8RbST7kB04faCYN
	U1nq3Too=; b=ZtFKMoGqnC8Hejifcvg62qXYcBdbIcQ+zkGa6XUFo1ZibewMV1K
	0iqtfaLcGeFLFqPrvkp5vL6kanLIeEAxw3M/z+om6zyIxaxQCGEj7XxqymBkZ7B6
	sO1BwdP0Qpb/eaHzIGxGpps0HRI3eydpX2rd98+OFV7JC7z9hknaogAN77hLmrAL
	JhbIY9N7i+1XxD9FB69JAUnK1gnNwwQLtDKnKCNiy5xmy5U09Sq2xH8Oyo0c/n1a
	b/9bUw5fW0uHu5UJwv7tcbHUHLA2lRMbOynjSY/MoBjufm5z8Nf4sorSspZHcHpy
	eqCV/EDsk9S0VE50Ejdn32hVDx0QHirckTg==
X-ME-Sender: <xms:eW41avt-NDvgzbak26m3GjE_AUL_LCOW0tSIF7wfIv3t2rGHFSVrqg>
    <xme:eW41akLURBAC-6ZRJJfuTZtANjV0-NAEpuH2uAbOC28LNOqW49-RyMIvo09uy6rhf
    CJyZK00eeZioxUNcduaP0-X8DaIwjIV8jsVOw8GdLo3va9RVQg>
X-ME-Received: <xmr:eW41askGnfXj3Or57RY42KAv0Coqw4Fo1LPaG8YlrwDUF6dstpCOpyseeLk0RzuE6xNcWAwxJWqIUUBRKB5PUN4lyyVTLYm0U70s>
X-ME-Proxy-Cause: dmFkZTEHu1IKuK2YM2lNh/c/eoDO+IET0mo0wIP+5PrW3Cg8B76cOlt8MYJG62TJ/N9AR9
    ZR34npcGkKEO0w5emofA1XbOylpaQkFfE6UbEggQ0OpYO6FkRyDxjhmYQcdrXqCR5SvgU6
    ci0tTm0Vuyfx1epzdZc+0gX1n3+6t58JVm98q0tZ/7plwnZPCaarDT5avcsoX5fIhE8HP0
    eJa96r/edOHJ9SJlkeztJO7jXxhYo/zegfpTwymcmuVKva4zi9tCMCDbhhIURGnTYONTfb
    LupioYmTCEGNYprIKOvDUT68E8/C9KcCCdMjOEb6i5U+uVO302t6C0FZZfvVU/rV63zBFz
    KwczBF/w3Jgzv5roqCHghEzRZi4M3SB093xeYCDGqs6eJAkkzzuGjeFB3cms8tt+QWtqjl
    z+uTQEO72zIszZH6xHeEPa1+ANyo87f4r33yeiREeONnisOy6ugUrwhKBww470J8Vfvebx
    ZsKS+x+zDl9hW55S021zaIM2muFDZavBgVpXEsLo3U0VQwYdsnTr5XR0KzsLqFgegRyq+r
    Kka76REpcU9pGmcyrALbqZ1JlwwycSi6TZ+aNpIbny9GUHpXy3VsvUQnzTKYjhMDXX7U/5
    YsGeAzAeBKxa2M5ZSMncAxfD15lZXiKj2QteQWm49ITdoyQd6fT6dFjJixtw
X-ME-Proxy: <xmx:eW41alLpLRtRPAdiXOaO1IYNEWY_NKp56ZgZwqPr0bxHbQmuNgUMgw>
    <xmx:eW41ah7TOWxyr8JxKcjkVcOo32iPpQeOny-cXgpCLDFHvA-ouWj50Q>
    <xmx:eW41ap32IzsFxryUBBGpHm6TQHfIJ_5J1VScwdRv-0m1ln0g7nZYlg>
    <xmx:eW41aneFpQoz2pl_Ps4b20R73cd22gxRiRgOHEwC-gkuHQ4U1pcGXA>
    <xmx:eW41asRIgboI6tt1L4qlySM95MG5nPIgsjWBLNJNuJ6w7ccbvg-KTQrl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:29:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Todd Zullinger
 <tmz@pobox.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4216: fix no-op test that breaks TAP output
In-Reply-To: <ajVMZpjTKiXc7TRe@nand.local> (Taylor Blau's message of "Fri, 19
	Jun 2026 10:04:22 -0400")
References: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
	<ajVMZpjTKiXc7TRe@nand.local>
Date: Fri, 19 Jun 2026 09:29:44 -0700
Message-ID: <xmqqa4sqlchz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Given this and the above, I would probably err on the side of
> designating this as 'test_lazy_prereq' or otherwise silencing the output
> of 'test_cmp' so that this does not taint the TAP output.

We can argue the merit and demerit with a good log message.  The
central issue at hand is how precious 52a9 in the script lost by
this patch is (in other words, are we checking more than "is our
char signed or unsigned?").

By the way, I do not quite get the _BY_DEFAULT in the name
SIGNED_CHAR_BY_DEFAULT.  The builder may have configured to use
signed char on a platform that can handle both and their char is by
default unsigned, and under such a condition, we would set this
prerequisite, even though the default on such a platform is
unsigned, no?
