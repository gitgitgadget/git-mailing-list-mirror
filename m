Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA78C1F453
	for <e@80x24.org>; Sun, 23 Sep 2018 20:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeIXCIP (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Sep 2018 22:08:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38275 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeIXCIP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Sep 2018 22:08:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so3117746pgr.5
        for <git@vger.kernel.org>; Sun, 23 Sep 2018 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=wuthk4E6dSNdgyEt0sNVah2TmKNbrSQdF8HmjPnqu88=;
        b=dpYe4VW+/c7IQx5rMZMUSbUDJWy8XcCZObAyPif433fOgB2KGF9JTMHODenh2eYgU9
         xaHKo5/dhwPPmXQf/TA7RHNU3O3jxcgGbxcXsfog+WVMAqoRhcLM6KFNSttjccG/3Cyd
         IOHwYdW+SqEYfI3TntFsAlJu2GRlDtK0zw/C3majIsz4xP0iZSnMZ0kzCLhnXFsny/L9
         5gvD60Z+eYq/pGpVH3+ArF8ztX7bkWIjCZ1XykSirxvi6zb4QnprubCRDXhe+dI929UE
         9qxfRWwuKFmoXfsixaRx1DVFaS5sgs4egVv/Rm0csXb1ElBfS+KtmUo+9MI5IZwSaIqj
         xUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=wuthk4E6dSNdgyEt0sNVah2TmKNbrSQdF8HmjPnqu88=;
        b=kGffz25mZ90N+Fs1KY5y8TAT+BwR2zJm+8WlJnNd3uihbshIPeLwc+4RH9OYcEgt1T
         9RLQXZc4ujIsD2EmG8FNt/CP8nWxEePJQeyffZreW/FLqXmcta6YJ4GdqoNqwpO7+vr5
         w4cFkcMqV6+ZltUA4co3e4MF7f2J0vWylXFJUXzObc781f/x+DdJl7O6YIA6QjnAL+ag
         +t63q3/UvoXt+PGeXqouj3sa2k1D8/8ka26SAYeNUjndBKBqE1N1Q5uptouQ8wJEP+K4
         8L0Cd0aeY/TWV8KNoM+q8gQ1KJUyaU3P31lx4YWNUD9NswAazWtyvqx6OE50WzG19sxw
         IJDw==
X-Gm-Message-State: ABuFfohtcrko9Buw8JmXsP6bzXk9NS/zUdtwKwdO/MtPiKIzrTPaNWxc
        7DGX0xIZdA55JDcPzxn3P4d1FNPVrXU=
X-Google-Smtp-Source: ACcGV63VspgXisiPtY1Atut7WEN/cDe4w2+PfU2X1PCf76Ic/zy4AOb/InfMYqyrRbrBTTNLjcpsnQ==
X-Received: by 2002:a63:1d3:: with SMTP id 202-v6mr6912097pgb.136.1537733371074;
        Sun, 23 Sep 2018 13:09:31 -0700 (PDT)
Received: from unique-pc ([27.62.48.110])
        by smtp.googlemail.com with ESMTPSA id f13-v6sm36940666pgs.92.2018.09.23.13.09.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 13:09:30 -0700 (PDT)
Message-ID: <90301874969f7b11f33e504500c150a25d722ff8.camel@gmail.com>
Subject: git fetch <remote> <branch> behaves weirdely when run in a worktree
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 24 Sep 2018 01:39:26 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.28.5-1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I was actually trying to automae the building and installation of Git
source code to reduce my burden. I tried to automate it with the help
of a script that runs daily via cron and a separate worktree used only
by the build script.y run

The script typically fetches new changes for the next branch by running
the following in the build worktree (which is not the main worktree):

   $ git fetch origin next

I thought that would result in FETCH_HEAD pointing to the latest
changes for origin/next if the command succeeded.

Unfortunately, it seems to be behaving weirdely when run in a worktree.
It sems to be behaving as if I ran 'git fetch origin'. To add to that
confusion when I run

   $ cat $MAIN_WORKTREE/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD

it seems to be printing the info about the remote refs once and then if
I run it again immediately nothing is printed. If I repeat it again,
info about remote refs is printed but this time the info about the
remote refs is printed thrice. This happens randomly. Sample output:

   01:23 $ cat ../git/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD 
   53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint' of https://github.com/git/git
150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master' of https://github.com/git/git
01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of https://github.com/git/git
7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of https://github.com/git/git
722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of https://github.com/git/git
   01:23 $ cat ../git/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD 
   01:23 $ cat ../git/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD 
   01:23 $ cat ../git/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD 
   53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint' of https://github.com/git/git
150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master' of https://github.com/git/git
01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of https://github.com/git/git
7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of https://github.com/git/git
722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of https://github.com/git/git
53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint' of https://github.com/git/git
150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master' of https://github.com/git/git
01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of https://github.com/git/git
7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of https://github.com/git/git
722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of https://github.com/git/git
53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint' of https://github.com/git/git
150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master' of https://github.com/git/git
01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of https://github.com/git/git
7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of https://github.com/git/git
722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of https://github.com/git/git
   01:23 $ cat ../git/.git/worktrees/$BUILD_WORKTREE/FETCH_HEAD 
   53f9a3e157dbbc901a02ac2c73346d375e24978c	not-for-merge	branch 'maint' of https://github.com/git/git
150f307afc13961b0322ad0e7205a7b193368586	not-for-merge	branch 'master' of https://github.com/git/git
01d371f741e6f0b0076d9ed942d99bdb23757eac	not-for-merge	branch 'next' of https://github.com/git/git
7a81cbc028be113058e0b55062706ec6de62ed94	not-for-merge	branch 'pu' of https://github.com/git/git
722746685bce03f223ed75febe312495e6c139da	not-for-merge	branch 'todo' of https://github.com/git/git

   'git fetch <remote> <branch>' behaves correctly in the main worktree.

   Why is this weirdness happening when run in other worktrees?

   Why isn't 'git fetch <remote> <branch> not fetching the changes for
   just the specified branch?

   Am I missing something?

   --
   Sivaraam

