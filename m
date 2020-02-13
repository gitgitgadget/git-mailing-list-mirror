Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB73C352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34AD218AC
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 20:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H1o7dKoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBMUeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:34:16 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53752 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgBMUeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 15:34:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F0C63BD027;
        Thu, 13 Feb 2020 15:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GiSoLDDNy3c46ZzN2+RFd1Dzfrw=; b=H1o7dK
        oeoKty3wYG5/rMjDBRdKP7IVLOFXw3X0cpZJ98aDI+4s++AS3egWwxE8hg8XvjLY
        Z54TXdVi/yd3shYRFD50aC7sl//IM8dIyQy+HGXpyB+7xZtBtUM/hS58/ajndRCP
        jP4JkKGwwkrgeIeYXn0Tp6IzaTfzVoT4saCuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PMJbjXYS75mJ7rGM3CKXWYYdf5iE8JXr
        2MnK+wHgH2uzyyKJpJftP9wSky+veSjBg87/rYysaPBEJE//wCyG7Tr71kAS6gFs
        +L6jhnqZy4JIM/bVqujlvSjhRKeN7NTi9TeQu2bW601zZMFc1ky6aqabGbLQ1FZD
        GehMi9NconE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E92ACBD026;
        Thu, 13 Feb 2020 15:34:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 20EF9BD025;
        Thu, 13 Feb 2020 15:34:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com>
        <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Feb 2020 12:34:09 -0800
In-Reply-To: <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Feb 2020 12:14:31 -0800")
Message-ID: <xmqqo8u2qla6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3190A5B8-4EA0-11EA-BC61-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Hariom Verma <hariom18599@gmail.com>
>>
>> `receive.denyCurrentBranch` currently has a bug where it allows pushing
>> into the current branch of a non-bare repository as long as it does not
>> have any commits.
>
> Can patch 3/3 be split into two, so that the fix would protect an
> already populated branch that is checked out anywhere (not in the
> primary worktree--which is the bug you are fixing) from getting
> updated but still allow an unborn branch to be updated, and then
> have patch 4/3 that forbids an update to even an unborn branch
> "checked out" in any working tree?  This update to the test can then
> become part of patch 4/3.

Oh, another thing.  The patch 4/3 that starts forbidding a push into
a checked out unborn branch should also have a test that makes sure
that such an attempt fails.  IOW, making the test repository used in
the test you changed to a bare one, to allow existing test to still
test what it wants to test, like you did in this patch is OK, but we
would want to have a new test that prepares a repository with the
primary and the secondary worktrees, check out an unborn branch in
each of the worktrees, and make sure receive.denyCurrentBranch would
prevent "git push" to update these branches.

Thanks.
