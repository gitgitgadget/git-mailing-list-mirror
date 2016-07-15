Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E232018F
	for <e@80x24.org>; Fri, 15 Jul 2016 08:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcGOI2k (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 04:28:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752798AbcGOI2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 04:28:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B18A0207BB;
	Fri, 15 Jul 2016 04:28:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hZNXEfzcwQxGDwDXkeYqausVNG4=; b=tdxQcb
	YsdV0mrI3AjdvJ1Xjl9mXme9OAzwmKNtxnXQ9KEZHFKsMm+unqEgXPHwoMXvsKAI
	VHkijedT98N2yptN3FQlORQ/boyAqghCh2Kk90UtjsFljDXtybOp01ezZlW6olxy
	CQt+fvbF8uQcZU4Io+R7jo1oQzEgTXTE5SwSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sxqwOpIJnSHweVzA4niEE/P8+Vxr+eIy
	oE7o6Bh+LhyiPNQZamzDYQ3PzwU2eTWdeZOsOBJRfkg077rTIBYGlQ+GB5kK1dlm
	6lYn4DdY70kn9Dw1O5GPwj8bNE763/21DlVhNywGytVZT2ad/b4rn4lWfeS6T9i+
	+4W4KYsWs44=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A8FA3207BA;
	Fri, 15 Jul 2016 04:28:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33E94207B7;
	Fri, 15 Jul 2016 04:28:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
Date:	Fri, 15 Jul 2016 01:28:31 -0700
In-Reply-To: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
	(Christian Couder's message of "Fri, 15 Jul 2016 08:46:03 +0200")
Message-ID: <xmqqd1mfnw40.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E0FF3FA-4A66-11E6-AC47-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> If people think that evolution is better than intelligent design, and
> want each current topic/work to just implement what is best for it,
> then that's ok for me. If on the other hand standardizing on some ways
> to interact with external processes could be helpful to avoid
> duplicating mechanisms/code in slightly different and incompatible
> ways, then I would be happy to discuss it in a thread that is not
> specific to one of the current work.

You seem to have listed only in-flight topics, which may not be a
good starting point to think about the issues.  A common trait their
implementation share may not necessarily be a good thing (for one
thing, one trait they share is that none of them is battle tested
yet), so you cannot distill their commonality into something we
would want to have in the first place.

You would need to have existing practices that have worked well for
us in the mix.  A few examples that may help the discussion go
forward are the remote-helper framework and credential-helper.  They
both call out of Git so that external/third-party enhancement
implementations can do things that core-git alone cannot do
natively.


