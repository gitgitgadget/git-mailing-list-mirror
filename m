Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A10A201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966181AbdEOTOC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:14:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35786 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964967AbdEOTOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:14:00 -0400
Received: by mail-qt0-f193.google.com with SMTP id r58so17353142qtb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZfmCpiPXVFYswke4NF073Y10JZtk8OZlVn5532/00k=;
        b=VTwJ0k9AcnpWyrSV6K802cTnOBwzFsnSvnUJGxaCLTfOVSdLIGH+3gCsOrf9XZPZGA
         1H6e4TRRUNDkqH3GXpnjHKUOuQTzO2r9ml7lFxnxJMwm9QmuC7zCk5OQ9IWm4BWCmv2G
         Qros3g/msepFg5vG2cxXqxEb1g7o6i0t4CORGxNbzZXMKnaLgEnNdEKykPpdyP7cSzMF
         aDLeb57N/nk4VLvCENGTcSnOgMECjlNHUAsXe8TtB6lryoomo1oFVPaVHAEMeVpQOS5u
         EEPMDXXlubDX43odpoKoxTsXEtws6JOw/iVfTOpbo193gPd362Mo+bcT3VHyQIQWxoRt
         24iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZfmCpiPXVFYswke4NF073Y10JZtk8OZlVn5532/00k=;
        b=XSvTyHotu5VPY2gFFbSiiOhfvDw7hY2stleKPY+SjDnzeIbbyx4CmgjUK5sa3HI7KF
         5/c/cnZPvAyCGjh+0bfrCeg4glimGg30WlYPu/OVKvQbBzZYCw3wQ4VgyirniQ+FxE7G
         DtJSK5OayUsSHKMe6SeVI8B+SZQZaDDsKQJg5M7mwaF4635JuMYIaaEHg3p4tPU4Sj0X
         pKorrs3AQSTzmiGqZx9diIk3/szbkKh0RvHcb2k+MkQFuhr+kGkWUxPlAgjsD0NAXcEO
         wLLUq8t9VCnY+jP9K9Swd9NjLy9+KK7dxs6VlUork4QzdwWr/wL9C6ryUrF/uHw7r32K
         T6DA==
X-Gm-Message-State: AODbwcC8f2SRzJIXVfw3+jk+fNn+13g1DVYMiJ0l1/cDVrVTmvfJhXbe
        q2gRjVvD4TSJLQ==
X-Received: by 10.200.37.227 with SMTP id f32mr7610088qtf.221.1494875639473;
        Mon, 15 May 2017 12:13:59 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 47sm9086903qts.26.2017.05.15.12.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:13:58 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v1 0/5] Fast git status via a file system watcher
Date:   Mon, 15 May 2017 15:13:42 -0400
Message-Id: <20170515191347.1892-1-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Goal
~~~~
 
Today, git must check existing files to see if there have been changes
and scan the working directory looking for new, untracked files.  As the
number of files and folders in the working directory increases, the time
to perform these checks can become very expensive O(# files in working
directory).

