Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C739F1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 17:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeAHRP1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 12:15:27 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:42799 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756563AbeAHRP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 12:15:26 -0500
Received: by mail-oi0-f53.google.com with SMTP id o64so7822434oia.9
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gS1F0vHFZeJf7GCiWpblFm/zTRClhJVQ9+UX7cYrIlA=;
        b=cMV5yMcpJP+w8wfvjX9mc/4TZfJQILz9zODuXsnjrwh9FTo8gE+P8dpqSNQe6XSMS1
         2uMXloDeDiqFBdAVxmsI6hbsBsruyHZTdKy4BSg7PeHFPQiYtxOw8aj2mJ6qAvhc4zY/
         JVrPJ6gpgWbo4QRm9xGccCCk8mR9IDU18ErS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gS1F0vHFZeJf7GCiWpblFm/zTRClhJVQ9+UX7cYrIlA=;
        b=b43oEAZEFbjyI6r3s3c2R+6vZ8lvHRl5Pk84xAzFfzMu3UnglOLvsZJHoGcNCFs+bz
         PiI6WuyQsuujUIF0TDQb5a/RIkUHHK0f0FkccISUcx9JcmmVs0XKW72CNN644q+7ysyM
         nfit6pK1miT9otKgsE0prR+/DAH6cxnRGK98v4VB0W7z9tFz390oRFHLFRk4alOJ0MNP
         Qx8sMS7ZpPnlJDN62d5+olE13gUt0bb64ENo0dm48QXAs3zCxOkXpXokJXqKsVUQGiI9
         +/lfvSkA4HtMFZSASCiUT64YR7InGTjyR2y6g12orytVH2fBPSBbzdaB+P0G45ZB652Q
         M/Bg==
X-Gm-Message-State: AKwxytdJYK/il26GyVgtKQAXnkU+RdYecTtowX+4X+ousGMN73EebCvR
        x40ykQHX6ZjKupplSsuNP4U9wbgGxCYZ2OBFvQXQoFnO
X-Google-Smtp-Source: ACJfBovzUKSRRpR151H83bFf0JddmpU95ObiNvesgaHp+uhY15qnLRsETzYPuWF6gc7IjgXpknN0APDyq4zdc6MZIG0=
X-Received: by 10.202.86.202 with SMTP id k193mr2428424oib.45.1515431725765;
 Mon, 08 Jan 2018 09:15:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.0.240 with HTTP; Mon, 8 Jan 2018 09:15:25 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 8 Jan 2018 17:15:25 +0000
Message-ID: <CAE5ih79t8N969E-8qm9JMNZZo6qvRqw6GA=b6UTHskB-ozt7Fg@mail.gmail.com>
Subject: git-p4 + watchman - watching the p4 repo?
To:     Git Users <git@vger.kernel.org>
Cc:     Alex Vandiver <alexmv@dropbox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I could be wrong about this, but I when I tried mixing watchman with
git-p4, I found that on "git p4 submit" it ended up watching the p4
repo, which seems a bit pointless (and was also very slow).

$ [create git-p4 clone of some p4 repo]
$ : >bar
$ git add bar && git commit -m 'adding bar'
$ git p4 submit --origin HEAD^ --shelve
Perforce checkout for depot path //depot/ located at /tmp/p4/cli/
Synchronizing p4 checkout...
... - file(s) up-to-date.
Applying 4ce4057 change
//depot/bar#1 - opened for edit
Adding '/tmp/p4/cli' to watchman's watch list.

Is there any way to stop it doing this?

Thanks!
Luke
