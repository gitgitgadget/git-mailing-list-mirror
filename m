Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD84C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B84D207BC
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 19:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t00vR/sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFMTWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:22:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64439 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMTWO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 15:22:14 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D55E6882B;
        Sat, 13 Jun 2020 15:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ix8KHGbh3b2dsLP2Hjo0gkdXHE=; b=t00vR/
        sZPSQqI+FCSbhyldvHWv0cgWRogjhZE6HCAxFvNJb7P8+SQU/nV3VeHTken/S0MH
        11k11St+bhbdYMu4qPvStvLWE+wLcl/5zZPaK+XrmrSRM9xR916sG3/D+Ti4UkZa
        6qfoS0//GvU3uaPBlgfpTADGGiKqVGV8pkeac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wPbaCjtdgH0fXLQGNyxJp6i4TjnX9r8V
        MuzQWAkmoXYVjm2sKZMRr3ZgZHIw6vXQTb0qSQEwq5AwpWvPQc8CSaO6PmIolcvY
        +JIyEs1MQP0Su5ihpR2dBQLMPz2qlsxDiIg3usqPMnsLReGQE9Psl6C76ePBAH5q
        /LlbLUuMpLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4275D6882A;
        Sat, 13 Jun 2020 15:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C64B068829;
        Sat, 13 Jun 2020 15:22:11 -0400 (EDT)
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
Date:   Sat, 13 Jun 2020 12:22:11 -0700
In-Reply-To: <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
        (Christian Couder's message of "Sat, 13 Jun 2020 19:10:13 +0200")
Message-ID: <xmqqa716zs7w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E6FE38E-ADAB-11EA-B0A8-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> My opinion is that it would be nice to have something like git-imerge
> integrated into Git.

I am not sure what you mean by "integrated into", but if you are
talking about somehow reinventing it, I do not think it is a good
idea at all.  "imerge" works quite well already.

Or do you mean it would gain more exposure for being bundled
together?  I am not sure if that is a good idea, either.  

Surely, it would be convenient for end users if a single download
(or "apt-get install") gives everything useful, but that does not
have to be done at the ultimate upstream level between me and
Michael, and doing so at that level would mean the release schedule
needs to be coordinated (one may need to wait unnecessarily for the
other's pre-release freeze period, for example), among other loss of
flexibility.  Luckily, most end users would get their Git from
packagers and they are good at doing the bundling (i.e. the
"git-core" package may "suggest" the "git-imerge" package).

So...


