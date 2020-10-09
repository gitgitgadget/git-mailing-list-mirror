Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CF9C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 23:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4536B223AB
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 23:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9+ysWhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbgJIXFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 19:05:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbgJIXFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 19:05:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39FB0101831;
        Fri,  9 Oct 2020 19:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lbd9e/JnHRoqpuXrhrvgm/+cAk=; b=Y9+ysW
        hzdJUChOBIP20L/py5ncGn056TVbx9bGUS9ODz7Pt7hz0dIAIaZyCC/bpRO1Y8aS
        9b1mqv9MNdlzIjDV2+gDDXHh1FBCkm29PM+NebsJ6LaAZva/ITLfRRxKGyL1QlU5
        aYelSgrvaE6e86cGm+tueqepeI3QN1twnXXLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kpNBiY/oFQ23AuXfvhPCgULSFRZQJwLW
        pNZU/XXfgPjWsgIBkFLo+VHzvngpym++QZQTgW1BeA6lqCEtLtKsOxfJaUvp3FiO
        KWMZNCRBeI93PNhRH1TL4MU88DU0dXiYVq29ty9A9qdMWNDM2oRmhbaGsYRA9YVb
        tDQLqRSOr10=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32233101830;
        Fri,  9 Oct 2020 19:05:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7647410182F;
        Fri,  9 Oct 2020 19:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
        <20201009015505.GB1314@generichostname>
        <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
        <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
        <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
        <20201009195701.GA967869@coredump.intra.peff.net>
        <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
        <20201009230033.GA31120@generichostname>
Date:   Fri, 09 Oct 2020 16:05:47 -0700
In-Reply-To: <20201009230033.GA31120@generichostname> (Denton Liu's message of
        "Fri, 9 Oct 2020 16:00:33 -0700")
Message-ID: <xmqqblhbrodw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8BC48A0-0A83-11EB-B950-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> And I have a strong preference, after thinking about it, to have
>> "extern" in front in the declarations.  It gives another clue for
>> patterns I feed to "git grep" to latch onto, and help my eyes to
>> scan and tell decls and defns apart in the output.  The benefit
>> alone is worth the extra 7 columns in front spent, which you call
>> "clutter".
>
> To be honest, I do not have any preference between having the explicit
> extern or not. I do have a strong preference, however, for having a
> codebase that's consistently written. When I was doing the refactor, I
> wouldn't have minded introducing extern everywhere although that wasn't
> suggested as an alternative.
>
> I agree that these are all benefits of declaring functions explicitly as
> extern. However, I don't think they're worth the cost of either another
> huge rewrite or an inconsistent codebase.

Yes, there is a cost associated with having made a mistake in the
past.  Biting the bullet now, perhaps as the first tree-wide change
immediately after the upcoming release, while the tree is quiescent,
would help us in the longer term, than having to live without extern
on declarations.
