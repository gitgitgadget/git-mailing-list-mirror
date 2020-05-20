Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E6C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18AA20829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 20:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGR5NQSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgETUbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 16:31:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57880 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgETUbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 16:31:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 31AA7DBC93;
        Wed, 20 May 2020 16:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TqP0iEDjQ+SARC6gnAySauC/y50=; b=BGR5NQ
        SFQcQUwSzc9nbppEqIzYxFeAgOM1shwm2ysonlK2AecBXLoRnFecnpM8l43y6mTu
        jDpEfyOzQ2T6eOas/9FuBEjypA7n3+xyDqrWFeAojtMRg59OakBRX5lLn1NWqx5r
        EsYwpHma6cffXefBvq79mWYHZFF9pos8RfeJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jhdKHZ4xWF8usIPPJcblMxreCJ8om/Gu
        y/4yttAAN4GcmIB/S3lQA7L7vkkFU98TvyQtd5O4so5q4nS+5zWqOdN8Kae1xHGG
        Mbw5yKV/TnAwnMRRvT48/Y7BSPZx8Kl889E0gev/tZq+/YdjpJmq36agkxy+zHYW
        8cM51KdR9nE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29553DBC92;
        Wed, 20 May 2020 16:31:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69A3EDBC91;
        Wed, 20 May 2020 16:31:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re* [ANNOUNCE] Git v2.27.0-rc1
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
        <20200520193156.GA4700@coredump.intra.peff.net>
Date:   Wed, 20 May 2020 13:31:30 -0700
In-Reply-To: <20200520193156.GA4700@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 20 May 2020 15:31:56 -0400")
Message-ID: <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E47193FC-9AD8-11EA-9192-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2020 at 12:17:11PM -0700, Junio C Hamano wrote:
>
>> Git 2.27 Release Notes (draft)
>> ==============================
>> 
>> Updates since v2.26
>> -------------------
>> 
>> Backward compatibility notes
>
> Is it worth mentioning here the reversion of v2 as the default protocol?
>
> It does end up (along with the actual code fix) in the "fixes from
> v2.26" section:
>
>>  * Those fetching over protocol v2 from linux-next and other kernel
>>    repositories are reporting that v2 often fetches way too much than
>>    needed.
>>    (merge 11c7f2a30b jn/demote-proto2-from-default later to maint).
>> 
>>  * The upload-pack protocol v2 gave up too early before finding a
>>    common ancestor, resulting in a wasteful fetch from a fork of a
>>    project.  This has been corrected to match the behaviour of v0
>>    protocol.
>>    (merge 2f0a093dd6 jt/v2-fetch-nego-fix later to maint).
>
> but that's somewhat buried. I dunno. It is not likely to introduce _new_
> compatibility issues, but perhaps folks looking into compatibility stuff
> may want to know about the revert.

The promotion in Git 2.26 was buried in the "performance &
implementation details" section and not in the backward
compatibility section, so it feels a bit funny to highlight the
reversion.  In any case, here is what I prepared (but not committed
yet)

-- >8 --
Subject: [PATCH] RelNotes: advertise the demotion of protocol v2

In the upcoming release, the transport protocol v2 is no longer the
default; note it in the backward compatibility section.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.27.0.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/RelNotes/2.27.0.txt b/Documentation/RelNotes/2.27.0.txt
index 5fb8c0cf67..95a8d338ad 100644
--- a/Documentation/RelNotes/2.27.0.txt
+++ b/Documentation/RelNotes/2.27.0.txt
@@ -24,6 +24,10 @@ Backward compatibility notes
    users may find annoying---those who prefer not to rebase need to
    set the variable to false to squelch the warning.
 
+ * The transport protocol version 2, which was promoted to the default
+   in Git 2.26 release, turned out to have some remaining rough edges,
+   so it has been demoted from the default.
+
 
 UI, Workflows & Features
 
