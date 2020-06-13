Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D21C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2F12074D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZVSyeCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFMTeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:34:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50770 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMTep (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 15:34:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85A3968AF9;
        Sat, 13 Jun 2020 15:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GQpy50Iha4uNd2S8SfS5mhiHspk=; b=hZVSye
        CGSRoMgU9ejh4mjonAN1BuK/b++5lQP1rBKeeuvlg76t0A7VCb4KtMiNIgOcwWBu
        +f5/EiJOnqxRnAf1ASuZkf8GIP1kidYeylzi7x4q9MXxViu74Vha2/YphJG8JOK1
        /fIBoqDStFFrE38hIA9FCZzZOpQ7XIIGl6b8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ff6N/+2lmjXhxXuvSiPIw2RqiPYOvynF
        c0aCKbFukDQbl8WhyssjD7N+h4NA0yJf2GAlQdxdn3yxdkRug/mBiq9DqEt0ZXg2
        4mZmet+bM8LaosGZY4rSeiOGHoFG91tW1x73Yuo7/ELXHJeFXbw5WLidjYfU5nLf
        C7F1LZ2piFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CB5868AF8;
        Sat, 13 Jun 2020 15:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C44FF68AF7;
        Sat, 13 Jun 2020 15:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "Curtin\, Eric" <Eric.Curtin@dell.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Geary\, Niall" <Niall.Geary@dell.com>,
        "rowlands\, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
        <xmqqa716zs7w.fsf@gitster.c.googlers.com>
Date:   Sat, 13 Jun 2020 12:34:42 -0700
In-Reply-To: <xmqqa716zs7w.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 13 Jun 2020 12:22:11 -0700")
Message-ID: <xmqq366yzrn1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE0FAED0-ADAC-11EA-B5FA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  Luckily, most end users would get their Git from
> packagers and they are good at doing the bundling (i.e. the
> "git-core" package may "suggest" the "git-imerge" package).
>
> So...

So my answer to your idea/opinion is that we shouldn't waste
engineering effort to "have something like imerge integrated into
git itself", but we should help distro packages to do the bundling
of "git" itself and all the good things around it.  One way of doing
it may be by keeping an official curated list of "third-party things
we find good" somewhere (it can be in-tree in my release tarballs,
but it does not have to be---some page on git-scm.com could just be
fine; as long as the quality of the list is maintained to our
standards, where the packagers and end users see it does not really
matter).

And such a list would also help those who prefer to build and
install things by hand.
