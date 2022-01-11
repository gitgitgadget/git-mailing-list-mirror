Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345E0C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 21:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiAKVPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiAKVPr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 16:15:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBDC061751
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 13:15:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m4so1381683edb.10
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/E15//QTHzYbwn6ayW8fzHbhwtm7VD3Gz+NNxOiK6vU=;
        b=OpABS90jDnves9x4XHFNbvlS6a1NfozgvWUPGqELH8QgWkFhLBjQFulC8+cZvkELq4
         NbMRluIlT29U/WUJd4qxlicw7VRZRJPZZaiau0R+qjchJa7XROV1pZPKU54FnvdTmyEF
         U3KHjKFnPpZwtPD2kaskMt/0IX0vXiLWrNsu5pGSz23eVQv1hNXtf3bbcOsRvNRjj7nu
         xlTYWqb9XFkk4Gy20ACpdEav+y0qHz0wY4skwMjEJFya3bWjfKkCAIYa0Uixq+/HSCXV
         881PSQm4Zfk9g3UG9ZQ/kGTCbSoakTVtpzw5chq6WTbxXjcBW3B24ZafTjZTcWFwUbEb
         zQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/E15//QTHzYbwn6ayW8fzHbhwtm7VD3Gz+NNxOiK6vU=;
        b=j0qmuRkDZxy+aneKxZVqqRLvY3HMgEdkkjvUR5FcLQMyn62FmKmdorX9+K7ejLx16M
         lqCYK+5G827gF8GSMKaJimJBkYP8VwLZL97RikUzvFp00H2dsJRlYQ9RYjG//82vtMuW
         HwJgqZ5H8A7Zpsr3b2hvE2LePiCmgR8LPdVk4iGjBpIwVKfFJ9riXSJ+p60HDk85kLb7
         DjTCHeh0TSXvb8xnS3YRpKf5CWWcR26PYVhtxqFp2GuAiornrhQ2wdQ2glkyAXUrAPOt
         ndU3xOdt/SlaSWOWHqw6vVeGm2zsvsdNcOg00eNBnUYMcUj9cPXRhvRbJkq4jV5hfTqV
         ne0Q==
X-Gm-Message-State: AOAM533xDAGQKGvjbSFJh3l8ACZC0DMLWZU2Hj57Qlxu8LQMQGwvbez/
        sYwsOzvFnycQsve16y+kAp80W9LjIzOV8ehSMWs=
X-Google-Smtp-Source: ABdhPJx6J6fWCLC/6mrNYrxZRxPvYzQcWFUfZb6BxVh/1ccuNhCg228Nd75f+j/QEZJj87Y0L4aeKkqHQXB8hjnrp50=
X-Received: by 2002:a17:907:2d10:: with SMTP id gs16mr5070766ejc.100.1641935744887;
 Tue, 11 Jan 2022 13:15:44 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
In-Reply-To: <CABPp-BHJvFx0fxobYZ2vauK=KfCLF_7So8xABLjqr9rx4SVy-w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Jan 2022 13:15:33 -0800
Message-ID: <CABPp-BEQ5BBEgB21hUNBuioOfMry_x2nKOLgY8=v2w8eGXrsyw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 9:59 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jan 10, 2022 at 5:49 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
...
> >, therefore it expects the resolved conflicts to
> > be in _files_. I don't think that there is a way to reasonably handle
> > symlink target conflicts or directory/file/symlink conflicts, but there
> > might be.
>
> You really need (mode,oid) pairs to be provided by the user.  That
> fixes the executable issue I mentioned above, and makes it clear how
> to handle symlinks and file/symlink conflicts.
>
> directory/file are still handled by providing individual files, but
> ordering traversal becomes really tricky.  The directory/file case
> might even require the pre_resolved_conflicts to be pulled out of that
> loop somehow.  It'd take some investigative work, or some deep
> thought, or both.

I think I came up with a solution to this during my run yesterday,
though I haven't tried or tested it.  Instead of modifying the loop
over plist.items, you instead add a preliminary loop over
pre_resolved_conflicts that modifies opt->priv->paths (and add this
preliminary loop just before the items from opt->priv->paths are added
to plist.items).  In that preliminary loop, you need to make sure that
(a) any files in pre_resolved_conflicts corresponding to existing
_files_ in opt->priv->path result in updating that item's clean &
is_null & mode & oid state, (b) any files in pre_resolved_conflicts
that correspond to existing _directories_ in opt->priv->path need the
value to be expanded to be a conflict_info instead of just a
merged_info, you need to set the df_conflict bit, and don't update the
merge_info fields but do update the extended conflict_info ones, (c)
any new files in pre_resolved_conflicts result in new entries
opt->priv->paths, (d) any leading directories of new files in
pre_resolved_conflicts are appropriately handled, meaning: (d1) new
opt->priv->paths are created if the directory path wasn't in
opt->priv->paths before, (d2) a tweak to df_conflict for the directory
item if it previously existed in opt->priv->paths but only as a file
(possibly also necessitating expanding from a merged_info to a
conflict_info), (d3) no-op if the directory already existed in
opt->priv->paths and was just a directory (and in this case, you can
stop walking the parent directories to the toplevel).

Then, after this preliminary loop that modifies opt->priv->paths, the
rest can just proceed as-is.

That should handle new files, new directories, and all directory/file
conflicts.  Yeah, it's a bunch to look at, but directory/file
conflicts are always a bear.
