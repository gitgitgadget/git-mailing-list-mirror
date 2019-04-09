Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A5920248
	for <e@80x24.org>; Tue,  9 Apr 2019 11:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfDILut (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 07:50:49 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:36391 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfDILut (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 07:50:49 -0400
Received: by mail-ot1-f48.google.com with SMTP id o74so15244647ota.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KUthLYgJEzrfiSNz4evabOv40jRi17ITFORDOueN2f4=;
        b=O2tWGYkdMyHqFmGj0QP9p9fMl+W/ekI94V6V5/5FGhpRIBKuhA6PsNwF5ipT56zwKy
         3TpwHbBS+0czGvK/xpWaMp2IH6evuqxvrjSw5jTGZAPMTQ5WMklmFGYMwY2Tv/wNT+Gv
         ESoeqUW8sJaEvv7enohRY3j5dTuXzpbmeGvzgdwERelCyMAnkOf6NQ2NCfVJIxaqIOaH
         IzsKIM0ayFwrUkW8ybReOspZ6LDEDKzFtr/q0C7yBa03av2T3pcmThHlxroVTDs1vXhi
         fLPpe9bXfsFKGc9fgpfYckoZweWE65zjVhQN1TiB6o3lgkZQWL82UTPe6QTesKBF9HDD
         vP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KUthLYgJEzrfiSNz4evabOv40jRi17ITFORDOueN2f4=;
        b=a1E5tfksH03Jm9sqHbhFVVKmBD4+TnhI/JaIzwRPeUEVjOYjuEVF7Hm8om59r78vbA
         v6Grai8FL4sa03mLujIcd9HOz6Z1bgxAPApYYzJQ70emJA80XMf+7KdyqrBfkEFzUomU
         fj+LGte0XDFxMWB8pnTNFS8Rmzm8EevNMNKigpP4M/9Iwt1oKBLHAEZpc7dqsCpteZ8L
         PgY2kn/+e+tfduyTkEkRUQGGSluZzvuuIULfpq6U8bbtr7D5fwexQYMFLQ3I0lpqzOnc
         XJQXrruo9diiSBnw4j9NvlcrsG93StCzmuqPvGQ8cSArYEtTZkAK7o19bZuDeVEkF5yL
         iyMQ==
X-Gm-Message-State: APjAAAXGwzt2t0iA6HAtfVFs0FkINI+tqVtLkX0/RWDMpbSLAjyWHzZ1
        fpZvgUi2SbxBp5xMf7Il7eBhXGj1mKffZzy41ZwDAz6Rx/o=
X-Google-Smtp-Source: APXvYqxztQH65k6ZYlR8u3nl6JkNEEJV/XEjNbKpa2BBdSg0pdphxPDeZLf/3k8ycH2hn59/UtKMWHfcoBOi+Z+Pq68=
X-Received: by 2002:a9d:5908:: with SMTP id t8mr24085393oth.45.1554810648060;
 Tue, 09 Apr 2019 04:50:48 -0700 (PDT)
MIME-Version: 1.0
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Tue, 9 Apr 2019 17:20:36 +0530
Message-ID: <CAMknYENOfZKM0H5aznK9VyXzGA_SG+E1v62Jcez4bxnznNyPmw@mail.gmail.com>
Subject: [GSoC] [RFC] git stashing discussing solution approaches
To:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just had a small discussion on irc about solving
https://git.github.io/SoC-2019-Ideas/#teach-git-stash-to-handle-unmerged-index-entries
the discussion:
https://colabti.org/irclogger/irclogger_log/git-devel?date=2019-04-09

Below are two approaches for solving this problem:

Approach 1) The suggested approach.

Perform an octopus merge of all `stage n` (n>0) unmerged index entries.

a problem with this approach:

1) Octopus merge can fail, and if it does what do we do in that case ?
Solution: store the conflicted state, and restore it when stash is applied.

I am not clear on how would we store the conflicted state (away from
index file).
please provide reference to code or docs that may be helpful to
understand this or is this the part that needs to be implemented for
this project ?


Approach 2) This approach is a shot in dark; not well thought, may
have a lot of problems.

consider a scenario, index file has 20 entries, 5 of which are
unmerged. now you detach those 5 entries from index file and store
them in some other file say `index_unmerged_branch_name`. now index is
no longer unmerged, and user can now do `git stash push`.
later when user does `git stash apply` we put those 5 unmerged entries
back in the index file.

identified problems with this approach:

1) where do you store `index_unmerged_branch_name`? What if the user
has a file that's already named like that?
Solution: we store `index_unmerged_branch_name` in `.git` directory

2) how do you reference that to a specific stash commit? remember that
there can be multiple stashes.
Solution: we put that info in the `.git/log/refs/stash` file telling
it, that this particular stash has a separate
`index_unmerged_branch_name` file.
Although this would require changing format of log file and hence the
code logic to read it. but it could be done.

3) blobs that are referenced in this index may not be referenced by
any tree/commit anymore.
Solution: perhaps we can store the references too.
