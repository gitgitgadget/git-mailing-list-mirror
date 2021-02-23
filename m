Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946FC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610D364E24
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhBWTdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:33:51 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54133 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhBWTdn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:33:43 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A24B6951DE;
        Tue, 23 Feb 2021 14:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zzSKQ6yx27rOQXUvyV2f4gzB9HE=; b=iJUhCs
        zy7jHZvRv3oZt7+f4dAp8MCagAv2sbJyE2exhO5FEGAbcTQ5GzR92HlHir8bJE5v
        8JKPAlh+dF5TRmW7i414Iopi0IUW7ibWXP5R7JvTfCMpKzs3D5rd/e119WlRNlSQ
        QuGaf2jDr8Qc2+zd3O/g0odxsgklCEuPTQvcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFjRTNxsylRQv8eJS1EI0FD3Y9o4bNbw
        xQbfsmv9tgZYZJsrkU8OAbtnJOPYmBUGvpECViOVk22AvE0y3gU9HFuR+ibgM/Ae
        K+pVCb+MjWWI+WJ/qg/sB+NSDuqH+a7UnzLZMfQCbbLT5OChhFg7/3uqnaygn2W4
        AJuCIfNXbH0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A8B0951DD;
        Tue, 23 Feb 2021 14:33:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F19EB951DC;
        Tue, 23 Feb 2021 14:33:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utku Gultopu <ugultopu@gmail.com>
Subject: Re: [PATCH] doc: `--date` in `git-commit` accepts approxidates
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
        <YDVFaTGnPCfuJQSa@coredump.intra.peff.net>
Date:   Tue, 23 Feb 2021 11:33:00 -0800
In-Reply-To: <YDVFaTGnPCfuJQSa@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 23 Feb 2021 13:11:53 -0500")
Message-ID: <xmqqtuq21swj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0B6B0AA-760D-11EB-B0FB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And then at the end of that section, expand what it's willing to take:
>
> ifdef::git-commit[]
> The `--date` option (but not the environment variables) will also try to
> make sense of other more human-centric date formats, including relative
> dates like "yesterday" or "last Friday at noon".
> endif::git-commit[]

Yup, I find this a lot more acceptable than reference to the code
that may happen to be correct only at this moment but can deviate
over time from the reality.  IIRC, the implementation detail cited
in the patch under review (e.g. use of _careful() helper) did change
in 2014.

Thanks, both.  Looking forward to seeing an updated patch.
