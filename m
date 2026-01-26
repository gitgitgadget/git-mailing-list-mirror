Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E164A346FC3
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446590; cv=none; b=gyLGK5YZSujGFSRTQ0fZkjxTLvPlO4IDiTHxsUydlOodVFCd/Gh8ZZn7FKzUf19XpHKEuQJAciKEcas3Fe04xIVO3G9dXHWK+OPFJ8+M74+iWciXsh6iw6yRHhpJ+dxiM39ep7tfu7G0C1A5lrevesEWbfpZPlXbBkOGm1by6CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446590; c=relaxed/simple;
	bh=JZC9PMMS0o9DSpVKQwwGuDQtCrYLLUq93HKZpYc5bdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUFEzXmfVu8LndIL4kwoBq8jhQXN6JcxOOsLBNK1fjgQcKJ8WadQ4yOjlNigk4szRzkHVpGupqWiHunRrYk+ycs92kWkzl7iKgObGkYi3u0YMphnyfLsNNz/FNiYcLYMvwUsBXJ3wJuKC/pl6PxSMyj1C8sPI7hxH2OqDxYcM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhS5iVFJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhS5iVFJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f38d974e0so612637b3a.0
        for <git@vger.kernel.org>; Mon, 26 Jan 2026 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446588; x=1770051388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9kE1TuJWYBtNnD7MpX5mAxlkkpPSwQMN7XGQy/XDPsU=;
        b=fhS5iVFJR39D3HmND4su7zCQ+Ip7HqElQ1bORUsXuKp+FxqaEbxzgHaKiaKbrS0dvC
         1IAFaubnrVHqFcbmWrxI+TUCsO/C8oQ4rOxDl6Tov7wU21bXLK398syGcmJumd3/R8Jm
         LTwu8uq/EEqH7VMnNfKHWOGvojweGDxlCjAhLUMUlj2fg7c/Kk8jNMfnyvVYWCGd7kEt
         ss52t7Zg1KczNtwVp6O6sTaThVDo3MxkOdJAb73gROqBLp1jhcxI9vOPHecAGuZaN2fx
         CfXsw6r6tSh/0y64msiZzojyEi2zoeH9jYybqddnZPg3cPLR0Z5yutJ8QSK7y0aCkQ0x
         WZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446588; x=1770051388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kE1TuJWYBtNnD7MpX5mAxlkkpPSwQMN7XGQy/XDPsU=;
        b=QwS6D5r7KUK2+rNib2JcFPK2VU+/xHviV3sjCLWtP9eoH1pel9q362K6EWX03arUNf
         t6ZnpHn5e/R85AY49klRJJzQaBeSjKbPHApWJ+b6DS7iiGGjsIbmcTBT30oeiVxFLVjT
         9umYbWDnTg2VOQw5rnu3bgZukxaACMNH5gcFU2pARU+a1gM9eSVLwVwERIlhEGR82MPT
         /j7sVGdC0j9oWxJyCtyaTP5RgBY23aq797NLVAx/xGHHgwEBIri2apetGgsqQnqqO1u7
         ExtVV8JBNYJXBJl+gzMJsp8KIDFVUZmcIeXcLkYY4fYudHJrz5tIZgzVcR6VCqArkNkT
         WnIQ==
X-Gm-Message-State: AOJu0YzfrLdEvE2DqdQD67zdDV8cWSPygUtuSo93kwqcDzEANn6tBmq4
	DiIu/TD9HCnNi1ZWwYHveXCgIK4S2zR4335vz/ZA103oYtMg1xT48j/OR7enxwRwVb0=
