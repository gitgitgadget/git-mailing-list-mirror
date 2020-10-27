Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0311C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDC9207C4
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 18:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L3QioiZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443665AbgJ0Svw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:51:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61164 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442640AbgJ0Svv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 14:51:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EE96E69B8;
        Tue, 27 Oct 2020 14:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bAM6rdrmDxf1
        a7xq7ITRzPeFFdw=; b=L3QioiZmrA8uWH6BjJMCn5DtQgSU28diQfBsij+ePJrL
        Pe5ZRgtb1VLMHBnO+ZJtCfb9vUn2pUW6Sv5z/NPUN4cgDyJNYN8VhlQXS5p6XtDG
        RCqLjYhYh2gcWHLOdAL7hdUMpY3a7nGh2wfbBiaExxE3ka6wy82HnvhVm601xvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=l7U2sn
        BeuxFAwtKGFEUiCxONo02dHSOBJth0eNnm+zZ+k7lTkls/NYjhjJfet3ylyA6T43
        LhI67ua5X7ni1HJJz9lm+KVVWMX+NkLfubDbYOJNpaa5e19YRkZ5CdKbJK/OE2th
        o++HgXevy1q8h5SJuqfrwtFglsLUOKf0Yw72w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37E85E69B6;
        Tue, 27 Oct 2020 14:51:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54999E69B5;
        Tue, 27 Oct 2020 14:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] clone: document partial clone section
References: <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
        <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
        <C9D6F2D9-7BA3-469D-B903-DB0B389C9166@gmail.com>
Date:   Tue, 27 Oct 2020 11:51:44 -0700
In-Reply-To: <C9D6F2D9-7BA3-469D-B903-DB0B389C9166@gmail.com> (Philippe
        Blain's message of "Tue, 27 Oct 2020 09:13:40 -0400")
Message-ID: <xmqqft5zcxj3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 768D5044-1885-11EB-A62C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi Dyrone,
>
>> Le 26 oct. 2020 =C3=A0 23:12, Teng Long via GitGitGadget <gitgitgadget=
@gmail.com> a =C3=A9crit :
>>=20
>> From: Dyrone Teng <dyroneteng@gmail.com>
>>=20
>> Partial clones are created using 'git clone', but there is no related
>> help information in the git-clone documentation during a period. Add
>> a relevant section to help users understand what partial clones are
>> and how they differ from normal clones.
>>=20
>> The section briefly introduces the applicable scenarios and some
>> precautions of partial clone. If users want to know more about its
>> technical design and other details, users can view the link of
>> git-partial-clone(7) according to the guidelines in the section.
>>=20
>> Signed-off-by: Teng Long <dyroneteng@gmail.com>

Compare this line and "From:" we see above?
They need to match.

>> ---
>>    clone: document partial clone section
>>=20
>>    Partial clones are created using 'git clone', but there is no relat=
ed
>>    help information in the git-clone documentation during a period. Ad=
d a
>>    relevant section to help users understand what partial clones are a=
nd
>>    how they differ from normal clones.
>>=20
>>    The section briefly introduces the applicable scenarios and some
>>    precautions of partial clone. If users want to know more about its
>>    technical design and other details, users can view the link of
>>    git-partial-clone(7) according to the guidelines in the section.
>
> Since your series has just the one patch now, you don't need to
> add a description in your GitGitGadget (GGG) PR. That's why it
> appears two times here: the text above the '---' is the commit
> message, and the text below is the PR description.

Nice.  We learn new things every day---I've always wondered where
the duplicated description we sometimes see comes from.

> In the context of a one-patch series, you can use this space to
> add additional info that do not fit into the commit message, for
> example questions about your patch, etc.  It is also a good idea
> (and viewed positively by reviewers) to use it to add a summary of
> what changed in your series since the last version you sent. I
> encourage you to read MyFirstContribution [1] for a good tutorial
> on the contribution process. Also, GGG understands that if you end
> your PR description with a line starting with "CC:" and an email
> address, further iterations of your series will be sent to those
> email addresses. So it would have been good to add Stolee in
> there, like this:
>
> CC: Derrick Stolee <stolee@gmail.com>

> (Junio prefers not to be directly CC'ed).

... unless it is the "final version with concensus among reviewers",
that is.

>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-=
745%2Fdyrone%2Fmaster-v3
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745=
/dyrone/master-v3
>> Pull-Request: https://github.com/git/git/pull/745
>>=20
>> Range-diff vs v2:
>>=20
>> 1:  6f340d9aad < -:  ---------- partial-clone: set default filter with=
 --partial
>> 2:  9baf4c8ba3 < -:  ---------- clone: document --partial and --filter=
 options
>> 3:  c1a44a3509 ! 1:  681c5dcb79 clone: document partial clone section
>>     @@ Commit message
>>          clone: document partial clone section
>>=20
>>          Partial clones are created using 'git clone', but there is no=
 related
>>     -    help information in the git-clone documentation. Add a releva=
nt section
>>     -    to help users understand what partial clones are and how they=
 differ
>>     -    from normal clones.
>>     +    help information in the git-clone documentation during a peri=
od. Add
>>     +    a relevant section to help users understand what partial clon=
es are
>>     +    and how they differ from normal clones.
>
> It appears that you sent the same version of the patch as in v1, instea=
d
> of the one you sent in v2 ? You had removed "during a period"  for v2,=20
> but here it pops up again. You should check that you've sent the more=20
> up to date version of your patch, before sending v4.
>
> I will not comment on the patch below, since it's not the more up-to-da=
te.
> I will send comments shortly on the v2 version by replying to [2] (the =
v2 version=20
> of your patch).
>
> Cheers,
>
> Philippe.
>
> [1] https://git-scm.com/docs/MyFirstContribution
> [2] https://lore.kernel.org/git/c1a44a35095e7d681c312ecaa07c46e49f2fae6=
7.1586791560.git.gitgitgadget@gmail.com/
