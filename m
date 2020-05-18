Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A838C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E12D620758
	for <git@archiver.kernel.org>; Mon, 18 May 2020 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cv6MMnWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgERQ5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 12:57:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64351 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERQ5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 12:57:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60638BE8BD;
        Mon, 18 May 2020 12:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MQGBOq5oDnTe
        jCFyYx2+Pm+Zz/U=; b=cv6MMnWaNumgi+KC7lHVhw16nTbbwnK/ypI4mRcccMuE
        Ew189JvY2YILj1r733TmviUEQwIPkFsSte6TYuev5WYvAWIOklgk6yS0/vg4HVTB
        yLmmu/IZwiCkWLQtLjPwIhf9ri9fc3Tf5aE5qWMpdsEsAuHDZIkwW6J0DjyF6a0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aInEhS
        XCA4VhH4/NpW2h5aQiADOm2qMumLRNZk0ml3qhZWcxDIZ8tB+ClzZH+4p2J5l2y/
        lXzwA2E/83iPtMX5VzmU9ShMc1pdP7+PhBGYtrwguxxu+mVK8koswsWchPk4t1Lx
        mo1Nd+402NWi+bamoGwiTNp0/53Y4+2isCz5E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58106BE8BC;
        Mon, 18 May 2020 12:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A177CBE8BA;
        Mon, 18 May 2020 12:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
References: <20200515155706.GA1165062@spk-laptop>
        <20200515233130.GC6362@camp.crustytoothpaste.net>
        <xmqq1rnk923o.fsf@gitster.c.googlers.com>
        <20200516173828.GB34961@spk-laptop>
        <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
        <20200516194033.GA2252@spk-laptop> <20200517021452.GA2114@danh.dev>
        <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
        <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
Date:   Mon, 18 May 2020 09:57:09 -0700
In-Reply-To: <20200518135656.GB1980@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Mon, 18 May 2020 20:56:56 +0700")
Message-ID: <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9E00081A-9928-11EA-803B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> I've written some test and concluded that we'll need this fix-up
> to make sure git-format-patch(1) doesn't generate broken patch:
>
> ----------------8<----------------
>  builtin/log.c            |  1 +
>  t/t4045-diff-relative.sh | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index d104d5c688..5949a4883e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1744,6 +1744,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
>  	rev.diff =3D 1;
>  	rev.max_parents =3D 1;
>  	rev.diffopt.flags.recursive =3D 1;
> +	rev.diffopt.flags.relative_name =3D 0;
>  	rev.subject_prefix =3D fmt_patch_subject_prefix;
>  	memset(&s_r_opt, 0, sizeof(s_r_opt));
>  	s_r_opt.def =3D "HEAD";

Hmph, what do you exactly mean by "broken patch"?

I actually do not mind people who set "diff.relative" to do

    $ git config diff.relative true
    $ cd t && git format-patch -1 --stdout

to get an incomplete patch that covers only the t/ subdirectory, as
long as they can ask Git to optionally get the full view with

    $ cd t && git format-patch -1 --stdout --no-relative

Note: this is not limited to format-patch but all the commands in
the diff family like "log --stat", "show", etc.

Of course, diff.relative configuration would have no use for me
personally and I suspect it would be useless for many people, but
those who work inside a deeply nested project (java perhaps?) it
would be handy and it makes sense to match the default behaviour
between "diff", "show" and "format-patch" when the configuration is
active, as long as they have a way to contermand from the command
line.
