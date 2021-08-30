Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618E2C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D2F60F42
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 17:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbhH3RLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 13:11:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56027 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhH3RLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 13:11:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B655414D72B;
        Mon, 30 Aug 2021 13:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EJbmch/3rgo6eI+B/iej72XBLUJVU24bUwlvC3
        168w8=; b=vFbhj4I7a1p/7i1ea7787x+omSIcas4H/IYOqwKNQdYWjvLrMI+z8S
        geBd9kP34c0M14kFlacXyVM8ahoOH2zg2xfpNA4Fqu59zBjMkIB4lRAaAXO8bv86
        ONY9dQkgITuBtpbyTo+m/FcGaYyfsY+YdPvIXTYXv5dWw9eVBmxnc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B062B14D72A;
        Mon, 30 Aug 2021 13:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E811614D725;
        Mon, 30 Aug 2021 13:10:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 10:10:03 -0700
In-Reply-To: <20210830072118.91921-4-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 30 Aug 2021 03:21:18 -0400")
Message-ID: <xmqqwno2505w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EA7150A-09B5-11EC-B6B7-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Like other Git commands, `git notes` takes care to call `stripspace` on
> the user-supplied note content, thereby ensuring that it has no trailing
> whitespace, among other cleanups. However, when notes are inserted into
> a patch via `git format-patch --notes`, all lines of the note are
> indented unconditionally, including empty lines, which leaves trailing
> whitespace on lines which previously were empty, thus negating the
> normalization done earlier. Fix this shortcoming.

Playing the devil's advocate, it can be argued that using the same
leading whitespace on a paragraph break line is actually a good
thing.  Leaving them in would give the consumer an easy way to see
which part was inserted from a note.
