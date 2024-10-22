Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EE51CCEFA
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634945; cv=none; b=t8q/0ra3UE+Fa2v0KBzkxyr50nLZkXUQHRYRONeZykFosmMiyc08C+FMbyVeD70dsL8J3E0JYj/2cuPhq05sbYWLRlJHLtoeOAlCV7rlRVdCFz15+dsEQ8crzbjPg+j9TeJ7mYYvqDvBfX1oM3S73iNuxNZJ/kFuspWNe+nT+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634945; c=relaxed/simple;
	bh=37eIvsVESLXLyoI6O5Hzp3/HE8UXk+PVlwfWePSa1M0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NJNby0QdkUIfLmp11lMqlWjVtynrA1zFBWMxdrwl9ndCxNRzAmw694+rNjkeAPBTd6Q7kOiM62UyrmCM4wrfmyVfIa0DpBM2SeNtEsCDP21H4rYj+tqcUKD01AC/Mu1ePjCBz9XCM3OxO5Bfo6Gy0lk8L+cZ+c5UHEJNpreXl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RszENaeC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RszENaeC"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53a007743e7so7495087e87.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634942; x=1730239742; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljjAwwc49VPeSHdsjTz8xOsjWNLz4b6qMHM1WZ0Hi1s=;
        b=RszENaeCYROEuScTfrNgoVKm/ivcAtFMRfrqPGeTznDvtEiYwsfLxkjny2Ml2jglUx
         HZ/OHLwk7owANkdtGpQW4PcflrxtjY7lmeDZMua9y40yiqW+nB4kJTrKSftBO/p55rMI
         7LxlOTknhd27nKA6KBewPo4+Tq6rUlQCYmPDZ7MNHzAMkE2iiTjqKu9LWS5L1/TeL53J
         UAGE5qIvYloxpOSlI0J6sxshyRdm2056BJ1O9UhzSDvqAko6E8gR5kc8h5ffs1o5FmKn
         YAwOIzxDq1AiXwPyUj9ADDi27+8F1WkFum8od7DlxBV+WL37hbTUvzwD86R+vYEoMORc
         czhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634942; x=1730239742;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljjAwwc49VPeSHdsjTz8xOsjWNLz4b6qMHM1WZ0Hi1s=;
        b=OmmWqtFVw8cvTUo2WYQTxHu2W/PigQ+pxkzqmWG8HPNF2uDFUkUNDRn1k0glMTOX0+
         8Uv18Z0SfBhO9eJA38CgaLVOI+NvZ1DDjYXWeepCnWyDxTU1xWEKIDKRQ0NDrCv8dZ99
         fpbUBcNb21H2JisMqMLBnU8qsM2pmzKDZDWXph3YInJJlE48r88koCzkoWT9CAkx7mzf
         L12FquOoMH2tZkncqsi/vHaetEHS9Rp9QUPsRfgmfOV9c6xCiuRmF7BEwOr3y4A1+jz3
         z+fNJ3bYekYmzYgiksIYYrQJHnIQSxkT8fzvo5XmP5BCp7sHkKa887PqGJC54XfJgHDC
         ICCg==
X-Gm-Message-State: AOJu0Ywi8/cY4pDLXRDQxhAW5qherLQ+2KUJfi44R6MJMFQl4IeoaBHJ
	ZILW8SkBSG66KfXy56q4x175zg8Puc99wF8Dr91ErkRy9uhVpc2Z5hBerQ==
X-Google-Smtp-Source: AGHT+IETmBdEiZ0T7VJGTnTQ9T9ZkU2W9OuB8PuaXM7v44A/buiVO8/ITJwycjtpn77zf0e8T+Mgsg==
X-Received: by 2002:a05:6512:2306:b0:539:f7de:df84 with SMTP id 2adb3069b0e04-53b1a30d360mr172500e87.10.1729634941393;
        Tue, 22 Oct 2024 15:09:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c72581sm3604290a12.86.2024.10.22.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:09:01 -0700 (PDT)
Message-Id: <8982dca646db72f903bd4c20416d6118da1c210c.1729634938.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
References: <pull.1810.v3.git.git.1729574624.gitgitgadget@gmail.com>
	<pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Oct 2024 22:08:57 +0000
Subject: [PATCH v4 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
 and UIDNEXT parsing
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace unsafe uses of atoi() with strtol_i() to improve error handling
when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
Invalid values, such as those with letters, now trigger error messages and
prevent malformed status responses.
I did not add any test for this commit as we do not have any test
for git-imap-send(1) at this point.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 imap-send.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ec68a066877..8214df128e5 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		return RESP_BAD;
 	}
 	if (!strcmp("UIDVALIDITY", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
 	} else if (!strcmp("UIDNEXT", arg)) {
-		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) || !imap->uidnext) {
 			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
 			return RESP_BAD;
 		}
@@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		for (; isspace((unsigned char)*p); p++);
 		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
 	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
-		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity) ||
+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx)) {
 			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
 		}
@@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (!tcmd)
 				return DRV_OK;
 		} else {
-			tag = atoi(arg);
+			if (strtol_i(arg, 10, &tag)) {
+				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
+				return RESP_BAD;
+			}
 			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
 				if (cmdp->tag == tag)
 					goto gottag;
-- 
gitgitgadget
