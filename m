Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215CD1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405222AbeKWWBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:05 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:6050 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbeKWWBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:05 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SSg6d1g; Fri, 23 Nov 2018 11:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971832;
        bh=0998gc8ZejZEZtKKtOjGKnFcrkAXlRuYh13FBYvXOTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=jvFDVY2bYcW1zB60Gk0efQQU+rs3SmMFq7zGEJq+stAOdyWUfiZ1mzzqaJ/WJxYdz
         d12D6fXtXmHAI/ij4t3Tvp3rYgDcskFugFUJ7llXyuT9ll3+2o43KXC3lwu/7SFakC
         1wRwUc04YyVs5XPdS6tW4BhrxIhudHRzHDU/VGdE=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=8zUNUy7P4OxzEhgFmEkA:9
 a=udaFBb1ndwMSLKr_:21 a=KjFHNWtBf9lYOp_b:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
Date:   Fri, 23 Nov 2018 11:16:49 +0000
Message-Id: <20181123111658.30342-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLJEnXTFHf8NvkXdda5EvfG3NyCgzftWOx8Trpn8vrPmawA9wiZz0z6vIk0zDmRENDXMzUyvlDVn0gYqn6+V9MyqI4UPa892V2nkCNs1XK+c3oObg/Tu
 VpYves9J781V/LkxEv3Bq4nk7rooZgjqXJf18DNmf7a3HVVIn3lI4AUE3pg5F9CfFGEnD9vP2eMHYtoTi5H44kxPGxTb9QrPJFYNzSn+6GAb4ztzD1NlbT3h
 k+egFMZsrgzJFYPIB3p4yhHuGEyGS5AJnyEh7N67QM419WvkOaSUWf0EfFy3DVPV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Thanks to Stefan for his feedback on v1. I've updated patches 2 & 8 in
response to those comments - see the range-diff below for details (the
patch numbers are off by one in the range diff, I think because the
first patch is unchanged and so it was used as the merge base by
--range-diff=<old-head>. For some reason the range-diff also includes
the notes even though I did not give --notes to format-patch)

When trying out the new --color-moved-ws=allow-indentation-change I
was disappointed to discover it did not work if the indentation
contains a mix of spaces and tabs. This series reworks it so that it
does.


Phillip Wood (9):
  diff: document --no-color-moved
  Use "whitespace" consistently
  diff: allow --no-color-moved-ws
  diff --color-moved-ws: demonstrate false positives
  diff --color-moved-ws: fix false positives
  diff --color-moved=zebra: be stricter with color alternation
  diff --color-moved-ws: optimize allow-indentation-change
  diff --color-moved-ws: modify allow-indentation-change
  diff --color-moved-ws: handle blank lines

 Documentation/diff-options.txt |  15 ++-
 Documentation/git-cat-file.txt |   8 +-
 diff.c                         | 219 +++++++++++++++++++++------------
 t/t4015-diff-whitespace.sh     |  99 ++++++++++++++-
 4 files changed, 255 insertions(+), 86 deletions(-)

Range-diff against v1:
1:  ae58ae4f29 ! 1:  4939ee371d diff: use whitespace consistently
    @@ -1,9 +1,10 @@
     Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    -    diff: use whitespace consistently
    +    Use "whitespace" consistently
     
    -    Most of the documentation uses 'whitespace' rather than 'white space'
    -    or 'white spaces' convert to latter two to the former for consistency.
    +    Most of the messages and documentation use 'whitespace' rather than
    +    'white space' or 'white spaces' convert to latter two to the former for
    +    consistency.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ -29,6 +30,39 @@
      	whitespace is the same per line. This is incompatible with the
      	other modes.
     
    + diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
    + --- a/Documentation/git-cat-file.txt
    + +++ b/Documentation/git-cat-file.txt
    +@@
    + stdin, and the SHA-1, type, and size of each object is printed on stdout. The
    + output format can be overridden using the optional `<format>` argument. If
    + either `--textconv` or `--filters` was specified, the input is expected to
    +-list the object names followed by the path name, separated by a single white
    +-space, so that the appropriate drivers can be determined.
    ++list the object names followed by the path name, separated by a single
    ++whitespace, so that the appropriate drivers can be determined.
    + 
    + OPTIONS
    + -------
    +@@
    + 	Print object information and contents for each object provided
    + 	on stdin.  May not be combined with any other options or arguments
    + 	except `--textconv` or `--filters`, in which case the input lines
    +-	also need to specify the path, separated by white space.  See the
    ++	also need to specify the path, separated by whitespace.  See the
    + 	section `BATCH OUTPUT` below for details.
    + 
    + --batch-check::
    + --batch-check=<format>::
    + 	Print object information for each object provided on stdin.  May
    + 	not be combined with any other options or arguments except
    + 	`--textconv` or `--filters`, in which case the input lines also
    +-	need to specify the path, separated by white space.  See the
    ++	need to specify the path, separated by whitespace.  See the
    + 	section `BATCH OUTPUT` below for details.
    + 
    + --batch-all-objects::
    +
      diff --git a/diff.c b/diff.c
      --- a/diff.c
      +++ b/diff.c
2:  7072bc6211 = 2:  204c7fea9d diff: allow --no-color-moved-ws
3:  ce3ad19eea = 3:  542b79b215 diff --color-moved-ws: demonstrate false positives
4:  700e0b61e7 = 4:  4ffb5c4122 diff --color-moved-ws: fix false positives
5:  9ecd8159a7 = 5:  a3a84f90c5 diff --color-moved=zebra: be stricter with color alternation
6:  1b1158b1ca = 6:  f94f2e0bae diff --color-moved-ws: optimize allow-indentation-change
7:  d8a362be6a ! 7:  fe8eb9cdbc diff --color-moved-ws: modify allow-indentation-change
    @@ -17,7 +17,7 @@
     
         This commit changes the way the indentation is handled to track the
         visual size of the indentation rather than the characters in the
    -    indentation. This has they benefit that any whitespace errors do not
    +    indentation. This has the benefit that any whitespace errors do not
         interfer with the move detection (the whitespace errors will still be
         highlighted according to --ws-error-highlight). During the discussion
         of this feature there were concerns about the correct detection of
    @@ -30,7 +30,7 @@
             they are uncolored.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    -    Changes since rfc:
    +    changes since rfc:
          - It now replaces the existing implementation rather than adding a new
            mode.
          - The indentation deltas are now calculated once for each line and
    @@ -49,8 +49,8 @@
      	const char *line;
      	int len;
      	int flags;
    -+	int indent_off;
    -+	int indent_width;
    ++	int indent_off;   /* Offset to first non-whitespace character */
    ++	int indent_width; /* The visual width of the indentation */
      	enum diff_symbol s;
      };
      #define EMITTED_DIFF_SYMBOL_INIT {NULL}
8:  1f7e99d45c = 8:  e600f8247c diff --color-moved-ws: handle blank lines
    
-- 
2.19.1.1690.g258b440b18

