Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD712C433FE
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiAaV6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiAaV5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:57:20 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FBC061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:57:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s9so28080658wrb.6
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6zvbuwySX00nwoMUQCNgFt1hKwltJpM4dyxBXgEaENI=;
        b=Uubf1bo5BNdLR3XNNp0bARjqdeJZwpdJ7y/c/S5ud+UzR/lRn0P8QVqJJZ1PtaZhuF
         eZb1fPHzprSz5hAW8xl/uqwKWZavpGeWzQld3f6KJf7hm66qhMpfv+5iVPVLgkvdDVnk
         dGl2bbNO6/cpfRI7ELvtD0tOvve1B09i+H35F5HnVAzCEbgLpHGOGm+t5QWpaD8JmInh
         7Q8k4/qebS5WTuPwirMrPbiA+q8rQq06oy1f46IEOK0FRzyC2GxYKzXIY5GTVPEvzADh
         +8xh/r9WDzWgH1sxYaeRNP2tg0wV2qasjibSqziHPqEJC0iJu2poQlztqKx5mB34JUUO
         VhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6zvbuwySX00nwoMUQCNgFt1hKwltJpM4dyxBXgEaENI=;
        b=q9+MEoFKP6JXvdfG+xCdEaXJL5Ys7vIPHVxldIfHm9Ddmigo7GwRG8OUXN/so6Gm5c
         14SgM1LPYs3OJNyVHn8RZJaNRgYoQWypQvoRPTKPk+OmUx0j74ia+eHfD9fcs9QEKzWK
         n2nOfQMlLkJcUPf3w61yUSNnf1qkQSsOjHixmajagMGVKSps2E/NHP+132gh9EdCpUnc
         lAjVGcqfYb6vWfEiI8+99LmkdWEm6OBHp7GwrqPE8n9PocPwhMQps5O8vKgvKyUs/CIk
         X30y0TlLreO+N1y4SMNR4vEYSTns0qE2iaTmGN3VKQZ91sbHFOi+ts27q8O9TTqrb1Lh
         UWOw==
X-Gm-Message-State: AOAM5335bPX4WyhIKkg4FoeZcU52PsZEAjK4xtfKj5uivbQL1L9NZoP2
        NHFl3EyCr9xNr5t8ZkSc9LJJK6LrlhQ=
X-Google-Smtp-Source: ABdhPJyT8718R9d6bm2nPlJmPzWf33ZtmFfcuB95ZVKFVhEAFmUQScKql2XdtQQKTskNlusyRZ5P5g==
X-Received: by 2002:adf:f54d:: with SMTP id j13mr18580754wrp.596.1643666238661;
        Mon, 31 Jan 2022 13:57:18 -0800 (PST)
Received: from smtpclient.apple ([2a01:e34:ec41:7980:bd0f:43a4:6858:c6cb])
        by smtp.gmail.com with ESMTPSA id m5sm472201wms.4.2022.01.31.13.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 13:57:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Stage, test, and commit only some changes, then repeat
From:   =?utf-8?Q?G=C3=A9ry_Ogam?= <gery.ogam@gmail.com>
In-Reply-To: <8db0ee81-c66a-1888-6727-f5ab61cff60f@kdbg.org>
Date:   Mon, 31 Jan 2022 22:57:17 +0100
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <74E376B9-40D3-4F88-AC23-0FADECA69BB4@gmail.com>
References: <37128901-233F-4428-8A52-470773A18AB0@gmail.com>
 <8db0ee81-c66a-1888-6727-f5ab61cff60f@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Le 30 janv. 2022 =C3=A0 22:13, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit=
 :
>=20
> Am 30.01.22 um 21:17 schrieb G=C3=A9ry Ogam:
>> Hello,
>>=20
>> I would like to stage, test, and commit only *some* changes of the =
working tree, and then repeat this process with the remaining changes.
>>=20
>> My current solution (published at =
https://stackoverflow.com/a/70914962/2326961):
>>=20
>> 1. Stage some changes:
>>   ```
>>   git add -p file
>>   ```
>> 2. Save away the remaining changes:
>>   ```
>>   git diff >patch
>>   git stash push -k
>>   ```
>> 3. Test the staged changes.
>> 4. Commit the staged changes:
>>   ```
>>   git commit
>>   ```
>> 5. Restore the remaining changes:
>>   ```
>>   git apply patch
>>   ```
>> 6. Go to step 1.>
>> It is not ideal because a) it uses a patch file for saving the
>> remaining changes; b) it uses the stash only for setting the working
>> tree to the index state.
>>=20
>> It would be ideal if I could save *only* the remaining changes in the
>> stash instead of resorting to a patch file. How to do it?
> For example:
>=20
> 1. Stage some changes
> 2. Commit
> 3. git stash
> 4. Test
> 4a. git commit --amend if tests show that the commit is not yet =
perfect
> 5. git stash pop
> 6. Goto 1.
>=20
> Be prepared for conflicts in 5 if 4a was necessary.
>=20
> -- Hannes


