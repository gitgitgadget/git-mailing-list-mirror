Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4498B1F461
	for <e@80x24.org>; Fri,  5 Jul 2019 17:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfGERG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 13:06:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37137 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfGERG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 13:06:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so1461266wrr.4
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BurjLDVmo6aFepMnCJGjhmTF5BlqStgP8PjXSgxLUIk=;
        b=L6JOvc7RQB3l7XJHX/o06B4UO/q86IxSGNASvFak1gAQCFY4hrsVJXrK84BPrdZmnJ
         GDMB8XJvPVMvJbY6xDrRR/vzOkok18WhIi/flQ7HgEgDoh9VZ+1vsV9bhwprOUbe3KPX
         NnVsA50MNvo85d1HXzeMPG1QTO5VcH+tKLRi3O6ykvUtrrfSNMSXC6hCrmmHjBWB8uBA
         AMV199yQWKMJXBiT0VV484wB95I2P9+N1BNW+lGbbuWVgbhtcJ8ToJnrJ1bWI24c62rU
         eERrmDmcid4fg1dPeBYHBQUCkqKtjAjDT4Ebl2HjjaZ5aNdqtRZ9E+lAo0H4dtSNMkVE
         g0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BurjLDVmo6aFepMnCJGjhmTF5BlqStgP8PjXSgxLUIk=;
        b=lm+Cpf93WegHonrKSgT42kfK7YPAHDwGeRy0tgxVghg5yEZ2Gwqqh1YvrWC0QpR15M
         IXXTkbFLWIS517XkMVUbmugedGc+4Va1EDL8bx1daWpX5ZurjXAbPn+rjd6mO2jfK090
         AVrem3EnZYMFbl8QHCWqFdOHV7rIH9SAvLzbmMJpYMqUpyT6vEq48DfL/191B6dmQjBy
         msDnBbw/QCvSZqp3fyRVnkGuzAQe+O6bQvdjXdvtk+OJab9nsGEeH/gjIy8UVhBzrFFc
         42unqThBgF1x5U8zKGmeRYahP98quKelWZ8/IofMCoI8+2mKZggAMxVqgvCDcq3JhbHl
         rYbw==
X-Gm-Message-State: APjAAAVl77iHEv1tOepCYCmN1g3dPt1bXMKSaGVFMQXSBTGykL1Li8XV
        zTfAtbF/r3ZdZFXCQtI7YpRktYCV
X-Google-Smtp-Source: APXvYqwogc53dHezFaeO0rVOCTXOsJBSzPP+4kH08OI9U4FxvTCI9ZqSAaEgcVOiHxj/Gy4KcYNyMA==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr4740091wru.195.1562346412239;
        Fri, 05 Jul 2019 10:06:52 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id m16sm8737941wrv.89.2019.07.05.10.06.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 10:06:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 00/14] output improvements for git range-diff
Date:   Fri,  5 Jul 2019 18:06:16 +0100
Message-Id: <20190705170630.27500-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190414210933.20875-1-t.gummerer@gmail.com/>
References: <20190414210933.20875-1-t.gummerer@gmail.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's been quite a while since I sent the RFC [1] (thanks all for the
comments on that), and the series changed shapes quite a bit since the
last round.

Since it's been such a long time, just to remind everyone, the goal of
this series is to make the range-diff output clearer, by showing
information about the filenames to which the current diff belongs.

In the previous round, we did this using "section headers" that
include information about the current file and adding that to the
outer diff's hunk headers.

In this round we still keep the section headers (with slightly more
information), but in addition we also add the filename to the inner
diff hunk headers.  In the outer diff hunk headers we then display
either the section header or the inner diff hunk header using a
userdiff pattern.

In terms of code changes the biggest change is that we're now re-using
the 'parse_git_header' function from the apply code to parse the diff
headers, instead of trying to parse them with some hacky parsing code
in range-diff.c.  This way we are sure that the diff headers are
properly parsed.

I had also considered just outputting the section headers directly
from 'git log', but then decided against that.  Parsing the headers
allows a future enhancement of range-diff, where we would allow
parsing an mbox file [2].

