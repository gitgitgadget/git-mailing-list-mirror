Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_BLACK,URIBL_DBL_SPAM
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42B21F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 06:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbeKRQr6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 11:47:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57315 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRQr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 11:47:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2DC611BD89;
        Sun, 18 Nov 2018 01:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uij/7D9dIhTk
        GjNt3nOpBPpN9GI=; b=gN+0VuhEmCi4l1/d7h4hdPe/IJOsU3OCpy6xujUxsLTk
        1+kTIREXy0sQnja0wo+hFl5wMMJtO55wfEJlBRvgH+JCRfdtWALQm3vs+fc4WDpd
        dHuGNgDA3CPk31TDJTSsMqnyrUpEeiZVSVJheqWhBhJG6d4dsIlYkpEKcD/Qw3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L4KJDo
        yGTUyZwiTWt/vsxBA2qdLA9Cl0SMrb+BSQgHa+NaTV8rQx5XsBbuGwrEqdXZUymD
        pyxKItuhNksssAr0zkSuQADn8CL4cUqf9dGxBxgupmddpdYTOvjyn4j2qE4ISuhy
        y6zKfB7nKDUwzl1FGXUDO65kD2A/WwlSCe7/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD5711BD88;
        Sun, 18 Nov 2018 01:28:35 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2627A11BD87;
        Sun, 18 Nov 2018 01:28:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
References: <20181114221218.3112-1-slawica92@hotmail.com>
        <20181114222524.2624-1-slawica92@hotmail.com>
        <xmqqsh01k1mr.fsf@gitster-ct.c.googlers.com>
        <2f3612b8-5f26-adae-9a7f-05d16040938e@gmail.com>
        <xmqqsh01ib51.fsf@gitster-ct.c.googlers.com>
        <a75dcea8-797d-9c9b-3453-2de2a4d983dd@gmail.com>
Date:   Sun, 18 Nov 2018 15:28:34 +0900
In-Reply-To: <a75dcea8-797d-9c9b-3453-2de2a4d983dd@gmail.com> (Slavica
        Djukic's message of "Sat, 17 Nov 2018 19:47:53 +0100")
Message-ID: <xmqq36ryhpbh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2D403A0A-EAFB-11E8-BB95-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavica Djukic <slavicadj.ip2018@gmail.com> writes:

>> Yes, but for that you'd need to be checking the resulting commit
>> object that represents the stash entry.  It should be created under
>> the substitute identity.
> Would it be correct to check it like this:
>
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 git reset &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 >1 &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 git add 1 &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 echo "$GIT_AUTHOR_NAME <$GIT_AUTH=
OR_EMAIL>" >expect &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 git stash &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 git show -s --format=3D"%an <%ae>=
" refs/stash >actual &&
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 test_cmp expect actual

So, you create a stash, and grab %an and %ae out of the resulting
commit object and store them in actual, and then compare.  Makes
sense.
