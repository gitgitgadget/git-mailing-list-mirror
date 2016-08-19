Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B411F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754516AbcHSP7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:59:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51029 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753665AbcHSP7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:59:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0252934F1C;
        Fri, 19 Aug 2016 11:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lrzN8r9u7XMnnANzqHg2JPqQOJ8=; b=b+4Fp1
        uE6/1RLy33tz86wPlt0N3mbEEtC7MV/uZ2EJZ9Q3ZrZoOex92zQKwb4CpopGjqcu
        +i+YCdgzECdYwYqCKmpCgD10dbXXOp+iMqGeasKJByrRXwV8paP3xsLRM1SkOxit
        Ncp3T5C/9/KkQmtNEWO669Bb7+OmJsK8xcsoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nmtswA6PW25Ta6+Xw0qrtEuxpRjHaOAc
        ZS51eDl8Ekfst3EnTttdHJ9lHNrbmMlKVF6om1VKexYPK3QbQxY+B/8afIbloZ+q
        Lz95c2kWZBOpAhMuLmk5gPQys0igPboNkxxt4pxAQZPrQA6KtHdJJOvOVU61uUKA
        s1X5cXG/weU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDFE034F1B;
        Fri, 19 Aug 2016 11:57:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D3BE34F18;
        Fri, 19 Aug 2016 11:57:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not inherited by child processes
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
        <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
        <20160818173555.GA29253@starla>
        <xmqqshu14udc.fsf@gitster.mtv.corp.google.com>
        <20160818224814.GA10341@whir>
Date:   Fri, 19 Aug 2016 08:57:41 -0700
In-Reply-To: <20160818224814.GA10341@whir> (Eric Wong's message of "Thu, 18
        Aug 2016 22:48:14 +0000")
Message-ID: <xmqqbn0o4uq2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA1D2446-6625-11E6-8112-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I'd be more comfortable keeping the EINVAL check that got
> snipped in your reply.  O_CLOEXEC can be defined to non-zero in
> new userspace headers, but an older kernel chokes on it with
> EINVAL.

Good point.  Thanks.
