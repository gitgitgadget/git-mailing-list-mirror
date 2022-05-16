Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10596C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245756AbiEPQOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiEPQOl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:14:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BF381BE
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:14:41 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D0112D363;
        Mon, 16 May 2022 12:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KQD8W4M+ZiY2BB/QLLjZhc799arVoaqSNZbN59
        q6OjE=; b=vEr7bUoEjqe+3wIkmXNhTlT3lfBpoiRZ9trUfbfsToxtBuAPMEWG91
        v2+3c2sOtDChnVlhjFkpo04iuV+nh4hr9Fymb30t0lp2VoSOHeDif5zQ6+Jjq+NB
        i+V1jUh1bc50nrh2xSnO3UNx4/hsr3Q4B3FJAiUK+e5pdyVdh/9hs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68AB812D362;
        Mon, 16 May 2022 12:14:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C88FD12D361;
        Mon, 16 May 2022 12:14:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Regad <dregad@mantisbt.org>
Cc:     git@vger.kernel.org
Subject: Re: Date in git-commit output inconsistent with log.date format
References: <CA+zp4VNWMxZ2ieS8KP2-uUu90AMmdzyR31VGkf78KdG4jY4eug@mail.gmail.com>
Date:   Mon, 16 May 2022 09:14:38 -0700
In-Reply-To: <CA+zp4VNWMxZ2ieS8KP2-uUu90AMmdzyR31VGkf78KdG4jY4eug@mail.gmail.com>
        (Damien Regad's message of "Mon, 16 May 2022 14:42:05 +0200")
Message-ID: <xmqqmtfh4fpt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49B627F0-D533-11EC-8F1C-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Regad <dregad@mantisbt.org> writes:

> I was amending a commit message, and noticed the date in the output is
> printed in 'default' format, as shown below:
>
> $ git commit --amend --no-edit
> [x bf63ada92] Test commit
>  Date: Mon May 16 14:25:57 2022 +0200
>  1 file changed, 32 insertions(+)
>  create mode 100644 test.txt
>
> Since I have set log.date=iso, I was expecting the date to use the
> Is it intentional that the
> default format is applied instead ?

Yes.

That output is from "git commit", and is not from any command in the
"git log" family.  Besides, it way predates the introduction of
log.date configuration variable.

This could be a XY problem.  Can you tell us why you care?  What
motivates you to see that date (and optionally Author when the
author is different from the current user) output in a specific
format---it is meant for human consumption so "I run 'git commit' in
a script and scrape its output" would not be it.

Thanks.
