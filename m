Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74114C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C18D20825
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t+IHfTuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgH0T52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:57:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0T52 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:57:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1FE06F660C;
        Thu, 27 Aug 2020 15:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YXDHQnXuCq0JazOS+PD7cRJoqI4=; b=t+IHfT
        uXOm1OPPcA1Htha4BZi2kjpTNQHryTsSZRJKWyXx9rkkFZI8f/xhPTCuE5lhZGsQ
        iluy70eDDcGNmqRyZk30D9r3yC8VpYXL5yKO+hmWOsSSIdkv4rxFOuzc+q8K4OOA
        cZjxpoBzHIhNAs+Qz5XOmRufNdmD6h/khppFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tz//45sZHWcfLQ2tHX1r6i3VfXwgE/qv
        8abl/F3ZLBqibNWNc1ddaAGX2Di9WlWf4jhJ/PKyac4dC11aGj3RcF6lBye+ok7+
        +zIKPMlU8rwA/BFsmYe2pIrv9DBuyd+anPQ+km/BpFrH/eciEm47x0O00JessHAw
        JmeKrsykv3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1982DF660B;
        Thu, 27 Aug 2020 15:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A95CF660A;
        Thu, 27 Aug 2020 15:57:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 00/10] New proc-receive hook for centralized workflow
References: <20200824174202.11710-1-worldhello.net@gmail.com>
        <20200827154551.5966-1-worldhello.net@gmail.com>
Date:   Thu, 27 Aug 2020 12:57:21 -0700
In-Reply-To: <20200827154551.5966-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Thu, 27 Aug 2020 11:45:41 -0400")
Message-ID: <xmqqmu2fq2u6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86009858-E89F-11EA-863B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> ## Changes since v18
>
> 1. This series is based on "next" branch, in order to resolve a conflict
>    with commit 95e7c38539 (refspec: make sure stack refspec_item
>    variables are zeroed, 2020-08-14).  See patch 9/10.

We cannot ever merge such a topic that depends on 'next' down to
'master' without dragging all the other topics that present in
'next', plus the merge commits that bring these topics to 'next'.

In this particular case, I think the conflict resolution is trivial
and more importantly, it is not a *new* conflict v19 introduces but
did not exist with v18.  IOW, what is in 'seen' has already resolved
the same conflict between 95e7c38539 and this topic.

I've applied these directly on 'next' (call it c0), rebased the
result on the same base as v18 is queued on, and then merged the
rebased v19 (call it c1) with 'next' to make sure that the result
(call it c2) matches, i.e. tree of c0 and tree of c2 are identical.

I'll use c1 to replace what is queued in 'seen'.

A workable alternative would be to base these on top of the topic
that contains 95e7c38539 (i.e. jk/refspecs-cleanup).  Then, this
topic is still taken hostage by that 'cleanup' topic, but at least
as long as that topic graduates, this topic can graduate to 'master'
without having to drag any other cruft with it.

Thanks.

