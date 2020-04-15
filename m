Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FCDC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81B7206A2
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yIzh/aGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506399AbgDOPT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:19:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55665 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505516AbgDOPTW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:19:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03F50493DA;
        Wed, 15 Apr 2020 11:19:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8nHHO1lNn0C+GQnyTfmKvtK2buA=; b=yIzh/a
        GE3zt4o34GRAS/w6AKJp57ALpxu1S1fKyHKwVKU5o8tROA1Ld7oG3kLMdBBJ21EK
        AbM/KBOk0XtScSfaXQXuWnPHkoCIF5J0twBqQ+o6iapODJRYpTOlBMXmhJJGBlJ5
        IggtVYUdOXcyDtB9rAPm0JQaDpDQMunqY5MIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pU6e4X90djVUXZO3eMdpB1PKeYBSszfZ
        3U5DCOhtU24rcLWZpvh9AX86vkZHrZQAloYuazdypYpRAKmy9OfuAmQU95zKT+/K
        rHajztKgAnV3z1FpXSnYa6P6RfiyAox6iHtg9LMaxJR4gho2LeF3ELtcM+rgY+MC
        2sDf7OJG+es=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF962493D9;
        Wed, 15 Apr 2020 11:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AB96493D8;
        Wed, 15 Apr 2020 11:19:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Bannister <adam.bannister@portswigger.net>
Cc:     git@vger.kernel.org
Subject: Re: Media query - Git flaw
References: <CAJQu+bp9SrzaMBuMv1UC8y8rJGn15MAsVogSCm_DNDKRMji1+Q@mail.gmail.com>
Date:   Wed, 15 Apr 2020 08:19:18 -0700
In-Reply-To: <CAJQu+bp9SrzaMBuMv1UC8y8rJGn15MAsVogSCm_DNDKRMji1+Q@mail.gmail.com>
        (Adam Bannister's message of "Wed, 15 Apr 2020 11:46:04 +0100")
Message-ID: <xmqqwo6g7p55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A403604-7F2C-11EA-A68E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Bannister <adam.bannister@portswigger.net> writes:

> How did the disclosure and patching process go?

I guess "Just like any other project" would be enough for you to
understand, given what you write and where ;-)

A security researcher discloses a possible vulnerability to the
git-security mailing list, which is a closed list.  On the list,
there are developers with relatively high familiarity with the
entire codebase, and there are those who are responsible for
managing binary packaging of the software to various distributions.

We prepare the fix.  We review the fix.  We repeat until we agree
that the proposed fix is what we want to deliver.

We arrange the coordinated disclosure and release among distro
people and other stakeholders.

All of the above have to be done behind public.

Then we go public at the same time.  It happened at 1100 US/Pacific
on Apr 14th, 2020.  For this one, as the fix itself was relatively
straight-forward, the time it took between the initial contact and
the release was spent mostly to wait for the slowest partcipant in
the coordinated disclosure process (obviously I won't name names).

> What is your advice to Git users?

Release is announced and users are urged to upgrade, like you wrote
on your article at The Daily Swig.
