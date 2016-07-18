Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D436F2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcGRSd2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:33:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751463AbcGRSd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:33:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17CFD2C55E;
	Mon, 18 Jul 2016 14:33:26 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoUbWP0EjBv3GZ9/7RM7dSlPvDo=; b=clOlIb
	6HKHhbpeRFxE4RtTN+vqToNwB1ib0Zu3kbTAFzG23M0qho1StTL0nSSxWWLTstNI
	4NlfCjWhNBCq7XgPkLGsyV/JBkLprGLNBeVaLnh6uXwCE0rzDJoqEfmcDD+aOsZ7
	3wn8J5Q88ljxnEKdmpyf4r6eYstjkE+M9aqRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W+UKKgG6dHaepsdrvrl7YXHr8ySiux1E
	hsR/dn1ZDAT9OjKfkDxQ3FSoVWUcu+r0hfCDAWUzZeIjqqQi+oj1/jEsV+ortqBz
	uvBm4SJ/SsD6kvI3YJ5WnTEIyaEFnUBTTPpRptWsdoqxu6cGQptEFlZt6KAk6bc4
	nSZg4w63CZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3BF2C55D;
	Mon, 18 Jul 2016 14:33:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 879612C55C;
	Mon, 18 Jul 2016 14:33:25 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ehsan Azarnasab <azarnasab@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Feature request for automatic worktree checkout
References: <CADWjqk40KK=AuKqqdpKjkBuUvhQb4k4fMR4bPfdo8JkGRs-Y9w@mail.gmail.com>
Date:	Mon, 18 Jul 2016 11:33:23 -0700
In-Reply-To: <CADWjqk40KK=AuKqqdpKjkBuUvhQb4k4fMR4bPfdo8JkGRs-Y9w@mail.gmail.com>
	(Ehsan Azarnasab's message of "Mon, 18 Jul 2016 10:42:57 -0700")
Message-ID: <xmqqpoqakd8s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D2F7A02-4D16-11E6-8072-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ehsan Azarnasab <azarnasab@gmail.com> writes:

> Currently if I have a branch checked out in a work-tree, git-checkout
> will show this error message when checking out that branch:
>
> $ git checkout master
> fatal: 'master' is already checked out at '/home/dashesy/development/feature'
>
> It would be very useful to instead of this error just change the
> current working directory, so git checkout would become a `cd` command

That is an understandable thing to want from 10,000ft view, but it
would not be something Git, or any external command that is spawned
by the shell for that matter, can address.  You'd need to teach the
shell to cooperate.
