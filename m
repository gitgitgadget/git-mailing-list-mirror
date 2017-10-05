Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CD11FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbdJEUzC (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:02 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:51913 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdJEUzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:00 -0400
Received: by mail-qk0-f172.google.com with SMTP id 17so16031330qkq.8
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SN3E8IZLz+FqTwHonwtM7261xc7zZLH0JfP1lyil2HQ=;
        b=UkhdI6U5zHXF32u/oiO/YPPtuKgixM10a28IZKHEwxRXHkxnlDIpAZHahJf1VKZJIC
         TsLOlYOM2qvxcLUigIvpL0dUxJ35vLPjSvoY2HLAH/hXiAXt0+JQoT6D51lE7xcdSKte
         hILPYmoTSpqfepBuLHP3G/nHDbOiX3ZfMhcov++qqMVre1kyvoqMIb0M4BNhH0Wj2p5C
         MdGfPL4mmYMCmz/ZJfdKxVjewS9lfNIh+foMdGvJMRse0Y5ynpSbPh3gOZfttDqC1BLx
         bnneh/+0rBoioS6Yj2oslBhog+Ii519ZJpxqDiFQ0S3Y2tqhca6PWYBqnVkNq69dpY+r
         n6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SN3E8IZLz+FqTwHonwtM7261xc7zZLH0JfP1lyil2HQ=;
        b=VxKvOQ8NGPXgfG2KMX6tM/vzFslUPvdAoWZbohGc7NaXLQyI9OCL0BzW5ojpuGtzPc
         KBeZAR6x55beXA/qGPMF3vI+KX4sqgnenxWk/ezFcMiNAtKH0qJ2aDG/f0im4A2bE2kS
         8516S1P4PM6H+3HnbeHN7k4cfhZVVNwQ0YKx/Hrw3WmASJ5GCO/q7s1eB5s7Ll6xJda+
         2VSiciyeGQyASqQhozdT1EZ58jEvQCTJRf9TNsZrocGmjv9U41WjwUYOsWo8tz2CPVfC
         sakmE7y3AyAC5v+6O8rFszB0G4Q2dDl/g+0Ke2jdtHS5YVQ0Q6P4SHusfDg8toj5VVl/
         D+Kw==
X-Gm-Message-State: AMCzsaUqZKBeaVFY8dAt5dIJe99lyJJrpyTIr1ieKeWdURzYZGsc4rgz
        XhH8879DgUPdW6EZLVsn12l6AvniEPo=
X-Google-Smtp-Source: AOwi7QAPc8CigL4mkmKfFBKpDQlGlmCBo+b/3mNwEtMvc8qvUg7u+NYagVkXxfFR8nkFApZB1FmdNQ==
X-Received: by 10.55.214.7 with SMTP id t7mr8763756qki.30.1507236899679;
        Thu, 05 Oct 2017 13:54:59 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:54:59 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 0/6] Teach Status options around showing ignored files
Date:   Thu,  5 Oct 2017 16:54:37 -0400
Message-Id: <20171005205443.206900-1-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

This patch series is the second part of [1], which was split into 2
parts. The first part, added an optimization in the directory listing
logic to not scan the contents of ignored directories and was merged
to master with commit 5aaa7fd3. This patch series includes the second
part to expose additional arguments to the --ignored option on the
status command.

This patch series teaches the status command more options to control
which ignored files are reported independently of the which untracked
files are reported by allowing the `--ignored` option to take
additional arguments.  Currently, the shown ignored files are linked
to how untracked files are reported. Both ignored and untracked files
are controlled by arguments to `--untracked-files` option. This makes
it impossible to show all untracked files individually, but show
ignored "files and directories" (that is, ignored directories are
shown as 1 entry, instead of having all contents shown).
    
Our application (Visual Studio) has a specific set of requirements
about how it wants untracked / ignored files reported by git status.
It requires all untracked files listed individually. It would like
ignored files and directories that explicity match an exclude pattern
listed. If an ignored directory matches an exclude pattern, then the
path of the directory should be returned. If a directory does not
match an exclude pattern, but all of its contents are ignored, then we
want the contained files reported instead of the directory.
    
The reason for controlling these behaviors separately is that there
can be a significant performance impact to scanning the contents of
excluded directories. Additionally, knowing whether a directory
explicitly matches an exclude pattern can help the application make
decisions about how to handle the directory. If an ignored directory
itself matches an exclude pattern, then the application will know that
any files underneath the directory must be ignored as well.
    
As a more concrete example, on Windows, Visual Studio creates a bin/
and obj/ directory inside of the project where it writes all .obj and
binary build output files. Normal usage is to explicitly ignore these
2 directory names in the .gitignore file (rather than or in addition
to *.obj). We just want to see the "bin/" and "obj/" paths regardless
of which "--untracked-files" flag is passed in. Additionally, if we
know the bin/ and obj/ directories are ignored, then we can ignore any
files changes we notice underneath these paths, as we know they do not
affect the output of stats.

[PATCH v1 0/1] Teach status to show ignored directories
[1] https://public-inbox.org/git/20170810184936.239542-1-jamill@microsoft.com/

Jameson Miller (6):
  Teach status options around showing ignored files
  Update documentation for new directory and status logic
  Add tests for git status `--ignored=matching`
  Expand support for ignored arguments on status
  Add tests around status handling of ignored arguments
  Handle unsupported combination status arguments

 Documentation/git-status.txt                      |  22 ++-
 Documentation/technical/api-directory-listing.txt |  28 +++-
 builtin/commit.c                                  |  32 +++-
 dir.c                                             |  44 ++++-
 dir.h                                             |   3 +-
 t/t7519-ignored-mode.sh                           | 195 ++++++++++++++++++++++
 wt-status.c                                       |  11 +-
 wt-status.h                                       |   8 +-
 8 files changed, 325 insertions(+), 18 deletions(-)
 create mode 100755 t/t7519-ignored-mode.sh

-- 
2.13.6

