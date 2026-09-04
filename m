Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5643B6CB
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525879; cv=none; b=oWWtpW8Unl6RZGlXVw8KQyp3XCsdFLzm7plBzZ65sRnBOSHgsng6MxIaftes4G1mEosSZbURv4G3pTtcaSShXXlI4TSUkuqnYJnvL9ema7cxJ7HJcYeoV/AYdnzcZFJ9cGhfVnWp7qmCiFKgOuT4wyWWhDidx2MPmbno7N7dB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525879; c=relaxed/simple;
	bh=WPY4T9YgId3BhaYiFz5AGhBiVqMmwPBCaLXTyEYmjTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIGp5I+x2jVvdG5gLN48JD2BY0OBTcZhAVXAu8oP4oM/83eo5DsJjjrPMDIgnuPh3QCmzGufh3gC5o9bcyiNdq5HDjXd60F3nkhdT9s4ZAzISqIHx3IZscDFZ+yehSnJw08rRi/Z4Cj0zMRxIRTn/zjo7jDaTnHAVjaRcattzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Jb4jHvLx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Jb4jHvLx"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so603938f8f.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788525875; x=1789130675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3xX+BhErONP7WfIOAePMgrU0Cdaa20w/boPjNHlhFM=;
        b=Jb4jHvLxQhEdKen47FKS3h9/1xo/fn2Z3jb/AX8ot+28yDA3NsRZGvJxxzeFZshxgm
         ZnmYeGhkz3R1B9sCJtV2+q0Q3k87//SIoCU+7VWembZAO7ihvrVvTfYuJZEcW1Ue+NNR
         8NuNu/Ol+pPiPtUzO/C412aIKG/gy5/7hnVsOU27ARVQ2WFnw1D/brjraiYEOsyV5I6u
         rDNnNv36Pg+qG9FdNqNpumTupdOIWfCQ6yctGN6ukgLoNifknIQ60LuzFs+5OC2LjHEq
         QNmFgh7eL6EByVDTA/7+0q7hs3vSwtovGQ080QoMVOpgz2omnVYEiW0pFxDBkB+EiUSz
         GShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525875; x=1789130675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3xX+BhErONP7WfIOAePMgrU0Cdaa20w/boPjNHlhFM=;
        b=TzP+3mZzk4HARGeGQO/4ZDJ7lqckrQFhIHhumf0XzM/QAXfU50A/7pG62VSsFWppn3
         7Rl5jfnyap6WUckO/jEL+hlMSxLjuc6s/NdWoZKScWYadDNZmdEM7AG1gbetPUCmnQ6+
         +tqMhGP7vAqczW5IJNvbUhvxMyFv3lCpLaZ97s1YO8mrt/BrRtDFH+p+pV9xm6xvKg5I
         WAljRJdKXGVNnvWyzNFusvlo32Q0FJP1znLWTepEe3ntkmnLUB/e7xUjtM1C+5q70Ds9
         UVkW1SWxHX9Ab54WCqIrfT8Nb8bxMOLsDHvC4/zx5qzngnpjZuDuvzbVNo3+kbpsqd/U
         J1jg==
X-Gm-Message-State: AFuF++lm/OMCfgneMfJIRiK9RTPzWoCw9u5YUGumghysO/zStjtAoApq
	LGhZMuYsUo8zpcPyEykT4vupzfbSh6gXKmvnIsoBE4UKw1rz5ULN7aENMYNBV9UGXaailOBD9G5
	8/6srRDogpg==
X-Gm-Gg: AYBFou11UrPbyvlWZt7XZmHCP95aZDNIqPOsT4OvY5IUQ7+8HHc6tJJL4cUWBq2svIa
	HQTqLBQTh2d7XuoAtmO3E2tpZmsAV8m4p+PikXMFupEsG/SE5X9TIW0bas7Q9iDMQS3Bdm/Een5
	BNWho5fwId/zQCkTrCvbDM9QKfyrh106gknwJdxKKoXYkWtOd+uA/5MgjujOLXo9UDBnDfXx8uh
	K82D0MYtNPQF+x7B/vOSZ41S/ZQMjePFsZY6tZ+pBo094A8TD1YK9nNwi65NMkSdHYdkW/VCnRa
	juRpKUlf1l40vZpRjP5LgSxEQf1tgo8CZE3+iClCu0qr31x0sJ/FgDtSZDdeSEmngsyGzx7hOZR
	iilmBapVkBBQsKQJsS0e1VK5x8uqB4CuO3z1FNO5qungA2f6JcKbJXdvndM3HxsUbrywK478CzC
	fsXaCoNoMWWSIw7Qbs7EdBTx/exZ4/3RWZOQiwH6fpfHRB3st2XX/W2LaAsfjv8nWEYKtSI/LQe
	9rG5c4=
X-Received: by 2002:a05:600d:6445:10b0:49c:fc6c:be09 with SMTP id 5b1f17b1804b1-49cfc6cc00emr24118715e9.32.1788525875430;
        Fri, 04 Sep 2026 05:44:35 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm151255475e9.10.2026.09.04.05.44.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 05:44:34 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v2] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Fri,  4 Sep 2026 15:44:33 +0300
Message-ID: <20260904124433.12840-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903010547.85469-1-f@lex.la>
References: <20260903010547.85469-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
local branch at entries older than the newest reflog entry of the
remote-tracking ref. That timestamp is read by a callback of
refs_for_each_reflog_ent_reverse() into a variable that is never
initialized, so when the remote-tracking ref has no reflog the walk
is cut off at whatever happens to be on the stack.

With the files backend a remote-tracking ref created by "git clone"
has no reflog and does not get one until it moves. On my machine the
leftover value exceeds any real timestamp: the walk stops at the very
first entry, never reaches the "Created from" entry that "checkout
--track" wrote, and the push is rejected with "remote ref updated
since checkout" although nothing on the remote has changed.

Initialize the timestamp to zero, so that a remote-tracking ref
without reflog makes the walk cover the whole reflog of the local
branch, as documented.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Changes since v1:
  - sign-off is now the last trailer
  - test_when_finished moved ahead of the setup so a failed init, push
    or clone still cleans up

 remote.c            |  2 +-
 t/t5533-push-cas.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 00723b385e..6d301698ca 100644
--- a/remote.c
+++ b/remote.c
@@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
  */
 static int is_reachable_in_reflog(const char *local, const struct ref *remote)
 {
-	timestamp_t date;
+	timestamp_t date = 0;
 	struct commit *commit;
 	struct commit **chunk;
 	struct check_and_collect_until_cb_data cb;
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872d..bb8878c593 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -396,4 +396,22 @@ test_expect_success '"--force-if-includes" should allow deletes' '
 	)
 '
 
+test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
+	rm -fr dst src &&
+	test_when_finished "rm -fr dst src" &&
+	git init --bare dst &&
+	git push dst main main:branch &&
+	git clone --no-local dst src &&
+	(
+		cd src &&
+		# a clone leaves the remote-tracking refs without reflog
+		# entries with the files backend, but not with reftable
+		git reflog expire --all --expire=all &&
+		git switch -c branch --track origin/branch &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-if-includes --force-with-lease="branch"
+	)
+'
+
 test_done

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

