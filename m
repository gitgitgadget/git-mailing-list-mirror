Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E36108
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="gVxX0SM/"
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6831A8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso1781451a91.0
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827193; x=1698431993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VhcZcZ/VVp5Ky/pKedj5WxjIF/bakqVnlJFSCa0j1Xk=;
        b=gVxX0SM/iGwj9Y+udlt2trBt8zeAE24fPMfQSiKwIsxQvxXLY3xmPbVaTgSvX0pKQe
         RUv6eXgSGZBbQDB2JiTsPVB3cgovrzTGfWVSqVG7BvyT5Cl5vF+d4vpd9d7Su7U0GeZ4
         V10+SFFMunklGtRA+wwo7ovkhG+vWDyOvOyYIjNiXBe2eOoCxmgXYqf+7SI9QVBrlUWE
         mi5P1d715Ey1h3fo0jP/o1Dl4W9mW7O0f7WyzSWyabGcU2/iR2AkeLdCakprvpGap2Cg
         0DZVkuaideMXFH+LgAFN8LeNUa6nfrDlWZLaen+mhH1ypDMU5kuXeFpJV8pnDT9Teemx
         q0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827193; x=1698431993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhcZcZ/VVp5Ky/pKedj5WxjIF/bakqVnlJFSCa0j1Xk=;
        b=Me6fy+adcoMeCkdfDrkD55Cc7Yv2lu04HvNdbhSIKoggu8VwFqB9khp1uwFOAYbxtG
         BUCsmu5azeY93/iXonQWn/E61rEd+QasRx+YBQw1WB0lF7OU0Su7+eNOoVv9FdXg+pCW
         Ya/qeLzlCxHPi4NhDXIeVU9hbJHaSb6XUT84Dolu+/p+/a7+juRM22tRSMLHK2dXUaWq
         K0QGzUR5NHKgHEMWPXCNkUlsy2WxYM9RGYFrGgFvzoLnGO9mBg5c04Xk8uOpIdUx2hYf
         69NOk1g/SKMJ+2NP/jMNo7qWQ2tJhqcoCtK58li20LD3+Vty2u0e3paNxPmUnNgCq4hU
         28cg==
X-Gm-Message-State: AOJu0YwCU0k6sDL0PMNex9t/Ych7WqZAOLaE3bIrYZclLg5sCqiY2lgz
	wY44VGL1cWQh0jePo2ajsaFrdKfeKybtg6ekt+7s/r5AX5QnUA==
X-Google-Smtp-Source: AGHT+IEBW2VyyjrwocoEc/7KUuBIycDJgYvgh/yq/YFykVF4gccQiACymv04JjGH2V090oOlZhdK0g==
X-Received: by 2002:a17:90b:35c1:b0:27d:452a:8bb6 with SMTP id nb1-20020a17090b35c100b0027d452a8bb6mr3893879pjb.10.1697827192890;
        Fri, 20 Oct 2023 11:39:52 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:52 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Date: Fri, 20 Oct 2023 11:39:42 -0700
Message-ID: <20231020183947.463882-1-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a proposal / proof-of-concept for a new table-based output
format for the git status command, and for dry runs (-n) of the git add
command. This could be extended to create visual dry runs for other
other commands like rm, mv, restore, stash, commit, and clean.

For some context, earlier this year I released a tool called Git-Sim
(https://github.com/initialcommit-com/git-sim) which allows users to do
visual dry runs of many Git commands, which are rendered as high quality
output image files. Simulating commands like status, add, rm, mv, restore,
stash, and commit creates a table with 3 columns to represent the way file
changes "move around" as a result of the command being simulated.

I've gotten positive feedback from users about this visual approach to
simulating git commands, which is more intuitive than pure terminal text
for both newer users to understand how git works and for visual people.

As a result, I was thinking of ways to integrate these types of visual
formats directly into Git. A table-based output format with colored
highlighting for the commands mentioned above is low hanging fruit.

Teach 'git status' the new -t, --table flag, which displays the status
output in a 3-column table format, preserving terminology and color
coding from the default git status "long output" format (note that the
column headers are shortened here for the small width of this email, and
also I just realized that the tables below might not look right on the
mailing list due to the differing character width, but it looks correct
in the terminal so please test there it's more fun anyway :D):

$ git status -t
-------------------------------------------------------------------------
|    Untracked files    | Changes n...or commit | Changes t...committed |
-------------------------------------------------------------------------
|         poiu          |                       |                       |
|     status-table/     |                       |                       |
|                       |                       |         asdf          |
|                       |        table.c        |                       |
|                       |      wt-status.c      |                       |
-------------------------------------------------------------------------

Teach 'git add' the new -t, --table flag to be used ONLY in combination
with the '-n' flag for dry runs. Instead of simply printing out the
added filenames, the full status table format is displayed, along with
arrows that visually show how the added files are being moved around:

$ git add -nt poiu wt-status.c
-------------------------------------------------------------------------
|    Untracked files    | Changes n...or commit | Changes t...committed |
-------------------------------------------------------------------------
|         poiu -----------------------------------------> poiu          |
|     status-table/     |                       |                       |
|                       |                       |         asdf          |
|                       |        table.c        |                       |
|                       |      wt-status.c ----------> wt-status.c      |
-------------------------------------------------------------------------

Other notes:

* The width of the table and columns are dynamically set based on the
  width of the terminal.

* Long paths are shortened to include the maximum number of characters
  from both ends of the path that will fit, with a '...' in the middle.

* Color coding matches the default output of 'git status', with
  untracked files and working dir mods in red, and staged changes in
  green. If needed, arrows are drawn in cyan.

As stated above, the dry run version of the table format can be applied
to various other commands like rm, mv, restore, stash, commit, and clean
which all move file changes around in a way that can be represented in
the table format. New columns may need to be added or arrows reversed
to show changes moving in various directions. Note that some of these
commands don't appear to have a dry run (-n) option yet, so it could be
added for consistency (if not already in use) and for use with the new
table format.

Since this is an RFC patch series, I probably did some illegal and dumb
things in my code changes just to get it into a demo-able state. I am a
bit wary of having made changes to files like "read-cache.c" and
"read-cache-ll.h" to pass in the wt_status info, and there are probably
betters ways to do some other things too.

Feedback on both the new format itself and the implementation is very
much appreciated!

Jacob Stopak (5):
  status: introduce -t, --table flag
  status: handle long paths with -t, --table flag
  status: add advice arg for -t, --table flag
  add: add -t, --table flag for visual dry runs
  add: set unique color for -t, --table arrows

 Makefile         |   1 +
 builtin/add.c    |  46 +++++++--
 builtin/commit.c |   4 +-
 read-cache-ll.h  |   9 +-
 read-cache.c     |  32 ++++++-
 table.c          | 245 +++++++++++++++++++++++++++++++++++++++++++++++
 table.h          |   6 ++
 wt-status.c      |  74 +++++++++-----
 wt-status.h      |   3 +
 9 files changed, 378 insertions(+), 42 deletions(-)
 create mode 100644 table.c
 create mode 100644 table.h

-- 
2.42.0.402.gbe8243af7b.dirty

