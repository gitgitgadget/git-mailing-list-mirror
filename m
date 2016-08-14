Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7D81FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcHNVVz (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:21:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751654AbcHNVVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:21:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAED2336D5;
	Sun, 14 Aug 2016 17:21:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rrEkXVmpzP1IhrY4o7bAVaDu5fw=; b=mfo977
	Yy/HAFiCsYVS3fOtpHtYfNuzkZb4DGtyQFFWCGSCY/pgw0StEIgYF2KhJenhRkEf
	g0yYim27+Tj/L1WPs9XZRbOcLzBh8NvinwbkRfJxy4yjpr0miSbkaqefcW/kfvEt
	I5lmqSNO9chH9PfaY83EJAieTHjHNUewAt3YI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q3RMo+cIsddmurIw15Pn76Tc/kNVl9EO
	pwIzir4LoBrMwLeKjYLyzYToX1g7etWU4SVe2cMKTvJuRPQ2idUszEaVzc+9sLZm
	pX9xUsRZGuF9v6MxFD0JxoGYHsuy9eFnqbRck00cG7DmJxpStYZoMu07wgujmxrA
	FsKXzSToGmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E0D2B336D4;
	Sun, 14 Aug 2016 17:21:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64DD6336D3;
	Sun, 14 Aug 2016 17:21:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v5 2/3] diff: add --diff-line-prefix option for passing in a prefix
References: <20160811225946.18381-1-jacob.e.keller@intel.com>
	<20160811225946.18381-2-jacob.e.keller@intel.com>
	<xmqqvaz5vgc7.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoX6AT7tGb5AJr1CSjzAQ67o8QXJFF1LxsV_7E_pF-moA@mail.gmail.com>
	<CA+P7+xq+GTbvzOtVvpu4_rdYYy-hhGZHhpk_ka=KkeU7UmQRew@mail.gmail.com>
	<CAPc5daVmyx+EX8H0yETfO6Vv+A7DqBM5bsqrnJdYzbEhVnA1wQ@mail.gmail.com>
	<CA+P7+xp_sPk6P1qyyDfOgpkXU1GxWPivfSzvveS4PAvGb-=ggQ@mail.gmail.com>
Date:	Sun, 14 Aug 2016 14:21:50 -0700
In-Reply-To: <CA+P7+xp_sPk6P1qyyDfOgpkXU1GxWPivfSzvveS4PAvGb-=ggQ@mail.gmail.com>
	(Jacob Keller's message of "Fri, 12 Aug 2016 15:59:17 -0700")
Message-ID: <xmqqa8gfkpw1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F17C8A6-6265-11E6-82EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Fri, Aug 12, 2016 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Fri, Aug 12, 2016 at 2:43 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> Ok so the big problem here is that unlike with diff which has support
>>> for line-prefixes already due to needing it for graph mode, I can't
>>> figure out where to get the prefix added for log output.
>>
>> Doesn't the --graph mode show the graph lines already? I think most
>> if not all of that processing happens inside log-tree.c::show_log().
>
> Yes but the problem is how to get this additional prefix to be displayed for
>
> (a) non graph mode
> (b) for graph mode but display the prefix before the graph prefix
>
> It doesn't seem straight forward, and I haven't figured out how the
> graph code already works.

Because you only need "diff --line-prefix" to work while leaving
"log --line-prefix" broken for the purpose of your immediate purpose
to update "diff/log [--graph and other options] --submodule=<type>"
to show "diff A B" in the submodule, I think it is OK to leave it
broken, as long as it is clearly documented that "--line-prefix"
should also apply to the log message part but the current code
doesn't.  Eventually, when somebody wants to add a new <type> that
runs "log -p A..B" instead of "diff A B" in submodules and wants to
make it interact well with "log --graph" at the superproject level,
they need to fix the breakage you leave behind.  That would be much
better than "because I cannot figure out how to prefix on the log
part, I'll name this --diff-line-prefix", which will force us to
support that half-baked option forever while having to add a proper
"--line-prefix" eventually anyway.
