Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928FAC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3300664E79
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 04:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhBXEZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhBXEZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 23:25:16 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D7C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:24:35 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id x23so214109oop.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 20:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VRk/HQgxJn0TG4LvE2FRm4XOdJYB+WbHP51hubmxymM=;
        b=XJm6kH0WFjOYBIB/4tnrAuITqbABsr9H5K+DUZzXRj+2QvmupDyDJvzRUKhjpc6Oct
         otTCBX7Y2kAJ/6HbNu2FSdhT+LhoXME5a/FwI3Z8se3j1oeYCluibv+arWFKDdaaMTWU
         R/wMbwvCdQcwHciSSTCQ3NvilKaDPsoqdrMOBUcxeL0NuGtob5w0F/TpHGdj+tpMtFLu
         yGjlBWz7TEGK9EsnZL/Sc4PJ0Sw3W/9Ou7+P+qOlPhz7aHjIXJ4+Oy+MTT7hqaBBf+zu
         sGaGHmjk7MKOR77JTp64dxKFSJcjnpowqbgHtJO2yD9iRBftisBqvBVK06AYKoMYvSLa
         /ZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRk/HQgxJn0TG4LvE2FRm4XOdJYB+WbHP51hubmxymM=;
        b=TuimNRBf9EcbmoNMxUPoSPMJlM7r2wU484RPC6W09V3PunSrYtNx1IIiV/x3YXc6BC
         C4fDWCIgXdoKfnjp75a3qbCJl41Vy9NMTNFRYIz5p9lOIu+y3Z/UViQDXJCwjZf5T87l
         n2JLyZiICkhAY6e/SMicT2KxaCj6Y50n9hGaD/VETJLfxNq4tTvmlk8NRGNjUOexUCy9
         6oRklMXyAAuCgu+uyBg12FFFoe4KGkcmopapxfVXFG+31qsUCjb7mTA1QQaqWcvAJtyP
         mPNowgzFp37xojX87GhwYBzpMz0NAXQZlv9Qdg+1kar7uT8qEmNAkJZLMjvB3ExiYlgi
         IiHw==
X-Gm-Message-State: AOAM530T4W03PeUpQHJo/jMrQCwx2sJMoQEwX+G+8AQd8rKqz4usQ28X
        GoQigMa8CBj8M1K08ApUw/EIMBWKdDLdSzIv8cpRpLeWVrQ=
X-Google-Smtp-Source: ABdhPJxiwodGV1JNuoR3qLo/gY1V+SaznM4dAnFNcwZW0QssKeFVIACPppc3o5KKlw/R8PGLiPl2opKJx7xiuoOUa5U=
X-Received: by 2002:a4a:9d0e:: with SMTP id w14mr22147687ooj.7.1614140675131;
 Tue, 23 Feb 2021 20:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20210222211621.0C5D.409509F4@e16-tech.com> <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
In-Reply-To: <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 20:24:24 -0800
Message-ID: <CABPp-BFa3CnOHMg4t99xMHWif8kMZJFcmHtLSNxZgAPaw1Cd=Q@mail.gmail.com>
Subject: Re: git format-patch lost the last part when branch merge
To:     Jeff King <peff@peff.net>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 3:03 PM Jeff King <peff@peff.net> wrote:
[...snip...]
>
> There are lots of ways to look at the diff of a merge. By default, `git
> show` will show a combined diff, which omits hunks where one side was
> taken verbatim, but otherwise shows what each side did.
>
> The diff shown in the link above is a diff against the first-parent
> (which you can also get locally with `git show --first-parent 582cd91`).
> One _could_ apply that diff onto the first parent to achieve the same
> tree as the merge plus all of the commits that got merged in. But it
> wouldn't make any sense to apply that (aside from conflict resolution,
> it would be redundant with all of the commits that format-patch just
> output!).
>
> You could imagine ways for format-patch to represent the conflict
> resolution done in a merge, but it's not quite trivial, and nobody has
> done it yet.

Are you referring to something like this (in the git.git repository)?

$ git show --oneline --remerge-diff 42342b3ee6
42342b3ee6 Merge branch 'ab/mailmap'
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1bce961e07..6fb18a34b0 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -257,16 +257,8 @@ test_expect_success 'No mailmap files, but configured' '

 test_expect_success 'setup mailmap blob tests' '
        git checkout -b map &&
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 60ecad090d (Merge branch 'ps/fetch-atomic')
        test_when_finished "git checkout main" &&
-       cat >just-bugs <<- EOF &&
-|||||||||||||||||||||||||||||||| 72c4083ddf
-       test_when_finished "git checkout master" &&
-       cat >just-bugs <<- EOF &&
-================================
-       test_when_finished "git checkout master" &&
        cat >just-bugs <<-\EOF &&
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 4e168333a8 (shortlog: remove
unused(?) "repo-abbrev" feature)
        Blob Guy <bugs@company.xx>
        EOF
        cat >both <<-EOF &&


I agree that representing the conflict done in a merge is more
difficult than it sounds, but if you mean what I think you mean then I
disagree with the "nobody has done it yet" half of your statement.
:-)

That said, I haven't attempted to tie this into format-patch in any
way, and have absolutely no plans to.  (And --remerge-diff hasn't been
submitted upstream, because it depends on ort, and that still needs
reviews...)
