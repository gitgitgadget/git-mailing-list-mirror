Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7393F12CB
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427696; cv=none; b=a2AcQQsEUZz83vSPbpFMRVuOYeUqc9iLyF/NJsa95fAcKFdAtCVamrjmoFXPyjQSvvUUCLbMwsUoa6cKICq4TUxweMfLX6DVYK0jYZar3OACI59mTgiJENKiGjdQ5ZJNJamVWfe/TRw93WCBXBR5XM58xFnaNEnHUFnkZS4iEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427696; c=relaxed/simple;
	bh=2vVhVf5Y8te66aaXlkW+Mqcl73WOxgsTnwSjVfiRzvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZ9jWSwOtU8CaRtUCltXCB6gwsyn7ritZ6WwJ+jQH7rKMwPOkob8rmvbhKMdfPmx7Nc46ihjH6wrgTGTnt3QY1/vCrV7HuB3D84RL1jXQZ2fuciMegwlUJEla1p3eIceaXuoAGwqA8mtU57xmyjjdo9y420uBRWxuwnnido4p3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMTLPozp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMTLPozp"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48442ea8f59so579616f8f.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427692; x=1789032492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7/uyOKPS/AHHXWENTh19BOLMKtY2b6fPSxGjwVkmmw=;
        b=QMTLPozpgeqFs+doLZtBp479oFlckNl/0uEVUmuOtX0W6jwXaZNWX/WRVzlz0Gn/Z+
         MMbCni5Y/iISIouERDXUYhg9n5XNoPz6z57nziQLxEqLul1B/UWmlzVP2oY+fX+g2Xgu
         tDWXwhygq+23eOhfhqyRO9IEdnqeCDZU8Kk9j8/PYubtzCGRioK+T/+bBrojbGopvIn4
         A+Q6YK/vl98Gu/Q/Eg9kqLdFFYaVdrEeRUT+PLGizyo+sq4ThhVqZkKd1ERpLemqsVNH
         GhyRg6lfWCgICg1g4e6uNnVU/myMg7nJ76osKinyuuj5/hSX16my7lRMJfcVGV2Kbv9r
         GZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427692; x=1789032492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7/uyOKPS/AHHXWENTh19BOLMKtY2b6fPSxGjwVkmmw=;
        b=hArBdiza4NEWa4fZ4I3t2B1glZAmAn9e2rLzB43ueSU+gdQ4DAlxik1NB6Iie+WkKn
         qo61JYdw5n3dapChhO06ENNb8QUXNuIT4vXKsWkvKXbFAuRBgCoSLDm/SoEY0z5vzLVg
         j7H+tORUD60pPiLDuWMY3n11lCDibioOzrgAWX4jik3gsSP+SEl8Y/UaxVCyinfr2q9B
         enXZayuQrm7K+UGdoq15kdBBAsUOudnK7UvKo4vOv9ODbjmIwEpPzsNlpFYYJClLDyp4
         kHWQzA5g0tUAHCCyZ/pFpoIqTheTiUWvC6bHaM56KfDFDzieKeESrNBY9Cqs+wlaoQpe
         SMLg==
X-Gm-Message-State: AFuF++ksXuw8mAiPFMumQ1E8rEaGZlNbCIqnpzMwPl3RuU20pgHadZW3
	tyUDY9Rl/KYyxJXf55k5hclQnixh/Z2aME1Q+AnawuQn0NEKfZhwELq+
X-Gm-Gg: AYBFou3KUS54EJS6AfaP0uV2y/Ebhp4JV+e3qrBhOv7uBTjn6xkFVP21uS9snBdvwcG
	snJkjsrfXdhu5yj3Q3rqFifVF/HhcQD8SNzk0mXaf8j8C3axGrDm/HOo3uJhSQ7t4peXQlCrODv
	v2rE6mAtg3gx5Jxsd2N5qv7BCimaaiW0KDYzFIIUFC4F/gSn/1kZ4X8pWduO1i2SX5ONC6X1B+4
	hI1jKQdzzJ2pMaDcZ/GEzsxSI3BCDvViFXRJBtsH2NxaehXrPNWW5nQ1AgEwRqkId0NJC8U07sn
	4kVW16/M0VKXxreR6bdHCxraqHrUGwvdbmYpNTBQZ0s/qAMZIMYG8BD5+ZTXdZwbS0DmS1l/3Jr
	8g9GLMpCBeL6SimApr881JHg97OgJMXIpNUtVBNKQUHCU3ZYp6khhsRpLoKQEqHi/Xv18cjKl4m
	xKoqoBEeYmFacJrPf0ugvIEoHegnfaZ4wSfGklmygpQZf7o4KqVFy11Uuo6bDVJEMz8uMUTd4Pd
	sXQpOf8XzrGE5SuQMFY4KQ1Z60=
X-Received: by 2002:a05:600d:4445:20b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49cf1577d23mr18248355e9.1.1788427691924;
        Thu, 03 Sep 2026 02:28:11 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:56e2:6e6b:ebf7:2587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm55553105e9.10.2026.09.03.02.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:28:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 03 Sep 2026 11:27:59 +0200
