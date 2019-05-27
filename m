Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026E31F462
	for <e@80x24.org>; Mon, 27 May 2019 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfE0VMy (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 17:12:54 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46239 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfE0VMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 17:12:54 -0400
Received: by mail-vs1-f67.google.com with SMTP id x8so11390360vsx.13
        for <git@vger.kernel.org>; Mon, 27 May 2019 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOOSfEcydkVQLY6aCeUll9Gn/IAIOa1ttJ87jF9wqjw=;
        b=QUmJRvPg7111qDB7mozDF40ij5XxFy6JyemqEAci29lVIaY8kgjCnD4NBdLe9zYWKc
         T03ukvk8DOM3fujwuHjzV/WcnwVkRrwnnLsoUsqct72NEaPOUBDNULW5ZtGyt6j1dMzy
         RIWK8glfw4+wyuBueUf+A7MCgHxmErrY6+yBpZoxjz7v5UfBZcankQ5Nd+HSwSw9fLwW
         evH1KhllWhMtPbxZbQ5a0GZsOMf0AAtKO7cFZ1idzs6lCgqIWygQFfl7ybupbgCjy7KY
         3jUAkAXi6LGpiN32VTuZfUnMYBifE4YhHuPFjTO7LoSKV8yl0C/ST1NHEV6mxb1K2CDy
         y8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOOSfEcydkVQLY6aCeUll9Gn/IAIOa1ttJ87jF9wqjw=;
        b=rPseOJcqVu6/fJS3ZTSwc1rKMRX/yWu1TPdBsXLLhmY9Xr4PGUfrVT0Q0m9cmSTZRk
         BbsX7rphjYCd20mRsjruHYa8K+6QE6/1ixHxoDX4KTRPbcftlsOPem0fifPJn7TlFg2z
         72Jddw4n1GAZTkkMvkc/sfbuUEZFjUpjlXfDasVZ+yDWGm4ERMO+TxE5lnv+3+JILYRZ
         hbLkEnAzKgz7pRsCbj3Ik1Qk778MQ1OCjwxD+BNJHTces/7PWiLee3NcCQWUpJuHMLLd
         MjCpDGcKg2HxNnCs7ZgJIsf/BK5yeCdOYw70YNDwP6rAPinFt2M1EAtnGAU1yRTQHPze
         DcQg==
X-Gm-Message-State: APjAAAX9KIx7FKdruxhLRwMQ8zsrz18ht+npHmQp0yowLGQVIgSs+PZl
        apGqsMtfMcZDHJGQI9e4jZg=
X-Google-Smtp-Source: APXvYqz1cigh5q+we1OTh2QRHw8/voizTBe7r092Y2yZt5I98fNTNuh5RUZcw4zOSzkVyuIvea0eJA==
X-Received: by 2002:a67:e3c5:: with SMTP id k5mr31937328vsm.221.1558991572877;
        Mon, 27 May 2019 14:12:52 -0700 (PDT)
Received: from localhost.localdomain ([198.97.14.67])
        by smtp.gmail.com with ESMTPSA id k82sm7375170vkk.12.2019.05.27.14.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 14:12:52 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Eric Rannaud <e@nanocritical.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4] fast-import: checkpoint: only write out refs and tags if we changed them
Date:   Mon, 27 May 2019 14:12:45 -0700
Message-Id: <20190527211245.12292-1-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.rc1.dirty
In-Reply-To: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
References: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 4:10 PM Eric Rannaud <e@nanocritical.com> wrote:
>
> With this patch, we keep track of whether a particular branch or tag has
> been changed by this fast-import process since our last checkpoint (or
> startup). At the next checkpoint, only refs and tags that new commands
> have changed are written to disk. To be clear, fast-import still does
> not update its internal view of branches in response to external
> changes, but now it avoids interfering with external changes unless
> there was an explicit command to do so since the last checkpoint.

This patch looks reasonable to me; you can view it one of two basic ways:
  1) an optimization (only update what needs to be updated)
  2) a way to have early access to a completed branch

In particular, if the fast-import stream is dealing with unrelated (or
very divergent) branches and it completes one branch before others,
then your change allows people to have early access to both read &
update the completed branches while the import continues working on
other branches.

If you changed your description to sell it this way, it'd be fine
as-is.  But you use --force and make multiple mentions of concurrent
updates to branches in external processes during the fast-import
process.  That kind of description makes it really clear we need to
tighten up what happens with the checkpoint command when it hits a
failure (as mentioned in the commentary on V3).  Below is a patch that
does this.

I think we should either:

  1) update your commit message to sell it without mentioning the
     concurrent rewrites, and then I'll update my patch to not
     conflict (we both add new tests at the same location to the same
     file causing a simple conflict) by building on yours, OR
     
  2) update your patch to come after mine and add a comment to your
     commit message about how checkpoint will abort if it hits an
     error, suggesting that people should only update branches
     fast-import will not be updating further or they should use
     --force and deal with their changes being overwritten by
     fast-import.  Then you can submit our two patches as a series.

Thoughts?

Elijah

-- 8< --
Subject: [PATCH] fast-import: remember to check failure flag when
 checkpointing

fast-import, when finished, will flush out the current packfile and
update branches, tags, and marks, returning whether it was successful.
The point of the 'checkpoint' command was to do all the same things, but
continue processing the stream of input commands if it was successful.
Unfortunately, the checkpoint code forgot to check the 'failure' flag to
see if there was an error in e.g. updating the branches, which meant it
would also continue if there was a failure.  Fix this oversight.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fast-import.c          |  2 ++
 t/t9300-fast-import.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index f38d04fa58..d0e12b03a0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3033,6 +3033,8 @@ static void checkpoint(void)
 	dump_branches();
 	dump_tags();
 	dump_marks();
+	if (failure)
+		exit(1);
 }
 
 static void parse_checkpoint(void)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3668263c40..788a543b82 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3262,6 +3262,48 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
 	background_import_still_running
 '
 
+background_fast_import_race () {
+	options=$1
+	input_file=$2
+	exit_status=$3
+	extra_cmd="$4"
+
+	mkfifo V.input
+	exec 8<>V.input
+	rm V.input
+
+	git fast-import $options <&8 &
+	echo $! >V.pid &&
+	$extra_cmd &&
+
+	cat $input_file >&8
+	wait $(cat V.pid)
+	test $? -eq $exit_status
+}
+
+test_expect_success PIPE 'V: checkpoint fails if refs updated beforehand' '
+	git checkout --orphan V3 &&
+	git commit --allow-empty -m initial &&
+	INITIAL=$(git rev-parse HEAD) &&
+
+	cat >input <<-INPUT_END &&
+	feature done
+	commit refs/heads/V3
+	mark :3
+	committer Me My <self@and.eye> 1234567890 +0123
+	data 10
+	generated
+	from $INITIAL
+
+	checkpoint
+	done
+	INPUT_END
+
+	background_fast_import_race "" input 1 "git commit --allow-empty -m conflicting" &&
+	background_fast_import_race "--force" input 0 "git commit --allow-empty -m conflicting"
+'
+
+
 ###
 ### series W (get-mark and empty orphan commits)
 ###
-- 
2.22.0.rc1.dirty

