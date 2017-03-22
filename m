Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F7E2095B
	for <e@80x24.org>; Wed, 22 Mar 2017 01:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757314AbdCVB6b (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 21:58:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751154AbdCVB6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 21:58:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14CCF6DF97;
        Tue, 21 Mar 2017 21:58:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vRqH8l5IwLNXn1PhZHhZ1MZN/SY=; b=is63lR
        cEKzCNzdOC/rsw88JPiPmeD2oJEklaKHISbr6cjMJDu1LUlqwsbrdG7EmrFntHjM
        EYHAGm1fz62+zfTGv6XVxA25Y27l08TfBRU6W4VQLsS49/1C0kXdXVWoCmTNBkbh
        kOxCGP33naOnxsguSK/EhukByEL7zCvVX74P8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C57C6DF94;
        Tue, 21 Mar 2017 21:58:28 -0400 (EDT)
Received: from localhost (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 784E76DF93;
        Tue, 21 Mar 2017 21:58:27 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] t1400: modernize style
In-Reply-To: <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net>
References: <20170321005616.31324-1-kyle@kyleam.com> <20170321020155.dx5juulntg5k6fpr@sigill.intra.peff.net>
Date:   Tue, 21 Mar 2017 21:58:26 -0400
Message-ID: <87fui6kr7h.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A671386-0EA3-11E7-85DF-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=vRqH8l5IwLNXn1PhZHhZ1MZN/SY=; b=Lg8XCT1JkUnYTJtDhmiSkCcaDO9s6Klugc5mde0CBBUCvUqbhh9CZhbGNs512Ecw2XYUObbigZkPsOoycZHGV5Pya87s1UjPMWIF6xAnmrtQb/7tzkK7K2eAznJPFcfQoFdzLqMTx+vA9xaLOv3/jR9saW1iy6RhYphxqOHuI7Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Mar 20, 2017 at 08:56:11PM -0400, Kyle Meyer wrote:

[...]

>>   * moving the here-documents for log creation into the following
>>     tests, but I don't think it's worth it because it makes already
>>     long lines even longer.
>
> Yeah, they're quite long. Probably something like:
>
>   # arguments: <from> <to> <time> <msg>
>   reflog () {
> 	printf '%s %s %s <%s> %s +0000\t%s' \
> 		"$1" "$2" \
> 		"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
> 		"$3" "$4"
>   }
>
>   test_expect_success 'verify $m log' '
> 	{
> 		reflog $Z $A 1117150200 "Initial Creation" &&
> 		reflog $A $B 1117150260 "Switch" &&
> 		reflog $B $A 1117150860 &&
> 	} >expect &&
> 	test_cmp expect .git/logs/$m
>   '
>
> wouldn't be too bad. Or maybe it's worse, because the actual format is
> all tangled up in that printf statement. ;)
>
> I'm OK with it either way.

Heh, I didn't consider that option.  I suppose I'll stick with the
here-document for now because, to my eyes, it seems a bit easier to
read.

-- 
Kyle
