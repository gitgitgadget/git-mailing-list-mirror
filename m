Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9523C433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A0E64DF2
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 07:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhBJHey (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 02:34:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65512 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBJHex (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 02:34:53 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66EF9B461E;
        Wed, 10 Feb 2021 02:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2oc1lA7agYOLeY5Dzmx0TKDn75s=; b=XWyR8A
        Jvjwk13QdrUOM4SMApm0wnzuw8zjveFLBD7NbdwKdvrS49fomphqrnCiDJboZOEB
        vRvHVRQXXflV/gbmumHMfAzif39+OmSVR9ced1HPoQ8sZlJ9RXT8O/pmirk8Mlgb
        7U8pGlQ1iIokEJ3MebX2L7lAFO/0fRVmdFrYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NTsTUB3TWVLDjjT0ccfAGHik92SRhyf0
        OpaUXVF+bmFf7d047+ZpoNioYFcL9S3r16d415Ri6bdZ6KqC9Cpxe/9RPujic/X/
        sALPCb04WNNBwiHF4ou9bDHN+TFqCcMArCHXZ4zMgPQn7t+E/oipQYBUdFb9ja9z
        WaCJgqZnRI0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EC0CB461D;
        Wed, 10 Feb 2021 02:28:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C569EB461C;
        Wed, 10 Feb 2021 02:28:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 7/9] stash: declare ref_stash as an array
References: <cover.1612258145.git.liu.denton@gmail.com>
        <cover.1612855690.git.liu.denton@gmail.com>
        <2f03d38b36665fe258444ce58f1e138be7b97e13.1612855690.git.liu.denton@gmail.com>
Date:   Tue, 09 Feb 2021 23:28:08 -0800
In-Reply-To: <2f03d38b36665fe258444ce58f1e138be7b97e13.1612855690.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 8 Feb 2021 23:28:53 -0800")
Message-ID: <xmqqft244c1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85FBEFA6-6B71-11EB-BFF6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Save sizeof(const char *) bytes by declaring ref_stash as an array
> instead of having a redundant pointer to an array.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/stash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

OK, up to this point there is nothing new that can be controversial
in design.  I suspect that we may want to fast-track these early
clean-up steps as a separate topic rather quickly while the new
feature(s) are worked out.

Thanks.
