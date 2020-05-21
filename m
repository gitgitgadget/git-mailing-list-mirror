Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3A6C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A1D2072C
	for <git@archiver.kernel.org>; Thu, 21 May 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyMK3hAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgEUQr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 12:47:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57952 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgEUQr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 12:47:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C650568B54;
        Thu, 21 May 2020 12:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9uTlawXLS9csCh25PreMuT+Kyhw=; b=fyMK3h
        AsE8NdzPw0T06lcdvuFIDPDBT9SAPHO0oS3Fot0BrQFctm5xAl4KQQka5pzUviRt
        tZwPYZ5JACwoE2wIYyvcoZh155GdKyEWalEJ8oR99pWzL+047QWdYJ6c/HMFUNvf
        jU3lmobDWcbA6HOL8j78sn/YvZSnE2Z3gFZ0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c+4UKR4dF8SiXifBtd1VhRmg30t0HLaC
        T/jPsL5Y421KIkdZTzaw9nNO5DKci2Gd4bprkf+4n8efp4drHcPeaoD+6fz85/Xo
        W7+ZGP2iGIT8MoOLvruwD3D2QJNQImvQeJZ/Bq6XZfK7beorQwR85mHqVeNsxMKl
        23zlCsyYiO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAE1D68B53;
        Thu, 21 May 2020 12:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47AED68B52;
        Thu, 21 May 2020 12:47:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] t: replace incorrect test_must_fail usage (part 5)
References: <cover.1588162842.git.liu.denton@gmail.com>
        <cover.1590019226.git.liu.denton@gmail.com>
Date:   Thu, 21 May 2020 09:47:22 -0700
In-Reply-To: <cover.1590019226.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 20 May 2020 20:24:14 -0400")
Message-ID: <xmqq8shlteud.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE8B8A4E-9B82-11EA-875B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi all,
>
> This is mostly a resend of what's currently queued in
> "dl/test-must-fail-fixes-5" except with a tiny bit of cleanup on the tip
> patch. I'd appreciate a review on this series so that we can finally get
> rid of that "Needs review" on the What's Cooking messages ;)

Thanks.  

The OVERWRITING_FAIL one was the only one I was unhappy about, so it
would be good to have more eyeballs on it---perhaps other people
find the approach acceptable, or can suggest more readable and
understandable approach.

