Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E38493
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729506; cv=none; b=RC/1/+1n28lxabOHoDWamL3vSNajPG5YsAdQyo0GDLecsAPPSCIQ7AvbjB3kvG7q7NCELRDGesqHY7aFqU+3MLYuEec7HcxtJQdqvSfJELOC/hmsnRKE/KLbl7ZJoPEVSdXGT8ImhcEG5/dVfpL/p+yZur0XAAms+enAo+osLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729506; c=relaxed/simple;
	bh=+m7C0CcNl2NR3KoZZfHWLylLpvi2YgM1K5aK6Fqwk/g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BXlm2ubFcNjg755jZ7zgXC92LaB5sqWVW6q5bMGXZ3gbiBEZi4T8ahNSyqxl3Ktp8P+IKYY8O1179E6QhERMNF7p+m+81VgsGACISN+ycQqkM2uyX3itYUcQEfhqdO9RNmBFKL9Sdz+Y+so94dFAlDxVq6Bn2NCwnNTO6XQY8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGrYdUOj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGrYdUOj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cb72918bddso417325a12.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729503; x=1730334303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rzv7AnOxuQovJ9pw7+5rvDkRMri4p78w2Bp8gd0vNA=;
        b=bGrYdUOjx58BcFuZ8rvUjHS2pOv05oQvbKyVyDfeF8o4YbH4oPfSpDMvRM+dcd6Y1d
         XBOUFIDXvqMIfji5v50TBcBZ7zsUfQZIGggPCWEPSPv5fLXAVzJ8yB8Za3Va99MUvCAr
         sfI7UrN+y1eS8LVQG92sVAwaUxAf+E3cLkjpEWw5iHlyrVRLPCOFMlUXyC0fsgAwh6Rq
         v7rQg+0EuzOkgFiX4uBOCy7GivSLkdIxVTdeFzuMcgR+BE7RYQ7yBwLCL/dg2nTEB38r
         Bs4RGBuZsf4HOkBWKuCUj4QtOUoMJ4/IJri3rPrjvnP6SViwdZ50YW5lugoWXiixy9c6
         vpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729503; x=1730334303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rzv7AnOxuQovJ9pw7+5rvDkRMri4p78w2Bp8gd0vNA=;
        b=pLIJ7DikGhbWvf/B7Ia/GmuiTFxpFWt7wn90mrEoPY4Fk8NrdMysOu8o7tGQ5SIlIq
         XoBkcbxrpLZgSUWxCKAbOzw6t+LJzTgzXERJrH4aWyA1QILttxiARt3iOl79GLFtHjlx
         0lEFQtCKSZMhz3aAjIGG60hhBLulZ5TlCuLkp9rOQe+jXfojbCt7NBJCu4q4FRDt+ayb
         0lG6blQKpVVyf2hWOqfLA16bf+to/hhy7iSRvfieZNgYJUh5TIjV/69clHz5zNYGon2F
         lN6qgYXkBNPzgFEqTRr5U8lfvPF1kMfAhbJd6YzMWZi4QXjJS09Bun3eNpf8tqU5vPYG
         fksA==
X-Gm-Message-State: AOJu0Ywa5nKvVEo4dlVfaDDJ4blpVuDqjpEcGSgw+fOlYT9tMHBYdzSS
	lQM07F95EoHRvFdNuWEOskaLuhifBMMTde0K6JISt8mArS/tYpa03dU8Pg==
X-Google-Smtp-Source: AGHT+IHfZ/na2fJ4f5eVkUP/RAW0gBFCgTrH7TlQwIJ80oJfLqKoErRSCDQR6k7/T59GX0glX3xL8g==
X-Received: by 2002:a05:6402:254d:b0:5c9:4281:4515 with SMTP id 4fb4d7f45d1cf-5cb8acb7b0amr3803671a12.17.1729729502632;
        Wed, 23 Oct 2024 17:25:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a555sm5031724a12.45.2024.10.23.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:25:02 -0700 (PDT)
Message-Id: <17484df5200356c9cc17cde293e501a5a88a744a.1729729499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
References: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
	<pull.1810.v6.git.git.1729729499.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Oct 2024 00:24:58 +0000
Subject: [PATCH v6 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
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
    Patrick Steinhardt <ps@pks.im>,
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
index ec68a066877..488c06e6139 100644
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
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) || !ctx->uidvalidity ||
+		    !(arg = next_arg(&s)) || strtol_i(arg, 10, (int *)cb->ctx) || !cb->ctx) {
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
