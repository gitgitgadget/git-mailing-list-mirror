Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C08C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB252072A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lIdFBQEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgHCPux (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:50:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHCPux (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:50:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72EABF39CF;
        Mon,  3 Aug 2020 11:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J4XIDFSeJYjbEd3LujKrKRTzVQ0=; b=lIdFBQ
        ECkjNOt7HOgESL3V54IIZSnw67I+Mx2SxTr8gUazwESwpydq8bjpSC1njVEmjP2s
        ip/vtD2MXN2dZIfUoWjywzTvtkk6mngxB7Xkz5Pkkz1qtKtEAZvSl8sB5vyAEPhV
        AvQTJry1LF/ADrbSujS6BuJ4oP+e1vnH+h360=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qd/97zkAaRfk1QULPqq9sxfOzWPq7yfv
        3p+5IeIxqX8Aiw2AoIvC41RYkztWeEwIIrnTdXAHCBRcF8ZiJPXjMyQuPgi5FlSS
        lHd01piWrhkyTS7ikhMdLqZSR2M7FDUW6T+L0z6ypsJCzPiKysUuME88BWmaJA2E
        Wloa2dQuuLY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AC7CF39CE;
        Mon,  3 Aug 2020 11:50:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1BFBDF39CD;
        Mon,  3 Aug 2020 11:50:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] t6038: fix test with obviously incorrect expectations
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <83a50f7e0bbfd19cffc5cffb9f17484e86443d0a.1596349986.git.gitgitgadget@gmail.com>
        <xmqq4kpkstwk.fsf@gitster.c.googlers.com>
        <CABPp-BHNebxZK1-tXx0HMmPDuRoj=_XWG=pVJ2HCvTkttvA4oQ@mail.gmail.com>
Date:   Mon, 03 Aug 2020 08:50:45 -0700
In-Reply-To: <CABPp-BHNebxZK1-tXx0HMmPDuRoj=_XWG=pVJ2HCvTkttvA4oQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 3 Aug 2020 08:36:28 -0700")
Message-ID: <xmqqr1snwwx6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18D4EC36-D5A1-11EA-A801-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I'd say that it is probably more intuitive to expect whatever
>> attributes set on the currently checked out and receiving the
>> cherry-picked change would take effect, but I do agree with you that
>> this is not well defined.
> ...
> What if you don't have any version checked out, and are doing a merge
> in a bare-repo or are just redoing a merge (on some other branch)
> without touching the working directory or index just so you can view
> that other merge?

The "receiving" is the keyword in my "I'd say".  Whey you view the
result of merge, the merge may be symmetric, but when initiating a
merge, you have a clear distinction between the target and other: I
am merging these other side branches into this one.

But as I said, I think it is not well defined whose attribute should
be used.  Some might even dream that .gitattributes from the tips
being merged are somehow magically merged first and then the other
paths' merges should use that resulting merged .gitattributes.

> Also, what if you were doing a merge in a dirty working tree, where
> your .gitattributes was locally modified?  Should the local
> .gitattributes file override the .gitattributes file recorded in
> history for how those versions are merged (which seems somewhat
> suggested by your answer)?

Yes, that is quite deliberate outcome from "when doing a merge, the
person who is merging is fully aware into which branch others are
merged into".
