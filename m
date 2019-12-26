Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABAFC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E01D206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 22:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ye/jPaUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLZWZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:25:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62903 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZWZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 17:25:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36D8AA04C0;
        Thu, 26 Dec 2019 17:25:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AsHP3EyST4GBctF8wxC5ikAikv4=; b=Ye/jPa
        UnOPRsQoUe4vr/fOhHg85J8QH6eNO4aBHedoTpNxqEvv8zFxXFMTY6VZjovWW4Q5
        Lv0hCc8AmLOoEx28oBXkOc85f5XsCUlwHW5eqprd4Fc99nlkjueHPVWUqpMGcywL
        7OonDawf4kJ6fj15+moyYa9vE7mhu25oEeE9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pW7Ig2iKJG0REREBwI0rAaj1O7aHqMK4
        jYGscRD+VU+87K3NwWRjIWin0gkddcKtIO5W2ka8MnJibF4lND7pHLfTsEUWeal2
        bOrhrb22jgIShXRiaERL97xoO4ZHzMRRqOdiVrbwiVo8xBZ97of1rOlkr9hfmAy7
        IxFa4s6PMLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DC20A04BF;
        Thu, 26 Dec 2019 17:25:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 61AB4A04BE;
        Thu, 26 Dec 2019 17:25:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: only test index entries for backslashes, not tree entries
References: <pull.682.git.git.1577382151.gitgitgadget@gmail.com>
        <4a120fd0b32d2d6492eac6b0494ad6b1bc2ba500.1577382151.git.gitgitgadget@gmail.com>
        <20191226200316.GD170890@google.com>
        <nycvar.QRO.7.76.6.1912262221000.46@tvgsbejvaqbjf.bet>
        <20191226214245.GA186931@google.com>
        <xmqqfth6kaqi.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Dec 2019 14:25:28 -0800
In-Reply-To: <xmqqfth6kaqi.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 26 Dec 2019 14:01:09 -0800")
Message-ID: <xmqqblruk9lz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FE0E7B4-282E-11EA-8997-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Is there anything we can or should do to prevent people checking in
>> new examples of paths with backslash in them (on all platforms)?
>
> I obviously won't dictate what should happen on Windows, but I think
> the overall principle for paths recorded in a tree object that can
> be problematic on some of the platforms ought to be:
>
>  * fsck and transfer.fsckobjects should be taught to notice
>    offending characteristics (e.g. has a backslash in it, is one of
>    the "reserved names" on some platform like LPT1).
>
>  * if paths with the offending characteristics are *so* obviously
>    useless in real life and are possible only in a crafted path that
>    is only useful to attack users, the check in fsck should default
>    to "reject" to help the disease spread via hosting sites.
>
>  * otherwise, the check should be to "warn" but not "reject", so
>    that projects can keep using paths that may problematic on
>    platforms that do not matter to them.
>
> I think LPT1 and friends fall into the "warning is fine" category,
> and a path component that contains a backslash would fall into the
> "this is an attack, just reject" category.

I guess I should have stepped back a bit.

In the message I am responding to, I focused solely on how tree
objects that originate elsewhere should be treated, but there are
two more data paths we need to worry about:

 * A new path gets introduced to the system, via "update-index",
   "add", etc., to the index and then "write-tree" to form tree
   objects in the local repository.

 * A path in the index, either created locally via "update-index",
   "add", etc., or read from a tree object, gets written to the
   local filesystem, resulting in an attempt to create a path that
   the local filesystem cannot represent (or worse---behaves badly,
   like "sending random garbage to the printer").

I think we should apply the same principle as the one I outlined for
the tree objects.  The fsckobjects mechanism may not be reusable to
catch violations in add_index_entry_with_check() as-is, but we need
to aim for as much reuse of logic and code as possible so that our
checks at various layers all behave consistently.

Thanks.



