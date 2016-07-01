Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B689C2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 18:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcGASy3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 14:54:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbcGASy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 14:54:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9C4627326;
	Fri,  1 Jul 2016 14:54:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BUoQgxQPVT6yOEPejT/HJir2hAY=; b=xnBdnV
	VdeZuOI8rIjCwXnWV83aX+We/zzbXkBLkQP7owXDivr8c1Ii3du4x1A1fmX9I06i
	lSsvNCid+GFE+R5qt5yhF2/9r91GNpK7nWdyI2hML6S+xkcctp1H4hYd3eKBBEuu
	qLTVbhPc0Zvqx3nA31xMB/J8b3ZZMYGNwal5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IcwP5QOhgBimKwAmZNXFvAwVQI4lpzEm
	oPRcjlk2B7nQGOaxTeYhv+/t4tkDH5CbXbO88mDErHdFGL9eEh8doP4Ta3CXBiYG
	in/Zdc0hA+2mfgPkcua20ZeM3z3H6LhI4hnzLdotK4dz7IjW5O5OCApJ8BXS0VLw
	QHPSnlLyMRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C26BF27325;
	Fri,  1 Jul 2016 14:54:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4422527324;
	Fri,  1 Jul 2016 14:54:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/12] nd/icase updates
References: <20160623162907.23295-1-pclouds@gmail.com>
	<20160625052238.13615-1-pclouds@gmail.com>
	<xmqqeg7id6ns.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BU0fDVR54hMpA6qVknj+QxWR9Z-i1gRgpaJ6hp+SB2xQ@mail.gmail.com>
	<xmqq4m89z0gl.fsf@gitster.mtv.corp.google.com>
	<CACsJy8BBQqxzT8jdaysyeDv3ja=DTD6R-whA3Lhr3pEs-2x8dA@mail.gmail.com>
Date:	Fri, 01 Jul 2016 11:54:04 -0700
In-Reply-To: <CACsJy8BBQqxzT8jdaysyeDv3ja=DTD6R-whA3Lhr3pEs-2x8dA@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 1 Jul 2016 20:46:30 +0200")
Message-ID: <xmqqziq1xk8j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FB1F60C-3FBD-11E6-960A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jul 1, 2016 at 8:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> Makes sense. But then if opt->ignore_case is false and regflags
>>> happens to have REG_ICASE set, should we clear it as well?
>>
>> I think .ignore_case is set iff '-i' is given, and .regflags has
>> REG_ICASE only if '-i' is given and the user said she does not want
>> literal string match (i.e. no '-F').
>>
>> So... can .regflags have REG_ICASE when .ignore_case is false?
>
> Yeah reg_icase is more like a subset of ignore_case. Ignore what I wrote.

The rule of the game can be updated to make whoever looks at
.ignore_case currently instead look at .regflags & REG_ICASE; that
way, we could remove .ignore_case and stop worrying about one is
subset of the other.

It is just it felt funny to be mucking with .regflags when the user
explicitly said -F, and that is why they are separate.
