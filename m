Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 695AD1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 16:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbfFXQCA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 12:02:00 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:35835 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfFXQCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 12:02:00 -0400
Received: by mail-lf1-f49.google.com with SMTP id a25so10474187lfg.2
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=/s+LltwjP5vBgYui3uAd2POyuhCWwKm0LcXWvR08nOA=;
        b=GXjQ3XpBItrzCM6GkJW+XRJPj6t2Li8mopbj8U4A46vkldh7zYNz1RQ36rvDGvWFr5
         3QtQhE0HiI9rPo/y7ODeK/Kb3lRq7mSLU01s1AcY0xTa8w2cNruzXcylWrY+Lr7O6w6D
         zme+5+ezZQa+ek9higEVE+8AnDoIMcw6u2FLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=/s+LltwjP5vBgYui3uAd2POyuhCWwKm0LcXWvR08nOA=;
        b=qxjIFtLr9HIjIRhC3/FNbCDMSwhbSPZzAfn8KH2ekybA3isEprBPi7qP75rMOwYMqL
         4mrthUnYZ47Z6T55lgyFSgGvEWmgFi9LqaBwk2IxL45yZx0LwHOwE8YqD1vbwTJj9zqf
         /KFxHGwQkQMCY3VRwsMZrcwrcs240urVfzHSvK+00//yADq3d42BH5mOpyj+U0tr68GC
         8yRORSUGC9U9Q48DQ5KZD/cIxRAXEYkiHJfMUEB4HQiGi6BRWNyNml6SVZbCftrUBILv
         GFJhZ19PcO/BEaHSLfEwoXYD4HTo3J5+61wZJ8h0RAyDNSWHpkrKlrY2GSae7CGCV/HR
         N+ng==
X-Gm-Message-State: APjAAAXryQbsNrwKlVGkWTBIiDIfCVFysmHBHxgJiHWbhU06liLUqfpt
        T2Y8U+jC8nabm+o51HQGQgLBL/JBdZkgoA==
X-Google-Smtp-Source: APXvYqyzAbH0P8pkhxMXaDDceNM3NAPXih/P1WkGNvl3z9CFTh3CcfuL8zxCqYIRX5VCZTYKawy7ig==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr32560980lfo.71.1561392116877;
        Mon, 24 Jun 2019 09:01:56 -0700 (PDT)
Received: from unit-1441.labs.intellij.net (notify.jetbrains.com. [81.3.129.5])
        by smtp.gmail.com with ESMTPSA id z30sm1811248lfj.63.2019.06.24.09.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 09:01:56 -0700 (PDT)
From:   Dmitriy Smirnov <dmitriy.smirnov@jetbrains.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Git 2.22 , --preserve-merges fails with custom commentChar 
Message-Id: <68F548D4-DF5A-411E-AAB7-33C9DBF9B658@jetbrains.com>
Date:   Mon, 24 Jun 2019 19:01:55 +0300
Cc:     Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
        Aleksey Pivovarov <aleksey.pivovarov@jetbrains.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I know =E2=80=94preserve-merges is deprecated now and =E2=80=94rebase-merg=
es should be used instead, however it is still possible to pass =
=E2=80=94preserve-merges flag, so the issue seems worth reporting.

In git 2.22, =E2=80=94preserve-merges does not work when custom =
commentchar is used. It shows the editor to select options bu then =
fails:

=E2=9E=9C  ProjectRoot git:(master) git -c core.quotepath=3Dfalse -c =
log.showSignature=3Dfalse -c core.commentChar=3D@ rebase --interactive =
--preserve-merges --no-autosquash =
554597b2e2c73e636b9c0cdf24dacba38568d02b
warning: git rebase --preserve-merges is deprecated. Use --rebase-merges =
instead.
error: invalid line 6: @ Rebase 554597b..a8702dd onto 554597b (4 =
commands)
error: invalid line 6: @ Rebase 554597b..0607564 onto 554597b (4 =
commands)
error: invalid line 7: @
error: invalid line 8: @ Commands:
error: invalid line 9: @ p, pick <commit> =3D use commit
error: invalid line 10: @ r, reword <commit> =3D use commit, but edit =
the commit message
error: invalid line 11: @ e, edit <commit> =3D use commit, but stop for =
amending
error: invalid line 12: @ s, squash <commit> =3D use commit, but meld =
into previous commit
error: invalid line 13: @ f, fixup <commit> =3D like "squash", but =
discard this commit's log message
error: invalid line 14: @ x, exec <commit> =3D run command (the rest of =
the line) using shell
error: invalid line 15: @ d, drop <commit> =3D remove commit
error: invalid line 16: @ l, label <label> =3D label current HEAD with a =
name
error: invalid line 17: @ t, reset <label> =3D reset HEAD to a label
error: invalid line 18: @ m, merge [-C <commit> | -c <commit>] <label> =
[# <oneline>]
error: invalid line 19: @ .       create a merge commit using the =
original merge commit's
error: invalid line 20: @ .       message (or the oneline, if no =
original merge commit was
error: invalid line 21: @ .       specified). Use -c <commit> to reword =
the commit message.
error: invalid line 22: @
error: invalid line 23: @ These lines can be re-ordered; they are =
executed from top to bottom.
error: invalid line 24: @
error: invalid line 25: @ If you remove a line here THAT COMMIT WILL BE =
LOST.
error: invalid line 26: @
error: invalid line 27: @ However, if you remove everything, the rebase =
will be aborted.
error: invalid line 28: @
error: invalid line 29: @ Note that empty commits are commented out
error: unusable todo list: '.git/rebase-merge/git-rebase-todo'
error: invalid line 6: @ Rebase 554597b..0607564 onto 554597b (4 =
commands)
error: invalid line 7: @
error: invalid line 8: @ Commands:
error: invalid line 9: @ p, pick <commit> =3D use commit
error: invalid line 10: @ r, reword <commit> =3D use commit, but edit =
the commit message
error: invalid line 11: @ e, edit <commit> =3D use commit, but stop for =
amending
error: invalid line 12: @ s, squash <commit> =3D use commit, but meld =
into previous commit
error: invalid line 13: @ f, fixup <commit> =3D like "squash", but =
discard this commit's log message
error: invalid line 14: @ x, exec <commit> =3D run command (the rest of =
the line) using shell
error: invalid line 15: @ d, drop <commit> =3D remove commit
error: invalid line 16: @ l, label <label> =3D label current HEAD with a =
name
error: invalid line 17: @ t, reset <label> =3D reset HEAD to a label
error: invalid line 18: @ m, merge [-C <commit> | -c <commit>] <label> =
[# <oneline>]
error: invalid line 19: @ .       create a merge commit using the =
original merge commit's
error: invalid line 20: @ .       message (or the oneline, if no =
original merge commit was
error: invalid line 21: @ .       specified). Use -c <commit> to reword =
the commit message.
error: invalid line 22: @
error: invalid line 23: @ These lines can be re-ordered; they are =
executed from top to bottom.
error: invalid line 24: @
error: invalid line 25: @ If you remove a line here THAT COMMIT WILL BE =
LOST.
error: invalid line 26: @
error: invalid line 27: @ However, if you remove everything, the rebase =
will be aborted.
error: invalid line 28: @
error: invalid line 29: @ Note that empty commits are commented out=
