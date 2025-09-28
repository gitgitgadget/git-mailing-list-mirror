Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C82367A0
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759095018; cv=none; b=qMTNcbZpqiqHl+ebVzTBkwoG2siSZFLtbdoYHXOoHxOz/7KKbeKkuM4a9i1KXqoMdC2cj4keEtXPRS/FnzqsPOmXYjPs74QupRAmrnz/I2FI8LjuZTzeAWt8Wwi4BQ1zncpkyPpilSk4sKt0CoLn6UNNRRBimF8qbVMG+YfAUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759095018; c=relaxed/simple;
	bh=XZFiVQ1Mi8ah/cv89Xv/z5jNxvgZytM4qO46tq1HuPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4mlVu0A/HqXqKyhvc0qnNK4zMJseC4S6XTPBzuuvh3DUC5Lhi0v+e1Ow4SK162/rkXBG7D0uCTN6Hc0xZ0rTF/c/mKZVKTppesdfC06Up/TF76lZul83LJT5ZZomqTBv25GFZRGayZqw6o1OhB60u4esQZSBFpaC9n0Ks31bY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1UWyKaq; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1UWyKaq"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60528734so42908107b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759095014; x=1759699814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R9nSAisXvGp4yysastjon8jxpOn8BY8/8h4sesIEQI=;
        b=J1UWyKaqJF0l1JAXe0dX62oIcfSNSzcOKiJHIGaqLf4/w8ErExDd87KpTVIP4ZT9S4
         0AJ1CqZFQMjMjIR40ovkVJOHKa53UhFl4tLjbcjr62jN6a3Rvy+tLz4hXmqv9/T8cTZb
         scVY4nNE/3O5n1kMkwG0UAnf1pDmP+nEBn+k3LTGlOf5VzjLfQ+lO8Vlyok10Db5EPQX
         4LbADNIcHGhO3xlHUSUI4ty/vkzS5Awb/fJ4VwvD9nMe09h3lfLTwjy1xXact+BUjEU3
         k4gHg2+35wNYiFRVcNg0QPLsYqpsT5gEJVI5AvHQ/9KGGhvbyb5MckbVAjGYg0ZTG3Mq
         erEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759095014; x=1759699814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8R9nSAisXvGp4yysastjon8jxpOn8BY8/8h4sesIEQI=;
        b=NXGDRPdPMgIY6Y4PEx1jJq+CnAjutV7wadBnqnDxkY6SEaSuRQvz/EsLYqI7WmLgcv
         yKestFSasQK0tSo+k4TSBNixpIrhDAFxdi7VdpdSzAcUS5Ybf7rHQPlVvkBJ9zmesjWj
         aoW/66fCntcZcpZxepNU56vMo1v5r2GcpLyGGSPIlQNjL2vejzdjSq85zhtdSn2MdvNy
         u8FzDuVOY8QxahL6XTvjiNns7Pc2APjrxd1eq7IHiz+tJP+02A4NWR729fPBfDbjdVRi
         7v8HZKQJIygmDiQ/1mvqpalziqelZLAfDHLf0dji0lLTQYdv61MdU+crXBfLNJoPD/A9
         yVBA==
X-Gm-Message-State: AOJu0YwBzi0BDR70gnmKpjj/pWYULEY/8nZAdvoumW3KTpN5CwYKlNMY
	fowraKa8J1akR7k4dxgTzGonHn2aOC8B/6JA2Hen0Lu1ZpJD17hEjpTOE2L5VY5X