X-Gm-Gg: AZuq6aK5tkPqmQkPsvuRtPeWV++lx3h0tscPHMPI9haU1eYJwlaJgd6hoPPwXSSpq1P
	W75JXTj9tSk632Gkb8TuKznwvGcMSa/rN7QIxw5HcGLdtV1jpvLb3U2XOIPNnaIT/jgQp2UrcJV
	uYcfzAZkUnTNKonxoCdKi0hesWs/TqV1h6c0PcvUcM2y5+d6NY64iYsjFWOnTDhyZJPjPlidJRH
	8aCSN2x54JYTUHXO3S2COIoNw0ptnKs1D6nN0XLdqo4ETW6XgYWxLfT+choPF5RwbxYInAdsy0R
	eckyjUvkL55pwzW7Fj2PHBMtU3wjba0l3u92zvenu974kVL7N01VhSxTPW6ztoJG7ntKDRBN02z
	+MjVDg4+si91O9QHeD76YsY3+UtWGAsQIx8PJ5Qajm1JSBWfY5Q7j7Q/4AOotqvE1Uw+SYkOXBy
	eXJOi/PqYAZHcl44I2lM2gTDxlNxc=
X-Received: by 2002:a05:6a00:2283:b0:81e:86d7:b57a with SMTP id d2e1a72fcca58-823411c3765mr3430982b3a.1.1769446587725;
        Mon, 26 Jan 2026 08:56:27 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318662dd9sm9693397b3a.19.2026.01.26.08.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:56:27 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH V1][RFC] t/perf/p3400: speed up setup using fast-import
Date: Tue, 27 Jan 2026 00:56:18 +0800
Message-ID: <20260126165618.596944-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The setup phase in 't/perf/p3400-rebase.sh' generates 100 commits to
simulate a noisy history. It currently uses a shell loop that invokes
'git add', 'git commit', 'test_seq', and 'sort' in each iteration.
This makes the whole process slow.

Optimize the setup by using 'git fast-import' to generate the commit
history in a single stream. Additionally, pre-compute the forward and
reversed file contents to avoid repetitive execution of 'seq' and 'sort'.

Performance enhancement:
  Before: 29.045s
  After:  18.081s

Measured on Lenovo Yoga 2020, Ubuntu 24.04.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 t/perf/p3400-rebase.sh | 53 +++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
index e6b0277729..9251a09b4f 100755
--- a/t/perf/p3400-rebase.sh
+++ b/t/perf/p3400-rebase.sh
@@ -9,25 +9,46 @@ test_expect_success 'setup rebasing on top of a lot of changes' '
 	git checkout -f -B base &&
 	git checkout -B to-rebase &&
 	git checkout -B upstream &&
-	for i in $(test_seq 100)
-	do
-		# simulate huge diffs
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i unrelated-file$i &&
-		echo change$i >unrelated-file$i &&
-		test_seq 1000 | sort -nr >>unrelated-file$i &&
-		git add unrelated-file$i &&
-		test_tick &&
-		git commit -m commit$i-reverse unrelated-file$i ||
-		return 1
-	done &&
+
+	test_seq 1000 >content_fwd &&
+	test_seq 1000 | sort -nr >content_rev &&
+
+	(
+		for i in $(test_seq 100)
+		do
+			echo "commit refs/heads/upstream" &&
+			echo "committer WGYDY <author@mock.com> $i +0000" &&
+			echo "data <<EOF" &&
+			echo "commit$i" &&
+			echo "EOF" &&
+			
+			if test "$i" = 1; then
+				echo "from refs/heads/upstream^0"
+			fi &&
+
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_fwd &&
+			echo "EOF" &&
+
+			echo "commit refs/heads/upstream" &&
+			echo "committer WGYDY <author@mock.com> $i +0000" &&
+			echo "data <<EOF" &&
+			echo "commit$i-reversed" &&
+			echo "EOF" &&
+			echo "M 100644 inline unrelated-file$i" &&
+			echo "data <<EOF" &&
+			echo "change$i" &&
+			cat content_rev &&
+			echo "EOF" || return 1
+		done
+	) | git fast-import &&
+	
+	git checkout -f upstream &&
 	git checkout to-rebase &&
 	test_commit our-patch interesting-file
 '
-
 test_perf 'rebase on top of a lot of unrelated changes' '
 	git rebase --onto upstream HEAD^ &&
 	git rebase --onto base HEAD^
-- 
2.43.0

