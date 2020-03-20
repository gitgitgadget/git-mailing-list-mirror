Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE3C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D9120409
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ownr595R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCTWr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:47:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50753 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:47:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CDF85E62C;
        Fri, 20 Mar 2020 18:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T7+zZ6IgHRJU7yafV5Ggnnjc5Cs=; b=ownr59
        5RUWTjsVxrSMdFs9rSfZ+6YPDZjcLJyGgWNQo0d9YDGf52j97fwCS0XHDUjzmsqf
        nJawEufFNpKHG1eFGRN5LX7jW2avWHQh+P19cAMx4erHVjv8dqaPlCCtobIh9ifx
        5bgXBKl25lkR8PYni+ewxvcsbDNZinUvpqSOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TiHVQRrycrzOPyxV06q/nPZbSNYXDgo6
        ezGCItC3t3OyMXGYVGbq17+kUxPA510fkJGtNTHSOX5e6LmV24KSssjL7mxpcPIH
        mINBL3th4cNwlMZnESVbt2v5bnBZSeuuyvBpWDW6fmlDY0tI5CmsUvaPZoAcIXWF
        RREq3gtdg9g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5509E5E62B;
        Fri, 20 Mar 2020 18:47:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D01755E628;
        Fri, 20 Mar 2020 18:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <20200319213902.GB45325@google.com>
        <xmqq8sjudirm.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2003202336390.46@tvgsbejvaqbjf.bet>
Date:   Fri, 20 Mar 2020 15:47:24 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003202336390.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 20 Mar 2020 23:38:12 +0100 (CET)")
Message-ID: <xmqq7dzebq4j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C51033BC-6AFC-11EA-A70D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I actually have a suspicion that "git bugreport" that is spawned via
>> "git" wrapper is a bad idea (in other words, /usr/bin/git-bug that
>> is totally standalone may be better).
>
> The obvious downside of `/usr/bin/git-bug`, of course, is that it has no
> way to provide accurate data regarding, say, the cURL version in use.

Sorry, but I do not see what's new in your argument this time.

I thought we've already established that the best solution for the
"accurate data regarding, say, the cURL version in use" is to use
your earlier idea, i.e. give an interface to git-remote-curl so that
"git bugreport" can ask it such details, because "git bugreport"
that is known by git.c::cmd_main(), whether it is builtin or
standalone, is *NOT* linked to the transport anyway.

And the same interface can be used by an independent "git-bug", or
even by the end user who is sitting at a terminal when asked by git
developers "what version of curl library does your build link
with?".
