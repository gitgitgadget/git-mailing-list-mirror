Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689B31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfFSOIS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:08:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63740 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSOIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:08:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58BF415E137;
        Wed, 19 Jun 2019 10:08:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L+4UHcZLqNwuqnmfwNSaVJRaK0g=; b=vrEaMv
        fpti89vVUwSb8Bwv4kopO4T0US1XvWQqK1zEHjHO9zgdplfoP6ywAx6cVRq+aIcG
        tRvinHzbogIi6+9BqHXq6nHNLJ1t3h1OnbLLM23DzpWZL0aWx45LdGFaWvIIyXkt
        DsLtlmETqXUtFXY4n+HCFnrwxwmEEkVG13rfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KLqpnwEBGrfIUehFVu5gNs8/wYO2AByv
        emhXLdBTxufmOB0dUHvmeLkj6w9j2iyRDxs2M3CW9AGzX/yOKBHCQ0KG7oAQK92i
        m6/tYKcLobGRbtacN7eOejV+ayDkYB81fxlxPV+GYfdD6k8qJ3BoITUAk6PqocC3
        IOIS+9ei//c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FC7915E136;
        Wed, 19 Jun 2019 10:08:16 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1D7F15E135;
        Wed, 19 Jun 2019 10:08:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4] rev-list: teach --no-object-names to enable piping
References: <20190618222917.261701-1-emilyshaffer@google.com>
Date:   Wed, 19 Jun 2019 07:08:14 -0700
In-Reply-To: <20190618222917.261701-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 18 Jun 2019 15:29:17 -0700")
Message-ID: <xmqq1rzpsm5t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE8B1B14-929B-11E9-9DB8-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Since v3, added a corresponding "--object-names" arg to pair with
> "--no-object-names", and "last-one-wins" logic. Also added a test to
> validate this new arg and the logic.

Thanks for a quick turnaround (unfortunately, I was OOO yesterday
and I am half-sick today, so please expect slow responses---sorry
about that).

> In adding the test, I noticed that I had left in a test about --oid-only
> that doesn't apply after the changes from v2->v3; that test is removed.

I noticed in range-diff, too.  So now --object-names can be used
with --pretty (not that "rev-list --pretty --objects" makes much
sense in the first place, so no point in testing that it works).
