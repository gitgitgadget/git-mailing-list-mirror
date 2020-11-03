Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A5C00A89
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B6A22243
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 01:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="heTyO5Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKCBtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:49:52 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63155 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCBtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 20:49:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2A29E4736;
        Mon,  2 Nov 2020 20:49:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=xcW+q+wrLmO1k5oxnnabwR2yTdk=; b=heTyO5JfHmG7TMtxasIm
        Ket/jqUWR/a4eI02Uz7xA46aLCpJRx54eBadCUkg74FGe9VeCPRffqYc5+LGiMHU
        CcTaSYYbTDHt1EdrL5iH0Yz0zkNSt4D4/TKCQvF2K6sWvKbxAziP7RHNS+aaMqP0
        qbuCWCImtNOt79s4P2L/XA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=QSazBAZL0PcEtruVyoAmDrVCGM1XIiD6tYsA+Ud9t3kmCj
        XQS+kFAV24NsSUZzCaHSKzrbcr3cfFM7x9aDq4lIm71e1aut1mG6PRLuA0P4VoIp
        OmWGovi2k0On/AtIA5oUtV67/qNFMCf6KFHKkowREFsXE++Db8FdxEl55wCE0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B661E4732;
        Mon,  2 Nov 2020 20:49:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D43ACE4731;
        Mon,  2 Nov 2020 20:49:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Stefan Haller <lists@haller-berlin.de>, Git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
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
        <xmqq361x7xj5.fsf@gitster.c.googlers.com>
        <CAMP44s2bgZbKde-UFL7+sR-7QgEv5Oiho2LTi3RG7S4BD0iuaw@mail.gmail.com>
Date:   Mon, 02 Nov 2020 17:49:46 -0800
Message-ID: <xmqq7dr3nr9h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DAC89E9C-1D76-11EB-9547-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> We are making life worse for the zsh users by shipping our own
>> version, aren't we?  If we didn't ship our own completion script for
>> them, the user did not have to remove the one "which is considerably
>> less complete/capable".
>
> No. You are assuming the opinion of one user in Stack Overflow is a fact.
>
> There's a reason people prefer to use Git's official completion, and
> there's a reason I wrote the wrapper.

Do you mean by "the wrapper" the 'gitfast' one you offer in the
oh-my-zsh collection?  If so, yes, I agree that 'gitfast' as "maybe
less complete but usably faster auto-completer" is a good thing for
end-users to have as an alternative to the Zsh default.

But that was not the point I was raising.  I was saying that it was
not making life better for them that we are posing as a valid third
choice in that competition.

Your "wrapper" can still be updated regularly to the latest to grab
the bash completion part from "git.git".  To the Zsh audience,
however, it would be more straight-forward if the choices were
"there is Zsh default completion, but if you want to use a
different/better version, grab 'gitfast' from the oh-my-zsh
collection" than "you can use Zsh default, or you can install
'gitfast' in the way Zsh users are accustomed to from the oh-my-zsh
collection, or you can manually install from git.git".  After all,
the latter two would give them the same thing.

It may be a good idea to leave a message in contrib/completion that
nudges people toward 'gitfast' as an alternative for thowe who want
to use something other than the default Zsh autocompletion.

Doing so would remove one level of unnecessary middleman (that is
us) from the picture and make it simpler for end-users by reducing
the number of choices from three to two.

> They prioritize completeness over usability.
> ...
> No. Those people don't care if their completion is unusable.
> ...
> This is not possible, as the Zsh maintainers don't care about usability.

I think our code of conduct applies to derogatory statements made on
even those who do not regularly appear in this community.  If you
want to attack them, please don't do it here.  Thanks.
