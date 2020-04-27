Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE8C82E81
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1242075E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CXVaVUCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgD0XQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:16:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61976 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgD0XQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 19:16:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61D5E4435E;
        Mon, 27 Apr 2020 19:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Holx5MbX5SJdtqicIeyKzig+YL8=; b=CXVaVU
        CaVaFbHu13lvrk5n+i8DFieJTnN80eKKc89BzK4fLwe0iy6L/8vdb202ePQh+V4L
        A69ctj3NnmzGv1gzH9laFWtPUap+8c5AHpb3ywlxKUeODzRKHudeApi/ajKPuT7L
        BQi0A1r1y75ATULMycYKr1DAfybpVyfwaI0BE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nTZsx8pQHmZ/lJUE91FlssWIYnFvAWcx
        uIvKkbjbCKD6GFnoWkqe0bbbmPq2gvcS/HdTxve/3JTbl3uWuBxzgiewF3LQId7J
        GAlLlfYxIuRVi96pjZOPuuXQ3SsDcmaI4cKKfzujvQkBOE7SWYlc1eOUPZkaw7Jb
        GoWADveM3v4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D7264435D;
        Mon, 27 Apr 2020 19:16:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7125A4434A;
        Mon, 27 Apr 2020 19:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <xmqqv9lod85m.fsf@gitster.c.googlers.com>
        <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
        <xmqq8sikblv2.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet>
        <20200427200852.GC1728884@coredump.intra.peff.net>
        <xmqqlfmg7hn7.fsf@gitster.c.googlers.com>
        <20200427220955.GA1747507@coredump.intra.peff.net>
        <CABPp-BE4qBquBwHp6QH31WNcQ-jUMrC+SqCbnBWKtCxdhoWRCQ@mail.gmail.com>
Date:   Mon, 27 Apr 2020 16:16:07 -0700
In-Reply-To: <CABPp-BE4qBquBwHp6QH31WNcQ-jUMrC+SqCbnBWKtCxdhoWRCQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 27 Apr 2020 15:23:22 -0700")
Message-ID: <xmqq4kt47c5k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14C46FE2-88DD-11EA-AFA9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> If it lived in contrib/ that might strike a good balance between making
>> it available for people to experiment with, but not having people
>> confuse it for the official build system.

If we declare cmake support is only for VS and throw it into
somewhere like contrib/buildsystems, that may be good enough.

> Maybe we could move configure.ac and config.mak.in into contrib as well?

Perhaps.
