Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D9EC4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E472395C
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 16:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="btiTeb+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIXQ6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:58:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57714 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgIXQ6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 12:58:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C29491ED4;
        Thu, 24 Sep 2020 12:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T3uZYVLgmdR8Hms0OSHSPUqQ5vM=; b=btiTeb
        +/l6ZDzYhFLt8rk6L4fCpq/G48wx7BJZA7xcnTJDqtIlJEpl+pz+BNIredFctHyH
        3K+8ORb73nuAfj/l9NdKQ9+09qgWGvdjgqNfhC9UtYbXkCPdDCVEAUuvLmI89fRf
        uivAQbLwTkPIT4X+73Axu61QB6PplsCnWhoI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIfClCocfhgyHoli+v7du2N2Ttb3hgDi
        Jekcdk2a6tWl4uEoNhNKV0L9YJVhaXl6USTCuuiVEPBuumEyBh4eXf50vaw51Tgd
        Ix3Y2vfWY9//1VJCepEvdE9iCNXTmKNcVHhoEDE/8tbOvunjDIrW0/stHQSdSHJM
        kaRg2nGnnxo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 536EC91ED3;
        Thu, 24 Sep 2020 12:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1FF191ED2;
        Thu, 24 Sep 2020 12:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] commit: add an option the reword HEAD
References: <pull.736.git.1600695050.gitgitgadget@gmail.com>
        <7f851e7c20aafdae5d5ae46ee1083b32ecc82c84.1600695050.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2009231206290.5061@tvgsbejvaqbjf.bet>
        <41dcb8cb-8e43-04ce-2ddd-d69c765ee327@gmail.com>
        <nycvar.QRO.7.76.6.2009232241140.5061@tvgsbejvaqbjf.bet>
        <95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com>
Date:   Thu, 24 Sep 2020 09:58:28 -0700
In-Reply-To: <95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com> (Phillip Wood's
        message of "Thu, 24 Sep 2020 10:58:54 +0100")
Message-ID: <xmqqft77glhn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4D7B80-FE87-11EA-A813-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> I don't think this patch series stops us implementing something for rebase but
>>> it would mean we couldn't use the name reword! unless we allow `git commit
>>> --reword` to take an optional commit which I'm not that keen on.
>>>
>>> What do you think to an alternative name?
>> I am really worried that the proliferation of confusingly similar
>> options
>> will increase Git's reputation for being awfully hard to use.
> ...
> The reason I'm not keen on having --amend or --reword take an optional
> commit is that I think it is confusing as it means sometimes that
> option creates a new commit and sometimes it modifies the last commit 
> furthermore passing --reword=HEAD would not reword HEAD but creates a
> reword! commit.

Adding just another subjective view to the two already presented,
but I think --reword, as presented by Phillip, sits better next to
the existing --amend.

I wonder if we can extend the existing "--fixup <commit>" (and
perhaps "--squash <commit>") to make them work better with the
workflow Dscho envisions?  Explicit presence of the "-e" option
might be a way to tell the command to behave differently from the
current "--fixup" and to leave a mark that is different from
'fixup!" in the resulting commit to affect the later "rebase" step
as well, for example.
