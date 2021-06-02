Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9894C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D12613AE
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFBLCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:02:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhFBLCM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:02:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA330143D74;
        Wed,  2 Jun 2021 07:00:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+HXaiebq13I29K7vNK8nJuLsbTBqq08BzTKraJ5nrU8=; b=P0Q7
        3Kdc87WIfA5b3gH/12UXcCxiBhTjga31if+Jf7azIiUvQPFu7PYunNZ3tPI8JInc
        0U34VBKRGrrRW1aHLq1XgIr7CVI/LgbYMFPwzps1FqRv0JHVPF2V51JrLrk/QkVd
        O2t3RpEiJZDw2N+lPNDml8YXKTUuLui1vnsBEp0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C48D7143D73;
        Wed,  2 Jun 2021 07:00:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EACDF143D70;
        Wed,  2 Jun 2021 07:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        <xmqqzgw9qky5.fsf@gitster.g> <xmqqv96xqjyr.fsf@gitster.g>
        <60b6c642ba65b_4044208ca@natae.notmuch>
        <9fb1f823-44f8-8046-adb5-d2c0fdb6b5a0@kdbg.org>
Date:   Wed, 02 Jun 2021 20:00:25 +0900
Message-ID: <xmqqo8co7cqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCC73BE4-C391-11EB-9E0A-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> rerere.autoupdate erases the information which files had conflicts.
> ... So, I'm strongly opposed to enabling it by default.

Exactly.  "checkout -m" can use resolve-undo information to
unresolve the conflicts, but to make effective use of it, you'd want
to know which paths had conflicts to begin with.
