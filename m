Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEAEE1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 17:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbcGKRNP (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 13:13:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751757AbcGKRNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 13:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2661A2C584;
	Mon, 11 Jul 2016 13:13:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mqIlYUOLFgtBbkPtCk/S8C+CTPU=; b=nORoP6
	GnUA4U2N5JCFijOyIcpjM+3Y75W19F5D1Htbow0iE4mYEkg2iQ+SlnexdFViwRwS
	BzNxaRXJVJde5ZjgCPB8Z4bQeHVS0FIzJrtBBPAbfWt1hpS0vm3lZY9m1gBnjqAA
	z/CGAMVtGex//9QMfwSXDMQfJRGURNxsjYvfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vbMpZV2Mixpe9KyZI1tYYgD8wwwNfq/+
	Vog7UwgIMgzO0CmvkQ7Em5D5xi8I4BDrKa1hNNQgQsKdgVxZvGqjAqwlcVnVtJv6
	1EWsY8BEv29kbSZsisQOl1sxrA4ah21O1bqnFe9/fYoEEnryJPbiSmidI5E9LC4b
	sshAs4uZb4c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D98C2C583;
	Mon, 11 Jul 2016 13:13:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A7D82C582;
	Mon, 11 Jul 2016 13:13:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607110821500.6426@virtualbox>
Date:	Mon, 11 Jul 2016 10:13:10 -0700
In-Reply-To: <alpine.DEB.2.20.1607110821500.6426@virtualbox> (Johannes
	Schindelin's message of "Mon, 11 Jul 2016 08:24:49 +0200 (CEST)")
Message-ID: <xmqqzipo9jyx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF91C7B4-478A-11E6-8220-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> What about the am-call-merge-recursive-directly patch series? As I
> demonstrated by rebasing it to `pu`, it is actually not butchering the
> smudge/clean pathway as you suggested.

What I said was it seemed to conflict with something else, which
butchered that codepath that needed further work.  It seems I was
reading the conflicts incorrectly and the conflicts were coming from
other topics like i18n and oid changes.

> I am a bit at a loss here: what can I do to get this picked up?

You can do one of three things, and they apply not specifically to
this case but in general when working with others.

 - You can help other topics that collide with what you do to move
   forward by helping their reviews.  Instead of leaving them
   something the still need polishing and requires your topic to get
   adjusted every time they change, help them be polished earlier
   and become part of the solid foundation you build on top.

 - You can wait until that polishing happens to the other topics
   that block you.

 - You can shoot down the other topics that block you, e.g. "these
   are not good ideas", "it aims to do a good thing, but its
   implementation is far from ready--it misses this and that cases
   among others. I'd recommend ejecting the topic for now and have
   it redesigned from scratch", etc., which would shift the issue of
   conflicting change to their problem as a side effect.

Rebasing on 'pu' essentially is the second course; you are
explicitly making your topic depend on the others (which creates a
bit more work to me to identify exactly which topics in 'pu' you
absolutely need to decide where to queue your patches, compared to
the case in which you explicitly say "these patches apply to a merge
of topic X and Y on top of v2.9", though).

Also, without _any_ conflicts with other topics, the above three
points apply well when working with others.  There are tons of
topics that are marked as "Needs review", and they will not advance
until that happens.  When the set of "needs review" topics balloon,
I have to stop picking up non-trivial topics to make time to review
them myself.

Thanks.
