Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AD21F404
	for <e@80x24.org>; Fri, 31 Aug 2018 06:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeHaKjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 06:39:48 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34424 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeHaKjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 06:39:47 -0400
Received: by mail-it0-f66.google.com with SMTP id x79-v6so4142237ita.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 23:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HgrBx0VDnNWPOOD2leSrd9hUOs5R6jnbSs0K5cYioDY=;
        b=VEgfditaKQ8zcuenQUBXSw2p6Kihqo4YI9enkzP6pGAHsifrB04Rd+BV3dllZy5Uih
         V8X/Iwyg7SP8u8gZjVLbnbpXAVFBuye/dinnkwnsmQiHlElpcleDDIaFnjCfDXYZh4SJ
         Yc17tXyuE6E957YaGpr0KFeeqMqByG/cCM+1/kf3eUdsKFwqp0qYhy7iOzu527RWVG3R
         JYqZ4u4A/kzfpvJK/G/cRiRBafcZxmCNnI6xG0qe4Bl+cXEMrMyL1n7k/e2SFemlKWtK
         SXqW1Q1Aug0SIGnuyQ4oIijkhLXqpXvz9Tyukd5Blex47yI9NMtrdA0GVEEedZajPemD
         QN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HgrBx0VDnNWPOOD2leSrd9hUOs5R6jnbSs0K5cYioDY=;
        b=AmuQO2sgKIqnSQOZhXN4gShAxn8vDaJlvhCiysBEHhJEbpmtgSISyUbL6eV5esObbG
         789YmYthWjj3xe2Kj6he/1MYfDBFcC8AqKOcwW8wY9StCYcgpLMrSWtuH/h3o3cufrFm
         JSXql2dIhDgG666eEhx2jkFFvLICb7700+mIulj59oOv106MYYS99oxd9a7DwduyINqm
         fXMoPqai0CQyCC/CK0rnv/QAadhndxzY63OZ7Yp9gHbTfjeNDdSRyeOV3wk+rbYErvxl
         O+cieJatemcLRZiGW3oXXfwqUIbQ7Yq82UULKusHdnT0PiAjUeWbYkx+T5KKP/TRTuva
         Omgg==
X-Gm-Message-State: APzg51Dzd1CrW5ZFNJmAuFfMuU5Pj+xHEoXR1ifg37IPStjPL0kMpFKE
        vutkikqP4YjbKouQE0kE7aGlNRam
X-Google-Smtp-Source: ANB0Vdav3p+IUFrTjanKW4rtgb5uH6t5oNhHNQCq+j8U09GrIRhRWMDNlRA9/JK2MMRZd592VutXRA==
X-Received: by 2002:a02:8b7c:: with SMTP id w57-v6mr11581656jak.123.1535697231926;
        Thu, 30 Aug 2018 23:33:51 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id k18-v6sm3734531iom.73.2018.08.30.23.33.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 23:33:51 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] doc-diff: add --clean mode to remove temporary working gunk
Date:   Fri, 31 Aug 2018 02:33:17 -0400
Message-Id: <20180831063318.33373-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.19.0.rc1.352.gb1634b371d
In-Reply-To: <20180831063318.33373-1-sunshine@sunshineco.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of its operation, doc-diff creates a bunch of temporary
working files and holds onto them in order to speed up subsequent
invocations. These files are never deleted. Moreover, it creates a
temporary working tree (via git-wortkree) which likewise never gets
removed.

Without knowing the implementation details of the tool, a user may not
know how to clean up manually afterward. Worse, the user may find it
surprising and alarming to discover a working tree which s/he did not
create explicitly.

To address these issues, add a --clean mode which removes the
temporary working tree and deletes all generated files.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/doc-diff | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index c2906eac5e..f397fd229b 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -2,20 +2,25 @@
 
 OPTIONS_SPEC="\
 doc-diff [options] <from> <to> [-- <diff-options>]
+doc-diff (-c|--clean)
 --
 j=n	parallel argument to pass to make
 f	force rebuild; do not rely on cached results
+c,clean	cleanup temporary working files
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
 
 parallel=
 force=
+clean=
 while test $# -gt 0
 do
 	case "$1" in
 	-j)
 		parallel=$2; shift ;;
+	-c|--clean)
+		clean=t ;;
 	-f)
 		force=t ;;
 	--)
@@ -26,6 +31,17 @@ do
 	shift
 done
 
+cd_to_toplevel
+tmp=Documentation/tmp-doc-diff
+
+if test -n "$clean"
+then
+	test $# -eq 0 || usage
+	git worktree remove --force "$tmp/worktree" 2>/dev/null
+	rm -rf "$tmp"
+	exit 0
+fi
+
 if test -z "$parallel"
 then
 	parallel=$(getconf _NPROCESSORS_ONLN 2>/dev/null)
@@ -42,9 +58,6 @@ to=$1; shift
 from_oid=$(git rev-parse --verify "$from") || exit 1
 to_oid=$(git rev-parse --verify "$to") || exit 1
 
-cd_to_toplevel
-tmp=Documentation/tmp-doc-diff
-
 if test -n "$force"
 then
 	rm -rf "$tmp"
-- 
2.19.0.rc1.352.gb1634b371d

