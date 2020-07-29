Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19443C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F8920658
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RTU2Qchq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2UFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:05:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64174 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgG2UFB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:05:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95C7FF475F;
        Wed, 29 Jul 2020 16:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hBR80jJoYg5rdxHDnuTS3sWGGUk=; b=RTU2Qc
        hqPrkhu0KvfdpjMjqe1nOWLR6vwywqMGxLbDgBG8oijCQwXAIpp8pZdgtW99MELf
        WQEirJkOE4wk4oJuSXh+wKzkrMbsK6Nt9E+JDbhQ43uYCI9Ouw6aAWa2GryVWMje
        Yyq+VO80xnJPIVoDnK7fkYbfT75nqUMaAr12w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQMHOeZe/osZzcaQJx4hF5Qhg66yMBVP
        GDTeo2/hMf3zYm7uqFhuhy/FdTI/jegEKs4qIwivC1ulnV22YgtWqfUHL94s7LCr
        6Drj87G3/C1LGohUcbulG12KT7eaRogeZR+VQKv97fI47aMqM0tyrQdgmHm9VHKu
        vXl6m7/teNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8BD74F475E;
        Wed, 29 Jul 2020 16:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C47B6F475C;
        Wed, 29 Jul 2020 16:04:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
Date:   Wed, 29 Jul 2020 13:04:55 -0700
In-Reply-To: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 29 Jul 2020 12:44:54 -0700")
Message-ID: <xmqqime69jfc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C64A6752-D1D6-11EA-914B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It turns out that commit 489947cee5 ("fmt-merge-msg: stop treating
> `master` specially") has the exact opposite effect of what the
> intention must have been.
>
> It may remove "master" from git, but what it does is then make it much
> more visible everywhere else.
>
> In fact, it doesn't even remove "master" from git itself. It just adds
> more of it into the test suite etc.
>
> So that commit is doubly stupid. If the intent was to try to avoid
> "master" as a word, it failed on every single possible level.

The intent was to stop treating 'master' as some kind of 'special'
word, since it is no longer special after init.defaultBranchName was
invented.

It could have been coded to start treating the word that is set to
init.defaultBranchName as a new 'special' word, but the chosen
design is to say there is no special branch name anywhere.  One
reason behind that design is because the concept of "one thing being
special among all others" does not necessarily hold in all projects
anyway.

