Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE62C433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F8364EEC
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 03:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhBFDSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:18:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53618 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhBFCuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 21:50:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5BD4B2C2E;
        Fri,  5 Feb 2021 17:28:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rqF6b129Prf9
        YdTKFHCtgFoZ2/g=; b=FhoE7tY8eUSm3jS7GbSVOMDphPzvg/d7rZLHC1KyD+u3
        5MqB/wTozIo/Ll1+5Z5Y4nr+lLCuaeljE38mHAK78YDSYC9fnKd3E4RZRpGkMWVp
        240etZ/x7IzOc8Sefyg8re1fV7nbE+tEZxEeLxgANgr8cT9RiLHTLHPypDuL8/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bC6HKu
        +dLst6+WwUB1SRmn0Zr7i72mz12TwwSgVwThDcKy+PFfqXYLiyfAj7PLWN1dNR4X
        k6Zr65PtlCdn8AtTLzk3Q3Ca2GcbKzIzbYX3HpxSWX+poG3VpaHfhyorSXzbY1ym
        Zk0+LskKw2pScV5ePJ0GZQ37D/eZX8TiVXmys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95A50B2C2D;
        Fri,  5 Feb 2021 17:28:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA981B2C2C;
        Fri,  5 Feb 2021 17:28:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <cover.1611686656.git.jonathantanmy@google.com>
        <87h7n3p363.fsf@evledraar.gmail.com>
Date:   Fri, 05 Feb 2021 14:28:27 -0800
In-Reply-To: <87h7n3p363.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 27 Jan 2021 02:41:08 +0100")
Message-ID: <xmqqh7mqyws4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77D746A0-6801-11EB-96ED-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Jan 26 2021, Jonathan Tan wrote:
>
> [For some reason the patches didn't reach my mailbox, but I see them in
> the list archive, so I'm replying to the cover-letter]
>
>>  Documentation/config.txt                |  2 +
>>  Documentation/config/init.txt           |  2 +-
>
> Good, now we have init.defaultBranch docs, but they say:
>    =20
>      init.defaultBranch::
>             Allows overriding the default branch name e.g. when initial=
izing
>     -       a new repository or when cloning an empty repository.
>     +       a new repository.
>
> So this still only applies to file:// and other "protocol" clones, but
> not "git clone /some/path"?

I agree with you that the new "unborn HEAD will also follow what the
upstream has" should be done for --local transport.  It is a bug
waiting to be complained about by users.

>     init.defaultBranch::
>         Allows overriding the default branch name e.g. when initializin=
g a
>         new repository or when cloning an empty repository.
>    =20
>         When cloning a repository over protocol v2 (i.e. ssh://, https:=
//,
>         file://, but not a /some/path), and if that repository has
>         init.defaultBranch configured, the server will advertise its
>         preferred default branch name, and we'll take its configuration=
 over
>         ours.

I actually do not think that is what is going on.  What the other
side advertises is *NOT* their preferred default branch name and it
does not matter if they have init.defaultBranch configured or not.

What the new protocol extension gives us is that we can learn what
the other side is actually using (not their preferred default) as
their primary branch.  We've always done so since very early days of
"git clone" (even back when we failed to clone an empty repository),
by trying to guess which branch their HEAD points at.

The only thing that is new with this topic is that it now gives us
a reliable way to learn what their HEAD points at, even when it is
pointing at an unborn branch.

In general we do not let other side _dictate_ what our configuration
should look like, as that can have security implications, and this
is not sending any configuration at all.

Their HEAD may be pointing at a specific branch (which may or may
not be unborn) because that is what they configured their
init.defaultBranch to, or their version of Git created the branch
and they haven't changed it since repository creation, or the user
using that repository just started working with that branch with
"git checkout [--orphan]" (the repository being cloned does not have
to be a bare repository).  It does not matter how their HEAD ended
up pointing at a specific branch---we just try to mimic their
current status---it is because it would make it easier to give our
changes back to them if everybody involved used the same name for
the primary integration branch, and the repositories the people
clone from are most often have their primary integration branch
pointed at by their HEAD.

And I do not consider it transfering any configuration.

So while I agree that the logic to choose the branch that gets
checked out in a new repository created by "git clone" needs to be
documented well, it has very little to do with "init.defaultBranch".