X-Gm-Gg: ASbGnctc56c9GKa9mN89AnpDSNs8oUvQ/hxnQHlqRTSGornalmtfGT1T6AeECOPKPPE
	YcAiZXHWYQR7W4YzXor4ZkHhPZbWmDWntENfHGg/+zafi5KDJMUROdpkN7tnkIIWlnCwVGoVJEI
	wP9mB7xrEFoWqLmZEZbpgF3EnvYwcyyVHShgVaj8KrzDpJkYCPNLRogLilbXyQFQQj46Ju7rQJW
	0kiwZrLZMBpsznUEmor27NXLCNO2lkJ1vZnXxQrm+O91qTxnrL77sJntWg3H72rTMWgoE0yqyRj
	ShorFt+QmcgLRGL0Q6PG56JptsBLu2pSfWZClidTrpTMqloEaA4arvsfw7T7XLZfHrrcaOnGiYo
	0+S/KImxsZ8ApIG5wMaZS7yamAtz5kdYgERbI9ZymHmAWLDRtz4WQ4/Ulp6oOpffJFaJh1cw=
X-Google-Smtp-Source: AGHT+IG6z0PrF8vTEOunRlxMkAWb/ULWp/F57sn864+W+brCMPi0U4csvnLGGlJUA0Cykq5V5t1tPQ==
X-Received: by 2002:a05:690c:74c1:b0:720:bb3:ec14 with SMTP id 00721157ae682-7640185174emr178424727b3.25.1759095014218;
        Sun, 28 Sep 2025 14:30:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:488:b20c:c605:ba83])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63ad64e5d45sm51448d50.29.2025.09.28.14.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 14:30:13 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Noah Pendleton <noah.pendleton@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thranur Andul <thranur@gmail.com>,
	Michael Grosser <grosser.michael@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v2 1/3] t7500: make each piece more independent
Date: Sun, 28 Sep 2025 17:29:14 -0400
Message-ID: <63b2b24d42906162f2415da37ccc75c921518b7a.1759094936.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759094936.git.ben.knoble+github@gmail.com>
References: <20250501214057.371711-1-gitster@pobox.com> <cover.1759094936.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

These tests prepare the working tree & index state to have something
to be committed, and try a sequence of "test_must_fail git commit".
If an earlier one did not fail by a bug, a later one will fail for
a wrong reason (namely, "nothing to commit").

Give them "--allow-empty" to make sure that they would work even
when there is nothing to commit by accident.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7500-commit-template-squash-signoff.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a7..05cda50186 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -42,7 +42,7 @@ commit_msg_is ()
 	(
 		GIT_EDITOR="echo hello >\"\$1\"" &&
 		export GIT_EDITOR &&
-		test_must_fail git commit
+		test_must_fail git commit --allow-empty
 	)
 '
 
@@ -50,33 +50,33 @@ commit_msg_is ()
 TEMPLATE="$PWD"/template
 
 test_expect_success 'unedited template should not commit' '
-	echo "template line" > "$TEMPLATE" &&
-	test_must_fail git commit --template "$TEMPLATE"
+	echo "template line" >"$TEMPLATE" &&
+	test_must_fail git commit --allow-empty --template "$TEMPLATE"
 '
 
 test_expect_success 'unedited template with comments should not commit' '
-	echo "# comment in template" >> "$TEMPLATE" &&
-	test_must_fail git commit --template "$TEMPLATE"
+	echo "# comment in template" >>"$TEMPLATE" &&
+	test_must_fail git commit --allow-empty --template "$TEMPLATE"
 '
 
 test_expect_success 'a Signed-off-by line by itself should not commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-signed-off &&
-		test_must_fail git commit --template "$TEMPLATE"
+		test_must_fail git commit --allow-empty --template "$TEMPLATE"
 	)
 '
 
 test_expect_success 'adding comments to a template should not commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-comments &&
-		test_must_fail git commit --template "$TEMPLATE"
+		test_must_fail git commit --allow-empty --template "$TEMPLATE"
 	)
 '
 
 test_expect_success 'adding real content to a template should commit' '
 	(
 		test_set_editor "$TEST_DIRECTORY"/t7500/add-content &&
-		git commit --template "$TEMPLATE"
+		git commit --allow-empty --template "$TEMPLATE"
 	) &&
 	commit_msg_is "template linecommit message"
 '
-- 
2.48.1

