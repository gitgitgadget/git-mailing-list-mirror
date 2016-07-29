Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818B81F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbcG2S6S (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:58:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750834AbcG2S6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:58:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5132E32ECA;
	Fri, 29 Jul 2016 14:58:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KppZvVxHNwykKM51qr8QTWoFgJQ=; b=IJglAo
	HyofUvkxuKJj4ssWGCrRHrbWLkaNhmGDI0kolkjYPfB7SO7st9SD526RTgwKoELU
	Ur94ULNzb4FDpG2HdtD+2wP2V6YLADrcz7bPlXRKa7JPZMOywko0kUl0SCYPKddJ
	9bRgHfC8NTkcd5Lsk8ftEW9rO9wKS9aHvVm08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H8cezSIumkx4xGiX73cg8CGN/d2wxBRb
	MR4DEMVM2SLPWt8Qzo4LZ1H5AyxJbi3+GTzllD9H9KUHKLuaiGJx5QV6kkQMhOXA
	WCsP7hP5sRongr8uq9EusEE33ze1p7LURq63ECQMKw/BRN6uAXqwg2eFcNYLszvU
	wVhLIn80ArU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48CAE32EC9;
	Fri, 29 Jul 2016 14:58:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6CA732EC8;
	Fri, 29 Jul 2016 14:58:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<20160627182429.31550-33-chriscool@tuxfamily.org>
	<xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com>
	<CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com>
	<CACsJy8CT2r1MKE_bQotPzKEWi10QB81sNn6w7H23GxRkEYRFfg@mail.gmail.com>
	<CAP8UFD3pZedUPWTj1A8q0zBGhR5ATL3CXOCxHf1_4Fuo+Uu4UQ@mail.gmail.com>
	<CACsJy8C=d-PsfEuRw_XoE3=E6+2_a7Pai1oFv0pEuQsqXwsWwA@mail.gmail.com>
Date:	Fri, 29 Jul 2016 11:58:13 -0700
In-Reply-To: <CACsJy8C=d-PsfEuRw_XoE3=E6+2_a7Pai1oFv0pEuQsqXwsWwA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 29 Jul 2016 20:35:14 +0200")
Message-ID: <xmqqwpk4mfui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67FE7212-55BE-11E6-BF2B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jul 29, 2016 at 8:23 PM, Christian Couder
> 
>> Do you mean that it might be a source of micro-projects for the next
>> GSoC or Outreachy? ;-)
>
> No that's what I meant by boring. This is not something to interest
> GSoC candidates, and while it looks simple, sometimes it needs a good
> understanding of git overall, and it's definitely not small enough for
> a micro project.

I think "that's not what I meant" is what you meant ;-) but anyway,
I actually view that as part of the same "libify" project, and not
solving it and building an "am that makes an internal call to apply
that is not libified" is adding technical debt to the codebase.

It may be a good trade-off between having "am that internally calls
apply" earlier and the additional technical debt, but is not a good
thing to do to the overall health of the project in the longer term
to pretend as if this new set_index_file() is part of a good API.

Instead it probably should be marked with "the libification of
'apply' took a short-circuit by adding this technical debt; please
do not call this function in new codepaths", or something like that.



