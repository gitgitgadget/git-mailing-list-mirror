Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A9EC1F462
	for <e@80x24.org>; Tue, 11 Jun 2019 07:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404379AbfFKHe3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 03:34:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33890 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404322AbfFKHe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 03:34:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so609783pgn.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTOIkHoUKZDMl/hIrLtBYW8NW7UJ8hFc3LppTMyEPZk=;
        b=tEIFXeIFHEJdN6r5HE6EYd0T/eKLm6hniyN7mZyqURT9vKugDDcN2GZO3auzj4ojkW
         SMG/FjQyEAfATBdycAuK3hFyUF4oN5rwzfCYbkZarxfjSYPLSUwqxziHug9pUPpIKaM0
         +DjS0EDds/eds4Cl8Nty5EsFFe6tn7PB9TfIoZ9Rz5JK3KK7dD5jFf7xqctSn6JdM8Il
         LVRce2QMvNCFVFZj/YAbpRmWdFHXHNvYZWFyoUTLclh6qUrscAWx4uhwhP3Gm/+gqP5e
         KS+963HPwdWag3ldb7WFrkNJtEVzckjT3dd7dMB1qLj9PrVl2fMb3bpo+NbPcHq67IXm
         Ypxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTOIkHoUKZDMl/hIrLtBYW8NW7UJ8hFc3LppTMyEPZk=;
        b=kMDyMYM3rTdl+E1kBknKi/9r9e9SbF7XnMToP4vJUlx18WQ3g6BqssoO8UUqZmg9Gc
         cz8jMuaZv2Doj9yU55QtzoeibzNdotD1d3kESmxvN8gxMd/Cp736ZqhR6hW91pgcAeN8
         o6S0v4xsFeFrGjvkB4H7GmTm89umlogBztyMjKQz/hlx7hCZDpNMguYk9wvfmIy5HEGH
         Ug4iH/iQJpCE0Swi+anNByz76IhNSQjI1ZKbarN7AIjV325fWLyv7buCkGP+4YTwVH7p
         PUAFa+EfHjefeZRcgUkRwltaebQ59hgPTMQhOdrO31cjg6fSNbmhtQqZN/Hig8zacLx5
         qtng==
X-Gm-Message-State: APjAAAVVjiPgCuDYYh256H8IBvV4ZGiHEpVFF3QvxKoQCm5NvcAV4XvB
        jE6rqAYo8ouForVnR+w4BMI=
X-Google-Smtp-Source: APXvYqx1pX6CD/e7P3VdCiT8W0HJpMhlqBNaKNTl4OV+atJkHZ2smNB5kURJ8O5Gkl/qXKyUr8uCtQ==
X-Received: by 2002:a65:5203:: with SMTP id o3mr19007352pgp.379.1560238467970;
        Tue, 11 Jun 2019 00:34:27 -0700 (PDT)
Received: from ar135.iitr.local ([2401:4900:310c:9b37:39e2:17f3:788e:3d39])
        by smtp.gmail.com with ESMTPSA id m16sm7166022pfd.127.2019.06.11.00.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:34:27 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v2 3/3] cherry-pick/revert: advise using --skip
Date:   Tue, 11 Jun 2019 13:01:52 +0530
Message-Id: <20190611073152.12214-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190611073152.12214-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced a --skip flag for cherry-pick and
revert. Update the advice messages, to tell users about this less
cumbersome way of skipping commits. Also add tests to ensure
everything is working fine.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
changes since last revision:
    - selectively advice --skip
    - add new test

 builtin/commit.c                | 13 ++++++++-----
 sequencer.c                     |  7 +++++--
 t/t3510-cherry-pick-sequence.sh | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1c9e8e2228..1f47c51bdc 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -60,15 +60,18 @@ N_("The previous cherry-pick is now empty, possibly due to conflict resolution.\
 "\n");
 
 static const char empty_cherry_pick_advice_single[] =
-N_("Otherwise, please use 'git reset'\n");
+N_("Otherwise, please use 'git cherry-pick --skip'\n");
 
 static const char empty_cherry_pick_advice_multi[] =
-N_("If you wish to skip this commit, use:\n"
+N_("and then use:\n"
 "\n"
-"    git reset\n"
+"    git cherry-pick --continue\n"
 "\n"
-"Then \"git cherry-pick --continue\" will resume cherry-picking\n"
-"the remaining commits.\n");
+"to resume cherry-picking the remaining commits.\n"
+"If you wish to skip this commit, use:\n"
+"\n"
+"    git cherry-pick --skip\n"
+"\n");
 
 static const char *color_status_slots[] = {
 	[WT_STATUS_HEADER]	  = "header",
diff --git a/sequencer.c b/sequencer.c
index 93284cd7dd..ecf4be7e15 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2661,10 +2661,13 @@ static int create_seq_dir(struct repository *r)
 			error(_("a %s is already in progress"),
 				 action == REPLAY_REVERT ?
 				 "revert" : "cherry-pick");
-			advise(_("try \"git %s (--continue | "
+			advise(_("try \"git %s (--continue | %s"
 				 "--quit | --abort)\""),
 				 action == REPLAY_REVERT ?
-				 "revert" : "cherry-pick");
+				 "revert" : "cherry-pick",
+				 !file_exists(git_path_revert_head(r)) ?
+				 !file_exists(git_path_cherry_pick_head(r)) ? ""
+				 : "--skip | " : "--skip | ");
 			return -1;
 		default:
 			BUG(_("the control must not reach here"));
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 6c1903a735..f298f02cd0 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -172,6 +172,26 @@ test_expect_success 'check advice when we move HEAD by committing' '
 	test_cmp expect advice
 '
 
+test_expect_success 'selectively advise --skip while launching another sequence' '
+	pristine_detach initial &&
+	cat >expect <<-EOF &&
+	error: a cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --skip | --quit | --abort)"
+	fatal: cherry-pick failed
+	EOF
+	test_must_fail git cherry-pick picked..yetanotherpick &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_cmp expect advice &&
+	cat >expect <<-EOF &&
+	error: a cherry-pick is already in progress
+	hint: try "git cherry-pick (--continue | --quit | --abort)"
+	fatal: cherry-pick failed
+	EOF
+	git reset --merge &&
+	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
+	test_cmp expect advice
+'
+
 test_expect_success 'allow skipping commit but not abort for a new history' '
 	pristine_detach initial &&
 	cat >expect <<-EOF &&
-- 
2.21.0

