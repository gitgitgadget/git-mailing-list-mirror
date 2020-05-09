Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_IMPORTANCE_HIGH,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A854C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DDC21582
	for <git@archiver.kernel.org>; Sat,  9 May 2020 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="q5jdmGBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEIQ4E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 12:56:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65467 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgEIQ4E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 12:56:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7134C14BE;
        Sat,  9 May 2020 12:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=POJdjCTPv1q/mrki8z/J2YmfFKk=; b=q5jdmG
        Bo7Sj3kIxXQYyOrqt86G8Zyf+GOX7jVJ6oyxlnT3su6HNDFAlvr8ItzhDetfB2NT
        EkVh5GTfHA7y8R3mvs/6dlFAm5teniPqihxFfuYgrK557QwNsKyxAua0GqZC4wGM
        WUcAu6Wx/eB+6VRgUmlWEVXUkU8tDKn+tPY2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YztNCbPMJxMh24Ci6yPVvhcqWEHQToyT
        fGtRB2Iw98wTpOKrWrzE76CklLIaHER8mBqZcQ2vyRXrZRPyTOkUaEr+IxW8QCas
        wH3c6IgDenF0E6paDPQ83SYf5oB5I5CM23jlYm+IW0eiMXYnLlVRcYPgcGaXpsWV
        moz+GKnLDGE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C055CC14BD;
        Sat,  9 May 2020 12:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAB92C14B9;
        Sat,  9 May 2020 12:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 3/3] Ensured t5319 follows arith expansion guideline
References: <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
        <pull.626.v3.git.1589034270.gitgitgadget@gmail.com>
        <efeb3d7d1321e53e05079f296a5db5ab87f5fab2.1589034270.git.gitgitgadget@gmail.com>
Importance: high
Date:   Sat, 09 May 2020 09:55:57 -0700
In-Reply-To: <efeb3d7d1321e53e05079f296a5db5ab87f5fab2.1589034270.git.gitgitgadget@gmail.com>
        (Son Luong Ngoc via GitGitGadget's message of "Sat, 09 May 2020
        14:24:30 +0000")
Message-ID: <xmqq1rntvyhu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4F34E44-9215-11EA-B8D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Son Luong Ngoc via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Son Luong Ngoc <sluongng@gmail.com>
>
> As the old versions of dash is deprecated, dollar-sign inside
> artihmetic expansion is no longer needed.
> This ensures t5319 follows the coding guideline updated
> in 'jk/arith-expansion-coding-guidelines' 6d4bf5813cd2c1a3b93fd4f0b231733f82133cce.

That does not match my understanding of the guideline.  By removing
the "dollar required" rule and not adding a new "dollar forbidden"
rule, we pretty much declared that "we do not care much either way"
[*1*].

Even if we cared, "Once it _is_ in the tree, it's not really worth
the patch noise to go and fix it up." rule from the guidelines
applies here.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/20200505210741.GB645290@coredump.intra.peff.net/
