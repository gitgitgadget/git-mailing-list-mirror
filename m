Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607DEC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45540615E0
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbhI2VWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:22:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51328 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhI2VWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 17:22:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91EF3EA705;
        Wed, 29 Sep 2021 17:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ny56gaDgcpUV
        DmqXZc52ZjOkAkgZ9ybHYqWQC8lvTYk=; b=tid82TuvipStBKscc5N/e1JrV16l
        uZFK9AA09naW19yNu29BZBj/Bl4pIJVBjz1JdWisnEf6w7gI8NVg6fqXfyuXh8Ww
        AT+MXFf8tWDUcWP3mjtEXDpW4GA0IRQ3iyedH6pibE3IeZqO209w0U6wXgfMVv13
        /KD43PjMjfzwspo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87B76EA703;
        Wed, 29 Sep 2021 17:20:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3840EA702;
        Wed, 29 Sep 2021 17:20:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
References: <87zgs34ccx.fsf@evledraar.gmail.com>
        <20210924024606.20542-4-tbperrotta@gmail.com>
        <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
        <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
        <xmqqzgs2vvim.fsf@gitster.g>
        <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
        <xmqqo88hspvv.fsf@gitster.g>
        <d9114e0a-cb6e-1791-51f8-6e57f313e8d5@gmail.com>
        <xmqq5yups3g8.fsf@gitster.g> <YU6+BWC+xvGJP3b0@carlos-mbp.lan>
Date:   Wed, 29 Sep 2021 14:20:31 -0700
In-Reply-To: <YU6+BWC+xvGJP3b0@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Fri, 24 Sep 2021 23:13:25 -0700")
Message-ID: <xmqqpmsrcc4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 146CC026-216B-11EC-ACAB-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> Everything after "git format-patch", i.e. -2, master, master..HEAD,
>> are usable, and there isn't much point in singling out revision
>> ranges.  FWIW, I think you can even give "-- <pathspec>" at the end,
>> which are not options or revision ranges.
>
> <format-patch options> then it is; would the following be worth adding
> in top so the recursive reference can be followed?

I am not sure what "the recursive reference" is an issue here, but
I agree that we may want to improve upon <revision range> in the
part you are touching, which currently we say:

    There are two ways to specify which commits to operate on.

    1. A single commit, <since>, specifies that the commits leading
       to the tip of the current branch that are not in the history
       that leads to the <since> to be output.

    2. Generic <revision range> expression (see "SPECIFYING
       REVISIONS" section in linkgit:gitrevisions[7]) means the
       commits in the specified range.

    The first rule takes precedence in the case of a single <commit>.  To
    apply the second rule, i.e., format everything since the beginning of
    history up until <commit>, use the `--root` option: `git format-patch
    --root <commit>`.  If you want to format only <commit> itself, you
    can do this with `git format-patch -1 <commit>`.

What we refer to in the prose, e.g. "--root" and " -1", do not
appear in the SYNOPSIS section.

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> index fe2f69d36e..806ff93259 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -30,7 +30,7 @@ SYNOPSIS
>  		   [--range-diff=3D<previous> [--creation-factor=3D<percent>]]
>  		   [--filename-max-length=3D<n>]
>  		   [--progress]
> -		   [<common diff options>]
> +		   [<common diff options>] [<rev-list options>]
>  		   [ <since> | <revision range> ]

I think the "<rev-list options>" you are adding here is to enhance
what <revision range> in the original wants to convey.  In addition
to things like @{u}..HEAD~2 (i.e. "the branch is mostly good, but
the tip 2 commits are not yet ready so do not send them out"), you
can do "-2" (i.e. "the topmost 2 commits"), which is not exactly
what "SPECIFYING REVISIONS" part of gitrevisions(7) describes.

So, yes, I like the spirit of the change, but no, I do not think it
goes there; rather, it would replace or extend <revision range>, I
would think.

In addition, "Generic <revision range> expression (see "SPECIFYING
REVISIONS" section...) may need to be updated.  First, what we'd
want to refer to is not ways to specify revisions, but ways to
specify a range.  IOW, it should be referring to "SPECIFYING RANGES"
section instead.

If we replace <revision range> with your <rev-list options> in the
SYNOPSIS, that will fall out as a natural consequence.  Perhaps, the
second description and an earlier part of the explanation can be
rewritten like so:

    2. <rev-list options> that specifies a range of commits (see
       linkgit:git-rev-list[1]) to be shown.

    If you give a single <commit> and nothing else, it is taken as
    the <since> of the first form.  If you want to format everything=20
    since the beginning of history up until <commit>, use ...

Thanks.
