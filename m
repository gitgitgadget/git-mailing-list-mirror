Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC444C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CA461263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFHHB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:01:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59614 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHHB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:01:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53144DE6DC;
        Tue,  8 Jun 2021 02:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9uqG4yVF9xm7
        lJbleJrz1eCkOIfV++fFkfASYiioyFs=; b=Shq7JdAtMV1w3kkpNygRg/w6SI5N
        DdgmbbTugpU6shrJWnqT0KSHqurk9dnkI0LGVBYqQXn2PtBsO65Yy3J3M+YZZQYm
        m4HfttDmvASYdyRcAhFrHqEt6KF22UrrNGWQMPLSaVNcYvHHVmPEib8um39Bfw7V
        o6iPK5CR65wX6kM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 370F9DE6DB;
        Tue,  8 Jun 2021 02:59:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 955BEDE6DA;
        Tue,  8 Jun 2021 02:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
        <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
        <xmqq7dj6w7a6.fsf@gitster.g>
        <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
        <CAOLTT8QE7pafPmhnz-6=5zuyjg9n1FNbu_k6bA80jE1e5vYCmQ@mail.gmail.com>
        <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com>
Date:   Tue, 08 Jun 2021 15:59:33 +0900
In-Reply-To: <CAOLTT8TSue=Cx8xos20vnGSi3oOd8+=jTfTw2h82gXmmd4KyLg@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 8 Jun 2021 14:16:11 +0800")
Message-ID: <xmqqk0n4q1t6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14FCEB4E-C827-11EB-84F1-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:18=E5=86=99=E9=81=93=EF=BC=9A
>>
>> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=9A
>> >
>> > Hope we can reach an agreement:
>> > delete `--rest` and add `--reject-atoms`. ;-)
>> >
>>
>> I forget one thing: %(raw:textconv) and %(raw:filters) can use
>> the value of "--rest" as their <path>. But now if we want delete --res=
t,
>> they can not be used for "for-each-ref" family, Git will die with
>> "missing path for 'xxx'".
>>
>
> If we actually delete "--rest", we will have no way to test %(raw:textc=
onv)
> and %(raw:filters)... So now I think we can keep --rest (or use
> another name --path)
> and let "git for-each-ref" family reject %(rest) by default.

I didn't read beyond the %(rest) thing, but do we even need
%(raw:textconv) to begin with?  It is totally useless in the context
of for-each-ref because textconv by its nature is tied to attributes
that by definition needs a blob that is sitting at a path, but the
objects for-each-ref and friends visit are mostly commits and tags,
and even for refs that point at a blob, there isn't any "path"
information to pull attribute for.

Is that what you want to add to give "cat-file --batch"?  Even in
the context of "cat-file --batch", you can throw an object name for
a blob to the command, but there is no path for the blob (a blob can
appear at different places in different trees---think "rename), so I
am not sure what benefit you are trying to derive from it.

Thanks.


