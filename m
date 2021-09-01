Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122CC432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFC76108E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbhIAFgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:36:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55229 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbhIAFgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:36:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBFD214A680;
        Wed,  1 Sep 2021 01:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkkDQ8JbDHVbOioxE4jTDct2h6FW7nll83fYYu
        r+HYE=; b=QrBenZIH6NbLGNWZbptNX7j7wRZvmh9MenGz0c88DS9KgqGheHikTk
        byPTavHBeht/Dtt6WZhfriqUKyoM4jdMgfr6nkOCSygMw2gPkWZNWWHL1L2bKJMW
        DYNStt0GJd/ozz15YC9NaT+VV/cRU7onhFLtcdeaPCjaMBTus5RzQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1D0214A67F;
        Wed,  1 Sep 2021 01:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5F29214A67E;
        Wed,  1 Sep 2021 01:35:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Maksym Sobolyev <sobomax@gmail.com>
Cc:     Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: [PATCH v2] Make ident dynamic, not just a hardcoded value of
 "$Id".
References: <pull.1074.git.git.1629736918861.gitgitgadget@gmail.com>
        <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
        <xmqq1r6fd23h.fsf@gitster.g>
        <CABFYoQC_FzbU_E4hU0kCz-WFJNOLspwL2Gjc01sMXDZosxJWjw@mail.gmail.com>
Date:   Tue, 31 Aug 2021 22:35:46 -0700
In-Reply-To: <CABFYoQC_FzbU_E4hU0kCz-WFJNOLspwL2Gjc01sMXDZosxJWjw@mail.gmail.com>
        (Maksym Sobolyev's message of "Tue, 31 Aug 2021 19:32:22 -0700")
Message-ID: <xmqqfsuosvrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 763C3CC8-0AE6-11EC-B7AB-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maksym Sobolyev <sobomax@gmail.com> writes:

> Junio, I've got rid of the  GIT_MAX_IDENT_LEN in rev3 posted here. You were
> right it was not really necessary.

Sounds good.

> Let me see if there are any more issues with the functional part of the
> change, if not I'll see about changing the structure name from ident_action
> to something more relevant.

I do not think the "structure" should be relevant, not just its name
but its presence.  As I said already, the data (i.e. the name of the
custom token that replaces $Id$) should not come from the attribute
subsystem---it belongs to the config subsystem, I would think.

Thanks.

