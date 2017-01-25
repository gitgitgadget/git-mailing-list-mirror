Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C0A11F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdAYVlE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:41:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51219 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752063AbdAYVlD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:41:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A5F2636F8;
        Wed, 25 Jan 2017 16:41:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9XDQw0QhOpJl0zbHjPcA+yJY/mY=; b=fxh9kC
        t+Ha/f8bOYA6Tos9bjN0DXBCTYuLqaaEZSGd2kGQXJi6TbtOQuO8GltIlfdUfRV3
        VVLoEKqmHHTgz2zNG8DfkGMDjlmrPuBKVGOAv6uLSCn61VozcveKkq8Enxa9Wbs9
        PCQcW2XpoJoi1i7rdlOxHqBqI6a1bcqKnSN0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GzLymal1wMTz0STpazywClzIg0+JUVkV
        Eqhz4lvgyr+lHj3/tMhaWx9+6HbsfVrtXtLx8CwYaNBmMVH7VtyPXTMJwPmydeqC
        nEnGuE27KWbgWOa/5DHLyTuN4VNq8jHGqDlHeVtZb6CUkfwOJfk/n7N6Mr85zZTo
        1ke6MkUbdf0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 516DD636F7;
        Wed, 25 Jan 2017 16:41:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95D66636F4;
        Wed, 25 Jan 2017 16:41:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Retire the `relink` command
References: <10319c47ff3f7222c3a601827ebd9398861d509d.1485363528.git.johannes.schindelin@gmx.de>
        <20170125211331.ts4ohigz5z6ugj6q@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 13:41:00 -0800
In-Reply-To: <20170125211331.ts4ohigz5z6ugj6q@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 16:13:31 -0500")
Message-ID: <xmqqtw8m95sj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F73A3AC2-E346-11E6-855D-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jan 25, 2017 at 05:58:57PM +0100, Johannes Schindelin wrote:
>
>> Back in the olden days, when all objects were loose and rubber boots were
>> made out of wood, it made sense to try to share (immutable) objects
>> between repositories.
>> 
>> Ever since the arrival of pack files, it is but an anachronism.
>
> Yes, this is a good idea. I could _almost_ see its utility if it linked
> packfiles, too, but then it is very unlikely that two repos have the
> exact same packfile.
>
>> Let's move the script to the contrib/examples/ directory and no longer
>> offer it.
>
> I am OK with this, but perhaps we should go even further and just delete
> it entirely. The point of contrib/examples is to show people "this is
> how you could script plumbing to implement a porcelain". But this script
> does not call a single plumbing script. It just looks directly in
> objects/, which is probably not something we would want to encourage. :)

Yeah.  I am OK with this patch as the first step of "first move to
contrib and then remove" two step process, but I suspect we may
forget to follow through.
