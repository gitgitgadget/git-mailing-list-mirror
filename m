Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7947E20193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbcHDTy4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:54:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934012AbcHDTyz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:54:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D38F3149F;
	Thu,  4 Aug 2016 15:54:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YUtb8mkCQ5g26cyOlK7vyiO+6jo=; b=fudmKa
	mGOu14aYQbm0DKEb3uW9zhY80U2ovvuqapQHUNMyU1N9LI0JStlOdO6+A9GG6hkg
	hedg4ScCdZo9tnTghkNgM6bP1XVyZjMCT2rloCylcQKJjyjsKCvc7nkkRNJjCCJC
	1q6pnI60jIqiYixn4YaFcTGdV0ikhiczK6cFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NgXPkMTKaPwKQR5PayWo8tdoGNHsTQKv
	0wGKcrntStwPbyz3Fk0waBm/xLbkA8K8HvNp4Dum/yRwcIW2rSc/s0q238/wDzbc
	4wBN/YiV0vy/GUYKxH8EON/ZS3Xq4IWvEAsUjacO6VZgKco1vz4n4GpM3HjuzotK
	n1DFgeyBC8I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 657C43149C;
	Thu,  4 Aug 2016 15:54:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF9DF3149B;
	Thu,  4 Aug 2016 15:54:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/8] Better heuristics make prettier diffs
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<20160804073833.7s3hh26hkalifima@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 12:54:51 -0700
In-Reply-To: <20160804073833.7s3hh26hkalifima@sigill.intra.peff.net> (Jeff
	King's message of "Thu, 4 Aug 2016 03:38:33 -0400")
Message-ID: <xmqqy44c1f90.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FE61BB2-5A7D-11E6-A3F2-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Not that you probably need more random cases of C code, but I happened
> to be looking at a diff in git.git today, b333d0d6, which is another
> regression for the compaction heuristic.

Wow, that one is _really_ bad.  Does it have something to do with
the removal being at the very end of the file?

> The indent heuristic here gets it right.

Looks that way.
