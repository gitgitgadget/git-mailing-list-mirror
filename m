Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFE7C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhKWRio (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:38:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51478 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhKWRim (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:38:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70623177789;
        Tue, 23 Nov 2021 12:35:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xthussQkIXNI8hojOj6G4zaakEFDcK9eCCn0tb
        HrvNA=; b=ykq/tlcwat8zGNJZXORqHZbnzCvNjOnGWmKdroz8K8AZFLQ9NxmBBs
        F2rGmUjHWfz4QzbQ/U/L49XqpXAK84d3KwRcM6YgWC+iLhQOBkDzcGck+P1MBep3
        6VRnhU3bR2Y1yTsvzDH2nhXOsULuQcd+8bWfklYZFBtOX4JieRju0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 68E39177788;
        Tue, 23 Nov 2021 12:35:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CC82F177786;
        Tue, 23 Nov 2021 12:35:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
        <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
Date:   Tue, 23 Nov 2021 09:35:30 -0800
In-Reply-To: <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
        (Carlo Arenas's message of "Mon, 22 Nov 2021 15:39:12 -0800")
Message-ID: <xmqqtug293ml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1DC64B2-4C83-11EC-839C-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> yes, my plan was to minimize the impact of this bugfix by doing this
> as narrow as possible, but you are correct that if we consider that
> ...
> I should have mentioned though that a better fix was forthcoming, just
> not with so little time before 2.34.1 gets released.
> ...
>> In any case, I am quite tempted to just revert the offending topic
>> for now, but later accept a resurrection patch with this isatty
>> check rolled in (either at this caller, or inside save_term) when
>> the dust settles.
>
> I indeed suggested[1] a revert but I wouldn't have proposed this
> alternative if it wouldn't be done safely enough,

I think the minimum impact fix is to revert the whole thing (people
survived without it for long time), so that is what 2.34.1 will
hopefully have.  As I said elsewhere, I am open to a rebooted effort
for the future cycles, but the conclusion for the topic in 2.34 series
is that we pretend we never heard about it ;-)

Thanks.