Given the number of new or modified files is typically a very small
percentage of the total number of files, it would be much more
performant if git only had to check files and folders that potentially
had changes. This reduces the cost to O(# modified files).

This patch series makes it possible to optionally add a hook process
that can return the set of files that may have been changed since the
requested time.  Git can then use this to limit its scan to only those
files and folders that potentially have changes.

Design
~~~~~~

A new git hook (query-fsmonitor) must exist and be enabled 
(core.fsmonitor=true) that takes a time_t formatted as a string and
outputs to stdout all files that have been modified since the requested
time.

A new 'fsmonitor' index extension has been added to store the time the
fsmonitor hook was last queried and a ewah bitmap of the current
'fsmonitor-dirty' files. Unmarked entries are 'fsmonitor-clean', marked
entries are 'fsmonitor-dirty.'

As needed, git will call the query-fsmonitor hook proc for the set of
changes since the index was last updated. Git then uses this set of
files along with the list saved in the fsmonitor index extension to flag
the potentially dirty index and untracked cache entries.  

refresh_index() and valid_cached_dir() are updated so that any entry not
flagged as potentially dirty is not checked as it cannot have any
changes. This saves all the work of checking files and folders for
changes that are already known to be clean.

If git finds out some entries are 'fsmonitor-dirty', but are really
unchanged (e.g. the file was changed, then reverted back), then Git will
clear the marking in the extension. If git adds or updates an index
entry, it is marked 'fsmonitor-dirty' to ensure it is checked for
changes.

The code is conservative so in case of any error (missing index
extension, error from hook, etc) it falls back to normal logic of
checking everything.

A sample hook is provided in query-fsmonitor.sample to integrate with
the cross platform Watchman file watching service
https://facebook.github.io/watchman/


Performance
~~~~~~~~~~~

The performance wins of this model are pretty dramatic. Each test was
run 3 times and averaged.  "Files" is the number of files in the working
directory.  Tests were done with a cold file system cache as well as
with a warm file system cache on a HDD.  SSD speeds were typically about
10x faster than the HDD.  Typical real world results would fall
somewhere between these extremes. 

*--------------------------------------------------------*
| Repo on HDD | Cache | fsmonitor=false | fsmonitor=true |
*--------------------------------------------------------*
| 3K Files    | Cold  |           0.77s |          0.55s |
+--------------------------------------------------------+
| 100K Files  | Cold  |          38.76s |          2.17s |
+--------------------------------------------------------+
| 3M Files    | Cold  |         421.55s |         18.57s |
+--------------------------------------------------------+
| 3K Files    | Warm  |           0.05s |          0.24s |
+--------------------------------------------------------+
| 100K Files  | Warm  |           1.13s |          0.40s |
+--------------------------------------------------------+
| 3M Files    | Warm  |          59.33s |          4.19s |
+--------------------------------------------------------+

Note that with the smallest repo, warm times actually increase slightly
as the overhead of calling the hook, watchman and perl outweighs the
savings of not scanning the working directory.


Open Issues
~~~~~~~~~~~

The index extension currently has a 32 bit version number, a 64 bit time
and a 32 bit bitmap size.  Do I need to quad-align the version and
bitmap size in the index extension or can all supported platforms handle
dereferencing memory that isn't quad aligned?


Credits
~~~~~~~

Idea taken and code refactored from 
http://public-inbox.org/git/1466914464-10358-1-git-send-email-novalis@novalis.org/

Current version as a fork of GFW on GitHub here: 
https://github.com/benpeart/git-for-windows/tree/fsmonitor


Ben Peart (5):
  dir: make lookup_untracked() available outside of dir.c
  Teach git to optionally utilize a file system monitor to speed up
    detecting new or changed files.
  fsmonitor: add test cases for fsmonitor extension
  Add documentation for the fsmonitor extension.  This includes the
    core.fsmonitor setting, the query-fsmonitor hook, and the fsmonitor
    index extension.
  Add a sample query-fsmonitor hook script that integrates with the
    cross platform Watchman file watching service.

 Documentation/config.txt                 |   7 +
 Documentation/githooks.txt               |  23 +++
 Documentation/technical/index-format.txt |  18 +++
 Makefile                                 |   1 +
 builtin/update-index.c                   |   1 +
 cache.h                                  |   5 +
 config.c                                 |   5 +
 dir.c                                    |  15 +-
 dir.h                                    |   5 +
 entry.c                                  |   1 +
 environment.c                            |   1 +
 fsmonitor.c                              | 233 +++++++++++++++++++++++++++++++
 fsmonitor.h                              |   9 ++
 read-cache.c                             |  28 +++-
 t/t7519-status-fsmonitor.sh              | 134 ++++++++++++++++++
 templates/hooks--query-fsmonitor.sample  |  27 ++++
 unpack-trees.c                           |   1 +
 17 files changed, 511 insertions(+), 3 deletions(-)
 create mode 100644 fsmonitor.c
 create mode 100644 fsmonitor.h
 create mode 100644 t/t7519-status-fsmonitor.sh
 create mode 100644 templates/hooks--query-fsmonitor.sample

-- 
2.13.0.windows.1.6.g4597375fc3

