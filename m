Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52C7C20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbcF2WLt (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:11:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbcF2WLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6409A28ECA;
	Wed, 29 Jun 2016 18:11:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BL7UVKDdY+JfDlHatzPzMUYgJ+k=; b=hLxsla
	me5Wj9Zqz8w1eE3EOtd7xxqvBEAQ3222YRMlDUrr7vDplkowNuwTbDnDOo8JWWte
	BzH48Qto+hdrhvUNlx/mYauuhDEjEUVK3Ri5Vt4ePJkB/f3flp+fufpqCntI3HN6
	kGlztGt+zah+yIGTy7DvGogNQi7g+NnQX5S7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TqtDQ40tdn57fqhkQO6zaMqquaFev6Lt
	bl/G67iqupg0BU2xtw5rFYSwq7DlLSVSRJNyqi0UUmeW6wlydWTyGqYXjQPEGm4H
	OFMHEgprVJEHrxy4fy+Yv4wprHRgpaze1w/pnkYqZXQzSDglV8AKeVEj7a6ziiMA
	JeScAtCMF7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F2628EC8;
	Wed, 29 Jun 2016 18:11:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B07A928EC7;
	Wed, 29 Jun 2016 18:11:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
	<CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
	<CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
	<xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
	<20160629205647.GA25987@sigill.intra.peff.net>
	<5774426F.3090000@gmail.com>
	<20160629220049.GA4416@sigill.intra.peff.net>
Date:	Wed, 29 Jun 2016 15:11:39 -0700
In-Reply-To: <20160629220049.GA4416@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 29 Jun 2016 18:00:49 -0400")
Message-ID: <xmqqlh1n1w84.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7543583C-3E46-11E6-B659-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yes, though generation numbers can help with more questions (e.g., "what
> is the merge base").

Hmm, how?  I have two commits, with generation number 38 and 47,
respectively.  What generation number does the commit that is the
merge base of these two commits?

I know we can say that 38 cannot possibly be a descendant of 47, but
can we say anything else that is useful?

