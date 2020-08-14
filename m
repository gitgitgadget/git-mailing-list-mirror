Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65978C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318C120771
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 04:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CPmwfzcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgHNEpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:45:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55466 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgHNEpH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 00:45:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2ECBE41F8;
        Fri, 14 Aug 2020 00:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pOKTmbHpUvXvb8Ex1JMgkXMUGrw=; b=CPmwfz
        cGKb5EUQ6KqJ2/HtBvzTlSY8baD4sGGJUzA9Z9lb9/NBWJ++g1/cWY3AvnXpTJQO
        ZrMfIeWq1BU8VH0e2K9KTHHSqgGPg2OiEcqVT2BC2f5a1JKd2PUi1jsU11czgv8r
        Ol9Qoyc6bd14+4U8Sw4TlAjK8zLhG9zYm1+MU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xB7n+fGbZ76bn1v7Cfmy0qP3HYmKQImp
        0fK+C7Y3FNOZCilREmF6OukUa7sYWBc7P3+quJbPo2uP3bTMe4MwXl3/jVJCdZFW
        5g4bdBomNvlDmHvqeogeP+rxLgI1poQ2jGWOW7itXQd3eizMx3MlFU//ibIxyosV
        5ZITuSQuyOE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB747E41F6;
        Fri, 14 Aug 2020 00:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF5B9E41F3;
        Fri, 14 Aug 2020 00:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] messages: avoid SHA-1 in end-user facing messages
References: <xmqqy2miyr0f.fsf@gitster.c.googlers.com>
        <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com>
Date:   Thu, 13 Aug 2020 21:45:01 -0700
In-Reply-To: <ee61b773-91c0-4b30-1d5b-e941bba03867@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Aug 2020 22:21:51 -0400")
Message-ID: <xmqqlfihzvhu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAA953B0-DDE8-11EA-A77B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> N_("Show blank SHA-1 for boundary commits (Default: off)")),
>> N_("Blank object names of boundary commits (Default: off)")),
>
> Is there a reason you dropped "show" here? Perhaps your
> intention is to use "blank" as a verb, but it read a bit
> awkwardly to me.

You guessed my intention correctly.  By using the word "blank" as a
verb (i.e. to fill the space, which should ordinarily contain
something meaningful, with whitespace instead), I can shorten "Show
blank" to compensate the lengthening of the message caused by
replacing "SHA-1" with "object name".

It also is more correct.  There is no "blank SHA-1"; blank cannot be
a valid SHA-1 hash value.  We are showing blank instead of SHA-1,
and I found that "blank" as a verb exactly has that meaning, which
was convenient.

The above is *NOT* to defend the choice of the exact phasing I used,
but to explain the criteria we need to use to come up with a better
alternative (in other words, why "show blank object name for..." is
a better replacement).

A better phrasing to replace it is of course welcome.

Thanks.
