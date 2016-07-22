Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B1D20195
	for <e@80x24.org>; Fri, 22 Jul 2016 15:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcGVP7t (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 11:59:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751244AbcGVP7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 11:59:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 927252CBD8;
	Fri, 22 Jul 2016 11:59:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAJtonZpAHSqEZ0DaqoLQfQg6R4=; b=BEC5ue
	oOgRUeL5te3Wr/sy+rM6vWYvsVFhxRnHNKDH7SayTdBfQ/1wKhfafWZybZRq4eYd
	e3ymDXXwKBLzCGsifdKFFmzILsVEA1tlw5CpriU46nW+D1xFtFVb7TZBMdyFKdeZ
	mrGIJkoOGza+xXvVr0P4+mXfrS8Hd6XBh0Iwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rqlwc+w5Yu66MwirCBdUx555CULPds+r
	C9D3upvvZq7f1wztjn50uD/iL+B8TBEuiBiexjHFq4cx3EEtMslAyx/ru40ZVOyk
	HSye5NgwKS8T2i60GUAORuTD8vVRDGwJqn5V5TpA+tElyXy4DevNEDgCwtHJBA+p
	SSOEjbGShlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B7492CBD7;
	Fri, 22 Jul 2016 11:59:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 137622CBD6;
	Fri, 22 Jul 2016 11:59:46 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
	<20160716201313.GA298717@vauxhall.crustytoothpaste.net>
	<alpine.DEB.2.20.1607170949360.28832@virtualbox>
	<20160717142157.GA6644@vauxhall.crustytoothpaste.net>
	<CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
	<20160717154234.GC6644@vauxhall.crustytoothpaste.net>
	<20160717162349.GB11276@thunk.org>
	<20160717220417.GE6644@vauxhall.crustytoothpaste.net>
	<xmqq4m7mltbw.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607211451060.14111@virtualbox>
Date:	Fri, 22 Jul 2016 08:59:42 -0700
In-Reply-To: <alpine.DEB.2.20.1607211451060.14111@virtualbox> (Johannes
	Schindelin's message of "Thu, 21 Jul 2016 14:53:33 +0200 (CEST)")
Message-ID: <xmqqvazxbr4h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FA4168E-5025-11E6-8FC6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 18 Jul 2016, Junio C Hamano wrote:
>
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > I will say that the pack format will likely require some changes,
>> > because it assumes ...  The reason is that we can't have an
>> > unambiguous parse of the current objects if two hash algorithms are in
>> > use....  So when we look at a new hash, we need to provide an
>> > unambiguous way to know what hash is in use.  The two choices are to
>> > either require all object use the new hash, or to extend the objects
>> > to include the hash.  Until a couple days ago, I had planned to do the
>> > former.  I had not even considered using a multihash approach due to
>> > the complexity.
>> 
>> Objects in Git identify themselves, but once you introduce the second
>> hash function (as opposed to replacing the hash function to a new one),
>> you would allow people to call the same object by two names.  That has
>> interesting implications.
>> 
>> [...]
>
> So essentially you are saying that the multi-hash approach has too many
> negative implications, right? At least that is what I understand.
>
> Looks more and more like we do need to convert repositories wholesale, and
> keep a two-way mapping for talking to remote repositories.
>
> Would you concur?

Not necessarily.

That was me thinking aloud, listing some issues that I would imagine
to be tricky to solve, without even attempting to be exhaustive,
that I expect to see solved in a good end-result implementation.
For example, "I do not see a nice way to solve X myself without
doing Y" in the message you are responding to does not necessarily
mean there is no good solution to X (just "I do not think of any
offhand"), and it does not mean I think it is terrible that we have
to do Y to solve X.


