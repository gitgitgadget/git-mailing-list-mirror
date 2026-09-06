Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCC3A6B67
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788679509; cv=none; b=rUPW+kXldEvmHHRQanlDFZSUtODtqOOrUsJjxoCz3lWLoBX0+hZC+AJYZ+nQ5/4GW4JjEOaMJbDp0MfcJK9ZFWS0kAGZ5G6bhUHUyH4dg/DHo4hMnF66JXQFgkWS3WoE0f91pNgz4oP3DI+gWyvCMf9B1Hw8veBnEQOe+VG1r5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788679509; c=relaxed/simple;
	bh=TsV8O13c9/Qy4rq3AQdK/yuKyfLMmXTMvEY44usoJuU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u+HKg0JDFWMWJOQ5bEvQvd5tutyAiln5U+KLr00sDjV4K65+rqx12BUsycs1+TfSd6V7efM5+lUmGuvQn1M3bEvgyP9kUkJUFZZerlwIxlnD3yFokwxZzw2o4o3cauB0Q4qLlVgBAJoc2IZXbeE+UN13w8aEef34T0Iyx2+1ADc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxkgQjEC; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxkgQjEC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-39682983a0fso2690816a91.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2026 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788679507; x=1789284307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Dx/xPYgpGNASflmpiadqQlrP4hMXnYGnLEjvTXpIUE=;
        b=NxkgQjECTePcwsMR/hxl1tUB1UqgKMiEOWcSyuwFC64Frozjk0eips9kQDcEQVIGRX
         bnJQaTL4pXHOi5ml/Nm6JCFa9HuMHxduRFuzpT7kKPa63GoU27xmE0xY6725qR7aurLr
         oo0BSX1mw2b9W814auybLMDRJnLrt0RUpaoZkLRfpUIzFBoO0It7gVCe8o/2Eb1PXuM+
         w1g40pIyyghBt0IsqjoeUkf2Enf+T+AsmjL3xpEMfVJPJsY30JmkeX7ZUdg+wgMCVQC+
         9ug/LghPh2VuGPEBktPT+/eUwBmoerljRix/Asn1KGnh/K5TpEyy2H5qikA74klMn/GO
         icsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788679507; x=1789284307;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Dx/xPYgpGNASflmpiadqQlrP4hMXnYGnLEjvTXpIUE=;
        b=Oxic7+wMfld9Pm3pn9ITolFGYXRIBAiL382Xan3MKBIooJZjpNtj+lR6CWh+bgcSgn
         PpEPf8xGuczZihPYGhkCRHBLhuUajJfNFJZu/podHEjKdE9KNxgOQk0jyHo+zKjSH14K
         dkYXlYv2yCiqg1RPX3CpwCMS1bMzM3PTNe1/q19d8UCDKy/OLXqzjaJtvfVhupHF2mu9
         b5QqmXB8jaq8yok5jxfoz4zt3cBctvEG0gedAW8wC7g9QBfsGXfWv+5h0QARAwK2e7BO
         g70Yr1GBYHfo7nTFmIL/25GU708hgd2dRvHWTKjc+zfezt7yHM/lbbmD9NuMb77Ykj+x
         uj8g==
X-Gm-Message-State: AFuF++njsgR7kxkYViuI+xSjHPe1i5EObkQsAu14CpId/rFLwU7QP5cM
	g/SvvWZrVxPH8r7BJerk+oF6aJg1F2NzRovAphz22u+TbVNhalKQlu4Bx/uY5PdG
X-Gm-Gg: AYBFou3OGVYnnnH8QaexWlbnQOiQxq3LpDPp4gplbjAWlDbLGPJQL6NyN+sDQc4I937
	BFaAx3qUoTr+Xj4Y/SobzQUGNvUmLzf8mh2FJcPoGaFHSEdcwAdW51Nxb9TMa9wM6NOP3tOZbP5
	uj2kFmkJoaeHsBBdcdGG+jI07XnmW2T8Um7sCR/UOqnZ/wME8HajADWdc28hn0XQxPsV9g+s881
	FSaCqiXSSaRKqOXYv5trXqT0NIPprGuepttfzgW7676hZv1BK6BXy6WvvLGZlje6/ELNsS+xyq7
	V1d+Zy3ZinfEUspSkA3m0v+GCk1R97JLkwxemzIWjEec9r2qa5alhjD9cbZYX+qFI2pKUscXItg
	rhBVjNcm22a5kB0pCS9sBQiPJ0RmSI/9nv4qwO02nDC+KjQKcdP5guudGsf8QV6HZmp7coYQNfx
	jqAJC/MTgWII80VOOL8TLPYZ3/EOEkL9OeP2iHEDHZo84TlnKmFy2CVd19/JUPPww=
X-Received: by 2002:a17:90a:d646:b0:398:9bd5:490d with SMTP id 98e67ed59e1d1-39b26214798mr26934261a91.20.1788679506924;
        Sun, 06 Sep 2026 00:25:06 -0700 (PDT)
