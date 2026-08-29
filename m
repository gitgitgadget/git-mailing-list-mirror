Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8045635975
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788025896; cv=none; b=X6vChISzmuXbt+qqiDP0QenUy92/3icxZFgD2pW0F/gyivxy5KEd/MezfVWjZL/BqeQoSVjrZWz01C7YiejJxa9EPzz0hKr4bn+7PuwOXNCbM0tcfL00lzu5xuwDP425T12wuXmj+/0uaLcbGajoVUxlUrahzy6q4UFGWzohIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788025896; c=relaxed/simple;
	bh=wT/vTxSckEAHXNmDY0DO4qyg20OXEPVfFz33ST5GGYY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KR5vCZJuHlC2cSDuAYwmXMFU4FVpgBnh2RSy8QRbRV+bHKFmkL3zt6lsyzQbihlhcYY1MrzJ1MsgWJnOvDW/Igytq0Cxa+GkpoYAx2oq77TobHYO6oXxxS+e+Vis+A4znRyr3yFn3pJV/Dlp+/mG1e/+jvEdNJyur3v+kp+nTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=slfsizUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JWJwc/Hy; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="slfsizUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JWJwc/Hy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5987F1D0008A;
	Sat, 29 Aug 2026 13:51:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 29 Aug 2026 13:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788025893; x=1788112293; bh=9mlt+WEsfo
	+TLoa4x0lpUHxQRUipn58XnyHm61+PDSk=; b=slfsizUZFPjlZB6hBKTQCVpI2X
	W6+SPXXQfBE3K8OiahSb1kdT/LqH415JXxENyB+5LlMnPFdq6Kiucd/G2LJSG9Wm
	I4pNEQawqfTPPznV7FlSQnbAuL58/iZc3aA486JYglV4cID8EVRpnUpWMZw/qw+E
	t95vZy5zZViIIpCZGMP1+hNe/VOTlxtAX1hXf0cRsb6jAT0HAgCY+Ke10fZmaWv2
	zIhwfw8jkLJpWl+KoDNQFrjO1jrvejkUQk5DB+F2TfCS4rP1dPMbXbe6hX1hQXqm
	c55grFrRQUWR7fHMtq+0RG2aykUapy0X1lxteq8aTWf/RhbljfOPspxX7ZdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788025893; x=1788112293; bh=9mlt+WEsfo+TLoa4x0lpUHxQRUipn58XnyH
	m61+PDSk=; b=JWJwc/Hyo0oZN/f4csOahKqe8leWslhjqBakURtbTGVmeaaRpRJ
	edv2DA09i1y6K+PtfK3oXAin3ajW4KYPPqW4Zby867wtuo/W2clKN4k29xBY0yCV
	L7rFx4C/BzWP+KeNt0yshYKRH5oFDw51YyXwperh/Nfzp9b1QNGuXXlxd4nJ8w8B
	Q+AT/u/abes/6q+mW//lY5GzSBPAjuYJOfKsBm/lXHUj+w+HMuW+AiWPaZZ+DevC
	3MQSb93tuKN+9pHjcpo4i9Wddz6PS81gbXVkCK2RzfOuCU+08lqrTSDb7iMFbeP3
	UT45cTgOgVB5tJQmNv7X+zO6X7i2Hnoif6w==
X-ME-Sender: <xms:JRyTamWhizkTahmrE_Zg03F9x4mpz0Tst6Sr2SOMu_lkYK6VTmleQA>
    <xme:JRyTaqBtYgRsPjicOwSziKbyDwH4Y-eJZ3p0qYcfpqyw7o4enbfmEXO26_R5y3wDM
    O12aY8P9x5k5u9jVO4YA6Uft_Rjs872np4juaQTvhvrk0FqZvBX3Q>
