Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8712047F
	for <e@80x24.org>; Thu, 28 Sep 2017 05:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbdI1FHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 01:07:47 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:46894 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdI1FHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 01:07:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id r68so289642pfj.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pPEO9voUMrgvQfTyXOVjB5ZQqYFGK7bFlInzLYt8R0k=;
        b=HB415k381SnzWa4ZEmj7qT5o653IfkAemBPPcAoAk1FPwT57ync5BVCRge/vin846n
         vOUmVfs0e95ZFn5EhVwqBjpRRZcOs6Nqsp1tXd/XwDFXOq56Mhi+FQDqXACbUGocw2Ia
         4hzYZy/0w6XI4HcQAhH146ChisVDdPn4wRHkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pPEO9voUMrgvQfTyXOVjB5ZQqYFGK7bFlInzLYt8R0k=;
        b=TH3RcLKOn/o4B3hjXG+wQJvESXg6wYAnc3HCotU2+OWW+e+iWMdtN569oYqiWnjcfQ
         woz+pRt6dymopUw1Ksf5t54WyV4X/DhBTwE93eRo9s1kN940HG3RyjpYFL4F186b1hMz
         5vvSs9y4O0ZjlVVnWdCANhCxyzpx+Z5+eU/5kHcechstuqMtzXb/bBIsolsOvs3ykUaZ
         hYwtXOhM5QwCVi9HSwJR0c/1ijnFXOVRELrEpoUYljmM8b3itqGIZJ37N4tocsSajUyj
         jwoZD++LbR+8gk2jn3seKPZmdqDPxFN/n+CWoSRIaPc5OtvA+YR1akPKtY42DviNz/xy
         jp/w==
X-Gm-Message-State: AHPjjUjmmRaOpC8Eb01QvTAuNdfQDGZnQhL2Z9bLDztABqEPFFv+ZBi8
        Arwh490VG0OQVDYoQYbt9VzQ6w==
X-Google-Smtp-Source: AOwi7QDNu1hVPm6WlemNw1OIZMGfZhXs8HrkF2hx9AJunuKAxaYicTJbs28Vi74PdsRoXJXcb251Aw==
X-Received: by 10.98.144.142 with SMTP id q14mr3214890pfk.303.1506575265253;
        Wed, 27 Sep 2017 22:07:45 -0700 (PDT)
Received: from localhost (node-1w7jr9qprg76wahmznhtpeq14.ipv6.telus.net. [2001:569:78e4:8500:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id u20sm847583pfh.171.2017.09.27.22.07.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Sep 2017 22:07:44 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Wed, 27 Sep 2017 22:07:42 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Wed, 27 Sep 2017 22:07:41 -0700
Message-Id: <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
References: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The checkpoint command cycles packfiles if object_count != 0, a sensible
test or there would be no pack files to write. Since 820b931012, the
command also dumps branches, tags and marks, but still conditionally.
However, it is possible for a command stream to modify refs or create
marks without creating any new objects.

For example, reset a branch (and keep fast-import running):

	$ git fast-import
	reset refs/heads/master
	from refs/heads/master^

	checkpoint

but refs/heads/master remains unchanged.

Other example: a commit command that re-creates an object that already
exists in the object database.

The man page also states that checkpoint "updates the refs" and that
"placing a progress command immediately after a checkpoint will inform
the reader when the checkpoint has been completed and it can safely
access the refs that fast-import updated". This wasn't always true
without this patch.

This fix unconditionally calls dump_{branches,tags,marks}() for all
checkpoint commands. dump_branches() and dump_tags() are cheap to call
in the case of a no-op.

Add tests to t9300 that observe the (non-packfiles) effects of
checkpoint.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 fast-import.c          |   6 +--
 t/t9300-fast-import.sh | 126 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+), 3 deletions(-)


Updated to include Junio's latest remarks.

Also adding the necessary PIPE prereq, as pointed out by Ramsay Jones.


diff --git a/fast-import.c b/fast-import.c
index 35bf671f12c4..d5e4cf0bad41 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3189,10 +3189,10 @@ static void checkpoint(void)
 	checkpoint_requested = 0;
 	if (object_count) {
 		cycle_packfile();
-		dump_branches();
-		dump_tags();
-		dump_marks();
 	}
+	dump_branches();
+	dump_tags();
+	dump_marks();
 }
 
 static void parse_checkpoint(void)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 67b8c50a5ab4..b8d394548520 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3120,4 +3120,130 @@ test_expect_success 'U: validate root delete result' '
 	compare_diff_raw expect actual
 '
 
+###
+### series V (checkpoint)
+###
+
+# The commands in input_file should not produce any output on the file
+# descriptor set with --cat-blob-fd (or stdout if unspecified).
+#
+# To make sure you're observing the side effects of checkpoint *before*
+# fast-import terminates (and thus writes out its state), check that the
+# fast-import process is still running using background_import_still_running
+# *after* evaluating the test conditions.
+background_import_then_checkpoint () {
+	options=$1
+	input_file=$2
+
+	mkfifo V.input
+	exec 8<>V.input
+	rm V.input
+
+	mkfifo V.output
+	exec 9<>V.output
+	rm V.output
+
+	git fast-import $options <&8 >&9 &
+	echo $! >V.pid
+	# We don't mind if fast-import has already died by the time the test
+	# ends.
+	test_when_finished "exec 8>&-; exec 9>&-; kill $(cat V.pid) || true"
+
+	cat "$input_file" >&8
+	echo "checkpoint" >&8
+	echo "progress checkpoint" >&8
+
+	error=0
+	if read output <&9
+	then
+		if ! test "$output" = "progress checkpoint"
+		then
+			echo >&2 "no progress checkpoint received: $output"
+			error=1
+		fi
+	else
+		echo >&2 "failed to read fast-import output"
+		error=1
+	fi
+
+	if test $error -eq 1
+	then
+		false
+	fi
+}
+
+background_import_still_running () {
+	if ! kill -0 "$(cat V.pid)"
+	then
+		echo >&2 "background fast-import terminated too early"
+		false
+	fi
+}
+
+test_expect_success PIPE 'V: checkpoint updates refs after reset' '
+	cat >input <<-\INPUT_END &&
+	reset refs/heads/V
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input &&
+	test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
+	background_import_still_running
+'
+
+test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V
+	mark :1
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+
+	echo ":1 $(git rev-parse --verify V)" >marks.expected &&
+
+	test "$(git rev-parse --verify V^)" = "$(git rev-parse --verify U)" &&
+	test_cmp marks.expected marks.actual &&
+	background_import_still_running
+'
+
+# Re-create the exact same commit, but on a different branch: no new object is
+# created in the database, but the refs and marks still need to be updated.
+test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no new objects)' '
+	cat >input <<-INPUT_END &&
+	commit refs/heads/V2
+	mark :2
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+	from refs/heads/U
+
+	INPUT_END
+
+	background_import_then_checkpoint "--export-marks=marks.actual" input &&
+
+	echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
+
+	test "$(git rev-parse --verify V2)" = "$(git rev-parse --verify V)" &&
+	test_cmp marks.expected marks.actual &&
+	background_import_still_running
+'
+
+test_expect_success PIPE 'V: checkpoint updates tags after tag' '
+	cat >input <<-INPUT_END &&
+	tag Vtag
+	from refs/heads/V
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 0
+
+	INPUT_END
+
+	background_import_then_checkpoint "" input &&
+	git show-ref -d Vtag &&
+	background_import_still_running
+'
+
 test_done
-- 
2.14.1

