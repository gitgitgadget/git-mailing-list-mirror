Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA20C433E0
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2191764EDE
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 10:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBUKNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 05:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUKNM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 05:13:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4FAC061574
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 02:12:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so11696250wml.2
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zPzW/8vDMH3+mbsC9sZkNaXdcFFOc371tRtqqauuZ04=;
        b=s4ANZxy4Nf7ScwX5ARcXU2K/SeUuJFs0JUMt9e/D32tKrEOTTPX1EJlXuSz76IC0fI
         36zrd3e4SV5vnlsGFtM41TO6WCiilQdu/JlydWac6l19OjCdJQ4U1P1Q6LnbvzAcHq8w
         VRJXoEFdlC7QcaH7++RqRPpxafL7TuDHzAzoKj4jAGzmioFD8uQkYKTxHUyzZPKJsm9g
         aBn01Wt0a8aTTFb5pNn0Cd5w63G0m9NdPKkHJHTVwsyM6lro467MNug0IlQipvKpaf2n
         6EDnctIVlRz13DA/Bm8YWlt+f4es+t8wxN+3R82KJPtoXsj10QJi0HUTiXBkcnJ7y8t6
         DBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zPzW/8vDMH3+mbsC9sZkNaXdcFFOc371tRtqqauuZ04=;
        b=mJFq1MO+RslscFUgGCf6Y68QiJFkLgALA9fuqkQTrHdGtTGa3kuAmSNoFn3NrFkouG
         VdedC4IiHngjz8pqPTPhueA0d2HFBqUyiHEdBPb5muk7mz/gacGVB7g+AMSKmtftRBJc
         V5imJ3U6pmGDV/x1L2+SIDTxK4ZNx/FfN9Fnr6l/s9DCjoBvQM72vUwUEhmGK0CZf4Yq
         ubbix3NkfWeHkzJGYx2IsRDTijCGujlvJuLorWZH6w6EW/upIKsklQ5KxMhWnyveWr5W
         UjKGcL3sTaQzYTRjNvQXiKcIl2Wlnq2DUj9guqE4lhCSn8M9+SlH6/FxpLTqFbIWL+YQ
         bYhQ==
X-Gm-Message-State: AOAM532uRbnvfM5y1fCgFuKwBZxGEOJ1qUVqOaPlf9FcXxjIcWerAG+n
        0ojsEtC2e2hoYEZEdkrvcq3s9ONcdnzkA6H5WFLCZq3f8g==
X-Google-Smtp-Source: ABdhPJyhGKs9Vfi06s0/jYpwpoIcF5T0+QdyJag5+NXRlDp0j+Fc2oso3Y3ODeXtxSzl0taK420iKB4WW3jHMp0aGb0=
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr10287282wmj.95.1613902350130;
 Sun, 21 Feb 2021 02:12:30 -0800 (PST)
MIME-Version: 1.0
From:   Stef Bon <stefbon@gmail.com>
Date:   Sun, 21 Feb 2021 11:12:19 +0100
Message-ID: <CANXojcx0TOP9SSr1NgXCddQ3PWze-wBLZA5SRO3YhczqO68u0Q@mail.gmail.com>
Subject: FUSE fs for git.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm working on a network fs mount service for Linux (I call it Open
Secure Network Services, short OSNS) which mounts sftp access on hosts
found in the network (using Avahi) and provides a browseable map to
the user like:

sbon@ws-001 OSNS]$ ls -al /run/network/sbon/fs/Open\ Secure\
Network/bononline.nl/alarm/public
total 3
drwxrwx--- 5 nobody users 4096 Feb 21 05:05  .
drwxr-xr-x 5 root   root  4096 Feb 21 05:04  ..
-rw-r--r-- 1 sbon   users    0 Aug 15  2018  1234
drwxr-xr-x 2 nobody users 4096 Jan 24 04:52  backup
-rw-r--r-- 1 nobody users   21 Feb 21  2017  .bash_logout
-rw-r--r-- 1 nobody users   57 Feb 21  2017  .bash_profile
-rw-r--r-- 1 nobody users  141 Feb 21  2017  .bashrc
drwxr-xr-x 2 nobody users 4096 May 27  2017  Projects
-rw-r--r-- 1 nobody users    4 Jul  1  2017  test
-rw-r--r-- 1 sbon   users   24 Aug  6  2017  test1
-rw-r--r-- 1 sbon   users    4 Aug 10  2017  test2
-rw------- 1 sbon   users    0 Aug 15  2018 'Text File'
-rw------- 1 sbon   users    0 Aug 15  2018 'Text File (1)'
-rw------- 1 sbon   users    0 Aug 15  2018 'Text File (2)'

See: https://github.com/stefbon/OSNS

It supports SFTP (over SSH) versions 3 (used by Openssh) to 6 (latest draft).
Other things I want to add is:
- own sftp client (osns_sftp_subsystem)
- backup on server of user defined directories and files (osns_backup_subsystem)
- next to SFTP also support SMB using libsmb2 by R. Sahlberg for
integration in Windows Networks
- fsnotify support in SFTP and in userland using a specific user agent
like osns_client_user (maybe also in SMB) (support in SFTP means an
extension)
- textchat and/or videochat (osns_chat_subsystem)
- forward connection to server over SSH using a simple api to talk to
osns_client for databases, and something like nx (emulation of
desktop)
- an own server osns_server
- support for use in large environments and roaming users (-> CA, ldap etc)

Now I'm looking it's possible and usefull to add a git fuse fs. The
thing I ask is:

- is there an api I can use (lowlevel and/or highlevel or whatever is
available)?

- is it usefull, in other words is there a serious benefit of a git
filesystem: does it add something?

Any other suggestion is appreciated,

Stef Bon
the Netherlands
