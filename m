Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC4E1F454
	for <e@80x24.org>; Fri, 26 Oct 2018 23:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeJ0Hqx (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34952 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeJ0Hqw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12-v6so64943wmq.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSBuV7n+g9YowbXSlk6MUzDeKG/laSjqkg8wOl9aOJo=;
        b=p7Pq1rnxiXWdMOjU/hqAgiaEBi+sKe22gCxKR/CXjYXnSF4fhdzWs+ZW2vDjQTYlrd
         7QHGpGDSD0OarurGD61zjAdxQETy7mtDkQi16MIGS68k8UJnrqp0vQydfpN4GRUf2VFT
         I53VU/X5wWc0LUGoi5RON9g2Sq0sAP08svz3QkOJjLrNCTOYd6sa5S9DPRkpa2FK0u+N
         IOqSDG5if5nD2/3RmsNeJOBzU/vDQi/GI0//Ky/fhDu9leBMNNbyGkj36uFP6+sjaAXm
         OFA48D5GmUySY9T9BJSwjYa3ZRKJH3zEAqCXf079tVScWVyrEnJMmauhfra4L+d7p+1V
         C72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSBuV7n+g9YowbXSlk6MUzDeKG/laSjqkg8wOl9aOJo=;
        b=mv73krbm0uvmluJ3fzN33j3BiJJNOZvjHqZieaGYaXHzoTqygM/ThfRJLUVC3Qbv42
         ciNMFKas+UTL9fjd2SlOqPmLL1eTpFVVohRZf7SHnzb3prdRqvwP5apkm6v2Wen+nhm9
         DuoKhlYtwSYE/jmFddU2MvhUAvlhfkdckiSktx48u1MM+Pl3LOWQkgcv6HiOYlHW+82B
         86qvZQ1vymmWU1wiDZfgIoOVjH0RRVSBFdnGle+KPps8cdWRMvkQAuod0hygJmLvmuJ1
         pBo9nW1otFLmkb/EX+/8P8uX4rYoif74ueV32tIB/RejsFJk68g+plfe63U6c0odm2tj
         uDWQ==
X-Gm-Message-State: AGRZ1gIRANfTSvYJJou/Ry/6rU8nlut3orKBOYqS6b/M8qY+dYdkuOZ1
        0ktg5Yni4h80N4OvXmZLWGntNAGOgEc=
X-Google-Smtp-Source: AJdET5cBOSX1A2of+RXnJkPDd9iLtBDyF+hRYKzpcRTMeD0sP4/tdoDZ2yTeoBuA6xH667yrY2G1Bw==
X-Received: by 2002:a1c:9b07:: with SMTP id d7-v6mr3172050wme.78.1540595274238;
        Fri, 26 Oct 2018 16:07:54 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/8] push: improve the error shown on unqualified <dst> push
Date:   Fri, 26 Oct 2018 23:07:36 +0000
Message-Id: <20181026230741.23321-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message added in f8aae12034 ("push: allow
unqualified dest refspecs to DWIM", 2008-04-23), which before this
change looks like this:

    $ git push avar v2.19.0^{commit}:newbranch -n
    error: unable to push to unqualified destination: newbranch
    The destination refspec neither matches an existing ref on the remote nor
    begins with refs/, and we are unable to guess a prefix based on the source ref.
    error: failed to push some refs to 'git@github.com:avar/git.git'

This message needed to be read very carefully to spot how to fix the
error, i.e. to push to refs/heads/newbranch. Now the message will look
like this instead:

    $ ./git-push avar v2.19.0^{commit}:newbranch -n
    error: The destination you provided is not a full refname (i.e.,
    starting with "refs/"). We tried to guess what you meant by:

    - Looking for a ref that matches 'newbranch' on the remote side.
    - Checking if the <src> being pushed ('v2.19.0^{commit}')
      is a ref in "refs/{heads,tags}/". If so we add a
      corresponding refs/{heads,tags}/ prefix on the remote side.

    Neither worked, so we gave up. You must fully-qualify the ref.
    error: failed to push some refs to 'git@github.com:avar/git.git'

This improvement is the result of on-list discussion in [1] and [2],
as well as my own fixes / reformatting / phrasing on top.

The suggestion by Jeff on-list was to make that second bullet point
"Looking at the refname of the local source.". The version being added
here is more verbose, but also more accurate. saying "local source"
could refer to any ref in the local refstore, including something in
refs/remotes/*. A later change will teach guess_ref() to infer a ref
type from remote-tracking refs, so let's not confuse the two.

While I'm at it, add a "TRANSLATORS" comment since the message has
gotten more complex and it's not as clear what the two %s's refer to.

1. https://public-inbox.org/git/20181010205505.GB12949@sigill.intra.peff.net/
2. https://public-inbox.org/git/xmqqbm81lb7c.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/remote.c b/remote.c
index 5cb3d00bfb..f4b438ff74 100644
--- a/remote.c
+++ b/remote.c
@@ -1049,12 +1049,22 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
-			error(_("unable to push to unqualified destination: %s\n"
-				"The destination refspec neither matches an "
-				"existing ref on the remote nor\n"
-				"begins with refs/, and we are unable to "
-				"guess a prefix based on the source ref."),
-			      dst_value);
+			/*
+			 * TRANSLATORS: "matches '%s'%" is the <dst>
+			 * part of "git push <remote> <src>:<dst>"
+			 * push, and "being pushed ('%s')" is the
+			 * <src>.
+			 */
+			error(_("The destination you provided is not a full refname (i.e.,\n"
+				"starting with \"refs/\"). We tried to guess what you meant by:\n"
+				"\n"
+				"- Looking for a ref that matches '%s' on the remote side.\n"
+				"- Checking if the <src> being pushed ('%s')\n"
+				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
+				"  refs/{heads,tags}/ prefix on the remote side.\n"
+				"\n"
+				"Neither worked, so we gave up. You must fully-qualify the ref."),
+			      dst_value, matched_src->name);
 		}
 		break;
 	default:
-- 
2.19.1.759.g500967bb5e

