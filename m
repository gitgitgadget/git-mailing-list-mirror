Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE89C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBAEC206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 19:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gCyip3jB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFHTjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:39:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHTjL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 15:39:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E827E63B93;
        Mon,  8 Jun 2020 15:39:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TNQ6NUrkrT6+4yNOdR8k/OHQucE=; b=gCyip3
        jBnGP+8KdMSwFnG6ePk12Gs/Yl8W3TYnIo2ozHx/x0iXT9p5T5cvYZhM5lRbldUb
        wgILW4qO284iYLTuCxx5AptAxda/t/K0hkxJaITN+MepzOC7Ig7XsRkEliDVLklP
        bRDvWQigR+eQlVNN6ixkpbDXHX3azxNimJS3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xFEoZWjYzhCa7XBt1ydw+nZxeiAiIoZT
        m7+JQWDC4YCS00mAW0PJluh6fBett25XqDKIcYgYy19rm6EekQt/jUDdj6jRr5Aa
        oaWY001SFwQIQ+ziGLs3qPsd6vsSeDeou1bAOc+xoDA5Xqx8hYLi7w9tL95p4ZwK
        orOTWtNuC3k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA0A863B92;
        Mon,  8 Jun 2020 15:39:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4995063B8F;
        Mon,  8 Jun 2020 15:39:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v16 11/14] Hookup unittests for the reftable library.
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <3e7868ee409146fc3e13e824f4dbfa6bdbeee3d9.1591380200.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 12:39:07 -0700
In-Reply-To: <3e7868ee409146fc3e13e824f4dbfa6bdbeee3d9.1591380200.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Fri, 05 Jun 2020
        18:03:15 +0000")
Message-ID: <xmqq4krll544.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B83F0166-A9BF-11EA-8A4A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The unittests are under reftable/*_test.c, so all of the reftable code stays in
> one directory. They are called from t/helpers/test-reftable.c in t0031-reftable.sh
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---

Hmph,

make: *** No rule to make target 't/helper/test-reftable.c', needed by 't/helper/test-reftable.o'.  Stop.
make: *** Waiting for unfinished jobs....

>  Makefile             | 17 ++++++++++++++++-
>  t/helper/test-tool.c |  1 +
>  t/helper/test-tool.h |  1 +
>  t/t0031-reftable.sh  |  5 +++++
>  4 files changed, 23 insertions(+), 1 deletion(-)

Forgot to add a source file?
