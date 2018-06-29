Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4F91F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030249AbeF2AUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:13 -0400
Received: from mail-yb0-f201.google.com ([209.85.213.201]:33741 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030243AbeF2AUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:12 -0400
Received: by mail-yb0-f201.google.com with SMTP id y7-v6so5655329ybg.0
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WbMmjTEf8czilEv2Qx1ptxkmXsPxwBNmJgfnjlL4UFY=;
        b=Wn04u5hL1cNa+K08uQb8UrMQQ1OEMr/7r6FnjNGUzUneTwl7LB9+yJEZtEbZi2ggLq
         Ew+Nv825a2wvZia6ixrWyIqDSuwG/cr3oNv7uV6koqOH5cpxqyAwWkGjieeSCwzZ7rtO
         Zr0QSwvuz0WHgycvk6ZMdk6xKx+QQoF2Wkj9itlezXWjt7kj15+8oQ4uJNWkqWrMSyUD
         AM5ewZS8+8JSypg/j1h2sXyjXVjTZvQ5ngINyNHmw3AbEEJmJo0leLbBt13qvWn7IHeF
         wcKTad+3/cbMuaKAhCw0gX3FiT8mHJiVfhS+tTIAYS8T39R+HMkJEJNjZPpXugHrKsh1
         rRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WbMmjTEf8czilEv2Qx1ptxkmXsPxwBNmJgfnjlL4UFY=;
        b=QtDrgurjI7b1UcbFvnePIn31/tC6X+jmvd5WtlbXU16risA1NPDi51AbMm+6tcNtoT
         JR4aK6Fry+PgaJQosu/CxpJB68LS3WwY4jCzXHabywnC19BCInCBV77amSpzMfrMsxG1
         cenyJjHmSvwuRwl1TOYKYxH7anH0RnuWTctp1dFJVMKz4G/fawnBG8rsR+TmOdLJTRA6
         ovrTnK2/tl7dKo80Y5IR/ZhyltTW5D6TEKM9CBmOJcuxVUZmaDXxMprEOm4KZ4WydQ7E
         cfMlqi+8P4LGEXEsTss3G++4UT9kYLJevXIJmQOMg5HUlR/WiFF7tPMU4DHR8RfSTgKK
         OMHw==
X-Gm-Message-State: APt69E3o4EI/EYfzOElKJm3rmsmmwNlZeKvidJMSMCPcOUIKDnQQWrrR
        x9TWASVf+Z0wI0cdAIVVhEoootPySrZn
X-Google-Smtp-Source: AAOMgpc84YGmAvHrmunk0dkMQUonXIYWDk4I2y9El6qS2wjYMvceJ4MkfiWXZavzWN7H2EimCvjCLDmV8HQf
X-Received: by 2002:a81:2686:: with SMTP id m128-v6mr3861306ywm.79.1530231611746;
 Thu, 28 Jun 2018 17:20:11 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:49 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180629001958.85143-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 0/9] Moved code detection: ignore space on uniform indentation
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v4:
 * see range diff below
 * brought best practices to t4015 and have git not upstream of a pipe
   (new patch 3)
 * squashed in the SQUASH patches
 * fixed the translation as well.

v3:
 This is a complete rewrite of the actual patch, with slight modifications]
 on the refactoring how to decouple the white space treatment from the
 move detection. See range-diff below.
 https://public-inbox.org/git/20180622015725.219575-1-sbeller@google.com/

v2: https://public-inbox.org/git/20180424210330.87861-1-sbeller@google.com/

v1: https://public-inbox.org/git/20180402224854.86922-1-sbeller@google.com/

Stefan Beller (9):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  t4015: avoid git as a pipe input
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: factor advance_or_nullify out of mark_color_as_moved
  diff.c: add white space mode to move detection that allows indent
    changes

 Documentation/diff-options.txt |  30 +++-
 diff.c                         | 253 +++++++++++++++++++++++++++++----
 diff.h                         |   9 +-
 t/t4015-diff-whitespace.sh     | 243 ++++++++++++++++++++++++++-----
 xdiff/xdiff.h                  |   8 --
 xdiff/xdiffi.c                 |  17 ---
 6 files changed, 472 insertions(+), 88 deletions(-)

-- 
2.18.0.399.gad0ab374a1-goog

1:  ace2dc2bc11 = 1:  ace2dc2bc11 xdiff/xdiff.h: remove unused flags
2:  53b3574564e = 2:  53b3574564e xdiff/xdiffi.c: remove unneeded function declarations
-:  ----------- > 3:  9b58621e0d8 t4015: avoid git as a pipe input
3:  34850b565df = 4:  be0ea0717e1 diff.c: do not pass diff options as keydata to hashmap
4:  8148e51178f = 5:  ff7e8721afa diff.c: adjust hash function signature to match hashmap expectation
5:  9d1de6a208e ! 6:  73c2801a5e3 diff.c: add a blocks mode for moved code detection
    @@ -19,7 +19,7 @@
      	moved line, but it is not very useful in a review to determine
      	if a block of code was moved without permutation.
     -zebra::
    -+blocks:
    ++blocks::
      	Blocks of moved text of at least 20 alphanumeric characters
      	are detected greedily. The detected blocks are
     -	painted using either the 'color.diff.{old,new}Moved' color or
    @@ -95,10 +95,8 @@
      	test_config color.diff.newMovedDimmed "normal cyan" &&
      	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
      	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
    -+
    -+	git diff HEAD --no-renames --color-moved=blocks --color |
    -+		grep -v "index" |
    -+		test_decode_color >actual &&
    ++	git diff HEAD --no-renames --color-moved=blocks --color >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
     +	cat <<-\EOF >expected &&
     +	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
     +	<BOLD>--- a/lines.txt<RESET>
    @@ -141,6 +139,16 @@
     +	test_config color.diff.newMovedDimmed "normal cyan" &&
     +	test_config color.diff.oldMovedAlternativeDimmed "normal blue" &&
     +	test_config color.diff.newMovedAlternativeDimmed "normal yellow" &&
    - 	git diff HEAD --no-renames --color-moved=dimmed_zebra --color |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    + 	git diff HEAD --no-renames --color-moved=dimmed_zebra --color >actual.raw &&
    + 	grep -v "index" actual.raw | test_decode_color >actual &&
    + 	cat <<-\EOF >expected &&
    +@@
    + 	7charsA
    + 	EOF
    + 
    +-	git diff HEAD --color-moved=zebra --color --no-renames | grep -v "index" | test_decode_color >actual &&
    ++	git diff HEAD --color-moved=zebra --color --no-renames >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
    + 	cat >expected <<-\EOF &&
    + 	<BOLD>diff --git a/bar b/bar<RESET>
    + 	<BOLD>--- a/bar<RESET>
