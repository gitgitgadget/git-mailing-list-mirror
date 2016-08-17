Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9855F1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 22:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbcHQWmT (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 18:42:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753007AbcHQWmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 18:42:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19775378F8;
	Wed, 17 Aug 2016 18:41:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2p4rFur9zFGSP3/LR2H7ncK2CA=; b=sRxFO7
	4wQO5ZZHoJr5ex6Bdd0dytM9xG3ggY00z/gDlTMyUj0Lzxf21dac0GjHElnD+bp/
	DndDAqsPEPSBEA6mv02JrG50SWAbPKj3pqRzuKla4aTOAhgIHFg0rcpau68z7zRK
	k/3/JgVVxCa1rby/8SWSte6sBVDQV4vYsiX1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a2QU5TZDvNdjTaN7P2GeZTfrJqNi76sH
	3PHIya/2FG5EZrQI5y4EzLiLXyrg3LF4rccTbYXRHzOoC1shasIEFvRN3/Q5PHmQ
	U3mDm1v4P3BC0rfw6OjuCO0InWbUzww5QOu72DjDN3UdJhn9ECgrIh0Ld4fO9xEs
	5Z+he/PqHn0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10868378F7;
	Wed, 17 Aug 2016 18:41:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 834A0378F5;
	Wed, 17 Aug 2016 18:41:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Tobiah <toby@tobiah.org>
Cc:	git@vger.kernel.org
Subject: Re: Working from different machines.
References: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
Date:	Wed, 17 Aug 2016 15:41:49 -0700
In-Reply-To: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org> (Tobiah's
	message of "Wed, 17 Aug 2016 14:47:45 -0700")
Message-ID: <xmqq4m6j81ci.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAD571B2-64CB-11E6-9123-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Tobiah <toby@tobiah.org> writes:

> In other words, I want to work from different machines, and always
> sit down to the environment exactly as I last left it.

You have several options, but it depends on untold expectations you
have beyond "exactly as I last left it."  So the following is only
to show directions and possibilities without going into details.

For example, do you save all changes you made in your editor buffers
before you leave the 'desktop'?  If the answer is "no", then that is
not a problem Git-the-tool is interested in solving, and the only
solution I could think of is to use mechanism to share the session
between 'desktop' and 'home', using things like remote-desktop or
screen session.

If the answer is "yes", the next question is if you commit all the
changes you made before you leave the 'desktop'.  If the answer is
"no", again, that is not a problem Git-the-tool is interested in
solving, and the only solution I could think of (in addition to the
"share the session" above) is to use networked filesystem shared
between 'desktop' and 'home'.

If the answer is "yes", then you are in the problem space that
Git-the-tool is interested in solving.  Assuming that you have
network connection into 'desktop' from 'home', the solution would
involve making it the first thing to do when get home to run "git
fetch" on 'home' to get the latest state from the 'desktop', and run
"git push" on 'home' to push out the latest state to the 'desktop'
before you leave 'home'.  If your 'server' is for your sole use, and
if 'home' has network connection into 'server', then you could
instead rendezvous at 'server' by running "git push server" on
'desktop' (or 'home') to 'server' as the last thing before you leave
'desktop' (or 'home'), and running "git fetch server" on 'home' (or
'desktop') as the first thing before you start working on 'home' (or
'desktop').




