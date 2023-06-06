Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1BDC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjFFCIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjFFCI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11876F7
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so56051375e9.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017305; x=1688609305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUQzUNV5Amn/0HkCLF26LDnuSSxJbqDmWSennKBsatc=;
        b=nlj/vYvimkM5T9UHvrGlzxDEg+DPQH9TXmOvV/uIqsS0RynL9NBennSl0FJNr/MlOw
         xXT3s0qmfrH+TcbxHy6nxnypJax0uCdOQPsbbqN72M7wRl0QY9t0x/zjNP4pgkFMEVOt
         6jpPrSE5dZepJ4CxwdkUYr8B7vE/sqYUQ+d370zj21g0NEeOT0d8twnu6ngbodgVLv/8
         SiU83A2SkBeZ2jqyel8BfC4ankIKpwjGUGv+rppwfcjPrCt6LCfVZ4GBT6BDWI+g8Iam
         AU81kZ0TEXHfrVFq+3uqUmkj1ihjeiZVGf7YgelOIwKvrdQ+6RA54WTGQDf6ytze13ic
         aKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017305; x=1688609305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUQzUNV5Amn/0HkCLF26LDnuSSxJbqDmWSennKBsatc=;
        b=PQw/6fxvdXgGMXMDcbTU4y9PPKNscmpbwAYP//yyN3ObGG/Yo5r9mA3FdxUprI+ss/
         cgBBB7wn9pR+6jJ+t1gmdaMvXAbloBYI/V3LekmpSLoO3R96czMkV8lJzP9Muklk+X05
         udkLZ7qCaCWTiyQxDZYCis6JO+FIy+Z5o8cG4LHQSai+TUZVtALuxZ6aPTT/jGsTLEkO
         HhmMNTA2LP7LFdNlsWRItUL4dQyLwIacyZLF8ixKHM568cpSce05gGPNu+BUerqtVCk0
         9PkNum27aAiuj2I5YwVZvMJcE+V/h+fzs/QUZrthZcsVGx6l8/2iOrenb+t4FcMq8h1n
         cfWA==
X-Gm-Message-State: AC+VfDycVV+p0bDBpOmjHpM708GgFiZ2E9vH9ncuM3l8Jf1toJHOqMPd
        0fyyXx03oYugpxClX5pTCOJBXEmu+fI=
X-Google-Smtp-Source: ACHHUZ5I/C5dB07FqbEEJiHVB+D6VXzaZC0WpzLwJCSiGjdp019EsQpmXm6oLsqexDiEirn4lUCRkw==
X-Received: by 2002:a05:600c:2291:b0:3f6:692:5607 with SMTP id 17-20020a05600c229100b003f606925607mr765982wmf.40.1686017305184;
        Mon, 05 Jun 2023 19:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003f605566610sm15900155wmi.13.2023.06.05.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:24 -0700 (PDT)
Message-Id: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:15 +0000
Subject: [PATCH v3 0/9] docs: interpret-trailers: reword and add examples
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes some small improvements to the docs for
git-interpret-trailers. The intent is to make it easier to read for
beginners who have never used this command before.


