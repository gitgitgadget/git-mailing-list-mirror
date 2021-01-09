Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FD6C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3CA2250F
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 22:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhAIW1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 17:27:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51036 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIW1L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 17:27:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A9098B946;
        Sat,  9 Jan 2021 17:26:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EpItpbbM0Zb1QQYp2wb3LTR0U44=; b=WoexJ1
        Q4vx/TTB3IaC5KHan9Kh+kh5cCgfyQVr8IXY9pzdoG9M99Udi5+tL32PY4IkY6G2
        Npi8z0yMHvGhYvjMb0VYRvjeqcHEK2nPj8SogHnOkzFHJ8PI1lli6k1EgU7VlCxo
        LJ+yxkZOn+Az1PObFpoeehyP1B2QIK5FYWzjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UDtqPDd3ojSJ9wFyDBbaZsjVW212oKI7
        qQ5yYPOcL2+wVgYU0XsIlA6pmVZmm8Fu4bYePv2ITG8aUa+VIvj1TaFBLQ9D26dT
        axBXSPmGHnM9WcpAhU16HRo2mRSsWdawWmRctVE62k1eEzo8uuxAWKdyRR1IuMc4
        3qHVDltfReY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22CBC8B945;
        Sat,  9 Jan 2021 17:26:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A30728B944;
        Sat,  9 Jan 2021 17:26:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git 2.30.0 and failed self tests
References: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
Date:   Sat, 09 Jan 2021 14:26:28 -0800
In-Reply-To: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
        (Jeffrey Walton's message of "Sat, 9 Jan 2021 06:29:33 -0500")
Message-ID: <xmqqy2h1eoh7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B794DA5C-52C9-11EB-AA30-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I'm seeing a failed self test with 2.30.0 on Alpine Linux 3.10,
> x86_64. Alpine Linux uses Musl and BusyBox, so things may be a bit
> sideways because of them.
>
> *** t4129-apply-samemode.sh ***
> ok 1 - setup
> ...

I thought that Alpine with Musl is part of our automated tests.
Let's see if we had any test failures there.

  https://github.com/git/git/runs/1618243621?check_suite_focus=true

It seems that we didn't notice anything strange while running t4129
there.

  https://github.com/git/git/runs/1618243621?check_suite_focus=true#step:5:1080

Note that it seems that GitHub gives the full output only to logged
in users.

