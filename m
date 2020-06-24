Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F35C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E73520738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 17:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OfjrZv80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405578AbgFXRjD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:39:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50797 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405456AbgFXRjA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 13:39:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 568F677C86;
        Wed, 24 Jun 2020 13:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b/S8wJHSzquMvvpVRCEkk2dF9Ro=; b=OfjrZv
        80EHmVQlFOzOmn/EsPAhd082NUcgsILkH1RprIhgftGbJeChCv2LnwmI+Ny2WzKJ
        plv2bI0/CIjcizFYWc/tVtzPAeX6pcQu8P60wZ5GsFf41vTh8r3L2AnIzEpXl1nm
        MBcSkjqmsB1IpdgC7jcCdGT9jN+AwxLTls/To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l2psHpGcqdFVxxIqLW7JL7qq2kp1bWyJ
        LcO+C0dDTOKvkkyaanBZrW2+c0A1F7PWFjgKI9CFRKPTFCWNoSjsuSU2LUlKTCSl
        ignQ9tJxGMjQJwoT2CRatIwuw/4NvlTvRKVO+MWfq6lJ0nnptfsjTxUqdd0OETTr
        Ob93twTEOXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D6E877C84;
        Wed, 24 Jun 2020 13:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF4B777C83;
        Wed, 24 Jun 2020 13:38:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
        <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
        <xmqqtuz08ofa.fsf@gitster.c.googlers.com>
        <xmqqd05o75so.fsf@gitster.c.googlers.com>
        <20200624172425.GA152115@generichostname>
Date:   Wed, 24 Jun 2020 10:38:57 -0700
In-Reply-To: <20200624172425.GA152115@generichostname> (Denton Liu's message
        of "Wed, 24 Jun 2020 13:24:25 -0400")
Message-ID: <xmqq8sgc749a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9516ACD2-B641-11EA-98F3-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Wed, Jun 24, 2020 at 10:05:43AM -0700, Junio C Hamano wrote:
>> I do not know how many of you regularly have interacted with 'pu'
>> and now need to go through the same adjustment as I do.  Sorry for
>> using you as a guinea pig for an experiment for you know what to
>> gauge the cost.
>
> Heh, I was wondering if you had any ulterior motives ;)
>
> Since we're on the topic of the cost of renaming branches, I was reading
> a reply from you back in 2011 about how HEAD symrefs are the only valid
> ones[0]. I'm not sure if the situation has changed since then but
> perhaps we could officially expand the scope of symrefs to allow users
> to essentially alias branches? It might reduce the cost of performing
> branch renames by having a backwards compatible option.

It would be one way to transition, adding a symref in refs/heads/pu
pointing at refs/heads/seen, but that unfortunately defeats the
whole point of the rename, to make room for pu/<topic> hierarchy for
contributors with names, in which P and U appear as the first and
the last capital letters, respectively.

So, no, that won't be a solution, unfortunately.

I have an unused branch 'pu/nomore' in the primary repository I work
in, so that my accidental "git checkout -B pu jch" will fail, which
also takes advantage of this D/F conflict preventing a ref from
being created.



