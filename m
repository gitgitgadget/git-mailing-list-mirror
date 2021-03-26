Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0704C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851D261A36
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 06:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZGa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 02:30:59 -0400
Received: from w4.tutanota.de ([81.3.6.165]:42048 "EHLO w4.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhCZGah (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 02:30:37 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 48B3A10603BA;
        Fri, 26 Mar 2021 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1616740235;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=RnKpefgU87yufweG4HEaywupyHQ59HKEfZqxShfxjts=;
        b=Ek6U4qxd3jFmYqXUK4Bkyu4b8DoJ5J/NSTCwtYGlKcR8hhwIuCJnxqhRfm5hY0D8
        HSIfdaXs0modB8FRb8mvzxLoPHrtduEYSJgYO+Rl4ljIqzSw3xl7ju/Ke3GewvxwikX
        NDe+pxneA7/ZpBlZeIo39opZ7emPSDvnyaU2iRxOvSJLwZ2O2OoJ7696UrhiTaQU0bN
        aBt1WDy5upNu5R+4rrC+TlUxwea6mIaY64Ry27kvanJi6l3WPWS0Qb/l4+RTiheMtl8
        d8qX8NFz+XvpbJGM637kUYgw5XXKgud28/asqukrAfCr0DhbdiD/+1ryvzJUqmgxkoO
        U7g62pxYVA==
Date:   Fri, 26 Mar 2021 07:30:35 +0100 (CET)
From:   jost.schulte@tutanota.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Message-ID: <MWhDYQt--3-2@tutanota.com>
In-Reply-To: <87a6qsourb.fsf@evledraar.gmail.com>
References: <MW_aJot--3-2@tutanota.com> <xmqqk0pwxqvt.fsf@gitster.g> <87a6qsourb.fsf@evledraar.gmail.com>
Subject: Re: Configure default merge message
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the detailed explanation. Where can I see the commits that yo=
u mention?

25 Mar 2021, 03:02 by avarab@gmail.com:

>
> On Wed, Mar 24 2021, Junio C Hamano wrote:
>
>> jost.schulte@tutanota.com writes:
>>
>>> Hello all,
>>>
>>> I'm using git mainly with BitBucket repositories. When I pull from a re=
mote, the default commit message will be "Merge branch 'source-branch-name'=
 of https://bitbucket.org/ <https://bitbucket.org/jibbletech/jibble-2.0-cli=
ent-web>repository-name into destination-branch-name".
>>>
>>> I'd like to configure git to omit the "of https://bitbucket.org/reposit=
ory-name" part. How can I do that?
>>>
>>> Regards
>>> Jost
>>>
>>
>> =C3=86var, is this something we recently made it impossible with 4e16833=
3
>> (shortlog: remove unused(?) "repo-abbrev" feature, 2021-01-12), or
>> is there more to it than resurrecting that "feature" to do what Jost
>> seems to want?
>>
>
> Perhaps I'm using it incorrectly, but I don't see how that repo-abbrev
> feature ever resulted in the insertion of this munged content into the
> actual commit object.
>
> The shortlog examples of "..." in 4e168333 are of shortlog's output
> being modified on the fly. Not of them being inserted into commits.
>
> You can run "git merge" with "--log" which says it inserts "shortlog"
> output. So I thought that maybe lines that were not the first "Merge
> ... into" line in the message could have gotten munged in this way
> before my change.
>
> But I don't think that happened either, and reverting 4e168333 and doing
> a merge --log locally with e.g. "# repo-abbrev: branch" does not munge
> the string "branch" in either the subject or the body, it's retained,
> e.g.:
> =20
>  commit 02c864e58da (HEAD)
>  Merge: 353c73510dc c6d63de00ff
>  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>  Date:   Thu Mar 25 03:00:21 2021 +0100
> =20
>  Merge branch 'to-merge' into HEAD
> =20
>  * to-merge:
>  Merge this branch blah blah
> =20
>
> That's because "merge" never used the munging.
>
> If you look at the code in 7595e2ee6ef (git-shortlog: make common
> repository prefix configurable with .mailmap, 2006-11-25) when this
> repo-abbrev feature was first added the "merge" would use
> builtin-fmt-merge-msg.c to format the "shortlog", which implemented its
> own function to do so, and didn't use the mailmap.
>
> As to Jost's question. I think the way to do this is to use
> fmt-merge-msg, see 2102440c17f (fmt-merge-msg -m to override merge
> title, 2010-08-17) for an example.
>
> That seems like it would also be simpler than Jeff King's suggestion in
> the side-thread in <YFvAJU3Euxhjb+uw@coredump.intra.peff.net>.
>
