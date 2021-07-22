Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01367C6377A
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6D161249
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 00:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhGUXlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 19:41:21 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58423 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGUXlU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 19:41:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 161AC146106;
        Wed, 21 Jul 2021 20:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QLf9XM3POllDVGKYXqA6LViWgI+/VvcTrxyoE8
        ANgvc=; b=c1tPWaK1OgPHzHwPsVqP1dX5gu0gKMUM61dFxJlOflrs5PIRCBE0Cb
        v/V8vb9MYywgN46q8wswAGW3N7VrirPyeH3VZlcHbidWEav4dFENhh1K4i/QeKnN
        vA5h6yufzLJuVPqPQEqXB+ye+jfAnkJH5jnayEQdDHuoKg/bxRy+8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EB6F146104;
        Wed, 21 Jul 2021 20:21:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 54D8C146103;
        Wed, 21 Jul 2021 20:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
        <xmqqy29z9r94.fsf@gitster.g>
Date:   Wed, 21 Jul 2021 17:21:51 -0700
In-Reply-To: <xmqqy29z9r94.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        21 Jul 2021 16:33:27 -0700")
Message-ID: <xmqqtukn9p0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0BCC2E6-EA82-11EB-8328-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
>> index 5c3fb67c01..7f4b2d1982 100644
>> --- a/Documentation/git-pull.txt
>> +++ b/Documentation/git-pull.txt
>> @@ -117,7 +117,7 @@ When set to `preserve` (deprecated in favor of `merges`), rebase with the
>>  `--preserve-merges` option passed to `git rebase` so that locally created
>>  merge commits will not be flattened.
>>  +
>> -When false, merge the current branch into the upstream branch.
>> +When false, merge the upstream branch into the current branch.
>>  +
>>  When `interactive`, enable the interactive mode of rebase.
>>  +
>
> Looks correct.  Will queue.  Thanks.

By the way, I'll update the proposed log message to say only that
the documentation needs to be fixed as it does not say what the
command does.  We should be able to fix the inaccuracies in the
documentation quickly without advocating different behaviour or
trashing the current behaviour in the proposed log message.

I also happen to think that "flipping the merge order" is not a good
thing to do anyway [*1*]; keeping the log message to state just "the
description does not reflect reality-fix it" has the added benefit
that we do not have to debate it.


[Footnote]

*1* https://public-inbox.org/git/7vd2shheic.fsf@alter.siamese.dyndns.org/
