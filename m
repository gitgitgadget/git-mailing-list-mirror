Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18741F453
	for <e@80x24.org>; Fri,  1 Feb 2019 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfBANRF (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 08:17:05 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:39220 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBANRF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 08:17:05 -0500
Received: by mail-pl1-f176.google.com with SMTP id 101so3213077pld.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bf8N45xve4krc9qq4KHGg8Cwl6Bz10Ht6S5a9wgs3is=;
        b=kjH5ntl22SvRJ0GYsughSVd6G2eONjw9KnNfTFQpyEASI00Z37i3NsNVzZVwwfBds0
         yoIzrEXuatYQMoiHL7PLwFIe+0f0NygOqaXzwM929PKidlHBfF2AvqXqLOHvswg7g51d
         QusXnljuxQUi8/vKJcah8cWN6GamxsF4/v+i7Kmtc6nOF7/suNp7D+y2lKz8IvgiTlm0
         Hm7tDXU74rp9Wsv9ZfWq/gFe9iYY1pAK80azhuA0u3byKUjDS9s2sbr+18HTuVfeP//8
         GGy+PcZuFia6ifer1QGDyPgSZSbIORScXMuf4cI59Xwmtz60jDExbq3RiDp3Dkp0OvFR
         QofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bf8N45xve4krc9qq4KHGg8Cwl6Bz10Ht6S5a9wgs3is=;
        b=qrqA9IHKAaxxkexekoyZl04wtDbgr82IGZw9nZt5oBnhTpYWBVa1jWlJtT7tQcVqNB
         QXZAB2a/T/pdC8P+z8BIeUBTodflZyqOVRUIe3n9oaD3kuGJJJocQzxyjDi4PGr3ls5D
         KUH/jrlzxNwYO8Q7lrz+41lTBEMZad41ZujOOBeNvAiMlBLRjBMugg8IbvoHXxG0DRQx
         OehlVOb7vT9LkHkLxsIbMRmDUaOmVSwkcOU90fmKd8Y8Ivc/OX+h0Y4NxMGJVD8uDSJr
         ZstXmqMjw2byozN2JjL1KUBUNegfZ3VnOrpgkmuthL6AWARidywLz7IKFocnQc9TAN3P
         rzKw==
X-Gm-Message-State: AJcUuke7ySq2McPpDOBmkkW0p6p6VmyjUIIBRqxuHivaKywJQF0Q7lSA
        6kEy9gF7pbNu5Hh8rHgj+afIt4OP
X-Google-Smtp-Source: ALg8bN7Uu0x9lyr3Sq/tIu9KbGNOOnNZndRD3X2qr+NJhU54oyVBn6DFkjkqlq9MgN1ZWbsuW/8Wgg==
X-Received: by 2002:a17:902:680f:: with SMTP id h15mr38846359plk.40.1549027024488;
        Fri, 01 Feb 2019 05:17:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 24sm15986367pfr.75.2019.02.01.05.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 05:17:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 01 Feb 2019 20:16:59 +0700
Date:   Fri, 1 Feb 2019 20:16:59 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Marketa Calabkova <mcalabkova@suse.cz>,
        Git List <git@vger.kernel.org>
Subject: Re: Worktree creation race
Message-ID: <20190201131659.GA30564@ash>
References: <89985b60-4c28-ebf0-64b1-8da75263d745@suse.cz>
 <2ee89ff3-e672-e940-f601-aa1d2647756a@suse.cz>
 <CAPig+cSdpq0Bfq3zSK8kJd6da3dKixK7qYQ24=ZwbuQtsaLNZw@mail.gmail.com>
 <CACsJy8D+zvgtw8RuBefYQsYrvn_vQT1dUO3Veg5ZtfQa2u5QKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8D+zvgtw8RuBefYQsYrvn_vQT1dUO3Veg5ZtfQa2u5QKA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 01, 2019 at 02:06:43PM +0700, Duy Nguyen wrote:
> worrying about races like this. The mkdir loop would be one way to go.
> But I'm going to add a new option to let the user control this
> directory name. This is necessary since this name is now exposed via
> "worktrees/<name>" reference space and should also be reported in "git
> worktree list". Avoiding the race is a nice bonus.

I'm not going to bother you with code yet (although if you want, you
can check out branch worktree-name on my gitlab repo), but this is
what the user facing changes look like. Looking good?

PS. I think this also calls for a command to rename working trees.
Sigh.. this worktree thingy never ends.

-- 8< --
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 18469e202e..d5db69dec7 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] [--name <name>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
@@ -195,6 +195,13 @@ This can also be set up as the default behaviour by using the
 --reason <string>::
 	With `lock`, an explanation why the working tree is locked.
 
+--name <name>::
+	Name of the working tree. Each working tree must have a unique
+	name. This is also the directory name containing all working
+	tree's specific information under `$GIT_COMMON_DIR/worktrees`.
+	If `--name` is not given, the name is based on basename(3)
+	optionally with a number suffix to make it unique.
+
 <worktree>::
 	Working trees can be identified by path, either relative or
 	absolute.
@@ -323,11 +330,15 @@ details on a single line with columns.  For example:
 
 ------------
 $ git worktree list
-/path/to/bare-source            (bare)
-/path/to/linked-worktree        abcd1234 [master]
-/path/to/other-linked-worktree  1234abc  (detached HEAD)
+(main) /path/to/bare-source            (bare)
+linked /path/to/linked-worktree        abcd1234 [master]
+other  /path/to/other-linked-worktree  1234abc  (detached HEAD)
 ------------
 
+The first column is the name of the working tree. The second column is
+the location of the working tree. The third column is the short commit
+name of the current branch. The branch name is put in square brackets.
+
 Porcelain Format
 ~~~~~~~~~~~~~~~~
 The porcelain format has a line per attribute.  Attributes are listed with a
@@ -341,10 +352,12 @@ $ git worktree list --porcelain
 worktree /path/to/bare-source
 bare
 
+name linked
 worktree /path/to/linked-worktree
 HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
 branch refs/heads/master
 
+name other
 worktree /path/to/other-linked-worktree
 HEAD 1234abc1234abc1234abc1234abc1234abc1234a
 detached
-- 8< --
--
Duy
