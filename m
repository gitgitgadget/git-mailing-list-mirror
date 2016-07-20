Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723B71F744
	for <e@80x24.org>; Wed, 20 Jul 2016 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbcGTT0t (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 15:26:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752265AbcGTT0s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 15:26:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 00A632BC8A;
	Wed, 20 Jul 2016 15:26:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fa9/HQusFl2TdisweRteKiY2RIo=; b=Kyh6B7
	F5xYYydh6+1vJNeD5AXdKfzc9QlhcEiCimf1uYmXRAOMZ3DHiCTmz433xw57rjss
	NW928UXW3HYYH7f73uyxGIjzNUAa+g1JhAvELtdzs2FmY/u+MJXo7ngbnRqFUyIc
	Sa+nXlRCLCVEVwR17vvr9DXGdipw4Bo1NET4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aS956Lc6DJ65rcRCL2QCFmzD5rVkhtsl
	AB5NSsEj4uofYmeewVxUONVp2tz1VNgHMHSEpqV8xSU+i8bgU941m6s/Z33qW6Uo
	KQRFUP3kAJX3wZphwpq1jkRiAhZV12RRUGfa7o/LzV4LzLVYb57oJX1+m+j+gfKE
	mC/sglEZN7w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB3622BC89;
	Wed, 20 Jul 2016 15:26:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65ACD2BC87;
	Wed, 20 Jul 2016 15:26:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Lang <david@lang.hm>, Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<20160717142157.GA6644@vauxhall.crustytoothpaste.net>
	<CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
	<20160717154234.GC6644@vauxhall.crustytoothpaste.net>
	<20160717162349.GB11276@thunk.org>
	<20160717220417.GE6644@vauxhall.crustytoothpaste.net>
	<1468804249.2037.0@smtp.gmail.com>
	<alpine.DEB.2.20.1607180905320.28832@virtualbox>
	<CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
	<alpine.DEB.2.20.1607181750470.3472@virtualbox>
	<CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
	<alpine.DEB.2.20.1607190910370.3472@virtualbox>
	<CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
	<alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz>
	<CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
	<alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz>
	<CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
	<alpine.DEB.2.20.1607201428030.14111@virtualbox>
	<CACsJy8A3ZTfRRNuYXYD-nzXm6KXHu8cHU6fzfysJxfW0EggKNA@mail.gmail.com>
	<CAGZ79kYzhPayXKq5LrddKTuO7d5=7_AZVvr7rJ4ztAzBFv-7eg@mail.gmail.com>
Date:	Wed, 20 Jul 2016 12:26:44 -0700
In-Reply-To: <CAGZ79kYzhPayXKq5LrddKTuO7d5=7_AZVvr7rJ4ztAzBFv-7eg@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jul 2016 10:10:02 -0700")
Message-ID: <xmqq1t2odsaz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5E9D420-4EAF-11E6-821A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> to follow the above, in my view, interaction with sha1 repos go
>> through some conversion bridges like what we have with hg and svn. I
>> don't know if we are going this route. It's certainly simpler and
>> people already have experiences (from previous migration) to prepare
>> for it.
>
> When treating the SHA1 version as a foreign dvcs and the SHA256
> as the real deal, we could introduce "pointer objects", and during the
> conversion
> create a 4e55ed3 pointer that points to the SHA256 commit of (add:
> add --chmod=+x / --chmod=-x options, 2016-05-31).

Hmmm.  If you are designing this "pointer objects" to be extensible
enough to cover other foreign vcs (i.e.e.g. you make it to be
capable of mapping Subversion's r24323 to a matching commit in the
converted result), I would think it may be a very useful thing to
have, but I think it is pretty much orthogonal to the discussion in
this topic.  IOW, that can happen with or without change of the hash
function.

And looking at it that way, I am not sure if such a mapping feature
should require adding a new type of "object".