Received: from [127.0.0.1] ([104.209.15.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befdefcsm16333164eec.29.2026.09.06.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 00:25:06 -0700 (PDT)
Message-Id: <fc21ecf8327722ed02b656a85e76b4a60371597b.1788679500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
References: <pull.2208.git.1787295352016.gitgitgadget@gmail.com>
	<pull.2208.v3.git.1788679500.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Sep 2026 07:24:57 +0000
Subject: [PATCH v3 3/6] shallow: reject missing boundaries without
 disconnecting
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

An incomplete shallow push can refer to a boundary commit the receiver
does not have. remove_nonexistent_theirs_shallow() drops that graft, so
paint_down() does not recognize it as a boundary and dies when parsing
the missing commit. The client then sees only that the remote hung up.

Treat an absent commit as the end of that traversal path rather than
aborting receive-pack. This lets paint_down() process the remaining
commits, after which the connectivity check rejects each affected ref
with "missing necessary objects". A present commit that cannot be parsed
still indicates corruption and remains fatal.

Assisted-by: Claude Opus 4.8 & GPT-5.6 Sol
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 shallow.c               | 16 +++++++++++---
 t/t5538-push-shallow.sh | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/shallow.c b/shallow.c
index 8e244a5669..c6f7437022 100644
--- a/shallow.c
+++ b/shallow.c
@@ -659,9 +659,19 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		if (c->object.flags & BOTTOM)
 			continue;
 
-		if (repo_parse_commit(the_repository, c))
-			die("unable to parse commit %s",
-			    oid_to_hex(&c->object.oid));
+		if (repo_parse_commit_gently(the_repository, c, 1)) {
+			/*
+			 * remove_nonexistent_theirs_shallow() may have
+			 * dropped a missing boundary, leaving it unmarked
+			 * as BOTTOM. Let the connectivity check reject a
+			 * missing commit, but still die on a corrupt one.
+			 */
+			if (odb_has_object(the_repository->objects,
+					   &c->object.oid, 0))
+				die("unable to parse commit %s",
+				    oid_to_hex(&c->object.oid));
+			continue;
+		}
 
 		for (p = c->parents; p; p = p->next) {
 			if (p->item->object.flags & SEEN)
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index afab456b32..10ca7833d8 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -164,4 +164,50 @@ test_expect_success 'push new commit from shallow clone has good deltas' '
 	test_region pack-objects path-walk config-push.txt
 '
 
+test_expect_success 'incomplete shallow push rejects without disconnecting' '
+	git init raw-origin &&
+	git -C raw-origin checkout -b A &&
+	test_commit -C raw-origin --no-tag has-shared sh shared &&
+	test_commit -C raw-origin --no-tag A1 &&
+	A1=$(git -C raw-origin rev-parse HEAD) &&
+	git -C raw-origin switch --orphan B &&
+	test_commit -C raw-origin --no-tag B0 &&
+	test_commit -C raw-origin --no-tag B1 &&
+	B1=$(git -C raw-origin rev-parse HEAD) &&
+
+	git init --bare raw-receiver.git &&
+	git -C raw-receiver.git config receive.fsckObjects false &&
+	git -C raw-origin push ../raw-receiver.git \
+		B:refs/heads/B B:refs/heads/A &&
+
+	git -C raw-origin checkout A &&
+	test_commit -C raw-origin --no-tag cX &&
+	cX=$(git -C raw-origin rev-parse HEAD) &&
+	git -C raw-origin checkout -b topic B &&
+	test_commit -C raw-origin --no-tag reintroduce sh shared &&
+	topic=$(git -C raw-origin rev-parse HEAD) &&
+
+	# Declare A1 and B1 as shallow, but omit them and their objects from
+	# the pack. This mimics an incomplete shallow push without relying on
+	# send-pack to create one.
+	{
+		printf "shallow %s\nshallow %s\n" "$A1" "$B1" |
+		packetize &&
+		printf "%s %s refs/heads/A\0report-status object-format=%s\n" \
+			"$B1" "$cX" "$(test_oid algo)" |
+		packetize_raw &&
+		printf "%s %s refs/heads/topic\n" "$ZERO_OID" "$topic" |
+		packetize &&
+		printf 0000 &&
+		printf "%s\n%s\n^%s\n^%s\n" "$cX" "$topic" "$A1" "$B1" |
+		git -C raw-origin pack-objects --stdout --revs
+	} >input &&
+
+	git receive-pack raw-receiver.git <input >out 2>err &&
+	depacketize <out >out.raw &&
+	test_grep "ng refs/heads/A missing necessary objects" out.raw &&
+	test_grep "ng refs/heads/topic missing necessary objects" out.raw &&
+	test_grep ! "unable to parse commit" err
+'
+
 test_done
-- 
gitgitgadget

