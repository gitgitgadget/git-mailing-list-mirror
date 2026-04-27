Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40F34E74B
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286539; cv=none; b=fOqWK1SCpJnptl4asuRtcP8KfK7wBi7tt/BYIXjh2iWH5uGanlygZ2PFJYvljuD/L3w5N8fzI4soWsQDnWHHMYQa6ncmWXjLFXNu7ic8r8VJOe1cKci8oVsbfHchDaKicNPoOU2P2O4mFvr7odUGgfE2TK/QgRhh0HEWRGKfDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286539; c=relaxed/simple;
	bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCC3aV6ToIiOLWjyQFrEvvF4IN0BJmxllmHhouTAATWkppX/WqzlpSULMdZt697xNoCypfYqjptnHkTkTr47NyVlSR/0VRw4Yntj9QWLHUJ2UYt5yyEsPd+XcF4udlZlVcUT+U0z6HOkGPAyXFsf/THPLI6HMM6vYzyRRHkfejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmjHOw+t; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmjHOw+t"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43eada6d900so9925143f8f.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286537; x=1777891337; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=XmjHOw+tjL2tivvwqsYyIM2EUzOMg6QQtwB351T5Asc0b2Uz0j3k/UbRML6aO23+wP
         MhfOAKoWsRlKpcZ3RMa4tjnbH/bBZWRDFfXu2urp+E1bspoL42H6QqATKu7jRB+NDPzd
         r+bqrz2b9AkI3aqo2UTXXRqnINo4rRp6RKyOcK0wM7gSu/njqVZq7XZjuXAGyTvzqP8N
         Sn0AVOhNQNBbCp0am+8Klj7gFkKJJnrCm4wmfIDo/hLWUYmCTPwxYPXV2X0iAjfhK4HJ
         xTr64QMsNI38MnFVd8PXzGNXSQGGQq0WyOlU0YjOCWejoMYp5YrlznHgMuULpRS2CILF
         A1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286537; x=1777891337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T0YmjADqGD03h6WFV6WSZlVCQK+jJbDkt2lcZ1dUCUQ=;
        b=ENT/g9YPxrspfckkng9TnyO7aMd9fMzJsiwTlwMZcAi2b6pcpJZHz5EeQKYeXRtCFA
         XYTktbiF3gyeZZ7cg4zyrM+EG09WF0TvwzGWWN6nHx1sixv2psARpyQQxOaNA+tvYLD5
         /baT0mahegS6uGVwkY8wgo1ggc6Xnej6+ePEdwsa0meiJUcRRL6EyqTcsQcMHQz9uErN
         aEDM3JCaNrQ+7Vlp3vqiA4ncSkEFpD5k8RHAqOKvo1u12to2X56ajB6DlR0cvb7vw4Cx
         cnydP1ZA7pr2lKEEIqLet6pwGJTgBbKg3leUducBv7Ni4uzHTirA+ACQ9ktF5ZxVYh6n
         ftaA==
X-Gm-Message-State: AOJu0Yw9a8i5kLzXEh8w5xMJKX3oZ/TIcsFF9EiWSHPvDIKp5M6mUhaY
	4RymAdlDqULRfRqs0PsHAJHK2fGa1lLlzvNrVkgFaIAXMHY4mPnK/Gv+wm0Qqg==
X-Gm-Gg: AeBDievzcRpAU2kpM3KEk0G07nezctLWAiNWlm5vGaKS8+Z0wMCq9HTwNfMgy8+c9a1
	oJoxPoeHz1Yl2TWXA+n7i9WD6Eym8dihyzkUm5z06Wo5SPd5oXvF8JbKAlaAmFYDNAMcysCh78c
	F4zxM9e4t/kxYDxeltYtnL99pAxzlCG0GzT/Oi1io5MgECaZiB/F60vmviL8pXo1zZ6nqog1q2D
	669NefgeetyRGSc6EaWC++IA+7XD0KVPvkCbYfO5ApaBXUXNly+TuunVsPylJgfm1uVcSm37taU
	Z0rET4vEnIe+Q4Vf094to0pvSqRhSpF+hCRQccPuNcankn2rRgbaW30tMBz016dkMr9jtIPURg7
	LPTwIdSdjutzsUBiyXjR2ydDY70Jc9kSuSRGNSy00W968E4Owq0WRWmefgjp+CEdkCwyIrrAIP4
	V6lg9p0TnEG2HgK7NgsXyf5m10e/i/WbE07Xpo7KN6
