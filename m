Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88056EAC5
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669230; cv=none; b=UwUaj47yK6S3FXusotgwvSFMVxt1gQrKM0FNNCRNvQWuS2hRwRGtgxAT1IVnvuhUq13eab4uiAqWi++yTtGthJ0HdXrkh/GF5FRYSGdDN8y2U0OIQ8oeWDT+TqlfZcGdgRMcaTWWauGoVmHCqwmMrXG4nvbWnKg9MqrAdJ4R7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669230; c=relaxed/simple;
	bh=+m7C0CcNl2NR3KoZZfHWLylLpvi2YgM1K5aK6Fqwk/g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u3vq49CntNHeO6ZGADvwdK6EQMAj090/oqRVsBd5T6lOcKJw4963tJKY/wZdurHCQ9/3Jlhph29BzVszx+hPLscnaAnnnwYF1eIhpHYeICik13LJelr8wwK8K2w3KEqxFsok9Ih8xOvDoWJwP086D1yq1PtqYB3OpJ5tv8D3PoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFq6qqUj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFq6qqUj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9aa8895facso304246666b.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669226; x=1730274026; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rzv7AnOxuQovJ9pw7+5rvDkRMri4p78w2Bp8gd0vNA=;
        b=WFq6qqUj4bwGq9xjiAlYYt/pgnVUzdkijhavExNX7F+Yjwwujqz0wP/3d8h8WZf9Bk
         Jp54Gumf8yI79e6+H+km+Le0doZ+LHZrlon0RgFSrKpp+Aqh24cLGrVt1cQdsR9LZdu1
         gQNevNgDO8mnZjIxj5+wm5s3M6IdeH3KjpVwtfc6YZYWbK7rKfHTfhYspgg+GWCJGyV1
         p0apY/N3cXFbIq89CiCcbmPkrHj/a0Fht0tdQ8f80Ve8b4dScYUGbFymKXtVK2JgPGR8
         fdsodNrh/Ij2HIEZ4iJPtPJaxK+bFIbnT+/E3V/MB0MBR+cnVqbJ6gfKFA7domZEn7Ps
         sOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669226; x=1730274026;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rzv7AnOxuQovJ9pw7+5rvDkRMri4p78w2Bp8gd0vNA=;
        b=F9cUPN3QdM7Je5h6f/eL1ZLq/Ml8GmmZhFGAU22+GQATtCL7kXkvqi2Of42CoAVPTj
         pES1GrOjcwoW5tvQSaw2wD1PFHfoJlPmm60aRyafqNwQvnsFHP91th1Ak+FLmxIdwYlY
         zZ6zKDipoO8igWM0Ro0ammAuIqmS70/UjNQ3sWX0RT57kRpaPuP70zwYCxnyjtsBoqCP
         2XO1Jk8pdFUxuePk1mel987VMtAoIx2uzJNmgd3jce52IWaUnWKMKXv8gW6KjvwEAR5F
         f15DVnUEnjh+ygLz+AUvF6lFsgrwzxxr8jnQnEtWYJ6iKICHJx5t73hpgdkAx7RCQyoQ
         /EeA==
X-Gm-Message-State: AOJu0Yyb7zj2Tegj4OB/qaVG/WdcKJJZFQwSLDJdWxfXF/07l1bWeup4
	2u/ovUo06C03UtoJuz4zt9ecQ1jVVKmevP+jLE4oKyea1cHIPe37eXEH9g==
X-Google-Smtp-Source: AGHT+IEvhQiVIWZcLvFNWFOixTDnTiFFW7Jx7c6wXhMA/FAHI1ASgFMR4OhluYaZSo7wvLf/ZzOj/Q==
X-Received: by 2002:a17:907:1ca3:b0:a9a:6477:bd03 with SMTP id a640c23a62f3a-a9abf8a5023mr117485766b.38.1729669226344;
        Wed, 23 Oct 2024 00:40:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d6ef1sm430443366b.38.2024.10.23.00.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 00:40:25 -0700 (PDT)
Message-Id: <9b2b2dc8fc890ff55586f890e41e54a5041bce62.1729669221.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
References: <pull.1810.v4.git.git.1729634937.gitgitgadget@gmail.com>
	<pull.1810.v5.git.git.1729669220.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 23 Oct 2024 07:40:20 +0000
Subject: [PATCH v5 3/3] imap: replace atoi() with strtol_i() for UIDVALIDITY
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
