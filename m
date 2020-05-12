Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E871C2D0F8
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582C620673
	for <git@archiver.kernel.org>; Tue, 12 May 2020 21:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6QWMvgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgELV1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 17:27:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53442 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgELV1W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 17:27:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7416DD41AA;
        Tue, 12 May 2020 17:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rI3hKN9X6I9Q6xWEPj1SJbA6gbU=; b=I6QWMv
        gAnt0dGR52scbqxr4BFZrzoqPwWmpM3BbubYNaLksJfh8meNVM3klUQF/cQYPKn/
        uzLEM+ncaD1UoyA8I1dwaBfRNCagzg7zcZEW5NagMwKQpX1GWgxe39NhqPSuIag1
        b+rBJpqFMuNuKqD1+Sgn/Yirv20ELekGbqevQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wbaMLs77DlkuC0OIvhAM5Am1Hbb3rJAG
        CTDIUXrqEpYLtzezFDKiAdaeBlqS40JhPYegEweA7ZCoc4dX9clrETuCA9aJAfJI
        WQPeZC8IDdzJ9Wm4qdCT9qhrE4DNiknMHChFgnHev6Tb3tvY61k/akm5np1isUlb
        mKLEQ2DBsqY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6444DD41A9;
        Tue, 12 May 2020 17:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 95CB4D41A8;
        Tue, 12 May 2020 17:27:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for vs-build job
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 14:27:17 -0700
In-Reply-To: <fa1b8032906c6042a0e5851f803ec0427922a1a5.1589302255.git.gitgitgadget@gmail.com>
        (Sibi Siddharthan via GitGitGadget's message of "Tue, 12 May 2020
        16:50:54 +0000")
Message-ID: <xmqq3684c096.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C36D782-9497-11EA-A964-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> Subject: Re: [PATCH v2 11/11] ci: modification of main.yml to use cmake for vs-build job

Yay!

> This patch modifies .github/workflows/main.yml to use CMake for
> Visual Studio builds.
> Modified the vs-test step to match windows-test step. This speeds

	Teach .github/workflows/main.yml to use Cmake for VS builds.
	Modify vs-test step to match windows-test step to speed up
	the vs-test.

> Changes:
> The CMake script has been relocated to contib/buildsystems, so point
> to the CMakeLists.txt in the invocation commands.

This does not belong to the log message for this (or any for that
matter) commit, no?  Up to this point, nothing in main.yml used
CMake script from anywhere, and "has been relocated" is irrelevant.

And if we add CMake script to contrib/buildsystems/ from the
beginning in [01/11], there won't be any "relocation" the readers of
the log message of this step need to know about.

> The generation command now uses the absolute paths for the generation
> step.

"now uses"?  Is that something the readers of the log message of
this step need to know about, or is it "in contrast to an earlier
attempt to add CMake script"?  If the latter, it only confuses the
readers of our history, as most of them will not even know about an
earlier attempt.

Thanks.
