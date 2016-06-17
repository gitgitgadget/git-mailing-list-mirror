Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDD6320179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcFQR3b (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:29:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752524AbcFQR3a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:29:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0622F24DC1;
	Fri, 17 Jun 2016 13:29:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lcp0BL3phm7iw0cszyEgYO245bY=; b=LdE1/B
	puKEvp7LIsVylkjgoI3Tr4S0mikz69FaepMldYDr7xNJX4WVd7hS+4LcW32OL+Ur
	8WHl74Z7BdrdIQn/F+07Azn7g3MCX5iJqoqVsHr2mHGjDpH4KMUvfwSmvui9N3Of
	l1XtYHU8PpasXsZw61LgzoJDcns4tw6+0jsh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V3ZT8aRMK7FlE+oHuTS1Zfdsl8yjP4GT
	gbUGM+BJJBW4l5NE5nO5/W8HVEq6qOxu+XsfvMsBF7PlQutZ/t4iHxKhQP8AncZ9
	9vlHaCHDRqcCGngpYA6nHwLUucLPLD40pXJ3A+KuojKlck9UXsQPKVxUVJ2jh7NJ
	4sAdKDaJfA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F09E624DBF;
	Fri, 17 Jun 2016 13:29:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B31924DBE;
	Fri, 17 Jun 2016 13:29:28 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Joey Hess <id@joeyh.name>
Cc:	Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] add smudge-to-file and clean-from-file filter configuration
References: <20160616203259.5886-1-joeyh@joeyh.name>
	<20160616203259.5886-3-joeyh@joeyh.name>
	<3c7349e7-34a1-ed7f-721e-e7a7b191bb3d@drmicha.warpmail.net>
	<20160617124707.GB24025@kitenet.net>
	<xmqq60t73igm.fsf@gitster.mtv.corp.google.com>
Date:	Fri, 17 Jun 2016 10:29:26 -0700
In-Reply-To: <xmqq60t73igm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Jun 2016 09:09:45 -0700")
Message-ID: <xmqqk2hn207d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B47CCD6-34B1-11E6-B72C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we prefer not to make this customizable (i.e. not having
> to use'%p').  Unlike '%f' that is optional, smudgeTo and cleanFrom
> "filters" are not filters and MUST read from the path given and not
> from any other paths.
> ...
> Would an interface that always appends the pathname at the end of
> the command line string work?

Just to avoid misunderstanding, when I say "I wonder if we want to
go this route instead", I am open to a response that says "No, we do
not; going that route is worse because ...".  Please do not take it
as a suggestion or request to "do it this way instead".

I may not even favor that other "route" I mention in my message with
"I wonder"; I am merely saying that I cannot come up with that
"because ..."  part to reject it myself, and asking for help from
others.

In this case, I would be happy to hear "Yes, '%p' may merely be a
way to allow taking the pathname at anywhere on the command line,
but that flexibility is important because...".

Thanks.

