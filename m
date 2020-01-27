Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6813C2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9446D24679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vpX/c/mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgA0Ubm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:31:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51883 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgA0Ubm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 15:31:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 370893B275;
        Mon, 27 Jan 2020 15:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TNM0zbGG1hPqPqTs2phHSg+oylU=; b=vpX/c/
        mCcUj2igqmz2QJkaDUHo3OvJC7UIxVPnAVykp0DRJaE0I8UUy4pJ8/jyXzzOV0cA
        UWtuQ+rQ5t8+4SCNVdmKeJIEfFBztyBra618B1itMrW+jsPCbrrwRVCOd91IdqBL
        ED8VbpFVJ5bvEQK5pZ97FAYXP9Lhy62d2m4bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NiB1FY0IQphRb6noVDn/nxlUfD7sovD2
        GmvthDpRy6LseDbk+hXk72Qnl18GDmIgseqAD07gVZa4rfuVt0tgoHMBS3mLcbbX
        6FWEHtNECZAR5xHALXm5CHquKUmAxLs2+fLxbwU9vHx5xQTJFGYmarwfR+ds/seH
        kaddpJXnn8o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2DC4E3B274;
        Mon, 27 Jan 2020 15:31:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CE583B273;
        Mon, 27 Jan 2020 15:31:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] worktree: add shorthand '-d' for detach
References: <20200125173744.4334-1-me@yadavpratyush.com>
        <20200127122610.GB10482@szeder.dev>
        <CAPig+cS_H+FTcZkBz4dA94bAcxv0CZ8UG=P8jOGvD=HXzf8ODQ@mail.gmail.com>
Date:   Mon, 27 Jan 2020 12:31:38 -0800
In-Reply-To: <CAPig+cS_H+FTcZkBz4dA94bAcxv0CZ8UG=P8jOGvD=HXzf8ODQ@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 27 Jan 2020 11:05:20 -0500")
Message-ID: <xmqq36c0bpzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 059C2F68-4144-11EA-9561-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> Here I would prefer to keep '--detach', because "detach" is a real
>> word with proper meaning, while 'd' is just an abbreviation.
>
> I fully agree with this assessment and was going to say the same.
> '-b' and '-B' are special in that they don't have corresponding long
> option names, thus they must be shown in short form, but long name
> '--detach' is much more informative in this context (and the reader
> can discover short '-d' easily enough without mentioning it here).
> So, I'd drop this change (and the other similar one).

Yup.  

Even though I do not mind a short-hand '-d', because "worktree add"
would be quite a rare event compared to the use of other Git
subcommands, those who do not remember '--detach' after learning it
would not have any better chance to remember to use the option, even
if a shorter variant '-d' was available.

In other words, if "worktree add --detach" is underused and it is a
problem that needs to be fixed, I do not think the reason why it is
underused is *not* because "--detach" is too long to type or does
not get completed when "git worktree add <TAB>" is typed.  Isn't the
real problem because people do not even *know* that the choice of
starting a worktree without being on a particular branch exists?

A better documentation would help, but I do not think

    "git worktree add -d foo" is about as easy to type and remember as
    "git worktree add foo"

is addressing the right problem.  s/-d/--detach/ may make it more
clear what the option is about, in which case it would be a better
way to promote the feature.