X-Received: by 2002:a05:6000:4283:b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-43fe3e13dddmr65242248f8f.34.1777286536599;
        Mon, 27 Apr 2026 03:42:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:5b56:7e7f:83e5:ed3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a7b4sm74231698f8f.22.2026.04.27.03.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:42:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 27 Apr 2026 12:42:06 +0200
Subject: [PATCH v3 5/9] update-ref: move `print_rejected_refs()` up
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-refs-move-to-generic-layer-v3-5-e4638dfb7897@gmail.com>
References: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
In-Reply-To: <20260427-refs-move-to-generic-layer-v3-0-e4638dfb7897@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, toon@iotcl.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=IB6HIIho4lrN2TnQXyT8tqTXBm5rXPnZlDwjzScKF4M=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnvPX9d7U1iHoSd4NfRj5wQj3cs0DTR9VfJA
 1b/9++PyZVFFokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp7z1/AAoJED7VnySO
 Rox/JYEL/1GT8xNmJjz2w/UiBzYBiF9W8fup/z1X1cGg6F7p/VXM5q/9pnzIUjWgyOUoWs8y7F6
 T2R4dkKO6UR+8MBA/zYhsk+ExtK5uqzrRCGlq2Rjn5ETePenrFxA8zLOAlGe+Eds8TE5tysKwbr
 uaDf8okxrOxfkzDuobOlp0/4849N9USDGLUh4rjmZR9ubXO8NJk6Up4iwyvSa7nKPo/FDMCQmUw
 +AZl1whFPxYF7cHat3LtzOeEQrVbjzdfZMBjaz2jKlofagTv3SzkTFeDcqjjeQ3FeF+XKKPpwfq
 49LBQ6DSvFViamGfwaDfbSdCe7rPTpp/epOyE6ELvvgkpxTDQyC4c0LWPkrwITz9/u+EOv+jjAE
 0QXbihBsiuopWhCs7boOCuFdo+26h3TQV3mMsvNYI332Fyid69i4IEeMFNxEopTSWb0GczhVbfq
 UfjTMerz9VTsUMkps9REZAeZzEVwbXidWMe9gI3Y7ubR6LL3JopzmwxehhXgfnpQBX6zqRhdBZ6
 qY=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `print_rejected_refs()` function is used to print any rejected refs
when using git-updated-ref(1) with the '--batch-updates' option. In the
following commit, we'll need to use this function in another place, so
move the function up to avoid a separate forward declaration.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/update-ref.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2d68c40ecb..5259cc7226 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -234,6 +234,28 @@ static int parse_next_oid(const char **next, const char *end,
 	    command, refname);
 }
 
+static void print_rejected_refs(const char *refname,
+				const struct object_id *old_oid,
+				const struct object_id *new_oid,
+				const char *old_target,
+				const char *new_target,
+				enum ref_transaction_error err,
+				const char *details,
+				void *cb_data UNUSED)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (details && *details)
+		error("%s", details);
+
+	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
+		    new_oid ? oid_to_hex(new_oid) : new_target,
+		    old_oid ? oid_to_hex(old_oid) : old_target,
+		    ref_transaction_error_msg(err));
+
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
 
 /*
  * The following five parse_cmd_*() functions parse the corresponding
@@ -567,29 +589,6 @@ static void parse_cmd_abort(struct ref_transaction *transaction,
 	report_ok("abort");
 }
 
-static void print_rejected_refs(const char *refname,
-				const struct object_id *old_oid,
-				const struct object_id *new_oid,
-				const char *old_target,
-				const char *new_target,
-				enum ref_transaction_error err,
-				const char *details,
-				void *cb_data UNUSED)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (details && *details)
-		error("%s", details);
-
-	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
-		    new_oid ? oid_to_hex(new_oid) : new_target,
-		    old_oid ? oid_to_hex(old_oid) : old_target,
-		    ref_transaction_error_msg(err));
-
-	fwrite(sb.buf, sb.len, 1, stdout);
-	strbuf_release(&sb);
-}
-
 static void parse_cmd_commit(struct ref_transaction *transaction,
 			     const char *next, const char *end UNUSED)
 {

-- 
2.53.GIT

