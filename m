Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2154C433E6
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C872065D
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UUgMBlj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgGMPMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:12:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62105 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgGMPMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 11:12:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62C22C1BF8;
        Mon, 13 Jul 2020 11:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Adn9PDTiEpjs08xxfzFx1YXnOFw=; b=UUgMBl
        j1ryx+Ou1V3QR7YQw+0EKPJZxjcHXT/WM/D1+znEd9NSThzT5inOtw4hGtk9UAHa
        kX9d2AzVdPodVTZVVDrJ+vnsOlqpuXfvN7ecsNmi2iywI/KEWcK78p+6buHsN3P3
        eA0pHKhvVJwC0l7na9DFord7V7+EyeTtPdzdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K66dSnR5OxOV6BvciNJPBFn3JULe4NB/
        PvjhwVneQjjAV54TFdDvx3s/o8mVHDFor7XYxF3RJbiRWUfaAF8kPOEjgl3AtNrl
        0R1IPVmdi0Xpud6JG5dqOrdj1YydIaEo3Gl/445hiknoJ2/lyQbs4ZN52iqYcnbq
        dWtYq2AurHs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BF57C1BF7;
        Mon, 13 Jul 2020 11:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E4E9C1BF5;
        Mon, 13 Jul 2020 11:12:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>
Subject: Re: Help understanding unexpected diff output
References: <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de>
Date:   Mon, 13 Jul 2020 08:12:11 -0700
In-Reply-To: <5F0C38BB020000A100039FF0@gwsmtp.uni-regensburg.de> (Ulrich
        Windl's message of "Mon, 13 Jul 2020 12:34:35 +0200")
Message-ID: <xmqqsgdvo3ec.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B397774-C51B-11EA-BBAB-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> I inspected some changes using "git diff", and it was hard to me
> to find the actual differences (see git-diff-png): I had to look a
> long time at those olcAccess lines to find any difference, so
> finally I pasted both blocks into separate Emacs files a and b
> (via PuTTY) and used "ediff-files" (see diff-emacs.png).  Within
> there, the was only a part of one line changed!

With redactions and making them into two images, you did a good job
killing interested parties' willingness to help, as they made using
tools almost impossible.

So here is only based on eyeballing the images, and I probably have
missed what you wanted readers to find, but don't blame me ;-)

It seems that the file got 6 lines removed, that begins with
"olcAccess: {$n}" (0 <= n <= 6), at around 8th line of the file, and
then very similar 6 lines that are not identical to what got removed
at the end of the file.  The ediff you showed tells me that the 6
lines removed from very early part of the file and 6 lines added to
the end of the file are similar but not identical.  These two 6-line
blocks differ only by the 5th line (i.e. "olcAccess: {4}") having
",pwdGraceUseTime,pwdChangedTime" in the newer version, but not in
the older version.

Am I reading what you sent us correctly so far?

Now, if this change to the "olcAccess: {4}" line in the new file
weren't there, i.e. if the 6-line block that disappeared from the
early part of the file and the 6-line block that was added near the
end of the file were identical (in such a case, your ediff would
show no changes, I presume), then what would your desired output
from "git diff"?

I would imagine that the answer would still be a very similar looking

    --- a/0/...
    +++ b/0/...
    @@ -5,12 +5,6 @@
     olcDatabase: {1}hdb
     olcDbDirectory: /var/lib/ldap
     olcSuffix: dc=... 
    -olcAccess: {0} ...
    -olcAccess: {1} ...
    -olcAccess: {2} ...
    -olcAccess: {3} ...
    -olcAccess: {4} ...
    -olcAccess: {5} ...
    olcLimits: {0}dn.exact=....
     olcRootDn: cn=Admin,dc=...
     olcRootPW: {SSHA}yZ...
    @@ -52,6 +46,12 @@
     entryUUID: ...
     creatorsName: cn=config
     createTimestamp: ...
    -entryCSN: ...
    +olcAccess: {0} ...
    +olcAccess: {1} ...
    +olcAccess: {2} ...
    +olcAccess: {3} ...
    +olcAccess: {4} ...
    +olcAccess: {5} ...
    +entryCSN: ...
     modifiersName: cn=config
    -modifyTimestamp: ...
    +modifyTimestamp: ...

with identical "olcAccess: {$n}" lines removed from earlier part the
file and added to the end of the file.

So I am not sure what you are asking.  It would not be correct to show
something like

    --- a/0/...
    +++ b/0/...
    @@ -52,6 +46,6 @@
     entryUUID: ...
     creatorsName: cn=config
     createTimestamp: ...
    -entryCSN: ...
    +entryCSN: ...
     modifiersName: cn=config
    -modifyTimestamp: ...
    +modifyTimestamp: ...

and pretend that the original "olcAccess: {$n}" lines did not get
moved from the earlier part of the file to the end of the file.

Perhaps you may be looking for "git diff --color-moved"?  I dunno.
