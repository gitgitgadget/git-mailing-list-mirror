Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF36C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B75B22202
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 01:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yBC8EMaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgJ1Bi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 21:38:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56887 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833011AbgJ0XcH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 19:32:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59C8781FD1;
        Tue, 27 Oct 2020 19:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wDnc0O3vWBUtKaTiimyiMfv+0W0=; b=yBC8EM
        aERNQzQ5VjkOwQZuthyIxeAisuD0Kq+1ffV+uDfTz12vU4DOKfnZ0qumkMmA9VLo
        uJdVVzFlpx5uNnWiS6TzIsZWQiR9AgJL1SW2Ae7oW3gdonAoFPiVDaAYvmSA5/eO
        PYJl9HJPyv0Bm7dhrLZ7nxjnvpxEY0HNXpJyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IsRNgXUPrb6v2ghtt40oGx/G7Ph5Vtlx
        ERyh6gkhIpADO2Igvyf9KWXFCnJ4nk88hhUVHBIGhNDeDXlWRrTHv0HESwIVnaFj
        BWf+8VPPxE9Jn3WgJRP07vlU6QM0Sm9ISAQ0FvGTbiktJPd8c4MG6PWe0jEEpdCS
        R/75ElL6MXk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B50A81FD0;
        Tue, 27 Oct 2020 19:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 544D381FCF;
        Tue, 27 Oct 2020 19:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
        <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
        <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
        <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
        <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
Date:   Tue, 27 Oct 2020 16:32:03 -0700
In-Reply-To: <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 27 Oct 2020 16:19:05 -0600")
Message-ID: <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EDC8D7C-18AC-11EB-A4CC-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Have you fed your patches to those folks who have dozens of issues
>> and the patches made their life better?
>
> Yes.

That's good.

>> (they will get
>> their zsh/git completion from their distros---I am assuming that the
>> distros get theirs from us in contrib/completion/).
>
> I don't know of anyone that relies on the zsh completion shared by
> their distribution.

Hmph.  If the real users don't get the completion scripts from their
distribution, is there still a point in having them in my tree?  You
are certainly not suggesting me to remove contrib/completion/ at
least for zsh part, but then it is unclear what you want.

Are you saying that by adding the latest and greatest, these real
users who so far couldn't rely on distros now can start to do so,
and we'll make their life easier by updating the 29-patch series
(which I presume is the v2 of this 14-patch series)?

In any case, some Zsh users, even though they are not active
developers for the completion script, may have something good to
say, now the 29-patch series has been posted to the list and queued.
I didn't look at the zsh part, but I didn't find anything glaringly
wrong in the changes to the bash completion.

Thanks.
