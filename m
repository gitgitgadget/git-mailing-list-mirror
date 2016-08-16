Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF061F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbcHPRuR (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:50:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbcHPRuR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FA0934EA2;
	Tue, 16 Aug 2016 13:47:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wGpdhEMpoMxsMxBhmrpBXMDOMq8=; b=E1iYrK
	uwj3uexZRp6OoMfctsfZ+TeplDIGpuWQlLiIEZyXqvYs7OxG0dW1zPlx96i6lFZn
	IvtwaKtuwXnpMtMc5iXXWHya+3JEGpEDr1McIQtjxtlZ/vPyOqQUN/oPKIdRSgVp
	yJ3Qicl1UDO6ZXGchy+yIMtAcd+SV8vSFddG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pAPlNXIJyFjuG8iKvgD2OOns/CWjbP93
	IpIPZLWtkiWJDleRDkdeW3j5ofi9g9saD70vIoJZ/8Wvk/UxAimgkN90Zgc/pOu+
	SA4xFl7X22egMG4X64TOar9/ykdKlbN4TLr5ODW2RuTHNWTgO8S3baxOowXGs2p4
	85VbkVobbpY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 636E534EA0;
	Tue, 16 Aug 2016 13:47:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E228D34E9F;
	Tue, 16 Aug 2016 13:47:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	meta@public-inbox.org,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
	<xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kby02NuRvQkcuTNjxxc4oDvjAH4wE=3dCXmqyRRrCU0tQ@mail.gmail.com>
Date:	Tue, 16 Aug 2016 10:47:44 -0700
In-Reply-To: <CAGZ79kby02NuRvQkcuTNjxxc4oDvjAH4wE=3dCXmqyRRrCU0tQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 16 Aug 2016 10:22:57 -0700")
Message-ID: <xmqq1t1oehbz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A386E5E-63D9-11E6-81DF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In your work flow, how do you respect the cover letter?
> e.g. in 3787e3c16ced:
>
>     Merge branch 'ew/http-backend-batch-headers'
>
>     The http-backend (the server-side component of smart-http
>     transport) used to trickle the HTTP header one at a time.  Now
>     these write(2)s are batched.
>
>     * ew/http-backend-batch-headers:
>       http-backend: buffer headers before sending
>
> Is the text from the original author (and if so from which version
> of the cover letter) or is it your work?

The source of truth in the merge log message is the "What's cooking"
report.  I really prefer to write these in my own words, as that is
a good yardstick to measure how much/little I understand the topic.
If I cannot describe it concisely, in a way suitable as an entry in
the release notes, that means I am merging a topic I do not have a
good idea about, which is quite irresponsive.  Forcing me to write
these myself keeps me honest.

Of course, if a cover letter describes the topic well, it would help
me write the entry in the "What's cooking" report.

It is a bit tricky to aim for the automation, though.  The cover is
an overview of the proposed log messages and typically tells a story
"I do this, and then this, and finally that", plus a reroll-specific
commentary like "what changed since the last round".  On the other
hand, the entries in the release notes gives a description of what
happened from a third-party's point of view.  They are told in
different voice for different target audience.


