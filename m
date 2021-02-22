Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5891C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B460264E41
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBWAAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:00:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59636 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhBVX75 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 18:59:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 382BBBDB5B;
        Mon, 22 Feb 2021 18:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ANE0Ywz8TlGl0Q/lUT7+9COdZqY=; b=Zl9Sdq
        3or82i3FKckJLNGNdqr1tCh+4PO5ola2hYSOmO3HGSc/fmEUinV+pC9Ff7lwsg9e
        g0bSjahLeNXIPmMTlNKsQB1LRbpi+VWkpc6MQCNDh8wdGRpReZqW15w0Ld14JeQK
        zFCH4zgW9PxOX40dAJLnP5jWGpHW3L22GvGBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WO/k+J8dukTMXoNCxsMmlZcau3lQfpoT
        v78c+cLf7z7pcRhSqF2u/fhzxjzXOl/D1ne60aLweFAs4HHYMMf+041sIPBQ1vCk
        EEJ75vQ/4qDvPDgZh6+wzuTrDLepTH0pCr0AhrgPk7uQ1oja981FY+nwoSZggmaO
        y3mfFQED+Wo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FDA3BDB5A;
        Mon, 22 Feb 2021 18:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B19BBBDB59;
        Mon, 22 Feb 2021 18:59:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New orphan worktree?
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
        <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
        <87wnv688u4.fsf@evledraar.gmail.com>
        <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
        <87ft1o8mi0.fsf@evledraar.gmail.com>
        <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
Date:   Mon, 22 Feb 2021 15:59:14 -0800
In-Reply-To: <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 22 Feb 2021 18:06:32 -0500")
Message-ID: <xmqqmtvv64dp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F763BC76-7569-11EB-B395-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> When I was pondering the issue before writing my original response,
> two thoughts came to mind. (1) "git worktree add --force --orphan
> <branch>" would be one way to make your case work; (2) given how
> infrequently --orphan is used, we just punt and require people to
> first use "git branch -D <branch>" if necessary (which has been the
> status-quo for git-branch and git-switch).

FWIW, as I personally view that branch -d/-D, checkout -b/-B, and
switch -c/-C were all mistakes (they should have been -d, -b and -c
with and without --force, respectively), I find the combination of
"--force --orphan" a reasonable way forward.
