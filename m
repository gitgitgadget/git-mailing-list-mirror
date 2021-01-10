Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F9BC433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1776D2389B
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 01:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAJBmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 20:42:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60228 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAJBmH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 20:42:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40E7A8CE56;
        Sat,  9 Jan 2021 20:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YylWh0lq/rSUBpw10TQ4pX3/4kg=; b=UYSE7R
        ihjSmsRYZGTh4GbZBaXedZPmBnLWiWgem3dFnuDf4RzA5Otk7rSJs1LePxRc5/hB
        RvEjEGIutR02UopC361khK4N7C3wgXSZwnWG8uWIKw/KCpfzBqW9jA6JZYZDA0Gr
        QnAc6hpxG8nU1USVGPvx+Bt4bwP3gyVAMBXgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nHw8Gx+b155DB2jps8BWjuQlWRVZZACQ
        dQLcSIVrwfvYOwAMGQg9WKplKhlIs8z8wffN0qYX8e3utk4Vk5dBJhWChbEJTjdF
        k65IZacs+Z4C03Wdl3f1tg5C1D1kCgcUpScIE5Balt1EEd5CEUwg0xDlw4ZJ66pP
        FVeh9HlX9bM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 303EC8CE55;
        Sat,  9 Jan 2021 20:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ADFD68CE54;
        Sat,  9 Jan 2021 20:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Alan Mackenzie <acm@muc.de>
Subject: Re: [PATCH] docs: add description of status output table
References: <X/oAhdZlLwcFRCrR@ACM>
        <20210109220614.759779-1-sandals@crustytoothpaste.net>
Date:   Sat, 09 Jan 2021 17:41:23 -0800
In-Reply-To: <20210109220614.759779-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 9 Jan 2021 22:06:14 +0000")
Message-ID: <xmqqim85d0vw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F25F4486-52E4-11EB-8606-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The table describing the porcelain format in git-status(1) is helpful,
> but it's not completely clear what the three sections mean, even to
> some contributors.  As a result, users are unable to find how to detect
> common cases like merge conflicts programmatically.

I agree that the addition clarifies, but it is a bit sad that we
already have a beginning of the explanation; I wonder if we should
improve the existing description in addition, even if it may not be
sufficient to eliminate the need for this new paragraph.  Here is
what we already have:

    For paths with merge conflicts, `X` and `Y` show the modification
    states of each side of the merge. For paths that do not have merge
    conflicts, `X` shows the status of the index, and `Y` shows the status
    of the work tree.  For untracked paths, `XY` are `??`.  Other status
    codes can be interpreted as follows:

This introductory text does sort-of hint that there are three
classes (merged paths, unmerged paths and untracked paths), but (1)
the order the three classes are described do not match that of the
table, and (2) the explanation of the untracked paths predates the
addition of ignored ones to the untracked class, so the description
is added after the legends as if an afterthought.

I am actually tempted to suggest rewriting the whole section,
starting from the paragraph above and ending at the table, with
something like this:

    Three different classes of paths are shown in the same format,
    but the meaning of `XY` are different:

    * For merged paths, `X` shows the status of the index, and `Y`
      shows the status of the working tree.

    * For unmerged paths, `X` and `Y` show the modification states
      of each side of the merge, relative to the common ancestor.

    * For untracked paths, `X` and `Y` do not convey different
      meaning (as, by definition, they are not known to the index);
      `??` is shown for untracked paths, and when `--ignored` option
      is in effect, ignored paths are shown with `!!`.

    In the following table, these three classes are shown in
    separate sections, and these characters are used for `X` and `Y`
    fields for the first two sections that show tracked paths:

    * ' ' = unmodified
    * 'M' = modified

       ...

    ....
    X        Y       Meaning
    ------------------------------------------------------------
            [AMD]    not updated

       ...

Hmm?
