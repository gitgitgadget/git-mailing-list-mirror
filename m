Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5AC433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E9C2076D
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 19:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGhP47eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgH2Tbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:31:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59069 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgH2Tb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 15:31:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A81DDD6A28;
        Sat, 29 Aug 2020 15:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=wpjwgSOYIUwYd0fkLU0gSAQ8wH4=; b=QGhP47ePiohPhkbAhV0j
        YbTmJTm8HjjjuzzuYRWYbtuw1cLs6kp1GYsoCTq1PN32PG2YnjYYY/KA2aEQ14Au
        Nso3eswmJzhLbTFOxUDiTAhxH3LU3MbmqCV+2dy7KgRuOWEsm6uNCOuvpkGOlNrO
        rtKka2j0b0nvmm0SKxzoarM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KMB95u8Dy2f8qs1vtHlYNWx7KCPNI2j/zj1pmNZ80Qv5/7
        CZswyeUtszJXgzZl8fNfXedlxxorS0tsKyZOrOcegUhov9QPxoUSv86F2gJ9Z9os
        8E5QJZMUjRq5Q1Kn1nF0tKA/oXyICJwpc+cY1QEcnQ6ZCIe5CQfBc+JDX7o6Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8DB86D6A26;
        Sat, 29 Aug 2020 15:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C30EBD6A25;
        Sat, 29 Aug 2020 15:31:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Finish converting git bisect to C part 2
References: <20200828124617.60618-1-mirucam@gmail.com>
Date:   Sat, 29 Aug 2020 12:31:23 -0700
Message-ID: <xmqq1rjpi704.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39D8CA96-EA2E-11EA-AC7C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> These patches correspond to a second part of patch series 
> of Outreachy project "Finish converting `git bisect` from shell to C" 
> started by Pranit Bauva and Tanushree Tumane
> (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> continued by me.
>
> These patch series emails were generated from:
> https://gitlab.com/mirucam/git/commits/git-bisect-work-part2-v6ps.
>
> I would like to thank the reviewers for their help.
>
> General changes
> ---------------
>
> * Rebase on master branch: e9b77c84a0 (Tenth batch, 2020-08-24)

Was this done because the updated series newly depends on something
that was not available in f402ea68 (The fifth batch, 2020-06-25)[*]
but is available in e9b77c84a0 (Tenth batch, 2020-08-24), and/or is
there a change between the fifth and tenth batch that conflicts with
the old iteration?

	Side note: the previous iteration, which is queued in
	'seen', was applied on top of f402ea68.

Updating to a new base is not by itself wrong, but please also
describe the reason why the topic was rebased, perhaps like

 * Rebased on e9b77c84a0 (Tenth batch, 2020-08-24), to build on the
   strvec API (instead of argv_array) and adjust to the codebase
   after the "--first-parent" feature was added.

or something like that.

> [6/13] bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell
>  functions in C
>  
> * Change `file_exists(git_path_bisect_head())` to a refs API call.

Very much appreciated.

Thanks.
