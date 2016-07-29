Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8078D1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcG2RSn (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:18:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751695AbcG2RSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 13:18:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EAA6323A9;
	Fri, 29 Jul 2016 13:18:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kBvE4/Y1tLkm0vGDTv9ElzNePyA=; b=w+dWuF
	Mc/HjJq0weSLMvvn54BYpacPRbLcgWwZeInh7Qn55l73Xdc6Qm4RdsyHKt45sTge
	umQhd+Doc2al4zxS1gcBcEJzlzmr/fyQyWWbjaAzx4X5bk3P9aLoOt5WiARYNsdS
	O/1vkR1bJOhhX9dkAL9xekuNXDhnl7cN9pd4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hThQiU9NEnJ9e3P3Zcej1MapZj4J8AfB
	YjRsgTzZeS5ExgRWFiLw9QbJNa8/ySKRVAWPyZqk2m6fEShUP5b4j31vbWhloUe2
	iGG6Qx3mA65B2li5HB0YiTdTv+E6H1AB9JPh9sbX4HSXnx6L/CEp086NoM/legEu
	0mUDUbYVU8M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0749D323A8;
	Fri, 29 Jul 2016 13:18:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8650B323A7;
	Fri, 29 Jul 2016 13:18:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
	<20160729002140.GC9646@sigill.intra.peff.net>
	<CA+55aFxMZAuY7NY6rSfrMVyEdLuZDHBTs97UUdfk9=yJL1iLjA@mail.gmail.com>
Date:	Fri, 29 Jul 2016 10:18:38 -0700
In-Reply-To: <CA+55aFxMZAuY7NY6rSfrMVyEdLuZDHBTs97UUdfk9=yJL1iLjA@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 28 Jul 2016 17:32:39 -0700")
Message-ID: <xmqq37mspdld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E751FC2-55B0-11E6-8DB8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So we do want to cache things for a single commit, it's just that for
> things like "git am" (or, like Junio wondered, "git rebase" - I didn't
> check) we probabyl just just flush the cache in between commits.

What I cautioned was indeed "git rebase", and the codepath that uses
"git am" internally would be fixed when "git am" is fixed, so it is
OK.

What I wondered was actually "git cherry-pick A..B", but I think it
runs "git commit" via the run_command() API as external process, so
it should also be safe.
