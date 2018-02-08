Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98F921F576
	for <e@80x24.org>; Thu,  8 Feb 2018 10:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeBHKwO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 05:52:14 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:53968 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeBHKwN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 05:52:13 -0500
Received: by mail-it0-f50.google.com with SMTP id i144so5994768ita.3
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 02:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=f8qkOvs3PSai+B2pbOdZpAUi2aZmU0RRUd0hQ6B6ICQ=;
        b=L00Bm3sdT6acOJg+gUp/neXGTXPk5IhrDLxeEjjQVJqAZHgqBAQldcXq9KbikUDvpZ
         x+yMqrsyA1GpRuOUtc6LULMzJfgClxkkJtubi5aqNaIIqizYRxuM7pcUdif53QNQlFwT
         mraQvmE/NCFrOstqVS8seZVHcK4vTaKb59gWWEnPPA7d0d5voZirV4XMooNlM3DxYBEK
         25IKQ+9riVBiwuudchN9ip2rd5T69ZN2oBoyJ3xz+GMIi23jyPfZi6Achr4lnrTqSk2O
         Z91QczgyDcP2z2RKC+/x9XWaiMf4j4Tvpr0sCklK+5MhFWU6XAxumMSeOFj8kujZhDkj
         BB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=f8qkOvs3PSai+B2pbOdZpAUi2aZmU0RRUd0hQ6B6ICQ=;
        b=Pb0wH5AZ2EPtuGC3gEpPruZM0IRhKla7l5bVnPn1WsqvopPNvI8z0Xhqf81B8VPfIJ
         fZXM12w/I6nk9QGmWkWzWFGhiyYVxPLna4qQukXhbrqbfXIJHVen/H3C0w9O1qUlgV7x
         z9U2ivlVka2hgfgOQ5GcYhFr8N2ZHu4Qay1QE79hQ1RFDfcpZ6QwerOTrTmELzefpb9y
         c4ELvX6QTrjFGOivs9Be16Y9ZdVcg+78lW0I6bm9eIbnDwv5kboQXtitw9Fh1Rsxia7/
         Ukm1kwXqB1EjJ8+0WHzc3mYa2vEdOPebqjRG86hMPQfx5B6bPLR4e3aMKSFg9dNhAzo+
         6qLQ==
X-Gm-Message-State: APf1xPAPCEq9dI+Q27BpbHMWsccLlRRHBCXGloBlQJWnbK73jPEe/vzI
        OVFpZq4QDQfR3J4WiuGmsR4EyibwBixbS/DE23YtfQsE
X-Google-Smtp-Source: AH8x224O17yejiqUOUfiISbUNI6m8HwyjG9LsRO0D5tjAHUiYH1edpOepLwEwgySRWYH/om8sCfS7xk0wp+sKcmJqY0=
X-Received: by 10.36.93.136 with SMTP id w130mr830753ita.106.1518087133098;
 Thu, 08 Feb 2018 02:52:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.203 with HTTP; Thu, 8 Feb 2018 02:51:57 -0800 (PST)
From:   "Nick O'Leary" <nick.oleary@gmail.com>
Date:   Thu, 8 Feb 2018 10:51:57 +0000
Message-ID: <CAF=vhqdJ2fByjSVt37b34wQUFo5_tb7rHbCddsaCzdvKywSBdg@mail.gmail.com>
Subject: Unexpected git diff output during merge conflict
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a merge conflict on a file and the git diff output looks wrong to me.

Here's how to recreate:

On branch 'dev' add/commit a file (called README.md) with the contents
( '------' used to delimit the file, not included in the content):

-------
This is my default readme
-------


On branch 'master' add/commit the same file with the contents:

-------
merged-history-test
===================

### About

This is your project's README.md file. It helps users understand what your
project does, how to use it and anything else they may need to know.
-------


Then, whilst on master, run `git merge dev` and get the inevitable
merge conflict on this file.

Running `git diff README.md` gives:

$ git diff README.md
diff --cc README.md
index 61d78b2,620d806..0000000
--- a/README.md
+++ b/README.md
@@@ -1,7 -1,1 +1,11 @@@
 -This is my default readme
++<<<<<<< HEAD
 +merged-history-test
 +===================
 +
 +### About
 +
 +This is your project's README.md file. It helps users understand what your
- project does, how to use it and anything else they may need to know.
++project does, how to use it and anything else they may need to know.
++=======
++This is my default readme
++>>>>>>> dev

This does not look right to me. The 'This is my default readme' line
has ++ at the start - suggesting its new to both parent copies of the
file, which isn't the case - it came from the dev branch so should be
prefixed with '+ '.
I'm also not clear why the line beginning 'project does' has both a -
and ++ prefix.

In every description of the Combined Diff format that I've been able
to find, they only show having '+ ' or ' +' prefixes on the actual
content and '++' on the <<<</=====/>>>> lines.


Am I missing something here?

Thanks,
Nick
