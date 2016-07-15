Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516D620195
	for <e@80x24.org>; Fri, 15 Jul 2016 16:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcGOQtz (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 12:49:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751809AbcGOQty (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 12:49:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1863B2CB41;
	Fri, 15 Jul 2016 12:49:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uMhXnCNS+jPXciOFZ4uaSjSaEIQ=; b=U+CMtm
	cxHcYODueTHJEH3+2+Z/Pae31mQnjmIK+zPQxfsmfCkOh1XVydGvM/kRJMKTNKth
	8E1res20mhXcheGYOrcPYKkqoWoizKUhtLF34R9bhVYUC2dakEc3tXg8wYrD+f1X
	KrcBudBegoCpvKE5YX+C9G/bFjAcZe/m/0Yjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MT5jh4EVS5s9fM8/JhM6fF446mB/4sPu
	JNiy0lYdbYrlNwkUN4i4a9XinU8Hmn9tfpGDUR8q+pQViAlXd5FL9NBUu08beIl6
	RidWSlvdS5d7rZf7ko4x+0PQDzRviURtZeOP52qUOHsSfNi330LGEJGRMrx71o7H
	jy3Dqh7vU2c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FA462CB3F;
	Fri, 15 Jul 2016 12:49:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895852CB3E;
	Fri, 15 Jul 2016 12:49:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<20160714182108.GB16497@sigill.intra.peff.net>
	<xmqqshvcourb.fsf@gitster.mtv.corp.google.com>
	<20160714201018.GA18372@sigill.intra.peff.net>
	<xmqqbn20otqu.fsf@gitster.mtv.corp.google.com>
	<20160714202727.GA19101@sigill.intra.peff.net>
	<xmqq7fcoot6t.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607151707180.6426@virtualbox>
Date:	Fri, 15 Jul 2016 09:49:50 -0700
In-Reply-To: <alpine.DEB.2.20.1607151707180.6426@virtualbox> (Johannes
	Schindelin's message of "Fri, 15 Jul 2016 17:10:13 +0200 (CEST)")
Message-ID: <xmqq60s6ongx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26C0BEB2-4AAC-11E6-93D0-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So what are your plans with 2.9.2? I ask because I do not want to engineer
> a 2.9.1 release just to see that 2.9.2 is out and having to spend the same
> amount of time for another release ;-)

Essentially unchanged from what I said in $gmane/299446 a few days
ago.  Merge only the t0006 workaround with lazy-prereq changes to
'maint', so that we can skip tests that are unrunnable on platforms
without 64-bit long to avoid unnecessary test failures, then tag
that to v2.9.2 soon enough so that you do not have to do two
releases in a row (i.e. skipping v2.9.1 saying "Git for Windows
skipped that one because it was not quite right; this release fixes
the issue" in your v2.9.2 announcement).

I couldn't do that while that t0006 fix was in flux.  Now I
hopefully can.







