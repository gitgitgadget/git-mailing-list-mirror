Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F371F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbcG2Wpk (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:45:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754189AbcG2Wpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 18:45:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BC0D2F572;
	Fri, 29 Jul 2016 18:45:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BimaX/HMJR/31XA00vhiJpcEDQw=; b=Bxdbjl
	OBwGUTCzTj6Xe8U/OjoYYkKVhcXrF1UMfiBDAo8BJ6hF0TQKAUbPVIqUDBER8Zdj
	OEWDMlVb88i0VyMqbCR24WXX4uGzeImKrAy+tVOv4wOlOx3gLOrsXW3OU4A7sVJT
	CtDkdHxikdo3pLusOcq200dWy34ERF/MJCwSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s23fXDPXSaRL4aPkRiEN1R4Y7nHASBcz
	FvBw87wrHcPmY4uLXX0wU10vYwQ4FItljPz6kVxduuM3MO22oEBxJGuPsVP3/Bz9
	Y7dZrP3LZ5msKT7WCdWELc+31F5WMnrG+bTQ/ElMVp4TD6pUGojEdst30Ei6tsV1
	6JdsZoeYGsk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1492D2F571;
	Fri, 29 Jul 2016 18:45:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A02852F570;
	Fri, 29 Jul 2016 18:45:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	<xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
	<20160729181121.GB14953@sigill.intra.peff.net>
	<xmqq1t2cnvco.fsf@gitster.mtv.corp.google.com>
	<20160729223134.GA22591@sigill.intra.peff.net>
Date:	Fri, 29 Jul 2016 15:45:35 -0700
In-Reply-To: <20160729223134.GA22591@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Jul 2016 18:31:35 -0400")
Message-ID: <xmqqwpk4kqr4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B2A172C-55DE-11E6-B6FD-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> TBH, I'm not sure anybody cares that much between the three. Even before
> user.useConfigOnly, this could be an issue on machines where the ident
> could not be auto-configured, and it seems like nobody ran across it.
> It's only the funny interaction with pull.rebase that makes it likely to
> come up, so as long as that code path is fixed (one way or another), I
> doubt anybody would bring it up again.

Yup, I do not think the choice among the three would make all that
much difference in practice.  If I really have to pick one of them,
I think the one in your message I am responding to would make the
most sense.

The one I sent, which I wrote as a response to some end-user request
on the list back then, has been sitting on 'pu' for quite a while
because I didn't see a real use or positive support for it, and the
only reason why I sent it is because this might be that one
real use it wanted to see.


> In some ways this is less convenient, but in some ways it is
> more so; the user can then manually commit or even "git
> rebase --continue" after setting up their ident (or
> providing it as a one-off on the command line).

Yup, that is the controvercial bit, and I suspect Dscho's original
was siding for the "set up ident first, as you will need it anyway
eventually", so I'll let others with viewpoints different from us to
chime in first before picking it up.

Thanks.
