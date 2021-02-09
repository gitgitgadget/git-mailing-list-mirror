Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C029C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19C464DDF
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhBIW0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:26:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59459 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhBIWUO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:20:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 359DB124F18;
        Tue,  9 Feb 2021 16:18:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/FJKnOdeZfkZlqSCb5xnMd+QmZE=; b=xT1/1q
        BlvfuTfrXCytII9iDBuEw6eXZ4uUU8bPzVcdWIYPBJ/IZ4o+1nxzjPJDoq5e+BcN
        kco/jT2aiza89sVKas1LBaGQsam+fzHbaUWh4gs/Ls8RxVLpuzubzVZTHRTj8fBM
        U4XJ3E7p2QGBRpfaT5K9iGBWv5uC6EGldpenk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mVnLxOiqWxJ5r52UXVu/ud+pjVBRTz7Q
        Ob1akJWABjACm1pUewfkC++P43b6I2J8WjBe79O7wWuwTIKoNTrZmKJsq3+9kfTX
        K19cslviypKONPUPA7U8KmSBGNwLV3ZEevoBoPT6NEbTG2KywB+N7qWCUkk0YJBZ
        3sjPbHFgmKQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F024124F17;
        Tue,  9 Feb 2021 16:18:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72048124F16;
        Tue,  9 Feb 2021 16:18:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, stolee@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2] usage: trace2 BUG() invocations
References: <YCJ6D1wGgmo1a+KT@coredump.intra.peff.net>
        <20210209193459.3100734-1-jonathantanmy@google.com>
Date:   Tue, 09 Feb 2021 13:18:26 -0800
In-Reply-To: <20210209193459.3100734-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 9 Feb 2021 11:34:59 -0800")
Message-ID: <xmqqzh0dym71.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A66519C-6B1C-11EB-9A54-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > +# Verb 007bug
>> > +#
>> > +# Check that BUG writes to trace2
>> > +
>> > +test_expect_success 'normal stream, exit code 1' '
>> 
>> Is this description accurate? It doesn't really seem like "exit code 1".
>> Maybe "99", though BUG is probably more accurate.
>
> Ah...you're right. Maybe 'BUG messages are written to trace2' is better.
> If Junio doesn't do it locally (or if there are other issues that need
> fixing), I'll send out v3.

It will risk me forgetting and queueing v2 as-is, and would leave
you nobody to blame.

Please do not assume that I am paying attention to each and every
detail of discussions, especially the ones involving well known
reviewers.

