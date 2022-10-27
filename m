Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924B5ECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiJ0R24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbiJ0R2z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:28:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10DE18D831
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:28:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so2235452pls.9
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KR9X8cROeNo4sAN1Z8+KKN55cDd7Z5jx9ZjFWA9PvZc=;
        b=PJfZvWKg/pF/ttJUqFhb+rrCG9zsoAQ2Gv1uKiKW2b1GjRwtLsT60yP6KAwnPor9I+
         P5cpoWJGhzPuuYgzuY9L/BuSjdPAVaCQ/ZoLj4jUYG84PBhUDK0O4L7Z5ztUeYmwWzPE
         xLKdxuLS6D2d4fG0qht6/jFV3IzPntfy2RZP0boRSYfJ7Uhvuo41UCm6rAfS6ZLKZLzH
         Np0lvimB8iL1e6/pH9Ncv121bwlLti/1Nh4O5rMnm+BGPu1P4BC2siYFi4YOS3+PicK1
         9yrT/A1Ia9t0A+8zvupqEk/CUiq3I2vHfgNyJrXzXM6Cl6Bs9IqjUabQph4VMQ54QhR1
         Kbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KR9X8cROeNo4sAN1Z8+KKN55cDd7Z5jx9ZjFWA9PvZc=;
        b=myjdYgC19tgPSmyiaIWhLV/B11FY+J/epnYSawwj7zUCzt2vJUrtjIhoh180ve8KC+
         yW/kLANSWNimhaNJn0y6qL4UcL7hKdNUaZaSQxfKdDQFFW5c8BLrqPYn1FfYsT5m3/ek
         GOk5Iw3cvOTNr1HRw5y5pHE1phF0zdcCZu25LQ9yNGv7PHNc4IM+ujdyPINmLDXFrJkK
         WomnMVz1koOULfFQB4xE4Y9hK5l6PqmDrMnRYOCaypnny2sNPkYk24KtZZcNmRwY6uxk
         RyvTNkBJvvhUDb76TxcM+dAX/++fmsOBszvl7NEAHWt82GeBjRdvckFKRMAOnaBRQXgb
         RejQ==
X-Gm-Message-State: ACrzQf0v7Z3Drfk2AI7U3P1EuMMTv8SKhByB4yhf2dwqDCnXfJBBqxM1
        fAcC9utrbdzwtP+0XtC1Gyo=
X-Google-Smtp-Source: AMsMyM6E97KV0fwgEJMEUShQzJLv0Ppq0eOn6wTmD/Vuv33pitU6XfcxgzqOJNAU8pCu8RibkORFsQ==
X-Received: by 2002:a17:903:1d1:b0:17f:6494:f8c3 with SMTP id e17-20020a17090301d100b0017f6494f8c3mr50015563plh.157.1666891734231;
        Thu, 27 Oct 2022 10:28:54 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090a318a00b002130ad34d24sm2967098pjb.4.2022.10.27.10.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 10:28:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Angelo Borsotti <angelo.borsotti@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Subject: Re: Git add documentation error
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
        <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email>
        <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
        <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email>
        <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
Date:   Thu, 27 Oct 2022 10:28:52 -0700
In-Reply-To: <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
        (Angelo Borsotti's message of "Thu, 27 Oct 2022 18:57:21 +0200")
Message-ID: <xmqqo7txmazv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Then I displayed the contents of both commits, and seen that it is pretty much
> the same:
>
> D:\gittest>git show --pretty="" --name-only 91ef45d
> C2.java
>
> D:\gittest>git show --pretty="" --name-only 8ec0c2f
> C2.java

You did not display the contents of these commits, though.  For each
of these commits, you checked the _difference_ between it and its
parent.

In the previous sequence

>> > I have tested this in the following way: I have two files: C1.java and C2.java
>> >
>> >     > git status
>> >     On branch master
>> >     nothing added to commit
>> >     > ... edit C2.java
>> >     > git status
>> >     On branch master
>> >     Changes not staged for commit:
>> >     (use "git add <file>..." to update what will be committed)
>> >     (use "git restore <file>..." to discard changes in working directory)
>> >         modified:   C2.java
>> >      > git add C1.java
>> >      > git add C2.java
>> >      > git commit -m "commit2"
>> >      D:\gittest>git commit -m "commit1"
>> >      [master 91ef45d] commit1
>> >      1 file changed, 1 insertion(+), 1 deletion(-)

91ef45d, relative to its parent (i.e. the previous state before the
commit was made), C2.java was modified.  C1.java was not.

So, what you saw

> D:\gittest>git show --pretty="" --name-only 91ef45d
> C2.java

is very much consistent with what you did.  And the above does not
mean 91ef45d does not have C1.java.  If you want to "display" the
contents of commit 91ef45d, you could

	$ git ls-tree -r --name-only 91ef45d

which lists all the contents in commit 91ef45d

or

	$ git diff --name-only $(git hash-object --stdin -t tree </dev/null) 91ef45d

which compares all the contents in commit 91ef45d with a completely
empty tree.

In them, you'd see both C1 and C2, among other things that you did
not modify in 91ef45d.
