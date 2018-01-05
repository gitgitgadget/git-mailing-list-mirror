Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78EE91F428
	for <e@80x24.org>; Fri,  5 Jan 2018 22:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeAEWh3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 17:37:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59778 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeAEWh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 17:37:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1C64CB75D;
        Fri,  5 Jan 2018 17:37:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YcZkdLd2EE3/I4ioS/NpK0Oa7fo=; b=QsI2jy
        LpPXBHsEtfGHZ9O3zeyZxywFO7cF2z2yohWdRJmww1PICetb9Zkka6+BQ/HCWTyT
        jVCAy6aTal6pCaZiSDzmrQG9VQ9pt0FsRrX/x7Co+ZG37hxIG3vV4aMlTkGx9Ch4
        tPVPLgf1eyRYV6O/KiHjXRhbAwTqXIrOXfyNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oOwDdZEsrn7DDTTxvMQi3clJQEubd0gn
        r1IbakkJQ5EGC/AAxXbg2yo3kRtfeTIYeNghrCCMpI3dJPyRX2X8xiRYA38BSbGO
        sMqjkM9B/lJOyHsmnKQsicf3uYXgNMNLc6V7iCqE/FQH5E+bHaj/jw2H+u2VxiU4
        WH7KBS78+70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A19ECB75C;
        Fri,  5 Jan 2018 17:37:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA0C8CB754;
        Fri,  5 Jan 2018 17:37:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
        <20180103222821.GA32287@sigill.intra.peff.net>
        <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
        <20180104040124.GA11626@sigill.intra.peff.net>
        <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
        <20180105195705.GA5217@sigill.intra.peff.net>
        <xmqqmv1savcg.fsf@gitster.mtv.corp.google.com>
        <20180105205227.GA6958@sigill.intra.peff.net>
Date:   Fri, 05 Jan 2018 14:37:25 -0800
In-Reply-To: <20180105205227.GA6958@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 5 Jan 2018 15:52:27 -0500")
Message-ID: <xmqq4lo0aq56.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01925130-F269-11E7-9CB2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 05, 2018 at 12:45:03PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Out of curiosity, did this change at some point? I thought the process
>> > used to be to merge to maint, and then pick up topics in master by
>> > merging maint to master.
>> 
>> If you look at "Sync with maint" merges made to 'master', you'd
>> notice that most of them are only updating Documentation/RelNotes/*
>> and otherwise no-effect merges, simply because when such an up-merge
>> is made, everything in 'maint' is already in 'master' because topics
>> are merged to the latter first.  Security fixes that go through
>> embargoes are excempt for obvious reasons ;-)
>
> OK, that makes sense. Pretty sure I did it wrong when I was interim
> maintainer back in the day, then. :)

Well, MaintNotes on the 'todo' branch needs a bit of updating, as it
says something somewhat misleading.

-- >8 --
Subject: MaintNotes: clarify the purpose of maint->master upmerge

Even though the paragraph before this one is pretty clear that
topics are first merged to 'master' and then to 'maint', it was
misleading to say 'maint' is merged to 'master' to propagate fixes
forward, as most of the time, such an upmerge is a noop because
topics merged to 'maint' are usually merged to 'master' already.

These up-merges are done primarily to make sure that the tip of
'master' has updated release notes from all the maintenance tracks,
so be explicit about that to avoid confusion.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 MaintNotes | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MaintNotes b/MaintNotes
index 3a70b88..393d81f 100644
--- a/MaintNotes
+++ b/MaintNotes
@@ -173,8 +173,8 @@ feature release).  These days, maintenance releases are named by
 incrementing the last digit of three-dotted decimal name (e.g. "2.12.1"
 was the first maintenance release for the "2.12" series).
 
-New features never go to the 'maint' branch.  This branch is also
-merged into "master" to propagate the fixes forward as needed.
+New features never go to the 'maint' branch.  It is merged into "master"
+primarily to propagate the description in the release notes forward.
 
 A new development does not usually happen on "master". When you send a
 series of patches, after review on the mailing list, a separate topic
