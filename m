Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1DEC433EF
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347299AbiDBV5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 17:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348545AbiDBV5l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 17:57:41 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF813CCA
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1648936539;
        bh=rNB1oiyzlcuNdPcwlWbLRKSQ+fOglfHYwXyYZtEl8Js=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:In-Reply-To;
        b=QXgQIFB3jQKkey2v9PmWnl0Nn+i/jpLdd6i80lidzKe1I9MERI1kP6jTU032km8lr
         +MAJfE1sdUZZlNGhVWScOt0pFIrhfuDt/ebDQwMmJ3IyQHmxpih9EjqWgmhkd6jclp
         2Lb9QCjC/ylpV2xuBz5rbkYxBUcYGQO96EVofmLE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzCEB-1nxP0C36WJ-00w7OW; Sat, 02
 Apr 2022 23:55:39 +0200
Message-ID: <d650bb90-df94-eeab-0684-ee447e080ad6@web.de>
Date:   Sat, 2 Apr 2022 23:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: Git has two ways to count modified lines
Content-Language: en-US
To:     Laurent Lyaudet <laurent.lyaudet@gmail.com>, git@vger.kernel.org
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
 <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Eckhard_S=2e_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>
In-Reply-To: <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9QpmI4zv06AMB6c4GcbcV6EDFjAqrHhNey4+dP2Bs/FpA0iDCHs
 DTTGknLfdMCktJTC7AwrMbSZVDEEX1HzSw0LblKrZCH2I8mk+IAM/ObWRDwQ49Bgn6reL5d
 7jb4YMAcbp16SS2kx90o9M77Lhn+9lvAaMk4sLm14zc+kPA8VzNa/xwAKWkCU1NjkwaClT6
 E0UA+hRWxhU5NST1DtCiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4M+4o3ATptg=:jahDA8gsVTzmydc0lV7gIc
 59cACKUZcqdQgOabJ9dqMPqZXnAtg5K+hV+QbuY8Rzliov2RhBeZXw0M1mLoW41uX/3nI826e
 O8CdQB0eC0ntyRd/H5fUyBLjhjj2zNNkgEXuzqde8Xqx0B7i7W/q1ABBb13n59pUvppJe3wYZ
 iC9NDkZbjP84YqIKbZcUjAaegHT2bkNaCNW7Hn7AnCA8vU7o3U2RwqH7jNXXxthTuHt9D/z1V
 EGYmMs9qIeMbtRWEnqTj7Bugh698znpBOHkQ+P45tgI2h8nMJTECrbIOC1w2tlLf1491r0+sp
 SH51OsLuboayBNByVG8hZoT0Q1uXm3jpKz+btbi7YhSYoQVUO6TttmkTUxhKb1LfXJE1zF/wN
 AnAFsY1bguINqTs9OfiakLlc02dIkZaRaG8k8v7CMEzkrEJ/vz3YTAlghTMhVS+WIU+KUqpQA
 nEz7eImTf2iA+OktxTJNKjTPfFT++bnCIMlnVimdLE/WQaMblL0B76AHqMLzlFyHlqp/hRf5a
 NMVSAyUUsrTQpHi2HK6LtTErw2B+fTs5LQw2TzbUXdMUK89mh/ZMQvTbMxxWTB+nYAblX6fv5
 yT6aTHYe6cJt9RoHaVCOvn6GhpYb9SMpB6sDvd5KTPJFxJAbs6WvgD4Ur7PrsydpFO29lnw6r
 4paS6fuXpi3xTFqHd+xcRHvgg4vEUeudn8j8eLX399+B+Ww4fcVNzIrk8nsSBAPW5luHM5VuE
 NkBHYG1wiU7E0BWhK2IzGquhbDzxRkAy9t59tq693Omtk3GXi5Si2IYnN+7ingHpp/oyI6KfN
 I174d4eVQVVqw41tL8GMczLcFz4kOFL/IYC2ZZGrd88x3R+TeAJIh7LbLxUELHPYWEFSaE5X6
 fT+Z4/ERDQvX6HZIvDxoFlsOYAAduyCsQZeDNKjy9seX6/8DgbTqBtZrIiOIQUn5qyVl9UHsA
 /4NCcxnvCKcqYSyDedaWEMM1kcz7wK0fFG7NW0CoROQ/gDdmGCjVF0FbmMcrcHI+ZUVRryVUF
 y7oqnytLSFNVLwrwNudI6XSvsnP2+FnhpmG+buy3cGLYQPL4mYRRibBjvbolNAWR3A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.04.22 um 18:49 schrieb Laurent Lyaudet:
> Le mer. 16 mars 2022 =C3=A0 19:08, Laurent Lyaudet
> <laurent.lyaudet@gmail.com> a =C3=A9crit :
>>
> I thought my email was sent to the right mailbox, at least it is what
> says this website :
> https://git-scm.com/community

Sure it was.

>> General questions or comments for the Git community can be sent to
>> the mailing list by using the email address git@vger.kernel.org.
> Moreover this website is cited in the README here :
> https://github.com/git/git/blob/master/README.md
>> Many Git online resources are accessible from https://git-scm.com/
>> including full documentation and Git related tools.
> Is there any problem with my questions explaining I got no answer,
> please ?
Not really, don't worry.

> I have found a partial explanation for the count differences :
>>  2 files changed, 88 insertions(+), 48 deletions(-)
>>  rewrite src/apps/logs/components/PresenceList.js (61%)
> When committing, a file considered as "rewrite" is counted like m
> lines deleted and n lines added if it had m lines before and n lines
> after.
> Even if the diff is much smaller.

Git stores the file contents before and after your change.  It doesn't
store any diff, but calculates them as needed, e.g. for the commit
confirmation message, or when you run git diff.  So in that sense there
is no "the diff".  The difference between two stored states can be
represented in many ways.

> Hence I answered my question :
>> How can I check how it computed these numbers in the first place ?

The option --break-rewrites controls rewrite detection.  Check out its
description in the documentation of git diff to see how to use it.

> But the two other questions remains :
>> How comes git has two ways to count modified lines ?
> i.e. What is (was) the purpose of this rewrite counting (when coded) ?

Rewrite detection is meant to improve the diff of a file whose content
was replaced with something very different.  Instead of lots of hunks
containing lines that add and remove unrelated stuff, separated by empty
lines etc. that the diff algorithm matches between the sides even though
they are also unrelated, a rewrite diff removes all the old lines en
bloc and then adds all the new ones, which is easier to read in that
case.

>> How can I make git output again the same numbers than just after commit=
 ?

git show --stat --break-rewrites

But I have a question to the list as well: Why is break_opt (the
diff_options member for --break-rewrites) enabled for git commit by
default?  I ask because the last commit that mentioned it, dc6b1d92ca
(wt-status: use settings from git_diff_ui_config, 2018-05-04), claimed
it would turn it off, if I read it correctly.

Ren=C3=A9
