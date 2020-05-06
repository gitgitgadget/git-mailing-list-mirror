Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D51FC47259
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0430F20708
	for <git@archiver.kernel.org>; Wed,  6 May 2020 16:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6yRYqCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgEFQbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 12:31:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52476 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgEFQba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 12:31:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA9295F1B3;
        Wed,  6 May 2020 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=s3m4PJ12qvbg
        hD0T0WQWLkG8YOk=; b=j6yRYqCh3i8VRbqZZQG2me/j45mXbDzmfvZNgtNxe/dd
        FUO/HLetICcBYu89fiEjZ6OCSxRFpgP6AL15LfO0AwfCQiBNpktnGYK6sp1+e1kG
        I1rJPOShmyvMjAWEAUpFrVBY4M7gHHRh8hmDO0zk5nsDWTMSGSXI2u++WD2UNew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rXPo/g
        XiYYv+IVZ8GcCR+9IC3DymmODu9BFb1NJcDK0BiPO1vSrNHyVMIk+On8lbLzhFwF
        WKS1OhnRH3NsaAM+8LC9ccjoJHb4JH1OyT41ZPFuaFXWbApHbLRSMgNOR0i4FS3X
        OTkNooMURe1HpRZzlN+0GVxpbmTRIFI1O9gjE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD6715F1B2;
        Wed,  6 May 2020 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43BA75F1B1;
        Wed,  6 May 2020 12:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
References: <20200504162311.GE12842@coredump.intra.peff.net>
        <20200504215824.GC45250@syl.local>
        <20200504233634.GB39798@coredump.intra.peff.net>
        <20200505002055.GC64230@syl.local>
        <20200505164326.GA64077@coredump.intra.peff.net>
        <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
        <20200505182418.GA66702@coredump.intra.peff.net>
        <20200505210451.GA645290@coredump.intra.peff.net>
        <20200506004612.GE927@danh.dev>
        <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
        <20200506142500.GA2429@danh.dev>
Date:   Wed, 06 May 2020 09:31:25 -0700
In-Reply-To: <20200506142500.GA2429@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Wed, 6 May 2020 21:25:00 +0700")
Message-ID: <xmqqa72l81pe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 07EC8706-8FB7-11EA-9D65-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2020-05-05 20:56:58-0700, Junio C Hamano <gitster@pobox.com> wrote:
>> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> wri=
tes:
>> > +--------------
>> > +$ git checkout --orphan ci-config
>> > +$ cp contrib/ci-config-allow-ref allow-ref
>> > +$ $EDITOR allow-ref
>> > +$ git rm -rf .
>>=20
>> This sounds horrible.  You just nuked the entire files in the
>> working tree you use for your everyday Git hacking to edit a
>> single file.
>
> It isn't that horrible as it sounds. It only removes the files that are
> currently added in index, which is the same with tracked files in old
> branch, and we can get it back by switching back to old branch.
>
> I decided to make an orphanage branch because I would like to save
> time and network bandwidth for the "check-ci" jobs.

I didn't say it is wrong to record a tree with a single file
(allow-ref) in a commit that is pointed by the ci-config ref.

I would have expected you to create such a commit in an otherwise
empty repository, and push into your fork of Git at GitHub.  That
way, you won't have to checkout and/or refresh the index all of the
3800+ files.

> I wonder whether the "git rm -rf ." makes that block sounds horrible?
> If that is the case, we can use the experimental git-switch(1)
> instead, it's doing more-or-less the same (or is it the same?) with
> "git checkout --orphan" and "git rm -rf ."

That does not change anything, as abuse of your primary repository
is what offends me.
