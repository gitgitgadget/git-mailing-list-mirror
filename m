Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D53202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 17:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbcGTRY7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 13:24:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35850 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbcGTRYz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 13:24:55 -0400
Received: by mail-lf0-f65.google.com with SMTP id 33so4000560lfw.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 10:24:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrrgdGEwGGCTybfVmLIH3FQ1+fswZVtIsYkzBBRui44=;
        b=eIkl5GdJJJkvqVqt3OW5huSaAya6MOtTDpFEr8a+vg3gWeBHGLMBHMyqyuoFmJN2bv
         Vbbd9kdh95BIFz1ULwNxH92gEL9uLIp8xk6pC2QAkOGEzyZ+X5rHUkXEmDTcWhyTIYIw
         BAvAZH237M6QI6n7DKgsxD6ZYUqhY0qh+hoS7mMirJjlW5iOZckSZnz/5rGL2WSspJRe
         d01bVjeeDfg1lKdBElXky/V54Bhg+LMf0SASrCWTNUrCoXyAeO/0KXzTrXNswermfZCl
         5ujdxxKWU+5qBpMY6brIt8Gqr8et5xR41CNTV0XOeS3aSl+42q4qzSscQ3OmE3qegQgA
         uUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrrgdGEwGGCTybfVmLIH3FQ1+fswZVtIsYkzBBRui44=;
        b=CqyI1MJ1SqkJTBDHnIMxwizG6/tLn+4qAjHMknhwzYAnLqHUPVsXnXW0gWvk36D7TU
         BIYjYf8FFICxmSwJ7rXR6DGP43Qm1XSMmUgZFYOgdoy+klmzIOUoQNq1AczzQfWpljQA
         qD2fsS46SjkfKMdtsZrcll3vfM1Je6GM+8CxNerBC4DWZINtD6PRQjxCXv7l8PWyX/Jl
         jXIms0f9jGYvyVTs0OR276HrnZ7n2d/4pjBLibkwQzFwnLuiBzVuVl80qkqSY6WLdhSG
         lFMsv3aCD6DlVNyXO2C1uakoaE7Um77UPcwcsM8rcGSqBjxECT04cXliWBlIVybZ1i8i
         tR1g==
X-Gm-Message-State: ALyK8tLLfpLGlS8h5W8HPOV+HMfkOc4jRe9wEhRzNuFGKqWqUWUjeVqR7OutHlnSNq9iZA==
X-Received: by 10.25.83.85 with SMTP id h82mr7697683lfb.97.1469035493254;
        Wed, 20 Jul 2016 10:24:53 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g74sm777884ljg.24.2016.07.20.10.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jul 2016 10:24:52 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	max@max630.net, Junio C Hamano <gitster@pobox.com>,
	git@drmicha.warpmail.net, Jens.Lehmann@web.de,
	larsxschneider@gmail.com, sbeller@google.com, mhagger@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 0/4] Split .git/config in multiple worktree setup
Date:	Wed, 20 Jul 2016 19:24:15 +0200
Message-Id: <20160720172419.25473-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.9.1.566.gbd532d4
In-Reply-To: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 6:14 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> If yes, do you know if someone is working on this? If nobody is working on this, do
>> you have some pointers for me what the main problems are?
>
> The blocker is config file being shared (you do not want to share
> core.worktree and submodule.*). I made some progress last weekend,
> just needed to add some tests to see if submodule works as expected
> and will post the series soon. Then you can take over if you want ;)

Here it is. I'm going to describe some more for new people. Let's
start with the problem, then the high level solution and finally
what's done in submodule. These are separated by ^----$

Multipl worktrees in its current form share the config file. The only
exceptions are core.bare and core.worktree which will be applied for
the main worktree only, if present in the config file.

This does not make submodules happy because submodules use
core.worktree to link back to the real repos stored inside .git dir of
the super modules. This is not so bad right now because the
submodule's worktree would be "main" worktree and core.worktree sticks
to it. If one day "git submodule add" initialize the worktree as a
linked worktree, problem arises.

The second problem is more real. When you initialize submodules,
submodule info is stored in the supermodule's config file, which is
shared. So the secondary worktree will not be able to initialize its
own submodules (and may be confused by the existing submodule.*
section).

----

So we need to split the config file into two logical parts: a shared
part and a worktree-specific one. This makes everybody happy even
though it's not easy.

What this series does is adding "git config --worktree" which writes
to the worktree-specific part, while "git config" writes to the shared
part. "git config" as a read operation will read the shared part
first, then the worktree specific part.

Now. In current multiple worktrees setup, both the shared and private
parts are in the same file, "config". And "git config --worktree" will
refuse to work if you have more than one worktree. For it to work with
multiple worktree, you need to enable extensions.worktreeConfig (in
config file).

This extension designates the file "config.worktree" as storage for
the private part. It can be .git/config.worktree for main worktree, or
.git/worktrees/xxx/config.worktree for linked ones.

Before enabling extensions.worktreeConfig (or soon after it), you need
to move core.bare and core.worktree to .git/config.worktree because
the exceptions above are gone. If they are present in "config" file,
they are _shared_ (and hell follows)

If you have followed through the first four iterations, v4 [1] has
very close design. The main difference is: in v4, "config" is
per-worktree and the shared part is split away, hidden in
.git/common/config. This leads to the migration and backward
compatibility problems.

The new design is free of that because "config" remains shared while
the private is hidden away. The risk is "git config" by default writes
to the shared part. Accidentally sharing something may be more
dangerous than accidentally _not_ sharing something like v3 [1] (which
defaults to per-worktree). I've thought about this and I'm willing to
take the new direction, bettting that 90% of the time people want to
share, so it's a rare problem.

----

With all that in place, what does a command have to do to take
advantage of it?

- Whenever you need to write a per-worktree config (you decide it!),
  use "git config --worktree". That's it. You don't really need to
  care where it ends up to. This is what 3/4 is, for submodule.

- Avoid "git config /path/to/.git/config" because that may or may not
  be the right place (there's also config.worktree now). Builtin
  commands have this worse because if you look at _another_ repo, then
  you may need to go through repo detection and stuff before you can
  read its config. I just fall back to running "git config" in 2/4.

So that's it. It seems to be running ok. But I know very little about
submodules to test it properly.

The only problem left that I have to work out is config deletion. I
suppose we could follow the chain backward again: try to delete in
per-worktree config file first. If not found, try again in the shared
config file...

[1] http://thread.gmane.org/gmane.comp.version-control.git/281906/focus=284803
-- 
2.9.1.566.gbd532d4

