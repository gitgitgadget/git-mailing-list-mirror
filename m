Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C826203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372AbcG0Rqx (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:46:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757358AbcG0Rqx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:46:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C7702EA5C;
	Wed, 27 Jul 2016 13:46:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5+tphmdoEKJ0xoLEBLcR0rGnH8Q=; b=cTC3US
	buJAemv8VM/0KKe0T6WSDzJKSrqFPtpkY6ZmXQ85aLU7I6Nge6xdWVl4/u/oOB78
	CLhhazh8Xne2BA3w37Saqfm2e8JAJrStd9uajmuhnTh++gxko9aMR0V9GyeLOLW3
	2q9vhbjuPjMBq9YiEcP2s5v1pm7ULdv7EIQCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rDpYsl+GfcT8ktxMseT2fd0ZsH0kfkpG
	KipOXgu72/v3xGf3tPYq9FzfnLEZlThFZLi2BpP6HBxA7Vq2j0/rq68HzzTa2xmi
	lqZ4/zlVIi25Elwaduit/NUp2wC+xCZgO6LzCPYB0EETNgqf28gWDaC5lxtS/388
	guwBFRQMHco=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84A6C2EA5A;
	Wed, 27 Jul 2016 13:46:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B8332EA59;
	Wed, 27 Jul 2016 13:46:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Phil Pennock <phil@pennock-tech.com>,
	Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretty format string support for reflog times
References: <20160727081414.GA21451@breadbox>
	<20160727135820.GC14928@sigill.intra.peff.net>
	<xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 27 Jul 2016 10:46:48 -0700
In-Reply-To: <xmqqwpk7vw30.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Jul 2016 10:18:11 -0700")
Message-ID: <xmqqk2g7vurb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 193FB318-5422-11E6-A054-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Hrm. Since Ted was not cc'd, it is not clear to me whether this is
>> coincidental or in response to the thread over in
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/299201
>>
>> To summarize, I think the conclusion there was that we would go with at
>> least the 't' and 'r' formatters in the short term. The 'i/I' ones were
>> not something Ted cared about that much, I think, but they do make
>> things orthogonal with the other ident dates.
>
> I forgot about that thread after it stalled without drawing
> conclusion, after Ted asked if anybody has a strong opinion
> and saw only one response to it at
>
>   https://public-inbox.org/git/20160711164317.GB3890%40thunk.org/
>
> So, what is the next step?  Apply
>
>   https://public-inbox.org/git/20160710055402.32684-1-tytso%40mit.edu/
>
> but exclude %g[iI] bits out of that patch while doing so?

FWIW, a squash to do so is trivial, but the original had two
compiler breakers.

I am not sure about the latter, i.e. the return value from the
get_reflog_time_t() function (which I think is misnamed, in that the
function returns "unsigned long", not "time_t", and should be
renamed to get_reflog_time()) uses the epoch as a fallback value.



 reflog-walk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index d0aa2d0..51bfe29 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -309,7 +309,7 @@ void get_reflog_message(struct strbuf *sb,
 	size_t len;
 
 	if (!info)
-		return NULL;
+		return;
 	len = strlen(info->message);
 	if (len > 0)
 		len--; /* strip away trailing newline */
@@ -330,7 +330,7 @@ unsigned long get_reflog_time_t(struct reflog_walk_info *reflog_info)
 	struct reflog_info *info = get_reflog_info(reflog_info);
 
 	if (!info)
-		return NULL;
+		return 0;
 	return gm_time_t(info->timestamp, info->tz);
 }
 
