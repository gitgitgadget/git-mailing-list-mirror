Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF54820FD1
	for <e@80x24.org>; Fri,  1 Jul 2016 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbcGAXWe (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 19:22:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752320AbcGAXWe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jul 2016 19:22:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C77526F53;
	Fri,  1 Jul 2016 19:21:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g+EazkqSxH+a
	13U+/3ewTF2+A9o=; b=Y+XgWl5BkHEBNWvcXDATbVBmjCJ4bHiPnc5jL+ZJxTsJ
	RMMR+gdEU2EeZZ5+Lplq5TtzjkBTwV1VvqY9XmW8a5YMxCFX44NCntUBtu1Ja511
	FNlqx98NH3flfOkw8MKAOJ+wCENa9McccPtx8Nu0ieyDDYtg1nac02DIWhd/b/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kGeRe0
	iBuHJh6G2RiiFoZZpp/+EkDAbFcGIxWK/Rvv9Ix5wSLHDerE6kD8zISs0eUzIiOS
	vTmGv55jpmajzFmG8HANl4mor4K9E0rI5X8xjwEsA3aQwwAwUCQL4FMe885F4A2w
	sDmjlZ3xCvTYCSS8jbdliSEszqin97GT40QT4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9543526F52;
	Fri,  1 Jul 2016 19:21:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2221326F4E;
	Fri,  1 Jul 2016 19:21:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, marcnarc@xiplink.com
Subject: Re: [PATCH v5 0/5] Better ref summary alignment in "git fetch"
References: <20160626055810.26960-1-pclouds@gmail.com>
	<20160701160331.29252-1-pclouds@gmail.com>
Date:	Fri, 01 Jul 2016 16:21:50 -0700
In-Reply-To: <20160701160331.29252-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Fri, 1 Jul 2016 18:03:26 +0200")
Message-ID: <xmqqvb0puepd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 97B17028-3FE2-11E6-8659-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I'm not sure if we should bring back "{ -> origin/}foo" format. I can
> do it if someone still wants it.
> ...
> +In compact output mode, specified with configuration variable
> +fetch.output, if either entire `<from>` or `<to>` is found in the
> +other string, it will be substituted with `*` in the other string. For
> +example, `master -> origin/master` becomes `master -> origin/*`.

What is the desired property we would want to see in the end result
of this series (or possible replacement of it)?  Easier to read by
humans?  Cut-and-paste friendliness?  Alignment?

I think the largest objection against "{ -> origin/}master" was that
it wasn't cut-and-paste ready.  There might have been other attempts
during the rerolls leading to this v5, but I have to say that what
we ended up with, "master -> origin/*", is no more cut-and-paste
friendly than "{ -> origin/}master".

I personally do not care much about cut-and-paste friendliness, and
I see the cover-letter is titled with "alignment", but if the
alignment is the sole issue, I would have to say "master -> origin/*"
is such a great improvement over "{ -> origin/}master".

So, I do not see strong reason to reject this, but I am not enthused
by the topic, either.
