Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B981F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeLRRef (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:34:35 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38622 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbeLRRef (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:34:35 -0500
Received: by mail-lj1-f169.google.com with SMTP id c19-v6so14945720lja.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CtWFDJFXijZRYDM3UNm/qCNvhPkiKUdmB66oWJxWMpU=;
        b=C6zomMRlguDlAE/d9P7td7lHdbl/iOrS+/DSJsfDAwIGSvTeLBGr6dCQLf4tVoodCR
         ft7EHGkV0r+N9QzfkJNJTDn5/Q3MYObG/8Q+BARAE4DWLxn2QsyxeWS9a5V50na0kCXv
         PIXEIrLcZyCBKs0Pwmv9mMnv5ezUA/IgY7fkEc+m+QVzyolS10NXJTGlsighibNha7V4
         E7UpZhlS/1tdKh1L0R+/U8A/Cc3KgxZ4cwD8zmbZuGKsXnRx98gxArWPM2ACST7KVVSo
         1ed0OBfAKBIcxvhMj+M5n44DHXG943OaWfDms6HyADluCK2lir29SSfOUpCKQSxgEw6f
         lilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CtWFDJFXijZRYDM3UNm/qCNvhPkiKUdmB66oWJxWMpU=;
        b=Sh+9NsGEGgIOuoqQZ88peyWJ7N0Xiu249wgR0yPg+F6DLaonwAXRRHuNOQcX46dU2I
         OtDl91g3MESf+adsWLNy5MqgucmfzO3bzw2pmphmamq2Gv6idf5G2PLCmeAY6S+eCRH2
         xtdllxej21QNTPExBKVOVn3K4FmYgdxXfkNLmoBvVeLTD83ETvyKbndiMBjU0Ragg8vl
         zRq3nwD6guuf1bOavngBGJ6TWR1ti1sk3X05vaBkiURQguonSVZBPhDj0zPjXV2Qf2y4
         p+rC+9qHAfIrrh23VlTTe6eH9U66zdm1ruDwOVGrHUm4NNQCSLkmYXQTXQK0DDvu5Qdb
         GPgQ==
X-Gm-Message-State: AA+aEWbC8xhoep9S1og+Zgh97kMfbdTZdE9Ob0kURSJIrKx8YjbMiR89
        mYFsOkM/Lh3F2jol+x5d2lFGoGP3LnRSXHyPl3vozZtIEYU=
X-Google-Smtp-Source: AFSGD/Xr44gJ63NtjI5rzdHWPzsboma/uaRmQk97d5ocYB08kTirnquf2KqH23+KS9+pyJgUm8Omkd/ECtqhZrGnYgM=
X-Received: by 2002:a2e:87c3:: with SMTP id v3-v6mr11723249ljj.13.1545154471561;
 Tue, 18 Dec 2018 09:34:31 -0800 (PST)
MIME-Version: 1.0
From:   Adilson de Almeida Junior <adilson.smem@gmail.com>
Date:   Tue, 18 Dec 2018 15:34:20 -0200
Message-ID: <CAKmxmfosaExDYNyoaNg2teHMzsu3JJ3bqiLhrAaUt0Jt473Phw@mail.gmail.com>
Subject: Merge behavior with merge.conflictStyle diff3
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I=C2=B4m not sure if this is a bug or not.

These are the steps to reproduce it (git 2.17 at least):
- In a repo, with default settings (merge strategy, conflict style,
merge drivers, etc);
- Create a file 'test.xml', and add the following content to it:

[div]
  A
[/div]

- Perform a git add and git commit, then, create a branch named branch1;
- Next, on branch1, edit the xml file and add a new div:

[div]
  A
[/div]
[div]
  B
[/div]

- Then, comit the changes, and after that return to branch master;
- So, perform a similar but slightly different change:

[div]
  A
[/div]
[div]
  C
[/div]

- Then commit it;
- Now, do a merge (git merge branch1);

When my conflictStyle is default (merge), the merged file becames:
[div]
[[[[[[[ HEAD
  C
=3D=3D=3D=3D=3D=3D=3D
  B
]]]]]]] branch1
[/div]

But when the merge.conflictStyle is set to diff3, I get:
[[[[[[[ HEAD
[div]
  C
[/div]
||||||| merged common ancestors
=3D=3D=3D=3D=3D=3D=3D
[div]
  B
[/div]
]]]]]]] branch1

I guess, most times the second behavior is the expected: two conflict
hunks, not only the divvergent pieces (this case, the second line) of
them. By the doc:

merge.conflictStyle

    Specify the style in which conflicted hunks are written out to
working tree files upon merge. The default is "merge", which shows a
[[[[[[[ conflict marker, changes made by one side, a =3D=3D=3D=3D=3D=3D=3D =
marker,
changes made by the other side, and then a ]]]]]]] marker. An
alternate style, "diff3", adds a ||||||| marker and the original text
before the =3D=3D=3D=3D=3D=3D=3D marker.

I replaced the 'lower than' and 'greater than' symbols by 'open n
close square brackets' to avoid antivirus.

Is this a bug, or something I missunderstood from git docs?

Thanks,
Adilson de Almeida Jr
