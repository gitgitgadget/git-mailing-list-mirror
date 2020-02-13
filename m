Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810EC3B189
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D24246AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G5yK9kux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgBMUOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:14:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63488 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBMUOi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 15:14:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 990E3AE61E;
        Thu, 13 Feb 2020 15:14:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OUnRVvqK/Sza9GWdP/lBeED3C+c=; b=G5yK9k
        uxQggpX3gl+w5j/jBZ3zPGx51aCUdo61O0RfdkIVmhE7hxdx8ZXfKqMUC2QBldY2
        dJstUBHlSpG+gG+ispZtoIYDrsxifO1WxhXhz7l8cgX1HfIkDf7qa2bKNaQNjsUC
        eYfnojELTvi1XydXcV6z/HSXSzTGzfa9XopQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dnLc4dubjBmjkKKJ1HgiozpUsSpXMV96
        483VShBf70xl3gYIi0mQ53dsxs6OGd1P9HY3sUdjV8AalU1+QZ/rCgAn3vmIPkrk
        rmhpLh7woF7fdGU10/PfsgESfeHThbhXL5ZUq5yHixlsVYTCXAevxO6lSXIvamar
        bLV/Gs0PoMg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90C2BAE61D;
        Thu, 13 Feb 2020 15:14:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BBFA8AE61C;
        Thu, 13 Feb 2020 15:14:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 12:14:31 -0800
In-Reply-To: <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Thu, 13 Feb 2020 18:59:09
        +0000")
Message-ID: <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7334100C-4E9D-11EA-9834-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Hariom Verma <hariom18599@gmail.com>
>
> `receive.denyCurrentBranch` currently has a bug where it allows pushing
> into the current branch of a non-bare repository as long as it does not
> have any commits.

Can patch 3/3 be split into two, so that the fix would protect an
already populated branch that is checked out anywhere (not in the
primary worktree--which is the bug you are fixing) from getting
updated but still allow an unborn branch to be updated, and then
have patch 4/3 that forbids an update to even an unborn branch
"checked out" in any working tree?  This update to the test can then
become part of patch 4/3.

Thanks.
