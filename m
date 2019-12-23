Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ECC2D0C0
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 22:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5865C206D3
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 22:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fTSrPcCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLWWKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:10:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62372 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLWWKN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 17:10:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 512DC20A74;
        Mon, 23 Dec 2019 17:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kv10hSUgF/nAE3dVWwDm3h2yck0=; b=fTSrPc
        CqbZmb7Rq5uia5+bZWl38y6faUdP+/gE37IEVQHyra4kVgV9DLX+PfcDrcpqNTzO
        dygFUObxcYKVerU/nmrGtDSgx97SlEF6uO5BS0KhPYTn+d0tMaI0YOs2NaFW8D8p
        acTY34toSc2y0hMFzyfHEvIO9aX47nJ3ZjI/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Wxfu3w6/Liy/FdHLvWO+lSLv4GjNhXN4
        H0XdkCs9ENAjbX99bNe3XQeqW8CSljGq/kWV2kyXhAjkPKqRt9oPLd+rxqDgTnud
        R6ZGMP/KkLU0CSnGuITyIR+tUkxCFB6hWndz4we91tEwxgl62zna5vCfmrpwnZxQ
        IrAYe9t04Pw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D8CC20A73;
        Mon, 23 Dec 2019 17:10:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F04020A72;
        Mon, 23 Dec 2019 17:10:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <kdaudt@alpinelinux.org>
Cc:     Arnaud Bertrand <xda@abalgo.com>, git@vger.kernel.org
Subject: Re: Mismatch meaning between git-diff and git-log for the .. (double dot notation) and ... (triple dot notation)
References: <CAEW0o+gYqWT5u-Tf8aDoMgXaf36Mb-XOApLNs4D+GMVLvsOjxg@mail.gmail.com>
        <xmqqy2v26hu0.fsf@gitster-ct.c.googlers.com>
        <20191223182939.GB676947@alpha>
Date:   Mon, 23 Dec 2019 14:10:06 -0800
In-Reply-To: <20191223182939.GB676947@alpha> (Kevin Daudt's message of "Mon,
        23 Dec 2019 19:29:39 +0100")
Message-ID: <xmqqtv5q66dd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAEDE572-25D0-11EA-8D6F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <kdaudt@alpinelinux.org> writes:

>> This is not limited to you but any user of modern Git is better off
>> to pretend "git diff A..B" does not exist; please unlearn dot-dot
>> and three-dots when using "git diff" and you'd be happier.
>
> I agreen that you should not use `A..B`, but what is wrong with
> `A...B`? The alternative is a lot more verbose.
>
> git diff $(git merge-base A B) B

Because it would interfere with even grander consistency that we
could achieve in the future, if we get rid of it.

Within the context of "git diff" (but not "git" in general), "git
diff A...B" that expands to "git diff $(git merge-base A B) B" may
appear OK, but this thread started by comparing "git log" and "git
diff", so it is no longer worth limiting our vision to a single "git
diff" command if we want to continue this thread.

Some commands, like "git checkout A...B", know that A...B can stand
for "git merge-base A B" in a context that does not call for a range
but calls for a single revision.  We probably would want to teach it
the general revision parser machinery so that this can consistently
be used.

In such a world, "git diff A...B" ought to mean, because "diff" is
about discrete endpoints and not about ranges, "git diff $(git
merge-base A B)", i.e. it should behave just like "git diff C" that
compares the given single commit and the contents in the working
tree through the index.  "git diff A...B" we currently have by
mistake should be spelled in "git diff A...B B" (or alternatively,
"git diff B...A B").

It would take a long time and careful transition planninng to reach
there, and training people not to use dot-dot notation is merely a
very small first step, though.



