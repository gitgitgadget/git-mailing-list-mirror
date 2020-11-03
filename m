Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96745C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4237620E65
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GjRipBAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKCRMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:12:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60471 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgKCRML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:12:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EC4E7A2F6;
        Tue,  3 Nov 2020 12:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3LrenIQsNw1DZXKjsmXYWrGJ514=; b=GjRipB
        ASrYRm8P5sMm7GaikkEboFBpBB35Xyg0QFrsqNQ767iuszxSwxf5ISyqSKU5613B
        qrH8RjwNbn9smDwUbczPvJdxCodgI5uOGHKbhcFAYTpMahBdiidAVPhVemnet5lX
        seBncNfsjw+n3FMIKQzsUF/EbISLx4tDI8xMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GTYTatDSKNOySr87ceGnK2Kv73ZSq+SB
        I8dLA6qminU6rIRIPJ9HKUhxf8OE0sVXxMb2wMKBmlDhi1guiptfjKFNF0D+ut/7
        lxGnPzBEvizHi4IUR+Y1n2vz0SgwTFZKAbhzLpIlY/IGHwLCoDu5m4T9SD6571pG
        iLpqAHrswi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 32EC97A2F5;
        Tue,  3 Nov 2020 12:12:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E7C67A2F4;
        Tue,  3 Nov 2020 12:12:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
        <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
        <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
        <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
        <xmqqeelh7y23.fsf@gitster.c.googlers.com>
        <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
        <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
        <e2b59b69-7fd2-f52c-eb06-6b97e3de557a@haller-berlin.de>
Date:   Tue, 03 Nov 2020 09:12:07 -0800
In-Reply-To: <e2b59b69-7fd2-f52c-eb06-6b97e3de557a@haller-berlin.de> (Stefan
        Haller's message of "Tue, 3 Nov 2020 10:59:14 +0100")
Message-ID: <xmqqlffis6u0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B46BDB70-1DF7-11EB-8847-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> writes:

> Using stuff from oh-my-zsh is not an option for me. I'm not using
> oh-my-zsh, and I don't want to begin using it just for this one package.
>
> I could use Felipe's version from
> <https://github.com/felipec/git-completion> (and in fact, that's what
> I'm doing right now, for testing. Works great. :-)  However, I'd have to
> remember to manually update it every so often.
>
> So yes, I prefer to use the one from git's distribution, because it is
> automatically kept up to date whenever I update git (as long as I
> symlink to it rather than copy it.)

Thanks for another data point.  

You'd need to add to another "as long as", which is "as long as it
keeps up with felipec/git-completion".  If we fall bahind, you'd be
better off getting updates directly from there, not from us.  

And I suspect that not many Zsh users want to care about the
distinction between the two.  If it were as easy to grab the latest
version of Felipe's as an update of Git from your distro, wouldn't
most people rather choose to do so?

If we are not doing much reviews on Zsh completion on this list, due
to lack of interest and expertise, then we will either fall behind,
or blindly copy, Felipe's repository and republish as a small part
of our project, without adding much value ourselves.

Which is not a very happy place for us to be in.  I dunno.
