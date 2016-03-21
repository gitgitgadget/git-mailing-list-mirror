From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Fixing segmentation fault when merging FETCH_HEAD
Date: Mon, 21 Mar 2016 02:40:00 -0400
Message-ID: <CAPig+cTGvYLP98NyPJpOY=kMML=ieTikotZvYowhxzZwWdU0_Q@mail.gmail.com>
References: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
	<1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
X-From: git-owner@vger.kernel.org Mon Mar 21 07:40:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahtVc-0005xs-My
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 07:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbcCUGkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 02:40:02 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35094 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcCUGkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 02:40:01 -0400
Received: by mail-vk0-f43.google.com with SMTP id e6so204479820vkh.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CR+wmNioPIIRG4+TJUJZEttJEnM+caSXoJuKhzyg4Hs=;
        b=I4UG/O9wcx4Kikpuyu0hVH/vLW+kqZP1U6kLUiO1Hi17U67LUhhEDlCMwfU+Xavd0p
         6UV1F4UyRoAkj3nMGHDiQ1x/I5HxlY3XyS/3pO/nNqiEw3Za5Uq1DfFeu69W3K+OtTEZ
         t+gjuJHmZz5xNsJr0WCmhFznHVoIqZPZszF2yLbPWLY7uATsvhPpvTW77vTI9OEU1Nud
         trcrCO2d7FJpXk6dpyZTOp6FIGWqhraPrhVrbRz2mnTCVwEj3PixQ6XYN3HuTLAj0MN+
         7cY1jIjDK+QuEXNWM9llf2dEJgGvzHZtfgPIDLoDHWlew2iYRApCgukKZU8TWUezqR8z
         CLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CR+wmNioPIIRG4+TJUJZEttJEnM+caSXoJuKhzyg4Hs=;
        b=EzLAlc3tzXh8WGauvY3xCiwDtwL2KtKnTnazznzf+VRcXNxVQm+i42Ml8oAvQKhUam
         iyLtMZ/dHKF4mgBCf9Le2p3oUIid8UtD5+s3Cjy6CMl/0RATLFeB1JueZVHYzQZ9gfH4
         MWWeOlBxiFUfuoVqrvLzilR6PDkSy0P9W/Cff9OTTG55qBNxWGeBRmRXne6oiyWKfbXe
         Cwf6RwRC0TqWC9FQbkGRwRM4jAEj7b3gZ9PDMRIPMqkU3FLtqYhU+M8r5/Rp3ByZAV10
         kk6JsxOj8BPmmbT7exUeGnCWOuwvI3aN1CQK24AlWdc3Qg3Los4ek8rkaons8DCRvea5
         g3ZQ==
X-Gm-Message-State: AD7BkJL3MuNnE1OfBqcS1hL/lHVKGU71OSoFrwEzxj4YpWpSy1evNcFzwRQ4rro+rAsFZZ5VlvdsZm79488RhQ==
X-Received: by 10.31.146.5 with SMTP id u5mr21814970vkd.19.1458542400187; Sun,
 20 Mar 2016 23:40:00 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 20 Mar 2016 23:40:00 -0700 (PDT)
In-Reply-To: <1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br>
X-Google-Sender-Auth: GOtnQguVgGUC9-nfQY4DDMWJu3E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289405>

On Sun, Mar 20, 2016 at 8:11 PM, Jose Ivan B. Vilarouca Filho
<joseivan@lavid.ufpb.br> wrote:
> Hello, Eric.
>
> Thanks for suggestions. I've added a test in commit replacing git fetch origin by a fake FETCH_HEAD content.

Thanks for the re-roll. To be "git am"-friendly, you should either
place a "-- >8 --" scissor line after the above commentary, or use
"git send-email" to send the patch, and place the commentary just
below the "---" line following your sign-off.

More below...

> merge: don't dereference NULL pointer
>
> A segmentaion fault is raised when trying to merge FETCH_HEAD
> formed only by "not-for-merge" refs.
>
> Ex:
>     git init .
>     git remote add origin ...
>     git fetch origin
>     git merge FETCH_HEAD
>
> Signed-off-by: Jose Ivan B. Vilarouca Filho <joseivan@lavid.ufpb.br>
> ---
> diff --git a/test-merge-fetchhead.sh b/test-merge-fetchhead.sh

As you're new around here, I probably should have been more specific
in my previous review and explained that you'd want your new test to
be incorporated into the existing test suite so that it actually gets
exercised regularly. A good place for the new test might be at the
bottom of t/t7600-merge.sh.

Writing a new test is pretty simple, especially when you already have
a recipe for reproduction. Take a look at existing tests in that file
to get a feel for how it should be done. Rather than all the "|| exit
1"'s, chain your test statements together with &&. And, because you'll
be incorporating the new test into an existing script, you can drop a
lot of the boilerplate below and just focus on the recipe.

Some style comments below (most of which won't matter after you drop
the boilerplate but are generally good to know)...

> @@ -0,0 +1,23 @@
> +#!/bin/bash
> +GIT=$(pwd)/git
> +REPO_DIR=./test-fetch-head-repo
> +
> +if [ ! -x "${GIT}" ]; then

Use 'test' rather than '['. Drop the semicolon. Place 'then' on its own line.

> +    echo "Missing git binary"
> +    exit 1
> +fi
> +
> +${GIT} init ${REPO_DIR} || rm -rf ${REPO_DIR} || exit 1
> +pushd ${REPO_DIR} || rm -rf ${REPO_DIR} || exit 1

In test scripts you need to take extra care when switching directories
since failure of a command following 'pushd' will prevent the
subsequent 'popd' from executing, and then tests later in the script
will be invoked in the wrong directory. The typical way of dealing
with this is to use a subhsell since 'cd' within a subshell doesn't
affect the parent, and the parent continues at its own working
directory when the subshell exits. For example:

    some-command &&
    (
        cd somewhere &&
        command-which-might-fail &&
        another-possible-failure
    )

> +#Let's fake a FETCH_HEAD only formed by not-for-merge (git fetch origin)
> +echo -ne "f954fc9919c9ec33179e11aa1af562384677e174\tnot-for-merge\tbranch 'master' of https://github.com/git/git.git" > .git/FETCH_HEAD

Non-portable 'echo' options. Use 'printf' instead. And, you'll need to
take extra care with the single-quotes since the test body itself will
be within single-quotes.

> +${GIT} merge FETCH_HEAD
> +GRET=$?
> +popd
> +if [ ${GRET} -eq 139 ]; then

So, both before and after this patch, this git-merge fails, and you
want the test to detect that it's failing in a controlled way (via
die()) rather than the previous uncontrolled way (via segfault). You
could use test_expect_code() for this (from t/test-lib-functions.sh),
or you could capture stderr and verify that it has the expected
failure message from die(). The latter is probably preferable, and may
look something like this:

test_expect_success 'my test title' '
    ...setup stuff... &&
    test_must_fail git merge FETCH_HEAD 2>err &&
    test_i18ngrep "not something we can merge" err
'

> +    rm -rf ${REPO_DIR}
> +    exit 1
> +fi
> +
> +rm -rf ${REPO_DIR}
> +exit 0

You typically don't need to cleanup after your test, so this
boilerplate can go away.
