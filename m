Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D56C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615AC61248
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 13:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhJDN4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhJDN40 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB16DC061753
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 06:45:32 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so11125993plh.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aez3N+OTuuAnxAsXVLCTbOQgXNm7zjoOtBzb2YSF62Q=;
        b=DKg1Tt+ZAZdQmq/V3U/e+dlesrOuYRt7WkIE5gqZzO0wFoEw+jHC14xsz+ln+XqTPq
         wm8QervOgvJiS+BSrC4NIxbeV0OmP43FL0eAvZnyiDxc4lYYdPEARMcv/viTZ8qSgFtX
         UD2GHbO2pqwC+KsJvJ1wfTTFponEKEoKE/BVHbzqZ+K90F8WU9LKfohEn0RLDFRoIx3y
         k0inYlpce624+d+VJ6+NUe3QeGH5YWIU0uH5r6mM6N6YJMLi0XamYSqq7AJaBw/9qWJ7
         6ekzUVK1svV62RhqgZ4W8x6ZeVrTNI3lHD0dYje7Ag7MepUJr4rA/K/t+lYIqZKXywqH
         W88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aez3N+OTuuAnxAsXVLCTbOQgXNm7zjoOtBzb2YSF62Q=;
        b=oqJQj3S23dISjJ0LpRU5pgJa7o1sl/rMp7HnD2jA+18MEqU8LVXVBW2fvisYbGLgnN
         QMGhA2YpzJPCPD2dtdBnq/eV1OkhAUaEagVqide2RsQs53kgbSgtft+XSi+b2pEu6+fi
         wKD1z83tjkZRF7vfLOE2xo69m3IcGKyiFG57IXc+BoBduNwDHdQJY560ujmZ3zH2Ceha
         Ftl21Rt7j3tN2dL7sqNPy+SnjsEXjY8Kcnb9Spna++o/ENwWHX6WM7OCHyqNygSYJab9
         kCmdpL6GUqzxig5maR3fxiB+jrFOBDaNLNzNh45/O68azvR0TfAOZKniPZsgSiDWtFtd
         Xz5g==
X-Gm-Message-State: AOAM533DEya7u859KRefJXKj2wsHGuOW+eLieNR1JpwdxmngYHJcw49n
        a4VXjMowC1hysSNMJgPbxEuoJxojfOpi2rGajJ4=
X-Google-Smtp-Source: ABdhPJySAHaZytJADR0xf5cuwIEG7IfMZzXiWkkYhG3XyCSwmh5t5jZ9uwJeygRyEzorlbkaYTkph1MUmbpUmp2J7ro=
X-Received: by 2002:a17:902:9687:b0:13d:b848:479d with SMTP id
 n7-20020a170902968700b0013db848479dmr24511604plp.59.1633355132141; Mon, 04
 Oct 2021 06:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
In-Reply-To: <YVOn3hDsb5pnxR53@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 06:45:00 -0700
Message-ID: <CABPp-BE4jXyPVAWo7h7fuVHDuatr+mw6CgcWQ1rF7oT0RPMqXg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 4:40 PM Jeff King <peff@peff.net> wrote:
>
> I just left a rather long-ish mail in the thread, but the gist of it is
> that I'm worried that there's some possibility of corruption there if
> the diff code writes objects. I didn't do a proof-of-concept there, but
> I worked one up just now. Try this:

Thanks for the testcase; it's very helpful.

Let's make it a little more interesting, though...

>
>   # make a repo
>   git init repo
>   cd repo
>   echo base >file
>   git add file
>   git commit -m base
>
>   # two diverging branches
>   echo main >file
>   git commit -am main
>   git checkout -b side HEAD^
>   echo side >file
>   git commit -am side
>
>   # we get a conflict, and we resolve
>   git merge main
>   echo resolved >file
>   git commit -am merged
>
>   # now imagine we had a file with a diff driver. I stuffed it
>   # in here after the fact, but it could have been here all along,
>   # or come as part of the merge, etc.
>   echo whatever >unrelated
>   echo "unrelated diff=foo" >.gitattributes

If we change this line to:

  echo "file diff=foo" >.gitattributes

Then the userdiff will fire on the file involved in the remerge-diff,
including on the file included in the automatic 3-way content
conflict, giving us a diff that looks like this:

diff --git a/file b/file
index 5c66bc5..2ab19ae 100644
--- a/file
+++ b/file
@@ -1,7 +1 @@
-<<<<<<< 7D4147C (SIDE)
-SIDE
-||||||| BE54C04
-BASE
-=======
-MAIN
->>>>>>> 03FC4E3 (MAIN)
+RESOLVED

>   git add .
>   git commit --amend --no-edit
>
>   # set up the diff driver not just to do a textconv, but to cache the
>   # result. This will require writing out new objects for the cache
>   # as part of the diff operation.
>   git config diff.foo.textconv "$PWD/upcase"
>   git config diff.foo.cachetextconv true
>   cat >upcase <<\EOF &&
>   #!/bin/sh
>   tr a-z A-Z <$1
>   EOF
>   chmod +x upcase
>
>   # now show the diff
>   git log -1 --remerge-diff
>
>   # and make sure the repo is still OK
>   git fsck
>
> The remerge diff will correctly show the textconv'd content (because
> it's not in either parent, and hence an evil merge):
>
>   diff --git a/unrelated b/unrelated
>   new file mode 100644
>   index 0000000..982793c
>   --- /dev/null
>   +++ b/unrelated
>   @@ -0,0 +1 @@
>   +WHATEVER
>
> but then fsck shows that our cache is corrupted:
>
>   Checking object directories: 100% (256/256), done.
>   error: refs/notes/textconv/foo: invalid sha1 pointer 1e9b3ecffca73411001043fe914a7ec0e7291043
>   error: refs/notes/textconv/foo: invalid reflog entry 1e9b3ecffca73411001043fe914a7ec0e7291043
>   dangling tree 569b6e414203d2f50bdaafc1585eae11e28afc37


> Now I'll admit the textconv-cache is a pretty seldom-used feature. And
> that there _probably_ aren't a lot of other ways that the diff code
> would try to write objects or references. But I think it speaks to the
> kind of subtle interactions we should worry about (and certainly
> corrupting the repository is a pretty bad outcome, though at least in
> this case it's "just" a cache and we could blow away that ref manually).


I implemented the pretend_object_file() solution on Saturday and tried
this out, and found with the above change that it has corruption
problems as well.  This really doesn't feel much safer too me.

The move-the-tmp-objdir-to-just-being-an-alternate-instead-of-a-primary
solution, as suggested at
https://lore.kernel.org/git/YVOiggCWAdZcxAb6@coredump.intra.peff.net/
has the same problem.

But, more importantly, neither of these solutions can be made safe.
Even if we adopt the GIT_QUARANTINE_PATH suggestion from Neeraj
(https://lore.kernel.org/git/20210929184339.GA19712@neerajsi-x1.localdomain/),
we still have objects referencing now-missing objects.

*However*, if we use the tmp-objdir-as-primary solution, and leave it
as a primary, and use your modification to the GIT_QUARANTINE_PATH
idea from Neeraj (i.e. create a "the-tmp-objdir" and have the refs
code check for it and turn on the quarantine automatically when one
exists), then we prevent adding or modifying refs to point to bad
objects, and any new objects that textconv might write that could
depend on transient objects, will themselves be transient and go away.
So, this solution is safe from corruption.  I'll be implementing it.

(not sure how quickly I'll get it done, as my time is mostly limited
to early mornings or evenings or Saturdays right now...)
