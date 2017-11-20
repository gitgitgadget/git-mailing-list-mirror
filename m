Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BB7202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 00:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdKTAYm (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 19:24:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57580 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751190AbdKTAYk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 19:24:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A30F0B4E71;
        Sun, 19 Nov 2017 19:24:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aixNyuYuoy+ozMZAycf9RBQdDek=; b=oGQRLL
        ALYFlZVDa3SWbNG9SOc/UgX2Am7Q75ss4Y49/m4kdeKIN/7sFRnXIfUBWR/hGS/Q
        XfjvTIsIzQ3SDiC5FbAqejfQ1ebNl1/mzvtWM7k8MSBb5A7y/YhsElwqbPbGwlxU
        55nJ/HOK78gtNSr6Rczu3V4K32fbPvxAyVrXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p1wGbCX0RP0eXZ3ih41QMs3zb/setV2w
        cFBpt3D5h+n0ZT59HAXMVJnUyNONlLVMtNCi5ZUv4st4Pq7SF18yOTS/8IzcLJEC
        NLwAL6+B03rPYjMms9t6H0X/ymV4vlGvsjc+F8QA0jNVMTzEWeF0T8bzetYNAttN
        Dx7mGeVl5gs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BA5FB4E70;
        Sun, 19 Nov 2017 19:24:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BDE9B4E6C;
        Sun, 19 Nov 2017 19:24:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gennady Kupava <gennady.kupava@gmail.com>
Cc:     git <git@vger.kernel.org>, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH 1/2] Simplify tracing code by removing trace key normalization concept
References: <20171117221631.x2xqeeqmf5xob3yv@sigill.intra.peff.net>
        <20171119004247.22792-1-gennady.kupava@gmail.com>
        <xmqqzi7jnh6a.fsf@gitster.mtv.corp.google.com>
        <CAPu-DQoapb=cgxYEOEVcpZ4nQeh+FuOE6VF=m3NaqRcr2p8Nrg@mail.gmail.com>
Date:   Mon, 20 Nov 2017 09:24:38 +0900
In-Reply-To: <CAPu-DQoapb=cgxYEOEVcpZ4nQeh+FuOE6VF=m3NaqRcr2p8Nrg@mail.gmail.com>
        (Gennady Kupava's message of "Sun, 19 Nov 2017 13:16:04 +0000")
Message-ID: <xmqqr2stokzd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3201C742-CD89-11E7-8B58-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gennady Kupava <gennady.kupava@gmail.com> writes:

>> The usual style comment on the subject applies here.
>
> Oh sure, 50 characters. 'Remove trace key normalization concept' would
> be better?

I was referring to #summary-section of Documentation/SubmittingPatches

    The first line of the commit message should be a short description (50
    characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
    and should skip the full stop.  It is also conventional in most cases to
    prefix the first line with "area: " where the area is a filename or
    identifier for the general area of the code being modified, e.g.

    * doc: clarify distinction between sign-off and pgp-signing
    * githooks.txt: improve the intro section

    If in doubt which identifier to use, run `git log --no-merges` on the
    files you are modifying to see the current conventions.

    [[summary-section]]
    It's customary to start the remainder of the first line after "area: "
    with a lower-case letter. E.g. "doc: clarify...", not "doc:
    Clarify...", or "githooks.txt: improve...", not "githooks.txt:
    Improve...".

> So comments explaining that, while implementing trace optimization, I
> saw two options:
> 1. Move normalization function from .c file to .h file
> 2. Remove it
>
> And why I choose removal - not used, would complicate header without
> any benefit, and actually I didn't mention minor benefit of
> compilation speed. This trace.h included and used in lots of places so
> it will take compiler some time to actually eliminate the code.
>
>> Puzzled.
>
> Does it make more sense now?

The thought behind the change flows much better in the above
explanation than your four-bullet list (which a reader would often
assume are parallel and orthogonal).  "Remove this, because it is
not used" is the primary thing for this step, and the fact that the
later step benefit from that change, while it may be more important
to the person who want to see that later change, is incidental to
see if this change makes sense as a standalone patch.

And that primary thing, "remove this, because it is not used and
only complicates the code" is what we want to start the log message
with.  The first sentence ("this needs to be moved there") saying
what the patch chose not to was the source of the confusion.