6:  e37bb7b1fc8 ! 7:  87a8919c260 diff.c: decouple white space treatment from move detection algorithm
    @@ -55,6 +55,7 @@
     +ignore-all-space::
     +	Ignore whitespace when comparing lines. This ignores differences
     +	even if one line has whitespace where the other line has none.
    ++--
     +
      --word-diff[=<mode>]::
      	Show a word diff, using the <mode> to delimit changed words.
    @@ -154,32 +155,32 @@
      	EOF
      	test_cmp expected actual &&
      
    --	git diff HEAD --no-renames -w --color-moved --color |
    +-	git diff HEAD --no-renames -w --color-moved --color >actual.raw &&
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-ws=ignore-all-space |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    ++		--color-moved-ws=ignore-all-space >actual.raw &&
    + 	grep -v "index" actual.raw | test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    + 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
     @@
      	EOF
      	test_cmp expected actual &&
      
    --	git diff HEAD --no-renames -b --color-moved --color |
    +-	git diff HEAD --no-renames -b --color-moved --color >actual.raw &&
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-ws=ignore-space-change |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    ++		--color-moved-ws=ignore-space-change >actual.raw &&
    + 	grep -v "index" actual.raw | test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    + 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
     @@
      	EOF
      	test_cmp expected actual &&
      
    --	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
    +-	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color >actual.raw &&
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-ws=ignore-space-at-eol |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    ++		--color-moved-ws=ignore-space-at-eol >actual.raw &&
    + 	grep -v "index" actual.raw | test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    + 	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
     @@
      
      	# nor did we mess with it another way
7:  a58e68b8880 = 8:  25279c42f25 diff.c: factor advance_or_nullify out of mark_color_as_moved
8:  f2d78d2c672 ! 9:  305f8b27589 diff.c: add white space mode to move detection that allows indent changes
    @@ -86,9 +86,9 @@
     +	group the moved code blocks only into a block if the change in
     +	whitespace is the same per line. This is incompatible with the
     +	other modes.
    + --
      
      --word-diff[=<mode>]::
    - 	Show a word diff, using the <mode> to delimit changed words.
     
     diff --git a/diff.c b/diff.c
     --- a/diff.c
    @@ -129,7 +129,7 @@
     + */
     +struct ws_delta {
     +	char *string;
    -+	int current_longer : 1;
    ++	unsigned int current_longer : 1;
      };
     +#define WS_DELTA_INIT { NULL, 0 }
     +
    @@ -339,6 +339,30 @@
     diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
     --- a/t/t4015-diff-whitespace.sh
     +++ b/t/t4015-diff-whitespace.sh
    +@@
    + 	EOF
    + 
    + 	# Make sure we get a different diff using -w
    +-	git diff --color --color-moved -w |
    +-		grep -v "index" |
    +-		test_decode_color >actual &&
    ++	git diff --color --color-moved -w >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
    + 	q_to_tab <<-\EOF >expected &&
    + 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
    + 	<BOLD>--- a/text.txt<RESET>
    +@@
    + 
    + 	# And now ignoring white space only in the move detection
    + 	git diff --color --color-moved \
    +-		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol |
    +-		grep -v "index" |
    +-		test_decode_color >actual &&
    ++		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
    + 	q_to_tab <<-\EOF >expected &&
    + 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
    + 	<BOLD>--- a/text.txt<RESET>
     @@
      	test_cmp expected actual
      '
    @@ -383,9 +407,8 @@
     +	QQYetQAnotherQoutlier
     +	EOF
     +
    -+	git diff --color --color-moved --color-moved-ws=allow-indentation-change |
    -+		grep -v "index" |
    -+		test_decode_color >actual &&
    ++	git diff --color --color-moved --color-moved-ws=allow-indentation-change >actual.raw &&
    ++	grep -v "index" actual.raw | test_decode_color >actual &&
     +
     +	q_to_tab <<-\EOF >expected &&
     +		<BOLD>diff --git a/text.txt b/text.txt<RESET>
    @@ -429,8 +452,7 @@
     +	test_must_fail git diff \
     +		--color-moved-ws=allow-indentation-change,ignore-all-space \
     +		2>err &&
    -+	grep allow-indentation-change err
    ++	test_i18ngrep allow-indentation-change err
     +'
    -+
     +
      test_done
9:  76db2b1328f < -:  ----------- SQUASH????? Documentation breakage emergency fix
10:  d484589fad1 < -:  ----------- SQUASH??? t/4015 GETTEXT_POISON emergency fix
11:  fceb91fc99d < -:  ----------- diff: fix a sparse 'dubious one-bit signed bitfield' error
