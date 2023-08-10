Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA85C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbjHJQKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHJQKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:10:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDD335A4
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:10:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95AFA1C78C;
        Thu, 10 Aug 2023 12:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/FkgU3iXAcLZujEDP7IR6iAttlsWfNvOhlR6jJxh950=; b=iClc
        WSJyeMVDzbWnu6I4ASDOoAS0BEgSsNaIjasglxlKW+t0xqSMOpObWEm+6I05I+qI
        1SM18vnLnbryHOSUwJKhox6QKHaLqeJUvq+iJ/qgD0KvJsl38BOrFyC5q20+bS8+
        jgDaAnPYfhXLHNcvaGtaxivJxXTdpu3Y7P99mOw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7EEC81C78B;
        Thu, 10 Aug 2023 12:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 988DC1C786;
        Thu, 10 Aug 2023 12:04:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] sequencer: rectify empty hint in call of
 require_clean_work_tree()
References: <xmqqa5v2ehba.fsf@gitster.g>
        <20230809171531.2564829-1-oswald.buddenhagen@gmx.de>
        <xmqq7cq3lwli.fsf@gitster.g> <ZNTI6xpXIRaoFlxx@ugly>
Date:   Thu, 10 Aug 2023 09:04:47 -0700
Message-ID: <xmqqedkahoio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1A1EE46-3797-11EE-8029-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> it becomes actually relevant only after my "rebase: improve resumption
> from incorrect initial todo list" patch, which still needs reworking.

We are already past -rc1 by the time you see this response, so this
fix is not of immediate urgency.  It has been with us for more than
several cycles, it does not seem to be readily triggerable, and its
effect is merely a single extra empty error message when other things
are mentioned there.

Even if it may not be triggerable, consistent use of the API is
something that is worth aiming for.  

If I were working on a separate change (i.e. your "resume from bad
initial todo") that will make this triggerable, I would explain this
patch as a pure clean-up patch to use the API function consistently,
and tell readers that there is currently no way to trigger it
(assuming that it is the case---I only poked a bit yesterday and
would not claim that I did a thorough investigation), and that it
will start mattering with a later step in the series.  And make it
an early part of the series that will contain the "resume from bad
initial todo" patch.

Thanks.