Changes from v2 to v3
=====================

 * Rebased on top of "master" at fe86abd751 (Git 2.41, 2023-06-01). The only
   conflict was in Patch v2 4/9
   (https://lore.kernel.org/git/783a0b1e00309e9bcf13494908d99317df72f0d6.1683839975.git.gitgitgadget@gmail.com/),
   because cbb83daeaf (doc: interpret-trailers: fix example, 2023-05-01)
   added the "subject/message" style for the examples that did not have any
   message text in them. These examples' additional message lines have been
   replaced with Lorem ipsum... like the others in Patch v2 4/9.


Changes from v1 to v2
=====================

In order of significance:

 * The phrase "commit message part" has been removed.
 * The word "message" is always used as part of the bigger phrase "commit
   message".
 * Deprecation language for trailer.<token>.command has been updated to
   minimize whitespace churn, while also tweaking the 2nd paragraph to
   reduce duplication.
 * The phrase "Lorem ipsum..." is always only used to stand in for the body
   paragraph(s) of a commit message.
 * Grammar fixes have been squashed together (01+06 previously).

Linus Arver (9):
  doc: trailer: fix grammar
  doc: trailer: swap verb order
  doc: trailer: drop "commit message part" phrasing
  doc: trailer: examples: avoid the word "message" by itself
  doc: trailer: remove redundant phrasing
  doc: trailer: use angle brackets for <token> and <value>
  doc: trailer.<token>.command: emphasize deprecation
  doc: trailer: mention 'key' in DESCRIPTION
  doc: trailer: add more examples in DESCRIPTION

 Documentation/git-interpret-trailers.txt | 132 +++++++++++++----------
 1 file changed, 76 insertions(+), 56 deletions(-)


base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1506%2Flistx%2Fdoc-trailer-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1506/listx/doc-trailer-v3
Pull-Request: https://github.com/git/git/pull/1506

Range-diff vs v2:

  1:  65e6fbdec92 =  1:  7d504700b91 doc: trailer: fix grammar
  2:  82353471831 =  2:  65386432ca4 doc: trailer: swap verb order
  3:  5fabe166714 =  3:  e0a56c8e61d doc: trailer: drop "commit message part" phrasing
  4:  783a0b1e003 !  4:  52f7d29f509 doc: trailer: examples: avoid the word "message" by itself
     @@ Documentation/git-interpret-trailers.txt: EXAMPLES
       
      -message
      +Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     - $ cat msg.txt | git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>'
     + $ git interpret-trailers --trailer 'sign: Alice <alice@example.com>' --trailer 'sign: Bob <bob@example.com>' <msg.txt
       subject
       
      -message
     @@ Documentation/git-interpret-trailers.txt: EXAMPLES
       
       Signed-off-by: Bob <bob@example.com>
       Acked-by: Alice <alice@example.com>
     -@@ Documentation/git-interpret-trailers.txt: $ git config trailer.help.cmd "~/bin/glog-find-author"
     - $ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <<EOF
     - > subject
     - >
     --> message
     -+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     - >
     - > EOF
     +@@ Documentation/git-interpret-trailers.txt: $ git interpret-trailers --trailer 'Cc: Alice <alice@example.com>' --trailer 'Re
     + $ cat msg1.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + $ git config trailer.sign.key "Signed-off-by: "
     + $ git config trailer.sign.ifmissing add
     + $ git config trailer.sign.ifexists doNothing
     +@@ Documentation/git-interpret-trailers.txt: $ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git config user.
     + $ git interpret-trailers --trailer sign <msg1.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + 
     + Signed-off-by: Bob <bob@example.com>
     + $ cat msg2.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + 
     + Signed-off-by: Alice <alice@example.com>
     + $ git interpret-trailers --trailer sign <msg2.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + 
     + Signed-off-by: Alice <alice@example.com>
     + ------------
     +@@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --author="$1" --pretty="%an <%ae>" -1 || true
     + $ cat msg.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + $ git config trailer.help.key "Helped-by: "
     + $ git config trailer.help.ifExists "addIfDifferentNeighbor"
     + $ git config trailer.help.cmd "~/bin/glog-find-author"
     + $ git interpret-trailers --trailer="help:Junio" --trailer="help:Couder" <msg.txt
       subject
       
      -message
     @@ Documentation/git-interpret-trailers.txt: $ git config trailer.help.cmd "~/bin/g
       
       Helped-by: Junio C Hamano <gitster@pobox.com>
       Helped-by: Christian Couder <christian.couder@gmail.com>
     -@@ Documentation/git-interpret-trailers.txt: $ git config trailer.ref.cmd "~/bin/glog-grep"
     - $ git interpret-trailers --trailer="ref:Add copyright notices." <<EOF
     - > subject
     - >
     --> message
     -+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     - >
     - > EOF
     +@@ Documentation/git-interpret-trailers.txt: test -n "$1" && git log --grep "$1" --pretty=reference -1 || true
     + $ cat msg.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + $ git config trailer.ref.key "Reference-to: "
     + $ git config trailer.ref.ifExists "replace"
     + $ git config trailer.ref.cmd "~/bin/glog-grep"
     + $ git interpret-trailers --trailer="ref:Add copyright notices." <msg.txt
       subject
       
      -message
     @@ Documentation/git-interpret-trailers.txt: $ git config trailer.ref.cmd "~/bin/gl
       
       Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
       ------------
     -@@ Documentation/git-interpret-trailers.txt: $ git config trailer.see.command "git log -1 --oneline --format=\"%h (%s)\" --ab
     - $ git interpret-trailers <<EOF
     - > subject
     - > 
     --> message
     -+> Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     - > 
     - > see: HEAD~2
     - > EOF
     +@@ Documentation/git-interpret-trailers.txt: Reference-to: 8bc9a0c769 (Add copyright notices., 2005-04-07)
     + $ cat msg.txt
     + subject
     + 
     +-message
     ++Lorem ipsum dolor sit amet, consectetur adipiscing elit.
     + 
     + see: HEAD~2
     + $ cat ~/bin/glog-ref
     +@@ Documentation/git-interpret-trailers.txt: $ git config trailer.see.cmd "glog-ref"
     + $ git interpret-trailers --trailer=see <msg.txt
       subject
       
      -message
  5:  dd7e29fcc21 =  5:  4a2a0e41e4a doc: trailer: remove redundant phrasing
  6:  96cb4ae2965 =  6:  f99545409dc doc: trailer: use angle brackets for <token> and <value>
  7:  4e234110ffd =  7:  6aba774489a doc: trailer.<token>.command: emphasize deprecation
  8:  8aaf9e27d98 =  8:  b13bd73d248 doc: trailer: mention 'key' in DESCRIPTION
  9:  7e95198894b =  9:  ec43e192d6e doc: trailer: add more examples in DESCRIPTION

-- 
gitgitgadget
