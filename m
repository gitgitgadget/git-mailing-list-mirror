Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F91C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1035613A0
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 05:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbhDFFej (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 01:34:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64611 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbhDFFei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 01:34:38 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27ED5B41E3;
        Tue,  6 Apr 2021 01:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7WdMYZ/BpKr5STZsFBN4vVNEdlw=; b=TjcQ65
        mbM0TwT/QxN1gI36MhESt42rOzUbHSoLswmru7Owjg9x2cSMIoecwjngu7T9Dyln
        Pm2JJVE8C6/nyydHYhEtcBZ4b91LPxrvBrOGTbxeQ3Rl2xm2PUVzWe/aMUk0EVSW
        HNt2KuFJq7Tr2HQbKWx3G4iM7t7jJ9C2+4Nzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J0XinFAc5zjCuphptNjMAf3TlehM4Gat
        J9kjs+6r7vqVd+iJE/9Kaq0HIg0eMuvwMf6OhRoMhWuzAVjjVW17UMYlYoFhlkuP
        9j3dMQXbaLHDe/D8Y4SeOg4E9R5SCDeqWBMP0sOBI1Q07jEQhtfQI3vtPwaosHws
        E/yJ4WsOOM4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FDE7B41E1;
        Tue,  6 Apr 2021 01:34:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4A5CB41E0;
        Tue,  6 Apr 2021 01:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config
 option
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
        <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com>
        <xmqqim544dl4.fsf@gitster.g>
        <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
        <xmqq8s5x7ht1.fsf@gitster.g>
        <CAP8UFD17=BxHRkb7nmC8XsiGet+J=Adzqv4P6d9jzgnKXT9LJw@mail.gmail.com>
        <CAP8UFD08Lagij6oqpOJkpbzMLRgQ08=mDfiyf1qXyD5VW6Ae7A@mail.gmail.com>
        <CAOLTT8TrJn+V-4WijCfi=q5JpvfBj_oMfWRx9TX-0Cs5uShmOg@mail.gmail.com>
Date:   Mon, 05 Apr 2021 22:34:29 -0700
In-Reply-To: <CAOLTT8TrJn+V-4WijCfi=q5JpvfBj_oMfWRx9TX-0Cs5uShmOg@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 6 Apr 2021 13:16:14 +0800")
Message-ID: <xmqqtuok2cyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2C6BA58-9699-11EB-82F9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I find in the status update description:
> "Seems to break new tests for .command variant in zh/commit-trailer"
> I have tryed to merge my local branch 1e9a657(trailer-cmd) and
> 2daae3d(upstream/zh/commit-trailer)

Thanks for noticing---the description is stale.  Remember that after
I pointed out the breakage, you responded that the conversion for
the .command codepath was wrong?  What is queued in my tree has a
version with fix of that bug, so the comment does not apply.



