Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BFC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CA16140E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 18:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGBSRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 14:17:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65346 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBSRp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 14:17:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0B0B14DBA1;
        Fri,  2 Jul 2021 14:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o03W32AKHpbdoEGmt7dF8pg/mVd6SilEooTM23
        ELJnU=; b=o7bT/7F9NULNarJQRkMmcyxpe23WFe/FnE6risNhR5A5tbE03qKAId
        1McZEY0IKP3P2+bkCkgACsUgYsTy6EVY4Exs5F6DY17ptdWQxuOpX1hsCeKm6rLJ
        55cEi9F5xQ5QAND0iMRwaYDQxkEHR67P8xuHwgW2PbiLVZz0GNDR4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C93FA14DBA0;
        Fri,  2 Jul 2021 14:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90F8814DB9F;
        Fri,  2 Jul 2021 14:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
Date:   Fri, 02 Jul 2021 11:15:07 -0700
In-Reply-To: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Fri, 02 Jul 2021 16:01:06 +0200")
Message-ID: <xmqqczs0popg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FA1824C-DB61-11EB-BBAB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I was wondering whether git fsck should be able to cleanup
> orphaned branches ("HEAD points to an unborn branch") as described
> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
> it be editing files in the repository, but I feed that's not the
> way it should be.

HEAD pointing at an unborn branch is not even a corruption, isn't
it?

   $ rm -rf trash && git init trash

would point HEAD at an unborn one, ready to be used.
