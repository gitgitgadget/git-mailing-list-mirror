Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68463C47257
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4568A207DD
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yF0qKNpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgD3UjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:39:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65236 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgD3UjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:39:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62D18BAADA;
        Thu, 30 Apr 2020 16:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9yyNVrrcjIrQzbSKuZ39ts9kAU=; b=yF0qKN
        pk6qv2RD0dZvevKOZ9AQydq0bXKeuQbI83e54NclsrSLU2MzWXyNJH6efffx+PPj
        DUX/FIaJia+jYUhQxJM2Cd9qMUsYkfdGom/EzaJB1yfS7o+tbb9PwQX14EDDVecl
        57SXpAVf469xtqbQqWyR71rqfGHi951rrWznw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PDsQuvPgcvCu7wobusrGI4/IJ//tneRL
        8qlHJZTzDTB4KUefKFlW2ToCtbTgF0n1yZ0K/B6hHkZQySqABvKf1P7F9eLFWc9h
        sCpCoQurdblL1xp112GuDnUPcmssTwr8ysbkVGzbvNlq7nZZAyLicQGZENi7Hn17
        E07xUeVygaQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B21ABAAD9;
        Thu, 30 Apr 2020 16:39:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A72CBBAAD5;
        Thu, 30 Apr 2020 16:39:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1.1] lib-submodule-update: pass OVERWRITING_FAIL
References: <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
        <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
Date:   Thu, 30 Apr 2020 13:38:59 -0700
In-Reply-To: <f0d8dcf7dc52fe5ad2f1e173cd744bfdeb55eb45.1588242122.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 30 Apr 2020 06:25:05 -0400")
Message-ID: <xmqqpnbor9ng.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F5C5416-8B22-11EA-98DC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> We are using `test_must_fail $command`. However, $command is not
> necessarily a git command; it could be a test helper function.
>
> In an effort to stop using test_must_fail with non-git commands, instead
> of invoking `test_must_fail $command`, run
> `OVERWRITING_FAIL=test_must_fail $command` instead.

This description alone does not make much sense to me as a reader.
For "when OVERWRITING_FAIL environment variable is set to
test_must_fail, something magical happens while running $command" to
be true, $command (which may be "a git command", or "a test helper
function") must be aware of, and must be told how to react to the
OVERWRITING_FAIL environment variable.  For example,

	test_must_fail test a = b
	test_must_fail git cat-file leaf HEAD

may succeed because "test a = b" and "git cat-file leaf HEAD" fail
and test_must_fail would notice that these commands exited with
non-zero status without crashing.

But how would the same happen for these commands,

	OVERWRITING_FAIL=test_must_fail test a = b
	OVERWRITING_FAIL=test_must_fail git cat-file leaf HEAD

which is what the above paragraph tells me to write "instead of
using test_must_fail".  There is something gravely missing from the
description.  

Is it that $command is *NEVER* a 'git' command, but just a selected
few helper functions know how to honor this convention?  If that is
the case, perhaps can we teach these helper functions an *option* to
expect a failure instead of expecting a success?  These are all
speculations, because the above description is too vague as a
starting point for clear thinking.

> +			OVERWRITING_FAIL=test_must_fail $command replace_sub1_with_directory &&
> +			OVERWRITING_FAIL= &&

If we have given up the "single-shot environment export" for
compatibility reasons (which is a sound decision to follow), we
should make sure it is clear to our readers that we are not using
that shell feature.  I.e.

			export OVERWRITING_FAIL=test_must_fail &&
			$command replace_sub1_with_directory &&
			unset OVERWRITING_FAIL &&

I still do not understand how you are forcing an arbitrary $command
to honor this environment variable, though.
