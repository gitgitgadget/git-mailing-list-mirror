Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EAEC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB6420767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L94JZ9b3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFVS26 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:28:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59627 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbgFVS25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 14:28:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 034405C833;
        Mon, 22 Jun 2020 14:28:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7kn/uXql7QkGI1EnFcoUgf64duk=; b=L94JZ9
        b3XwDLkHK3rHqfZTPcrVnm8LeLDVO+9DI5xbkclBDUuhdDZHPTWNxxsztw0nBi+e
        h86qSDRlJHfh+wTpFcV8ZUMWs0z9tJQg3oW2oIjyhvxfu8i/nxM5o7B4TVLv38Cw
        VtLkHASPDFlLQJmtJ0vLH0/f3GOQ6xk7I6QJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eEGEbA9H5bWUcSk1aXCfeCcQByCXTp+8
        K3aqdNotbbemlqh9YaHjoJEnx68MvGACA44B0XF2cS7JigS/hgtTS5o6BRf3T1al
        YWSYhvT75vU1FAyf7LVRNq/I9+SAOq3OFD3CvO3DcY9B6a9b7o7TCCCAatuAxetK
        Z3M+kepKMKI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDB825C832;
        Mon, 22 Jun 2020 14:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BA445C830;
        Mon, 22 Jun 2020 14:28:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Lin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Lin <johnlinp@gmail.com>
Subject: Re: [PATCH] bash-completion: add git-prune into bash completion
References: <pull.667.git.1592784835441.gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 11:28:53 -0700
In-Reply-To: <pull.667.git.1592784835441.gitgitgadget@gmail.com> (John Lin via
        GitGitGadget's message of "Mon, 22 Jun 2020 00:13:55 +0000")
Message-ID: <xmqq366ndkey.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A698868-B4B6-11EA-9D6E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Lin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Lin <johnlinp@gmail.com>
>
> Sometimes git would suggest the user to run `git prune` when there are
> too many unreachable loose objects. It's more user-friendly if we add
> git-prune into bash completion.

Yes, but it does not suggest all the time, and there is a reason.
Most of the time "gc" is more appropriate, but there are narrow
cases where "prune" is more appropriate and that is when the users
will see suggestion to run "prune".

Isn't it too much to type p-r-u-n-e while seeing that message,
typing as you read it?

I do not think it hurts to complete "git prune", in the sense that
we would want to avoid completing potentially destructive operation
to those who do not understand the implications, because the command
is pretty much benign.  But I am not sure it forces users to type
too many keystrokes too frequently that it requires a tab
completion.  I dunno.

Will queue for now.

Thanks.
