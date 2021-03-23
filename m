Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906EDC433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CC06148E
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhCWUvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:51:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61491 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbhCWUus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:50:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73C4ABBAA7;
        Tue, 23 Mar 2021 16:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FA0oFvECMjoK
        ol8CYf0yb4+0aMo=; b=JkuZUqkOyXAyVYdKEnSwgcjykFZ87cKHmkE1UHOlCRqf
        ukF0zMT0B5pdIh0TvaMKmcpL7ykK2Hq3Uhu/GkeBzpweO0orw8Q4nb5NQg+Vivhv
        GRLnOGFxivpZjQHlAWQCKKD6b7mE9mdAbfQtfl8hvqzpFEzbscqQLBUKZvdVr7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=siT1W6
        HFe/M2S9unBQUprhl3qxvvDVy62BubkHy0j02axxPAonbs/U/Dh/LELjzzNZR7zP
        A4qzOpbQ/eUr6COhtxyGWmQKQwp7qOaWgaDSokx1ibyFlAI0pXkhIMFqdo0jx9D6
        +D4yIKmPG4bEbJZudH0K7R6G+Qhm5AUX/Rwak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A345BBAA6;
        Tue, 23 Mar 2021 16:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC500BBAA5;
        Tue, 23 Mar 2021 16:50:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Madhu <enometh@meer.net>, git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
References: <xmqq7dlz94by.fsf@gitster.g>
        <20210322.143437.212295420302618690.enometh@meer.net>
        <xmqqr1k76p8d.fsf@gitster.g>
        <20210323.092748.1559327071188512317.enometh@meer.net>
        <xmqqr1k64bmk.fsf@gitster.g>
        <20210323165335.urvvccwnhahxmokt@tb-raspi4>
        <xmqqo8f93gsd.fsf@gitster.g>
        <20210323203124.oxzqad2wmedelstu@tb-raspi4>
Date:   Tue, 23 Mar 2021 13:50:46 -0700
In-Reply-To: <20210323203124.oxzqad2wmedelstu@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 23 Mar 2021 21:31:24
 +0100")
Message-ID: <xmqqr1k51tnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 716AD5E8-8C19-11EB-9F98-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> I do not think we want to go there.  filemode is not the only thing
>> that would be shared.  What do you want to do with core.eol=3Dnative,
>> for example?  Paths touched while switching branches get the 'native'
>> line endings on the system that the user happened to be on when the
>> "switch" command was run, and working tree files end up with mixture?
>
> I don't intend to solve all possible confusions caused by sharing all
> config variables - just this very one.

I intend to help users by drawing a clear red line and telling them
that crossing that line leads them to danger.

Sharing a working tree across systems that require different core.*
settings (filemode included) is on the other side of that line, and
that is the reason why I said I do not think we want to go there.
By saying "this is only about core.filemode but you can share a
working tree between incompatible systems", I am afraid that we end
up training users to go where they should not get nearby.

