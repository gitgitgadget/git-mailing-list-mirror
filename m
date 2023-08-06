Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A388C001B0
	for <git@archiver.kernel.org>; Sun,  6 Aug 2023 18:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjHFSgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 14:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFSgM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 14:36:12 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65110171B
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 11:36:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8A69D32000E5
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 14:36:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 06 Aug 2023 14:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1691346962; x=
        1691433362; bh=fGICLLjbJfbMgGlOj4N8i6H3WLEq2t1tqDCaHt9otZ8=; b=M
        b4lAZtrAfNo85eSpXbbOkPTBrDfvJzWEeyyQdp66tqowu8D2DqYQTholCuX1wWab
        rfCwWnL1reqUe0u8elzAsyUdZfc25g7oBk1UX4gckGChK1Z/2Schya9oWiVwnu96
        jmeluR7yMVLtPVOUKRpCtU6qbMNqexYQaiiarXQKVQmvH6GUf3we9Jdlc1T0KcQc
        elt+5PMp7qkWMBjJZlYpF639Ls1v+XuwJFVNysPGjbjBknPLYtxmaya+RCQKe5tu
        BBkXOOduuVtDwbEVwUOMO+OKAONEQSzEHlVWukuoxYeR7PrKJoF7Qd3kJs5jrDKn
        kUpS8oOkFzCDNUa8Zw9gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691346962; x=1691433362; bh=fGICLLjbJfbMg
        GlOj4N8i6H3WLEq2t1tqDCaHt9otZ8=; b=W0Piq70osIxe6K7D4oOR1btBqpjk0
        D2zChygB/aPjX9WQwkQk20JXnKkvVEwCJ3yMdVbfNnJ+1NwtPeCCUPIULFF2qXMc
        ZzKml7MqF65X1Bd4nWMyoLoUlmKQI7rphMP6NjUbAhWgicXhhRcQZM3nf17fcw5j
        c1EYjy4erzLJJL7aZYKEPR/HzpD7V674zX/IFLueHLaiBfRe+AV2iLj5ZeGttDdp
        bpHgQNg7yNW2+yeOscfTACnH169OwtRGKjt+NbWDA9D1eI1jcPwZH08wN4ewN66B
        zetiQruE0uTeirbt0cl6+R+h8IVbFuPdzV3uGvG01BGmc63eXq9oVWqoQ==
X-ME-Sender: <xms:EejPZAnxwVgftzc-8gmolII6cpYhfiXjjm8za68C9WHdt5WwJsmkXg>
    <xme:EejPZP3SY1NZESdqNY9SRPd3qgEqzzf19PO22X3i1TJOJo7DLNPskhtIernf2cpDN
    V745xOOMlFXXsQx>
X-ME-Received: <xmr:EejPZOp7rA_F-dKdcK3hJwzpQF6KrFMdKAUMnIZKRV0inxg8u3t9EcmCG3MW6gN_4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeekgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhtgfgggfukfffvffosehtqhhmtd
    hhtdejnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgvsegr
    lhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpeehteffkefgtdevieeuve
    dthfevfeeiffegudejteefgeekvdfggfetgfdtgefgvdenucffohhmrghinhepghhithhh
    uhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:EejPZMlqYBCgKcT0DcGTounlDzuK81b8e8KAOM8l4__B2WL-Ue74eg>
    <xmx:EejPZO3RjZTcK7gswua2YqETfeNTLqGAmZEA9yowfy4KPxupXJIy-Q>
    <xmx:EejPZDvsXziUKMlkt_T0YrkZDMh2W-wF3ZxBGOIdhQ64sVEI36I1iA>
    <xmx:EujPZHiIPtFMjrObBtUEMLfoeizDu0aB0MSyEG9PsTmOCDSF5Lcd1Q>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sun, 6 Aug 2023 14:36:01 -0400 (EDT)
From:   Brooke Kuhlmann <brooke@alchemists.io>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Git Commit Notes (fetching/pushing)
Message-Id: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
Date:   Sun, 6 Aug 2023 12:35:50 -0600
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm noticing issues with GitHub and GitLab when fetching and pushing =
commit notes and wanted to know if there is a correct way to configure =
my Git configuration for working with these servers (or maybe notes =
aren't supported at al)?

Here's my configuration:

```
[notes]
  rewriteRef =3D refs/notes/commits

[remote "origin"]
  fetch =3D +refs/notes/*:refs/notes/*
  push =3D +refs/notes/*:refs/notes/*
```

Upon creating a note (i.e. `git notes add`) and then pushing changes to =
the remote, I'll see the following response from GitHub:

```=20
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 8 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 289 bytes | 289.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/bkuhlmann/test
   5811bd44c32b..0f2422597c5d  refs/notes/commits -> refs/notes/commits
```

Only problem is the notes are not pushed. In fact, the feature branch =
I'm working is never updated. Only when removing my `[remote "origin"]` =
Git configuration does the GitHub server work properly (i.e. my changes =
are pushed to the remote server...but without any notes). Strangely, in =
all cases GitHub answers back with a success message even though that is =
incorrect.

Anyway, if anyone has advice or additional information how this should =
work (or if my configuration is wrong), I'd be grateful. =
=F0=9F=99=87=F0=9F=8F=BB=E2=80=8D=E2=99=82=EF=B8=8F




