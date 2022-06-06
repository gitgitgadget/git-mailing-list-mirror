Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05727C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiFFRKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFFRJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:09:23 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9285D316
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:57:21 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a127-20020a621a85000000b0051bc393dcb4so6693327pfa.6
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=JDkXATLcG7tN0t/e4abovwCMpo1vKcysMLSc2Or5G2A=;
        b=iAiJ03A9F7AMVJsGwSLvM43oPhACPTadOMq7TO1efwHaDqtII8iV4bgahqhwxNdMjP
         fpsvbOvDiaCDZtT32fF8pUdXoLAcBcobjTsEAeWOBU8ycnR67k9jGztdmq39CuFlbYD4
         A3YBcT9gHfoWkljPS/8ncVZfXv7XFs4Ot6ZHvJUiFFdX+s+591U/icPy4BgYG/i2jlRL
         DAF8QRwtH5S8vZGdkmmUhrWNAvRInp5oijjbdzzS3DQnUNffky9BjGK/VXe8QF60FLs4
         cONE4xg8TVRoUOPZDXQYEq0MylOtshBPnzIJcXT875XUw4Q62CqvdpcEfqC1ZJBx6aXI
         P+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=JDkXATLcG7tN0t/e4abovwCMpo1vKcysMLSc2Or5G2A=;
        b=zo1d4k4X+9NMKmLh8UmuBLrTV5CtsoIFKjb+o39shqN+Y3Xccq3QJ30LtSxEMUTjXd
         NfZG/OHgKrrGwIWczw1vFNRbeiVN1R90ONjQd1uOJtqttZvLz/UPIIqDRu8VuGA1D0Yn
         4hE7KZtLSHMhj1GG//KbRvcBwDcgjeFZ0Ll0GVumW13g02mr+eXjs9uAyyIgrOOT/KKU
         FVUe5Rn1i5mIbuYRdb+t2nDhR2YuUpGZWBSvV25eY2MqZXqaJryzAVFX7c73Fcwkga23
         M01ho1Ay2CeFSQdacoekycU5xHijXPtkzm635yHkUU03n7Mq8WTl23D2lgYKeMX/PrLb
         xvlQ==
X-Gm-Message-State: AOAM530LfEccqCl2TXJB8jkvMVztiTFqsZVMUHQsROXT7hG6bpvnMS+p
        Ezm1+ZUJIgXQdYmjsYIYVhu912IzxYhP9A==
X-Google-Smtp-Source: ABdhPJybiEA84z0nKA5pUHt5cpF2hHNE5B7C1eSz+Ig0053KjJTCeX0mCuEPKwl/RUjjxWVZLJpwVfBZUbsUQQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ce07:b0:1e3:50eb:64d with SMTP id
 f7-20020a17090ace0700b001e350eb064dmr34622437pju.22.1654534640949; Mon, 06
 Jun 2022 09:57:20 -0700 (PDT)
Date:   Mon, 06 Jun 2022 09:57:18 -0700
In-Reply-To: <24022c08-ed58-8157-6036-6a4c6a49f195@web.de>
Message-Id: <kl6ly1y9d91t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <e308be58-a399-8e5c-36a8-96d3d58caff3@sprangle.com> <24022c08-ed58-8157-6036-6a4c6a49f195@web.de>
Subject: Re: git bug: Including a git repository in a directory
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Steven Jonn Edlefsen <steve@sprangle.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 06.06.22 um 07:43 schrieb Steven Jonn Edlefsen:
>> Git cannot commit/push a directory with a git repository in
>> a sub-directory.
>>
>> The sub-directory with the git repository and the directories below
>> are set to the =E2=80=9Cmaster=E2=80=9D branch, while the directories ab=
ove remain
>> set to the new branch.
>>
>> When the top directory is committed, the sub-directory with the
>> git repository appears as an empty file.
>>
>> Even when the subdirectory branch name is changed from master
>> to the new branch and the top directory is re-commited/pushed,
>> the same problem occurs.
>>
>> When the git repository in the sub-directory is removed, e.g.
>> the .git file is removed, and top directory is committed/pushed,
>> the subdirectory has all the sub-directories and files.
>
> This is intended behavior.  A repository inside another one needs
> special handling.  Git provides the submodule feature for that.  A
> simpler alternative for some use cases is called subtree.

As Ren=C3=A9 described, this is intended behavior - repositories cannot
contain entire repositories with `.git` inside them [1]. As far as I
know, this is security feature because `.git` can contain sensitive
files that you wouldn't want to clone down, e.g. .git/config can make
"git" execute arbitrary code.

What happened in your case is that Git noticed that the subdirectory is
a repository and automatically 'sanitizes' it for you by converting it
into (what is essentially) a submodule [2]. When a subdirectory is a
submodule, Git stores a single commit id for the entire subdirectory -
you you can no longer change individual files inside the subdirectory.

To demonstrate this "single commit id" behavior, this is what happens if
you tried to `git init` a subdirectory in an existing project:

  $ git init foo
  Initialized empty Git repository in /Users/chooglen/Code/repo/foo/.git/
  $ git add foo
  error: 'foo/' does not have a commit checked out

Notice the line above! We can't add `foo` because it has been converted
into a (pseudo) submodule [2].

  $ (cd foo && git commit -m "foo" --allow-empty) # create a commit
  [main (root-commit) 9e27581] foo
  $ git add foo
  warning: adding embedded git repository: foo
  hint: You've added another git repository inside your current repository.
  hint: Clones of the outer repository will not contain the contents of
  hint: the embedded repository and will not know how to obtain it.
  hint: If you meant to add a submodule, use:
  hint:
  hint:   git submodule add <url> foo
  hint:
  hint: If you added this path by mistake, you can remove it from the
  hint: index with:
  hint:
  hint:   git rm --cached foo
  hint:
  hint: See "git help submodule" for more information.
  $ git diff HEAD=20
  diff --git a/foo b/foo
  new file mode 160000
  index 0000000..9e27581
  --- /dev/null
  +++ b/foo
  @@ -0,0 +1 @@
  +Subproject commit 9e27581b9eb91c0f1699eb18a2e81d758de9209d

Now that there is a commit in the subdirectory repository we can `git
add` it, but only as an entire commit. We cannot just add individual
files.

If you truly need a repository inside of another repository. You may
want to consider submodules/subtrees as Ren=C3=A9 mentioned.

[1] A repository can contain a "bare" repository because a bare
repository does not have `.git`, but that isn`t relevant to the
discussion here.
[2] A submodule technically also has to have an entry in the .gitmodules
file.
