Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF7C433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 16:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E883F20724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 16:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hSIAv+Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbgF3QD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:03:26 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57970 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389792AbgF3QDV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 12:03:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BA3DE463F;
        Tue, 30 Jun 2020 12:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hgH7QcrstxzR9QvDWg6+bphSzXQ=; b=hSIAv+
        Uu6XcihROGASDgxmlHhf/abO7f+u/NsDJNuDbQRrkeg7wG+LWcmk1xn7lmlwe2hA
        UjbHPeRRwEQ7FXGLF1HqvIzyUA23kwn9k00bUlWu+CPGvAPJm5KANbTRY4kTYgkt
        FU2ldm5TFBrjjZeRLbdjbLoF40JjmiwkN0rMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ewtPb8o+rqH3aThL8lz5Ca8qsJyz8Kkj
        2T8oZ7HeCteEtn1gbdgFfw3nSyWcd6NqzFXjs0RCci+6rzb11xLirfxYyDwEEHId
        7KolCauZxpfMMtVGhaETkXzZQd+Mb+Ev1BH256kKu70Mre26UoFbZyqchbccPpeo
        PoMMc+UzFlA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33207E463E;
        Tue, 30 Jun 2020 12:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 780EEE463D;
        Tue, 30 Jun 2020 12:03:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <pull.668.v3.git.1593087539.gitgitgadget@gmail.com>
        <xmqq366j5d57.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2006291606060.56@tvgsbejvaqbjf.bet>
Date:   Tue, 30 Jun 2020 09:03:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006291606060.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 29 Jun 2020 16:07:14 +0200 (CEST)")
Message-ID: <xmqqpn9gee2l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3573C40A-BAEB-11EA-9784-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> You could have just told me that the fixup queued on 'seen' looks
>> good to you and squash it in the first step instead to save one
>> roundtrip, but replacing with a new set of three patches is not so
>> bad, either ;-)
>
> To be honest, the GitGitGadget-based workflow makes it quicker for me to
> just submit a new iteration.

I do not mind seeing a new iteration that gives easier time for
others to comment on the version that is closer to the final than
the previous round.  The offer was only for contributors who find
it easier to just say "yeah, I am happy with that change" than
submitting a new round.

> In fact, I did not even see your fixup until I read your mail.

This I actually would mind a bit more.  The reason why I publish
'seen' is to make it easier for authors of individual topics how
their work would play with other topics in flight, and it diminishes
the value of it if contributors do not pay attention to what is
queued there.  I expect contributors to fetch and look at what is
queued in origin/seen.

There may be evil merges that reveal subtle interactions between
topics, some of which may involve the topic an author may care
about.  There may be fixups for problems that were not found during
review but only found during the integration process.  I try to
communicate these back on the list when possible, but the thing is,
a day does not have sufficient number of minutes for me to always do
so.

Thanks.
