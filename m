Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370151F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeGLTUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:20:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36950 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeGLTUx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:20:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so22764233wrd.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y4NpF3WQu97gJAfhMci67nmlr3PxtSpliQb13YkCWzk=;
        b=FA5rquruwcJwQuUj7Ybb80ua3HD7vuAM4vtEntXEgQgAnKD+qwEjqjIGU4l3I3DWvK
         QvmHVgvf3wtr8C4S2GcDKUdvxhASvFPSrHGIaIYW6QTuN9XUUsme7zyTQJbsn2E1UhwW
         Li+Xh8X1pV1S+I6C0Tyyamy6fVSTV4i7U2yI0XYxPo9bX3tOOZwAMRdx90g3c1EBQfE5
         cXxlsrVo9puZzvaGTB6BaFaBLhrEO+rdOggEiy102vg7Gjqdx/Zvtfuou6d6xtqyVEOn
         Lv5S+pU1r6DDDGhm5/aqcC6v7n8M2VWGcq7151+qzmFmm3zuVOAoqBwhPnHkxs+/wDOM
         d2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y4NpF3WQu97gJAfhMci67nmlr3PxtSpliQb13YkCWzk=;
        b=J7Dw05hb6NRkO3q+uS5Hyh48Aewco1ouov+fHuZnTnIG1PB9A1PxEwo6WwSQYqF+Z5
         4xFA4SWWHfw0bdxvz/mk7JiQXJDn8wZ1hmNBY6kuHDs/eWDpHIAVbaAIC3pZyyh75Nqx
         UHPxDEe54fWML0ngdP4EiwO2pej1i9jL6liwe31eTM/rZ+qJmUTJgBIii8NJ68br14JM
         MuuvwpvAyQkPnUp6FRlV8KEKxvH8+WnyN4RqQyoqPTV7iq3GESU3DdakL3GWSQqLg/Fa
         QBimomqeY+1DTR94i8kGk9wEacqQnRqkL/YTUn9TOM/AG80oOqp0rwWaaswysrewuE3m
         IGKA==
X-Gm-Message-State: AOUpUlF85UVlEE3bTRdvXYt3N294nOS/8GIFiyAzvr+QO3mwmR766AI7
        Shye/leqNa8VE2DD4O7Kn/o=
X-Google-Smtp-Source: AAOMgpfVSgeeWQkY1mOg58Buzj9WdWAbr3Mv6vYqAuvlUVLgJIQZ+wM8gmmwJjBNoPDSTel/1L9+xQ==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr2813787wrv.228.1531422599302;
        Thu, 12 Jul 2018 12:09:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p184-v6sm4597144wmp.31.2018.07.12.12.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:09:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
        <20180712054909.29077-1-wchargin@gmail.com>
        <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
        <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com>
Date:   Thu, 12 Jul 2018 12:09:57 -0700
In-Reply-To: <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com>
        (William Chargin's message of "Thu, 12 Jul 2018 09:14:10 -0700")
Message-ID: <xmqqva9kw9ru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin <wchargin@gmail.com> writes:

>> As we discussed during the review on v1, ":/<substring in commit>"
>> is *NOT* pathspec (that is why having these tests in t4208 is wrong
>> but we are following existing mistakes).
>
> Ah, I understand the terminology better now. Thanks. I'll change the
> commit message wording to use "extended SHA-1s" instead of "pathspecs".
>
>> Now you have Peff's sign-off for the one-liner code change, the last
>> one is redundant.
>
> Okay: I'll remove the "Based-on-patch-by" line.
>
>> Other than the above two nits, the patch looks good.  I would have
>> broken the line after "including HEAD.", but the slightly-long line
>> is also OK.
>
> Happy to change this while making the above edits. :-)

Let's save a round-trip.  Here is what I'd queue for now, and you
can just say "looks good" if you agree with the result, or send an
updated version ;-).

Thanks for working on this.

-- >8 --
From: William Chargin <wchargin@gmail.com>
Date: Wed, 11 Jul 2018 22:49:09 -0700
Subject: [PATCH] sha1-name.c: for ":/", find detached HEAD commits

This patch broadens the set of commits matched by ":/<pattern>" to
include commits reachable from HEAD but not any named ref. This avoids
surprising behavior when working with a detached HEAD and trying to
refer to a commit that was recently created and only exists within the
detached state.

If multiple worktrees exist, only the current worktree's HEAD is
considered reachable. This is consistent with the existing behavior for
other per-worktree refs: e.g., bisect refs are considered reachable, but
only within the relevant worktree.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: William Chargin <wchargin@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/revisions.txt   |  3 ++-
 sha1_name.c                   |  1 +
 t/t4208-log-magic-pathspec.sh | 26 ++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dfcc49c72c..0845c3f590 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -180,7 +180,8 @@ existing tag object.
   A colon, followed by a slash, followed by a text, names
   a commit whose commit message matches the specified regular expression.
   This name returns the youngest matching commit which is
-  reachable from any ref. The regular expression can match any part of the
+  reachable from any ref, including HEAD.
+  The regular expression can match any part of the
   commit message. To match messages starting with a string, one can use
   e.g. ':/^foo'. The special sequence ':/!' is reserved for modifiers to what
   is matched. ':/!-foo' performs a negative match, while ':/!!foo' matches a
diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..19f66713e1 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1649,6 +1649,7 @@ static int get_oid_with_context_1(const char *name,
 			struct commit_list *list = NULL;
 
 			for_each_ref(handle_one_ref, &list);
+			head_ref(handle_one_ref, &list);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(name + 2, oid, list);
 		}
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index a1705f70cf..69643d101d 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -25,6 +25,32 @@ test_expect_success '"git log :/a -- " should not be ambiguous' '
 	git log :/a --
 '
 
+test_expect_success '"git log :/detached -- " should find a commit only in HEAD' '
+	test_when_finished "git checkout master" &&
+	git checkout --detach &&
+	# Must manually call `test_tick` instead of using `test_commit`,
+	# because the latter additionally creates a tag, which would make
+	# the commit reachable not only via HEAD.
+	test_tick &&
+	git commit --allow-empty -m detached &&
+	test_tick &&
+	git commit --allow-empty -m something-else &&
+	git log :/detached --
+'
+
+test_expect_success '"git log :/detached -- " should not find an orphaned commit' '
+	test_must_fail git log :/detached --
+'
+
+test_expect_success '"git log :/detached -- " should find HEAD only of own worktree' '
+	git worktree add other-tree HEAD &&
+	git -C other-tree checkout --detach &&
+	test_tick &&
+	git -C other-tree commit --allow-empty -m other-detached &&
+	git -C other-tree log :/other-detached -- &&
+	test_must_fail git log :/other-detached --
+'
+
 test_expect_success '"git log -- :/a" should not be ambiguous' '
 	git log -- :/a
 '
-- 
2.18.0-129-ge3331758f1

