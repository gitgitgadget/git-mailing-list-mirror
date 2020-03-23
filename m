Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA18C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C73520409
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="awrAQ3Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCWQSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:18:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54437 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbgCWQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 12:18:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88070522D6;
        Mon, 23 Mar 2020 12:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zJ6h0Nbfw23w
        eRJsIjBMSVnX+WI=; b=awrAQ3MmSCV3nr3kmUf3kd3t0sv5u5+I+viRnuWdSb5k
        aEVYhBdY/KYrLrWzdcBwfs2epV+IFX3ZwDc0SDqpyFIiQ7sx0CrHsBtdTKiUcm/S
        ZHd7A/5x2XBTGrHls2pU7wv51cdQ3PHGLDLrF0HUFU7Tj+NhOJ0iYtSNx0qz0qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HFk3jM
        ZQDsm+ich4yYdXo9C15U23BU1/lKOpnQyMbecsWnoqlTgtejUW1nhjhJq+uFNYaV
        AVsVg85c3Em0uLKwwjFZP7lpZBVU7d3Ljr1U3P0cQGGmqwKOSXu+kepk58pvGiAR
        N5DRnH78BLOhtr9z0vQt7fCIwqaKoK8unK4W4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FA56522D5;
        Mon, 23 Mar 2020 12:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07298522D4;
        Mon, 23 Mar 2020 12:17:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Sheikh hamza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sheikh hamza <sheikhhamza012@gmail.com>
Subject: Re: [PATCH] bisect: remove root directory restriction for git bisect
References: <pull.736.git.git.1584868547682.gitgitgadget@gmail.com>
        <20200322104826.GB2224@szeder.dev>
Date:   Mon, 23 Mar 2020 09:17:57 -0700
In-Reply-To: <20200322104826.GB2224@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Sun, 22 Mar 2020 11:48:26 +0100")
Message-ID: <xmqqpnd359l6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DC971326-6D21-11EA-9C5C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Sun, Mar 22, 2020 at 09:15:47AM +0000, Sheikh hamza via GitGitGadget=
 wrote:
>> From: sheikh hamza <sheikhhamza012@gmail.com>
>>=20
>>     according to the open issue #486
>
> What issue #486?  Where?  The Git project doesn't use issues.
>
>> the git bisect
>>     command should be able to run from inside any
>>     subdirectory
>
> Why should 'git bisect' be able to run from inside any subdirectory
> (of the working tree, I presume)?
>
> In particular, what happens, if someone starts 'git bisect' from
> within 'subdir/', and 'git bisect' then checks out an old commit,
> where said 'subdir/' didn't exist?  What happens, if the user runs
> 'git bisect run ./script' from within 'subdir/', and that 'subdir/'
> doesn't exist in that old commit?  What happens, if 'subdir' does
> exists in that old commit, but it's a file, not a directory?  What
> happens, if all this is on Windows?

Hmm, I am of two minds.  Most certainly, the bisection would break
when the directory cannot be removed, and if it can be, then $pwd
would become in a weird state and the iteration with the bisect
machinery (be it interactive test before saying "bisect good/bad",
or the command execution during "bisect run") would fail in a
strange and unpredictable ways.

So from that perspective, it does make sense to forbid running "git
bisect" from a subdirectory, and we should probably do so on the
same principle for "git checkout", "git pull" and many other things.

But even then, it would not probably be foolproof.  Another process
that the end-user is not even aware of its execution (e.g. virus
scanners?) may have a file open in the subdirectory on a filesystem
that does not allow directories to be removed while there is an open
file descriptor on a file it contains, and would cause the command
to fail in a similar way.

So it probably is being too draconian to forbid these commands (not
just "git bisect") from being run in a subdirectory for no good
reason (i.e. being strict is not helping us much).  What would help
is to make sure we fail in an understandable way (i.e. "cannot
remove directory /foo/bar/boz, so checkout of version v1.2.3 failed"
is clearly conveyed to the end user, which we may be already doing
in which case that is wonderful).

>> and in the same disscusion "dscho"
>>     gave the directions and those directions lead me
>>     the fix of adding SUBDIRECTORY_OK=3DYes on L#34
>>     before sourcing git-sh-setup that made it work as
>>     in git-sh-setup there was a check on SUBDIRECTORY_OK
>>     that prevents it to run in sub directories if it is not
>>     set to "ok" as this file was also sourced in other commands
>>     that are required to only run from root one of such scripts
>>     is git-filter-branch
>
> Please don't indent the commit message and use punctuation to make it
> more readable.

This is a good point.
