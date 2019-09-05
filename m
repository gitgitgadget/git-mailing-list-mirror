Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27051F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390741AbfIETeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:34:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54229 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbfIETeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:34:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D6E12ADB5;
        Thu,  5 Sep 2019 15:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XrjEcvOwkpQU2rautMFDgxhKGIw=; b=yhNzI5
        B6eCUtVp+d4+nkEXDPd/n9hhvZLUAoc8Y0L5BeHFWnAZElkhUmYJGcVMwgaltkLc
        8AjZshD7YoKwKbK5gNKmCX1TBjXVJ5DXF4nhLhHL91IEy7p2qnA+Hd3ok3ytknba
        thsosq8h3N7pDGhq7eNJ7hKgtvbDXe5Fc2758=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oDKvcB20NI+ssuymRjsbSXnnag4YpgqI
        SU4UDYSnwwnXrl24Odt14zOELcspw2+7jTCLgVfB0dbWIeaT0nXTKK+JO0u3B19C
        calgFSGKzNxmo1t9FQ7fWA5TgqpQiFsy+UAsuzD8Mhliu3dAQuwlMqCJ/+qBr3IR
        Zk69BFOA+t8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 763392ADB4;
        Thu,  5 Sep 2019 15:34:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5C06A2ADAE;
        Thu,  5 Sep 2019 15:34:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: use LF variable defined in the test harness
References: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
        <20190904002930.GA76383@syl.lan>
        <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
        <20190905184716.GA12647@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 12:34:02 -0700
In-Reply-To: <20190905184716.GA12647@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Sep 2019 14:47:16 -0400")
Message-ID: <xmqqmufipmfp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E125C30-D014-11E9-9AA2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 05, 2019 at 11:17:57AM -0700, Junio C Hamano wrote:
>
>> Somebody may want to go clean-up the use of various $sq and $SQ
>> locally defined by giving a unified $SQ in test-lib.sh, by the way.
>
> Maybe good #leftoverbits material, since we may have Outreachy
> applications coming up soon.

OK, then I'd refrain from doing it as a lunchtime hack myself ;-)

 * Find sq=, $sq and ${sq} case insensitively in t/.  If there is
   any use of $SQ that does not want a single quote in it, abort
   the whole thing.  Otherwise proceed.

 * Introduce an assignment SQ=\' in t/test-lib.sh, next to where LF
   is assigned to.  Replace all uses you found in #1 with reference
   to $SQ.

#leftoverbits.