X-ME-Received: <xmr:JRyTanx1ZFBXzZm5yg4Ncx47WlpoaQhgiorGhc7PFd74k4KPnCh4-8adkEM>
X-ME-Proxy-Cause: dmFkZTGA+yrsAscVl+6ZgG08/DkFi3GT7fy+VmAzfe1jqEeDcjGwaNMpf4M/WfcUOA8C8v
    zX4WfJL1RE+z1tZ2bjozY3mvcFQxLS5avJu+ilzVPxUccPEBYXZ0l3y7vfoge5a8D+jLxm
    BAjTxDrUuWx7iPPD20cpjui78wjTn9G71vlWjQ3AbZbroj8IcljxzrkDQrEkFomHB/NNuK
    6GaQ7B404I9x/XCSOtDkwjNvbEPKgUwdESfheTh6w95/7kC3/M5ih3nLyteP2GILXCFi85
    eIbb2gDFX0Sr+19cic+n90CCz261BLE+Hp8SyHtIDwoYeyWbJtaqXske2ZzDAxbpGrlje2
    3BYldpVluBKI8JXG7AaG+8k+1jJOX5N3lBNwjQw88Oj/jvxcPqvKLij9h7eLAL+uNMmr0g
    chShaw64s+nofMIr8F1vjMOcc471yVSASqDMRHZXetWqe2nDJJvl918eZvlwYHXqU153Re
    jZttzlhymtuvNLRCt+tgV7h3DFEi5sbL1Kkg/KlW9rYDqzupXv0F+4KxhKcM6O+qj/Ibfd
    EkOAHHMt37y5V4itYBcdd+1/SGdSGdYAjiC5d1Hc40snb70y15hcKYrqKG17T84xz3Z4KH
    EDxmop8Ege/+U/LlvYIsc0qTYQaxfsJqQFDGKokrlK4P9CSvX2SytdW1TKaA
X-ME-Proxy: <xmx:JRyTanDxbTuTuXh-43z-pH1be-APJ0jzuIIgUYzIp7UigvJ_8MvHfQ>
    <xmx:JRyTakboWzL6TeNw98XkoTjcN8LwX3sdFhXD43fKYKlD4xZZ5L1H5g>
    <xmx:JRyTavhK6uLXO6KL4nGY9YeUtiEYIGHXoZ47ADMUcnGxbmu46Je8gw>
    <xmx:JRyTam7Fj7fDtJ5vVwLZn0aZaDqcZbMzWznBrFHHqWPZpP3pe3zXYg>
    <xmx:JRyTauyRXgFEKhJ1f07PmFCMYTWhKuYwjSUJvJtf0qlyEJFFupYhGKz7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Aug 2026 13:51:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] die_for_incompatible_opts(): accept more than four
 options
References: <20260826233152.1703497-1-gitster@pobox.com>
	<20260826233152.1703497-3-gitster@pobox.com>
	<20260827045515.GA176544@coredump.intra.peff.net>
	<xmqqv78vbphh.fsf@gitster.g>
	<20260829111418.GA40814@coredump.intra.peff.net>
Date: Sat, 29 Aug 2026 10:51:28 -0700
In-Reply-To: <20260829111418.GA40814@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 29 Aug 2026 07:14:18 -0400")
Message-ID: <87a4q4u867.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Aug 27, 2026 at 07:35:38AM -0700, Junio C Hamano wrote:
>
>> > So that makes sense. Of course the follow-on question is whether any
>> > callers actually want to pass more than 4 options. I don't see any
>> > patches adding new calls.
>> 
>> There isn't.  While I was writing [*], I wondered if the two calls
>> next to each other for opt3 and opt4 want to be combined to opt7.
>
> OK. I wonder if we're approaching churn here, but I don't have a strong
> feeling.

A quiz that I may probably fail if I were asked in a job interview:

- Using die_for_incompatible_opt[234]() functions, find a way for
  any arbitrary N (4 < N) to ensure that no more than two of N
  options are not set at the same time.

  For example, die_for_incompatible_opt5() can be written like so:

    void die_for_incompatible_opt5(int opt1, const char *name1,
				   int opt2, const char *name2,
				   int opt3, const char *name3,
				   int opt4, const char *name4,
				   int opt5, const char *name5)
    {
	die_for_incompatible_opt4(opt1, name1, opt2, name2,
				  opt3, name3, opt4, name4);
	die_for_incompatible_opt4(opt5, name5, opt2, name2,
				  opt3, name3, opt4, name4);
	die_for_incompatible_opt2(opt5, name5, opt1, name1);
    }
	
but can't we do better?  ;-)

> Yeah, but then you can't get good compiler support, since I don't think
> there is an integer equivalent to LAST_ARG_MUST_BE_NULL.

Ah, I missed that.  It certainly makes sense to flip the order of
these <set, name> pairs.  I suspect that nobody was thinking that
these eventually need to support vararg form when they first added
die_for_incompatible_opt2() and then later extended it to forms that
can support 3 and 4 options; otherwise we would certainly have
chosen the <nameN, setN> order to allow NULL termination.