I split the "only pass required data" commits up, in the hopes of
making them easier to review, but I'm also happy to squash them if
people feel like that makes it easier to review them.

An added advantage of this is that we're also getting rid of things
like the similarity index, which are not important in the range-diff,
and are thus not represented in the "section header".

One thing that did not change is that the new/deleted strings are not
translated in this version either.  This is similar to the regular
diff output, where we also don't translate these.  We can still
consider translating them in the future though.

[1]: https://public-inbox.org/git/20190414210933.20875-1-t.gummerer@gmail.com/
[2]: https://github.com/gitgitgadget/git/issues/207

I'm including the range-diff between this version of the series and
the RFC, and a diff between the range diff and the range-diff without
these changes below.  Probably not useful in reviewing the code, but
good to show off the changes made in this series.

range-diff:

 -:  ---------- >  1:  ef2245edda apply: replace marc.info link with public-inbox
 -:  ---------- >  2:  94578fa45c apply: only pass required data to skip_tree_prefix
 -:  ---------- >  3:  988269a68e apply: only pass required data to git_header_name
 -:  ---------- >  4:  a2c1ef3f5f apply: only pass required data to check_header_line
 -:  ---------- >  5:  0f4cfe21cb apply: only pass required data to find_name_*
 -:  ---------- >  6:  7f1d7a4569 apply: only pass required data to gitdiff_* functions
 -:  ---------- >  7:  a5af8b0845 apply: make parse_git_header public
 1:  0e678d222c =  8:  1f25bb1002 range-diff: fix function parameter indentation
 -:  ---------- >  9:  01ed0f2a6a range-diff: split lines manually
 2:  48716230fc ! 10:  044a79868b range-diff: don't remove funcname from inner diff
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      				strbuf_addch(&buf, '\n');
      			}
      			continue;
    --		} else if (starts_with(line.buf, "@@ "))
    +-		} else if (starts_with(line, "@@ "))
     -			strbuf_addstr(&buf, "@@");
    --		else if (!line.buf[0] || starts_with(line.buf, "index "))
    -+		} else if (starts_with(line.buf, "@@ ")) {
    -+			char *skip_lineno = strstr(line.buf + 3, "@@");
    -+			strbuf_remove(&line, 0, skip_lineno - line.buf);
    -+			strbuf_addch(&buf, ' ');
    -+			strbuf_addbuf(&buf, &line);
    -+		} else if (!line.buf[0] || starts_with(line.buf, "index "))
    +-		else if (!line[0] || starts_with(line, "index "))
    ++		} else if (skip_prefix(line, "@@ ", &p)) {
    ++			if (!(p = strstr(p, "@@")))
    ++				die(_("invalid hunk header in inner diff"));
    ++			strbuf_addstr(&buf, p);
    ++		} else if (!line[0] || starts_with(line, "index "))
      			/*
      			 * A completely blank (not ' \n', which is context)
      			 * line is not valid in a diff.  We skip it
    +
    + ## t/t3206-range-diff.sh ##
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
    + 	      14
    + 	4:  a63e992 ! 4:  d966c5c s/12/B/
    + 	    @@ -8,7 +8,7 @@
    +-	     @@
    ++	     @@ A
    + 	      9
    + 	      10
    + 	    - B
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
    + 	      14
    + 	4:  a63e992 ! 4:  d966c5c s/12/B/
    + 	    @@ -8,7 +8,7 @@
    +-	     @@
    ++	     @@ A
    + 	      9
    + 	      10
    + 	    - B
    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
    + 	:      14<RESET>
    + 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
    + 	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
    +-	:    <CYAN> @@<RESET>
    ++	:    <CYAN> @@ A<RESET>
    + 	:      9<RESET>
    + 	:      10<RESET>
    + 	:    <REVERSE><RED>-<RESET><FAINT> BB<RESET>
 3:  71679cb747 <  -:  ---------- range-diff: add section header instead of diff header
 -:  ---------- > 11:  69654fe76d range-diff: suppress line count in outer diff
 -:  ---------- > 12:  c38f929b9a range-diff: add section header instead of diff header
 -:  ---------- > 13:  6df03ecdcf range-diff: add filename to inner diff
 4:  8f45b6a995 ! 14:  5ceef49035 range-diff: add section headers to the outer hunk header
    @@ Metadata
     Author: Thomas Gummerer <t.gummerer@gmail.com>
     
      ## Commit message ##
    -    range-diff: add section headers to the outer hunk header
    +    range-diff: add headers to the outer hunk header
     
    -    Add the section headers we introduced in the previous commit to the
    -    outer diff's hunk headers.  This makes it easier to understand which
    -    change we are actually looking at.  For example an outer hunk header
    -    might now look like:
    +    Add the section headers/hunk headers we introduced in the previous
    +    commits to the outer diff's hunk headers.  This makes it easier to
    +    understand which change we are actually looking at.  For example an
    +    outer hunk header might now look like:
     
    -        @@ -77,15 +78,43 @@ modified file Documentation/config/interactive.txt
    +        @@  Documentation/config/interactive.txt
     
         while previously it would have only been
     
    -        @@ -77,15 +78,43 @@
    +        @@
     
         which doesn't give a lot of context for the change that follows.
     
    @@ Commit message
     
      ## range-diff.c ##
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list)
    - 			strbuf_addstr(&buf, " ##\n");
    + 			strbuf_addstr(&buf, " ##");
      		} else if (in_header) {
    - 			if (starts_with(line.buf, "Author: ")) {
    + 			if (starts_with(line, "Author: ")) {
     +				strbuf_addstr(&buf, " ## Metadata ##\n");
    - 				strbuf_addbuf(&buf, &line);
    + 				strbuf_addstr(&buf, line);
      				strbuf_addstr(&buf, "\n\n");
     +				strbuf_addstr(&buf, " ## Commit message ##\n");
    - 			} else if (starts_with(line.buf, "    ")) {
    - 				strbuf_rtrim(&line);
    - 				strbuf_addbuf(&buf, &line);
    + 			} else if (starts_with(line, "    ")) {
    + 				p = line + len - 2;
    + 				while (isspace(*p) && p >= line)
     @@ range-diff.c: static void output_pair_header(struct diff_options *diffopt,
      	fwrite(buf->buf, buf->len, 1, diffopt->file);
      }
    @@ range-diff.c: static void output_pair_header(struct diff_options *diffopt,
     -static struct userdiff_driver no_func_name = {
     -	.funcname = { "$^", 0 }
     +static struct userdiff_driver section_headers = {
    -+	.funcname = { "^ ## (.*) ##$", REG_EXTENDED }
    ++	.funcname = { "^ ## (.*) ##$\n"
    ++		      "^.?@@ (.*)$", REG_EXTENDED }
      };
      
      static struct diff_filespec *get_filespec(const char *name, const char *p)
    @@ range-diff.c: static struct diff_filespec *get_filespec(const char *name, const
      
      	return spec;
      }
    +
    + ## t/t3206-range-diff.sh ##
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
    + 	1:  4de457d = 1:  a4b3333 s/5/A/
    + 	2:  fccce22 = 2:  f51d370 s/4/A/
    + 	3:  147e64e ! 3:  0559556 s/11/B/
    +-	    @@
    ++	    @@ file: A
    + 	      9
    + 	      10
    + 	     -11
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
    + 	      13
    + 	      14
    + 	4:  a63e992 ! 4:  d966c5c s/12/B/
    +-	    @@
    ++	    @@ file
    + 	     @@ file: A
    + 	      9
    + 	      10
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
    + 	1:  4de457d = 1:  a4b3333 s/5/A/
    + 	2:  fccce22 = 2:  f51d370 s/4/A/
    + 	3:  147e64e ! 3:  0559556 s/11/B/
    +-	    @@
    ++	    @@ file: A
    + 	      9
    + 	      10
    + 	     -11
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
    + 	      13
    + 	      14
    + 	4:  a63e992 ! 4:  d966c5c s/12/B/
    +-	    @@
    ++	    @@ file
    + 	     @@ file: A
    + 	      9
    + 	      10
    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
    + 	sed s/Z/\ /g >expected <<-EOF &&
    + 	1:  4de457d = 1:  f258d75 s/5/A/
    + 	2:  fccce22 ! 2:  017b62d s/4/A/
    +-	    @@
    ++	    @@ Metadata
    + 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
    + 	    Z
    ++	    Z ## Commit message ##
    + 	    -    s/4/A/
    + 	    +    s/4/A/ + rename file
    + 	    Z
    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
    + 	    Z 1
    + 	    Z 2
    + 	3:  147e64e ! 3:  3ce7af6 s/11/B/
    +-	    @@
    +-	    Z
    ++	    @@ Metadata
    ++	    Z ## Commit message ##
    + 	    Z    s/11/B/
    + 	    Z
    + 	    - ## file ##
    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
    + 	    Z 9
    + 	    Z 10
    + 	4:  a63e992 ! 4:  1e6226b s/12/B/
    +-	    @@
    +-	    Z
    ++	    @@ Metadata
    ++	    Z ## Commit message ##
    + 	    Z    s/12/B/
    + 	    Z
    + 	    - ## file ##
    +@@ t/t3206-range-diff.sh: test_expect_success 'file added and later removed' '
    + 	sed s/Z/\ /g >expected <<-EOF &&
    + 	1:  4de457d = 1:  096b1ba s/5/A/
    + 	2:  fccce22 ! 2:  d92e698 s/4/A/
    +-	    @@
    ++	    @@ Metadata
    + 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
    + 	    Z
    ++	    Z ## Commit message ##
    + 	    -    s/4/A/
    + 	    +    s/4/A/ + new-file
    + 	    Z
    + 	    Z ## file ##
    + 	    Z@@
    +-	    @@
    ++	    @@ file
    + 	    Z A
    + 	    Z 6
    + 	    Z 7
    + 	    +
    + 	    + ## new-file (new) ##
    + 	3:  147e64e ! 3:  9a1db4d s/11/B/
    +-	    @@
    ++	    @@ Metadata
    + 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
    + 	    Z
    ++	    Z ## Commit message ##
    + 	    -    s/11/B/
    + 	    +    s/11/B/ + remove file
    + 	    Z
    + 	    Z ## file ##
    + 	    Z@@ file: A
    +-	    @@
    ++	    @@ file: A
    + 	    Z 12
    + 	    Z 13
    + 	    Z 14
    +@@ t/t3206-range-diff.sh: test_expect_success 'changed message' '
    + 	sed s/Z/\ /g >expected <<-EOF &&
    + 	1:  4de457d = 1:  f686024 s/5/A/
    + 	2:  fccce22 ! 2:  4ab067d s/4/A/
    +-	    @@
    +-	    Z
    ++	    @@ Metadata
    ++	    Z ## Commit message ##
    + 	    Z    s/4/A/
    + 	    Z
    + 	    +    Also a silly comment here!
    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
    + 	sed -e "s|^:||" >expect <<-\EOF &&
    + 	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
    + 	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
    +-	:    <REVERSE><CYAN>@@<RESET>
    +-	:     <RESET>
    ++	:    <REVERSE><CYAN>@@<RESET> <RESET>Metadata<RESET>
    ++	:      ## Commit message ##<RESET>
    + 	:         s/4/A/<RESET>
    + 	:     <RESET>
    + 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
    + 	:    <CYAN> @@<RESET>
    + 	:      1<RESET>
    + 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
    +-	:    <REVERSE><CYAN>@@<RESET>
    ++	:    <REVERSE><CYAN>@@<RESET> <RESET>file: A<RESET>
    + 	:      9<RESET>
    + 	:      10<RESET>
    + 	:    <RED> -11<RESET>
    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
    + 	:      13<RESET>
    + 	:      14<RESET>
    + 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
    +-	:    <REVERSE><CYAN>@@<RESET>
    ++	:    <REVERSE><CYAN>@@<RESET> <RESET>file<RESET>
    + 	:    <CYAN> @@ file: A<RESET>
    + 	:      9<RESET>
    + 	:      10<RESET>

diff between range-diffs (a diff between range-diffs seems a bit
insane, though with some coloring I find it actually somewhat
readable):

diff --git a/rd1 b/rd2
index 5fa847fbab..d6f99d1548 100644
--- a/rd1
+++ b/rd2
@@ -8,7 +8,7 @@
  1:  0e678d222c =  8:  1f25bb1002 range-diff: fix function parameter indentation
  -:  ---------- >  9:  01ed0f2a6a range-diff: split lines manually
  2:  48716230fc ! 10:  044a79868b range-diff: don't remove funcname from inner diff
-    @@ -27,15 +27,45 @@
+    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
       				strbuf_addch(&buf, '\n');
       			}
       			continue;
@@ -32,10 +32,8 @@
       			 * A completely blank (not ' \n', which is context)
       			 * line is not valid in a diff.  We skip it
     +
-    + diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
-    + --- a/t/t3206-range-diff.sh
-    + +++ b/t/t3206-range-diff.sh
-    +@@
+    + ## t/t3206-range-diff.sh ##
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
     + 	      14
     + 	4:  a63e992 ! 4:  d966c5c s/12/B/
     + 	    @@ -8,7 +8,7 @@
@@ -44,7 +42,7 @@
     + 	      9
     + 	      10
     + 	    - B
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
     + 	      14
     + 	4:  a63e992 ! 4:  d966c5c s/12/B/
     + 	    @@ -8,7 +8,7 @@
@@ -53,7 +51,7 @@
     + 	      9
     + 	      10
     + 	    - B
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
     + 	:      14<RESET>
     + 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
     + 	:    <REVERSE><CYAN>@@ -8,7 +8,7 @@<RESET>
@@ -67,9 +65,10 @@
  -:  ---------- > 12:  c38f929b9a range-diff: add section header instead of diff header
  -:  ---------- > 13:  6df03ecdcf range-diff: add filename to inner diff
  4:  8f45b6a995 ! 14:  5ceef49035 range-diff: add section headers to the outer hunk header
-    @@ -1,17 +1,17 @@
+    @@ Metadata
      Author: Thomas Gummerer <t.gummerer@gmail.com>
      
+      ## Commit message ##
     -    range-diff: add section headers to the outer hunk header
     +    range-diff: add headers to the outer hunk header
      
@@ -92,10 +91,10 @@
      
          which doesn't give a lot of context for the change that follows.
      
-    @@ -24,16 +24,16 @@
-      --- a/range-diff.c
-      +++ b/range-diff.c
-     @@
+    @@ Commit message
+     
+      ## range-diff.c ##
+     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list)
     - 			strbuf_addstr(&buf, " ##\n");
     + 			strbuf_addstr(&buf, " ##");
       		} else if (in_header) {
@@ -112,10 +111,10 @@
     + 			} else if (starts_with(line, "    ")) {
     + 				p = line + len - 2;
     + 				while (isspace(*p) && p >= line)
-     @@
+     @@ range-diff.c: static void output_pair_header(struct diff_options *diffopt,
       	fwrite(buf->buf, buf->len, 1, diffopt->file);
       }
-    @@ -41,7 +41,8 @@
+    @@ range-diff.c: static void output_pair_header(struct diff_options *diffopt,
      -static struct userdiff_driver no_func_name = {
      -	.funcname = { "$^", 0 }
      +static struct userdiff_driver section_headers = {
@@ -125,15 +124,13 @@
       };
       
       static struct diff_filespec *get_filespec(const char *name, const char *p)
-    @@ -54,3 +55,154 @@ $^
+    @@ range-diff.c: static struct diff_filespec *get_filespec(const char *name, const
       
       	return spec;
       }
     +
-    + diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
-    + --- a/t/t3206-range-diff.sh
-    + +++ b/t/t3206-range-diff.sh
-    +@@
+    + ## t/t3206-range-diff.sh ##
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
     + 	1:  4de457d = 1:  a4b3333 s/5/A/
     + 	2:  fccce22 = 2:  f51d370 s/4/A/
     + 	3:  147e64e ! 3:  0559556 s/11/B/
@@ -142,7 +139,7 @@
     + 	      9
     + 	      10
     + 	     -11
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit' '
     + 	      13
     + 	      14
     + 	4:  a63e992 ! 4:  d966c5c s/12/B/
@@ -151,7 +148,7 @@
     + 	     @@ file: A
     + 	      9
     + 	      10
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
     + 	1:  4de457d = 1:  a4b3333 s/5/A/
     + 	2:  fccce22 = 2:  f51d370 s/4/A/
     + 	3:  147e64e ! 3:  0559556 s/11/B/
@@ -160,7 +157,7 @@
     + 	      9
     + 	      10
     + 	     -11
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed commit with sm config' '
     + 	      13
     + 	      14
     + 	4:  a63e992 ! 4:  d966c5c s/12/B/
@@ -169,7 +166,7 @@
     + 	     @@ file: A
     + 	      9
     + 	      10
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
     + 	sed s/Z/\ /g >expected <<-EOF &&
     + 	1:  4de457d = 1:  f258d75 s/5/A/
     + 	2:  fccce22 ! 2:  017b62d s/4/A/
@@ -181,7 +178,7 @@
     + 	    -    s/4/A/
     + 	    +    s/4/A/ + rename file
     + 	    Z
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
     + 	    Z 1
     + 	    Z 2
     + 	3:  147e64e ! 3:  3ce7af6 s/11/B/
@@ -192,7 +189,7 @@
     + 	    Z    s/11/B/
     + 	    Z
     + 	    - ## file ##
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'renamed file' '
     + 	    Z 9
     + 	    Z 10
     + 	4:  a63e992 ! 4:  1e6226b s/12/B/
@@ -203,7 +200,7 @@
     + 	    Z    s/12/B/
     + 	    Z
     + 	    - ## file ##
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'file added and later removed' '
     + 	sed s/Z/\ /g >expected <<-EOF &&
     + 	1:  4de457d = 1:  096b1ba s/5/A/
     + 	2:  fccce22 ! 2:  d92e698 s/4/A/
@@ -240,7 +237,7 @@
     + 	    Z 12
     + 	    Z 13
     + 	    Z 14
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'changed message' '
     + 	sed s/Z/\ /g >expected <<-EOF &&
     + 	1:  4de457d = 1:  f686024 s/5/A/
     + 	2:  fccce22 ! 2:  4ab067d s/4/A/
@@ -251,7 +248,7 @@
     + 	    Z    s/4/A/
     + 	    Z
     + 	    +    Also a silly comment here!
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
     + 	sed -e "s|^:||" >expect <<-\EOF &&
     + 	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
     + 	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
@@ -262,7 +259,7 @@
     + 	:         s/4/A/<RESET>
     + 	:     <RESET>
     + 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
     + 	:    <CYAN> @@<RESET>
     + 	:      1<RESET>
     + 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
@@ -271,7 +268,7 @@
     + 	:      9<RESET>
     + 	:      10<RESET>
     + 	:    <RED> -11<RESET>
-    +@@
+    +@@ t/t3206-range-diff.sh: test_expect_success 'dual-coloring' '
     + 	:      13<RESET>
     + 	:      14<RESET>
     + 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>

Thomas Gummerer (14):
  apply: replace marc.info link with public-inbox
  apply: only pass required data to skip_tree_prefix
  apply: only pass required data to git_header_name
  apply: only pass required data to check_header_line
  apply: only pass required data to find_name_*
  apply: only pass required data to gitdiff_* functions
  apply: make parse_git_header public
  range-diff: fix function parameter indentation
  range-diff: split lines manually
  range-diff: don't remove funcname from inner diff
  range-diff: suppress line count in outer diff
  range-diff: add section header instead of diff header
  range-diff: add filename to inner diff
  range-diff: add headers to the outer hunk header

 apply.c                | 185 ++++++++++++++++++-----------------------
 apply.h                |  48 +++++++++++
 diff.c                 |   5 +-
 diff.h                 |   1 +
 range-diff.c           | 126 +++++++++++++++++++---------
 t/t3206-range-diff.sh  | 124 ++++++++++++++++++++++-----
 t/t3206/history.export |  84 ++++++++++++++++++-
 7 files changed, 407 insertions(+), 166 deletions(-)

-- 
2.22.0.510.g264f2c817a

