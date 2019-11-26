Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A666FC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5662068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V4Bpdt17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfKZBNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:13:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52640 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfKZBNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:13:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A97C9478F;
        Mon, 25 Nov 2019 20:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vtVbj1q4lEyv45wfO2WG4wtNm0s=; b=V4Bpdt
        17JbCyUkKvKqbBC3SPABHgkkHkGu0A7KkUG1R3Q2GNrGKh4SNeLnBlR5CfVBnNlC
        GZ1pyW/SYa9NQ9u447TmkA1Np1FF5rzNNXkEGCYUk7AVum06pwlw5mFn9dDvxp9A
        Q8Of04GpzXWUPIlWJeqEtNuAKXxVeBXvdS+2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q67KkUwmKMFE8ikGsfaI14jZLVDDnv9H
        IckjONvwIwldZ+FJfgjNhE98vbO3DG8t86GFpYM19H6hYxdrXirsS8Lu6cEAKc0G
        VU6k3rvY7GfI+4J/YElYH+h9z9CeEKF9E3REwbdv+9eS001HMQN/TY62eyykPWz/
        WQIlgVcmAUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 12FD89478E;
        Mon, 25 Nov 2019 20:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 370B194785;
        Mon, 25 Nov 2019 20:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
        <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Nov 2019 10:13:32 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 25 Nov 2019 15:45:53 +0100
        (CET)")
Message-ID: <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7801AE2-0FE9-11EA-B46D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Hmph, I wonder why this was sent my way.  How does GGG determine
>> > whom to send patches to?  I, like other reviewers, prefer not to see
>> > earlier rounds of patches sent directly to me unless they are about
>> > areas that I am mostly responsible for (other patches I'll see them
>> > and review them on the copies sent to the mailing list anyway).
>
> Oops, I forgot to address this. The reason why this is sent your way is
> that you are the Git maintainer, and as such, GitGitGadget sends _all_ Git
> patches your way (except the Git GUI ones).
>
> The reason for this is that this is the suggested way, as per
> https://git-scm.com/docs/SubmittingPatches#patch-flow:
>
>> 5. The list forms consensus that the last round of your patch is good. Send
>>    it to the maintainer and cc the list.

Yeah, but as far as I can tell, this is the _first_ round the list
sees this topic, which by definition would not have any consensus
;-)