Hello Johannes,

Thanks for the solution! I think you can avoid conflicts in step 5 by =
popping off the stash right before step 4a and pushing on the stash =
right after, like this (the three columns represent the state of the =
working tree, index, and HEAD):


edit
X X X
Y
Z

git add Y
X X X
Y Y
Z

git commit
X X X
Y Y Y
Z

git stash push (saves X Y +Z)
X X X
Y Y Y

while test fails {

git stash pop (restores X Y +Z)
X X X
Y Y Y
Z

edit
X X X
Y'Y Y
Z

git add Y'
X X X
Y'Y'Y
Z

git commit --amend
X X X
Y'Y'Y'
Z

git stash push (saves X Y' +Z)
X X X
Y'Y'Y'

}

git stash pop (restores X Y +Z)
X X X
Y Y Y
Z


But the problem with your solution is that you commit before testing and =
then amend in case of test failure.

The option --keep-index of the command git stash push is supposed to =
handle this, like specified in the reference documentation:
=
https://git-scm.com/docs/git-stash#Documentation/git-stash.txt-Testingpart=
ialcommits


Testing partial commits

You can use git stash push --keep-index when you want to make two or =
more commits out of the changes in the work tree, and you want to test =
each change before committing:

# ... hack hack hack ...
$ git add --patch foo            # add just first part to the index
$ git stash push --keep-index    # save all other changes to the stash
$ edit/build/test first part
$ git commit -m 'First part'     # commit fully tested change
$ git stash pop                  # prepare to work on all other changes
# ... repeat above five steps until one commit remains ...
$ edit/build/test remaining parts
$ git commit foo -m 'Remaining parts'


But --keep-index is fundamentally flawed because though it sets the =
working tree to the index state (instead of the HEAD state like bare git =
stash push), it still saves the changes between the HEAD state and the =
working tree state (i.e. staged changes and unstaged changes). So when =
you git stash pop, you get conflicts since the working tree is not in =
the HEAD state like expected, but in the index state.

People have been complaining about this conflict issue on Stack Overflow =
many times:
https://stackoverflow.com/q/7650797/2326961
https://stackoverflow.com/q/20028507/2326961
https://stackoverflow.com/q/49301304/2326961
https://stackoverflow.com/q/25620844/2326961
https://stackoverflow.com/q/20681448/2326961
https://stackoverflow.com/q/57524906/2326961

FEATURE REQUEST
So could we add a new option -U|--unstaged (by symmetry with the =
existing option -S|--staged) to the command git stash push to do what =
the option --keep-index was trying to achieve? It would:
=E2=80=94 save the changes between the index state and the working tree =
state, i.e. only unstaged changes;
=E2=80=94 set the working tree in the index state.

So the difference with --keep-index is the source: the changes would be =
computed from the index instead of from HEAD.

With that new option -U|--unstaged, we could solve the =E2=80=98testing =
partial changes before committing=E2=80=99 problem elegantly (called =
=E2=80=98Testing partial commits=E2=80=99 in the reference =
documentation, which is a bit misleading), that is
=E2=80=94 without conflicts contrary to the solution in the reference =
documentation:
 git stash push --keep-index
 test
 git commit
 git stash pop
=E2=80=94 without temporary commits contrary to your suggested solution:
 git commit
 git stash push
 test
 git commit --amend
 git stash pop
=E2=80=94 without temporary files contrary to my solution:
 git diff >unstaged
 git restore .
 test
 git commit
 git apply unstaged
 rm unstaged

Like this:


edit
X X X
Y
Z

git add Y
X X X
Y Y
Z

git stash push --unstaged (saves X Y +Z, not X +Y +Z like --keep-index =
does)
X X X
Y Y

while test fails {

git stash pop (restores X Y +Z)
X X X
Y Y
Z

edit
X X X
Y'Y
Z

git add Y'
X X X
Y'Y'
Z

git stash push --unstaged (saves X Y' +Z)
X X X
Y'Y'

}

git commit
X X X
Y Y Y

git stash pop (restores X Y +Z)
X X X
Y Y Y
Z


Best,

G=C3=A9ry Ogam=
