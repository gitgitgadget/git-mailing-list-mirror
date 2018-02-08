Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF6C1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeBHWJ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:09:28 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:40189 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHWJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:09:27 -0500
Received: by mail-io0-f181.google.com with SMTP id t22so7481728ioa.7
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=WaP1jpdeSJhAoqU8uJzmrLHCdqIU9v3yQDs3AatLhfY=;
        b=sndT42VQX64z+lWHPxD/jIDben+ebcQc4Ujpe/os88BGYRdR6shUu6ftJq4X8If5DB
         4Qi1XWxlLdbTytd+AF7FgYi/7ULuvuE4GnJ3Kbq2Eo0pvWxULM0QFFSveDkm5jcRllon
         A/CClj8JA2GqOx4eFUV0iXP9OmAGHyqE2qP3wlxChnhQYlhL6zEfqD4VyQi96CtQZ+W7
         0k1vYumBgHyGwQ/aLi+trOO7yo6mQOqZu/KlR1A7idbjvY5rxvkqq2RGigOz0irfkYTT
         cqHTW2cW7fMY21DnpU+KS5PRYd3n/zOc9N9XFtq59tcLO2U0eiMkxlDLjFJ7EpVySv0d
         LRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=WaP1jpdeSJhAoqU8uJzmrLHCdqIU9v3yQDs3AatLhfY=;
        b=bVMmVEew45epP1oVYkPeKPGy19pcjZIrUK+vj3gWbPvwqLW5vLN1jjDxBpaVYKDdIJ
         FJgJxwaCuh20LgvmWBJ43sQ5Z+82PntMrkrXGpO0NDTSDJM+fpEjX8cr6meX4vF40TeJ
         LxvLx+Me5yLB5ZKPrbDRfwLSXrX4LM9vqOw8+WkpA5USfcg5xiHRfOYRYUon5QLZ9Rki
         70HJs43Cd0v6E47mbwjTNC6A/8Qp31QlEvZSuuyaE3UQ7rBmEEuif+YDmnVZbi2wCgy7
         Bxiq23kjv7OcGDr8ER2kfTWWHRPvizC0LL3vwWXqMRRf8e6hDObk1MmsKhi2oG2KkNEY
         OPVQ==
X-Gm-Message-State: APf1xPCw6rKfUM/aE20qmkYE84eQJ8tif9N3KCrEd+QxK4BOC9rUdeKp
        c2Ikutl22RPd7cjhuaO365ftAF4a2eTVPDkiYrE=
X-Google-Smtp-Source: AH8x227yBl+Xb73PsOxniXtREYOcRlnTANjrqqymIDj9olYNlLcrTNtV7uHzeXFeQPsLGmtHfJ5LevVPOBoY0H2D+8w=
X-Received: by 10.107.78.5 with SMTP id c5mr770757iob.120.1518127767053; Thu,
 08 Feb 2018 14:09:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.59.196 with HTTP; Thu, 8 Feb 2018 14:09:25 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Feb 2018 14:09:25 -0800
X-Google-Sender-Auth: -Wb479crDMG7khLL7iZ2wA7gGaE
Message-ID: <CA+55aFzaxTrki92C8ih3M3BtYHU3BG8P2SWwvdWiTXZWFDH=1Q@mail.gmail.com>
Subject: Left-over COMMIT_EDITMSG file in gitdir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This may be intentional, but if so, it's not obvious..

Back long long ago, the original "git commit" shell script got rewritten in C.

In that rewrite, removing some temporary files seems to have been left
out. At least one: .git/COMMIT_EDITMSG.

In the original commit.sh shell script, we can find this:

  rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"

after creating the commit.  In the C implementation, we do have a
number of "unlink(...)" calls:

        unlink(git_path_cherry_pick_head());
        unlink(git_path_revert_head());
        unlink(git_path_merge_head());
        unlink(git_path_merge_msg());
        unlink(git_path_merge_mode());
        unlink(git_path_squash_msg());

but no

        unlink(git_path_commit_editmsg());

and that *seems* to be an oversight.

Similarly, builtin/tag,c leaves a stale TAG_EDITMSG file behind.
Again, that actually did exist in the original shell script, which
used to do

  trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG
"$GIT_DIR"/TAG_EDITMSG' 0

which caused that file to be removed at exit.

I guess I really don't care much, but those two files struck me when I
was doing a "git gc --prune=now" and looked at what was still left in
the .git directory..

If this is all intentional, never mind.

               Linus
