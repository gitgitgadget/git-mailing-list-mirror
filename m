From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Subject: [PATCH] git am: Transform and skip patches via new hook
Date: Tue, 7 Jul 2015 12:32:52 -0400
Message-ID: <CAPig+cQy-KHAaK_byw2nMM-S8cNosTpOiyejkHzAL6VavncaOw@mail.gmail.com>
References: <CAJ3HoZ2YdAFVt1-4dTk04=0cLTUxQocJPNSVupr09Ee01tGCAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Robert Collins <robertc@robertcollins.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 18:33:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVo4-0000zF-RR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989AbbGGQdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:33:11 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33514 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214AbbGGQcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:32:53 -0400
Received: by ykeo3 with SMTP id o3so62237652yke.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=sjLZX+NDJfpS/ETpRjmaWc/bgwEPB/3EKPXFKl7evx8=;
        b=rnMAxB7+tTcNEiSdqHU0lzjFbRDvDvMF1mw0/f397VweuUyF9hjNyedsMJZTKirB5H
         AZdMmwPlo2Z0mYNCrZ+0oEyVY/vsIvFpqqEzzBP9fgNMujI28R75H8u3Zwf9IDcNA7bf
         Yzh6WzovLsQ9HLXkB7xvaHNsoeBgNZxP3nWDmTl5SASkHNF3CwDkvhPcsm0n0aRKWBL2
         dRJGT532rNwk67dF6NZHdJQzTeFpEuJpfI+NcLeFfiJV7Zge1A1x4ZABh+rZNDyCnKWj
         1Yl3RGTrqAWaMCcrm4xrMXES6KdryYvrbR7yGHZ1AjoiaKrInFJDudPEhVMRmN3jo466
         HhDg==
X-Received: by 10.170.233.10 with SMTP id z10mr5781075ykf.71.1436286772494;
 Tue, 07 Jul 2015 09:32:52 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 09:32:52 -0700 (PDT)
In-Reply-To: <CAJ3HoZ2YdAFVt1-4dTk04=0cLTUxQocJPNSVupr09Ee01tGCAQ@mail.gmail.com>
X-Google-Sender-Auth: NPChRjYzlVgdQOJH8ep8gNbsFag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273587>

On Tue, Jul 7, 2015 at 3:52 AM, Robert Collins
<robertc@robertcollins.net> wrote:
> From 0428b0a1248fb84c584a5a6c1f110770c6615d5e Mon Sep 17 00:00:00 2001
> From: Robert Collins <rbtcollins@hp.com>
> Date: Tue, 7 Jul 2015 15:43:24 +1200
> Subject: [PATCH] git am: Transform and skip patches via new hook

Drop the "From sha1", "Date:", and "Subject:" headers. "From sha1" is
meaningful only in your repository, thus not useful here, and git-am
will pluck the other information directly from your email, so they are
redundant. The "From:" header, however, should be kept since it
differs from your sending email address.

> A thing I need to do quite a lot of is extracting stuff from
> Python to backported libraries. This involves changing nearly
> every patch but its automatable.
>
> Using a new hook (applypatch-transform) was sufficient to meet all my
> needs and should be acceptable upstream as far as I can tell.

For a commit message, you want to explain the problem you're solving,
in what way the the current implementation is lacking, and justify why
your solution is desirable (possibly citing alternate approaches you
discarded). Unfortunately, the above paragraphs don't really tell us
much about why applypatch-tranforms is needed or how it solves a
problem which can't be solved with some other existing mechanism. You
do mention that it satisfies your "needs", but we don't know
specifically what those are.

The above paragraphs might be perfectly suitable as additional
commentary to supplement the commit messages, however, such commentary
should be placed below the "---" line under your sign-off and above
the diffstat.

> Signed-Off-By: Robert Collins <rbtcollins@hp.com>

This is typically written "Signed-off-by:".

More below.

> ---
>  Documentation/git-am.txt                     |  6 ++---
>  Documentation/githooks.txt                   | 15 ++++++++++++
>  git-am.sh                                    | 15 ++++++++++++
>  templates/hooks--applypatch-transform.sample | 36 ++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+), 3 deletions(-)
>  create mode 100755 templates/hooks--applypatch-transform.sample
>
> diff --git a/git-am.sh b/git-am.sh
> index 8733071..796efea 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -869,6 +869,21 @@ To restore the original branch and stop patching
> run \"\$cmdline --abort\"."
>
>   case "$resolved" in
>   '')
> + # Attempt to rewrite the patch.
> + hook="$(git rev-parse --git-path hooks/applypatch-transform)"
> + if test -x "$hook"
> + then
> + "$hook" "$dotest/patch" "$dotest/final-commit"
> + status="$?"
> + if test $status -eq 1
> + then
> + go_next
> + elif test $status -ne 0
> + then
> + stop_here $this
> + fi
> + fi

This indentation looks botched, as if the patch was pasted into your
email client and the client mangled the whitespace. git-send-email may
be of use here.

> diff --git a/templates/hooks--applypatch-transform.sample
> b/templates/hooks--applypatch-transform.sample
> new file mode 100755
> index 0000000..97cd789
> --- /dev/null
> +++ b/templates/hooks--applypatch-transform.sample
> @@ -0,0 +1,36 @@
> +#!/bin/sh
> +#
> +# An example hook script to transform a patch taken from an email
> +# by git am.
> +#
> +# The hook should exit with non-zero status after issuing an
> +# appropriate message if it wants to stop the commit.  The hook is
> +# allowed to edit the patch file.
> +#
> +# To enable this hook, rename this file to "applypatch-transform".
> +#
> +# This example changes the path of Lib/unittest/mock.py to mock.py
> +# Lib/unittest/tests/testmock to tests and Misc/NEWS to NEWS, and
> +# finally skips any patches that did not alter mock.py or its tests.

It's not clear even from this example what applypatch-transform buys
you over simply running your patches through some transformation and
filtering script *before* feeding them to git-am. The answer to that
question is the sort of thing which should be in the commit message to
justify the patch.

> +set -eux
> +
> +patch_path=$1
> +
> +# Pull out mock.py
> +filterdiff --clean --strip 3 --addprefix=a/ -i
> 'a/Lib/unittest/mock.py' $patch_path > $patch_path.mock
> +# And the tests
> +filterdiff --clean --strip 5 --addprefix=a/tests/ -i
> 'a/Lib/unittest/test/testmock/' $patch_path > $patch_path.tests
> +# Lastly we want to pick up any NEWS entries.
> +filterdiff --strip 2 --addprefix=a/ -i a/Misc/NEWS $patch_path >
> $patch_path.NEWS
> +cat $patch_path.mock $patch_path.tests > $patch_path
> +filtered=$(cat $patch_path)
> +if [ -n "${filtered}" ]; then
> +  cat $patch_path.NEWS >> $patch_path
> +  exitcode=0
> +else
> +  exitcode=1
> +fi
> +
> +rm $patch_path.mock $patch_path.tests $patch_path.NEWS
> +exit $exitcode
> --
> 2.1.0
