Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD06A1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbfIMU3H (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:29:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbfIMU3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:29:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 80FBF85248;
        Fri, 13 Sep 2019 16:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uOOnTR5AwysvGOIopCVPVcRvbbY=; b=aUEY1N
        ZoFQd3YPodvhvGOteFgweXTJFaZGZpRrZa/fpHJAUuSnvc+BTn6//fxQ+I2x4QnP
        Hg0d6ZPiZBr1cGBquRLty09bxpMsdMaYnPHufmud+jvHv5bN0DUYWAzH0v72bjuw
        of7rKT91uR99tfKeURUSsGvCXD9f3vA0gjoT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qAZFV+1LMSFkFrugQR2mJvTYuldfpjtL
        JdPaofZcAFbf5SV4l44R9jfZhvDQjrar4KS3UqHa1kxXCz5rtYJFuOEh6i5ePDaM
        EHQ1C13dwTKHJX0A44UwKSl43vogscu5a1NzEDrIxvKohQM07hdWY2L0Hat1OgSV
        pogzbsXY7wk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 793E385247;
        Fri, 13 Sep 2019 16:29:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3575B85244;
        Fri, 13 Sep 2019 16:29:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [PATCH v3 01/12] t7300: add testcases showing failure to clean specified pathspecs
References: <20190905154735.29784-1-newren@gmail.com>
        <20190912221240.18057-1-newren@gmail.com>
        <20190912221240.18057-2-newren@gmail.com>
        <xmqqblvodo1v.fsf@gitster-ct.c.googlers.com>
        <CABPp-BG1Hvr6joYh-qT6B-8iEetGtj2pE5Mo-gVjdDRre=yrag@mail.gmail.com>
Date:   Fri, 13 Sep 2019 13:29:00 -0700
In-Reply-To: <CABPp-BG1Hvr6joYh-qT6B-8iEetGtj2pE5Mo-gVjdDRre=yrag@mail.gmail.com>
        (Elijah Newren's message of "Fri, 13 Sep 2019 12:10:54 -0700")
Message-ID: <xmqqk1acc54j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 203BCC74-D665-11E9-BCFE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Also, you talked about tracked paths in the proposed log message; do
>> they not participate in reproducing the issue(s)?
>
> If there is only one directory which has no tracked files, then the
> user can clean up the files -- but confusingly, they have to issue the
> same git-clean command multiple times.  If multiple directories have
> no untracked files, git-clean will never clean them out.  I probably
> didn't do a very good job explaining that although I started with the
> case with one tracked, that I view the case without any as the more
> general case -- and that solving it solves both problems.  I could
> probably make that clearer in the commit message.  (Or maybe just add
> more testcases even if slightly duplicative, I guess.)

My comment/puzzlement indeed was the lack of any tracked file in
your tests, even though the log message did talk about one's
presence making a difference in the outcome.

Thanks.