Subject: [PATCH v6 2/4] receive-pack: drop static variables to track report
 status version
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-758-introduce-hook-v6-2-6283b1fb9b1c@gmail.com>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
In-Reply-To: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=2vVhVf5Y8te66aaXlkW+Mqcl73WOxgsTnwSjVfiRzvs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqZPacMh0O6XMi0xsJj2FqowjcveTFeQBxSv
 9ZWcZYRSbf1G4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmT2nAAoJED7VnySO
 Rox/l2IL/0ZSFd4Xtrb8mzLSgkMAsmvXoZ74s/WEPKMFBZRJpLh+LppT1ORginYtARwCPqT4nAP
 9xn/CQ6otzByX3A54Rcqa4oZgbfcJUpUmP7nkI+G0DK7IIo7xw8H7Kt7JsCZLZ9ul8sJkX715Ya
 vVgYWkED8o7aAtQZB+Fsq+G2wkkSVXy4G3SjLLBHBEQZmwRMUHMahANV5+ZdKxRWDxxKHihjou5
 T7OU2JhiuXPqShdw7lrrcwvYe8c1CB3Mo0sOOADGwhOhxS0krS2ihxskfjGNdg4ktakG/wHpUjp
 Qh5PjgNg838xmKI8ShLWtYEtlnDEulKb6JHSenWT9DkLhYfHvXjS++wjMorzzEvOztIFIi3rVUa
 oGxu2Skix+Jv8zyrsI51uTUHQtHODPMKyrspQSAxp+F7F8aeQhOj+ZcXLPBN+SZfuceSJoAx2NF
 5TXFUTNhmsmdLHRI8wxXOxNhqYJexuRYsL/x0CfBkRIAkJK9FiPzF2mauP8Zw4AsuTqWA67aJF5
 k0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'git-receive-pack(1)', to track the report status version, we use the
static variables `report_status` and `report_status_v2`. As the report
status version is mutually exclusive, using an enum better suits the
requirement. switch to using a new `enum report_status_version`, while
also dropping the static variable to make the flow easier to understand.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/receive-pack.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86933d8d7e..a9a3d21c24 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -55,6 +55,12 @@ enum deny_action {
 	DENY_UPDATE_INSTEAD
 };
 
+enum report_status_version {
+	REPORT_STATUS_UNKOWN = 0,
+	REPORT_STATUS_V0,
+	REPORT_STATUS_V2,
+};
+
 static int deny_deletes;
 static int deny_non_fast_forwards;
 static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
@@ -69,8 +75,6 @@ static int advertise_push_options;
 static int advertise_sid;
 static int unpack_limit = 100;
 static off_t max_input_size;
-static int report_status;
-static int report_status_v2;
 static int use_sideband;
 static int use_atomic;
 static int use_push_options;
@@ -2207,7 +2211,8 @@ static void queue_commands_from_cert(struct command **tail,
 }
 
 static struct command *read_head_info(struct packet_reader *reader,
-				      struct oid_array *shallow)
+				      struct oid_array *shallow,
+				      enum report_status_version *version)
 {
 	struct command *commands = NULL;
 	struct command **p = &commands;
@@ -2233,9 +2238,9 @@ static struct command *read_head_info(struct packet_reader *reader,
 			const char *client_sid;
 			size_t len = 0;
 			if (parse_feature_request(feature_list, "report-status"))
-				report_status = 1;
+				*version = REPORT_STATUS_V0;
 			if (parse_feature_request(feature_list, "report-status-v2"))
-				report_status_v2 = 1;
+				*version = REPORT_STATUS_V2;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
 			if (parse_feature_request(feature_list, "quiet"))
@@ -2621,6 +2626,7 @@ int cmd_receive_pack(int argc,
 	struct shallow_info si;
 	struct packet_reader reader;
 	struct odb_transaction *transaction = NULL;
+	enum report_status_version version = REPORT_STATUS_UNKOWN;
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
@@ -2689,7 +2695,7 @@ int cmd_receive_pack(int argc,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	if ((commands = read_head_info(&reader, &shallow))) {
+	if ((commands = read_head_info(&reader, &shallow, &version))) {
 		const char *unpack_status = NULL;
 		struct string_list push_options = STRING_LIST_INIT_DUP;
 
@@ -2716,10 +2722,12 @@ int cmd_receive_pack(int argc,
 				 &push_options);
 		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
-		if (report_status_v2)
+		if (version == REPORT_STATUS_V2)
 			report_v2(commands, unpack_status);
-		else if (report_status)
+		else if (version == REPORT_STATUS_V0)
 			report(commands, unpack_status);
+		else
+			BUG("unknown report status version");
 		sigchain_pop(SIGPIPE);
 		run_receive_hook(commands, "post-receive", 1, NULL,
 				 &push_options);

-- 
2.55.GIT

