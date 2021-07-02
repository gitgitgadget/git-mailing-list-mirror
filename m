Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE8BC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C9B613FE
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 22:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhGBWvx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGBWvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:51:53 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04AEC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 15:49:19 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o13-20020a9d404d0000b0290466630039caso11629848oti.6
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 15:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=viC72skec2Hls/X0sd9AupC6Bsd1ff3AYjvYK7EErPc=;
        b=tCTty3aWNSXbiPx9bIHsnhw0mYbV4sjMx1ucWVcBgD73A56eXzzfK+lePw4+ZCYQl2
         dxyMNJNuh0rCax+JMTIVt76hQok7LUHjl5mJl70I5rJ41mX4lrt8U4F6p7YO+D4O9AuP
         4sT0u6jfAYQj5WMjznTYNI6HekpBdTdJKhGGEAG1Itj113bO4I1vwOLMI0dMGJJ/6mqK
         LBMjvaznGZpAuOjxcAlWcDIint6ldvQN6SGPtX3H0uSPyy/69ahhVR/Lt/xO1FUKAtfe
         kfFiztsm6Fi6Ckn2j++G+dFFBUY7oqqZgPjhXbd/1p2YObTU+vsn15DuHTXqAG16DcmO
         N11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=viC72skec2Hls/X0sd9AupC6Bsd1ff3AYjvYK7EErPc=;
        b=GCwqkwFY3NWe/LynNxC35diqQF2bJawV8vvE1y5QMG6saNm2RZvkKsiYoywyHjh2PZ
         pvlDQVVPrjvnqZfYT1P/t57hf+QWqnJown0L8aElWUfcnbwKs8xCmrscqxIKFXzoWRCa
         hJfVZoxrRGYNicZJVSxkTuquhTe65bVa7uGt9/Glu+SX68qtDeMnF8gfJCXv30vuvgUJ
         vZUYwJZA8HWwIDgO/PJzkAHn0vmBn51lSp8/7YX/ZPXtrmuXYGowwD1pvpNtn18AmxPm
         ZBYJpGiOku4ITb8UVF1DRqZEkDatmWfvexR1Z8Rpd0vYXQUDf2PNhWjBpI1k1jJM9kYY
         nkzA==
X-Gm-Message-State: AOAM533DLsxvC8rqo0750+LZWYX4JAMyzymmATUBXGz2WMz7HnWVspyb
        pY+A2WnnHSAsLiAuvZh95/m7t7373Ne2qA==
X-Google-Smtp-Source: ABdhPJz4Lo7jaaKCFm6H9wBObd3OrpNTfxVYl9HAJqZiimbrP5JUeVLw1g/VruLrCZPNxtQHH7uwjw==
X-Received: by 2002:a9d:70c1:: with SMTP id w1mr1250402otj.82.1625266158730;
        Fri, 02 Jul 2021 15:49:18 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id t5sm857389otk.39.2021.07.02.15.49.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:49:18 -0700 (PDT)
Date:   Fri, 02 Jul 2021 17:49:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60df97ed24687_34a92088a@natae.notmuch>
Subject: The git spring cleanup challenge completion
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

One month ago I suggested the git spring cleanup challenge [1], which
after 50 replies can probably be considered a success.

After one month of trying my best not to add many configurations, this
is my final .gitconfig:

  [merge]
    conflictstyle =3D diff3
  [alias]
    co =3D commit -v -s
    br =3D branch

Judging from the discussion, diff3 should definitely become the new
default conflict style. I already sent some patches [2] to try to start
moving in that direction, but unfortunately it doesn't seem to be that
easy because many commands simply ignore that configuration, while
others have issues with the configuration and the command line. Many
probably need a new command line argument to specify the desired
conflict style. A lot of work is needed.

Not to mention the two new proposals to have a new, better diff3: zdiff3
[3] [4]. These come from a proposal from Uwe Kleine-K=C3=B6nig in 2013 [5=
].


Other than that, it's fair to say that *everyone* needs some command
aliases to use git. This past month shell completions have saved me, but
not completely. I can't imagine how a newcomer must feel using git
without any alias.

I sent some patches to attempt to have some standard default aliases
[6], also, there's this old thread where default aliases were discussed
at depth [7].

Another uncontroversial configuration everyone agrees should be the
default is `rerere.enabled`. Although `rerere.autoupdate` is more
controversial, I don't see why it cannot be considered too.

Here's a few other interesting configurations:

  * rebase.autosquash =3D true
  * rebase.autostash =3D true =

  * commit.verbose =3D true
  * diff.colorMoved =3D true
  * grep.patternType =3D perl
  * alias.undo =3D reset --hard @{1}
  * feature.experimental =3D true
  * branch.sort =3D committerdate
  * diff.algorithm =3D histogram

I for one can't wait to finally have proper aliases again.

That was painful.

Cheers.

[1] https://lore.kernel.org/git/60b5d281552d6_e359f20828@natae.notmuch/
[2] https://lore.kernel.org/git/20210622002714.1720891-1-felipe.contreras=
@gmail.com/
[3] https://lore.kernel.org/git/20210613143155.836591-1-felipe.contreras@=
gmail.com/
[4] https://lore.kernel.org/git/b7561a67c192d4bdede47fee5b7b1cb30c44b785.=
1623734171.git.gitgitgadget@gmail.com/
[5] https://lore.kernel.org/git/1362602202-29749-1-git-send-email-u.klein=
e-koenig@pengutronix.de/
[6] https://lore.kernel.org/git/20210702100506.1422429-1-felipe.contreras=
@gmail.com/T/#t
[7] https://lore.kernel.org/git/CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2w=
YnEuZ07eaQ@mail.gmail.com/

-- =

Felipe Contreras=
