Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815D2231C
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508147; cv=none; b=cRM5DmoTm+3OUiFvf2Gd6VF8vza5i0WxuQvS/haxzIF53Te+NVyxRT33PN/aI5PhghbvJa3/omjovir9GWidNGoR1uFNeiPLqv1014kgVDozm5skKsH9WxOKMCLnp/bxNKYOBVIJoqjt+l2ssktYVqiHjRQtop4E3n0sI9gY9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508147; c=relaxed/simple;
	bh=+wIGYoK5c2oqFGXTNeLcwuejukM50VCwg9kjoJQNzO8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding; b=BWJv76631w6vFaxehwlV+4KD8tkIekwkIzqAv0rkYBH37SL4ZqdzpYh8wS0x8RdZFMFGI6ZT+84wh+uDNmc7YtiyhBugk9yD/ku26sQLXxYUCF51JCsoNf1ytv17S1b5rY0WQBhXJAhCr7RCsIXfvDn4QswqsCYDoyOg5yblQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf4Z0JbW; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf4Z0JbW"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdfed46372so9112195a12.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705508144; x=1706112944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaHsbh7RCmkp9yLbEbqYzsWOHeK8TLMlRdkA6MRQeaM=;
        b=Sf4Z0JbWyXGBprpN5OevWINSHRYiixcDAcKi5XQ43FAI63J0VjDMLdaa8tt9Sa+RVB
         iRpUHORiFJMDXphcoRiErIEpMjgVqk6Qwx45V0SbIPSnBvF/VgTqQmtqb/SvpW3V2iq4
         8uP1N1Mo9BMXhwGspFYt9OmNuVB6PzLXK4bRzq2b9jeuRFlYa9yKa6E5J6lmSvXh7f0/
         dDxU1GRcQRAr9JZB5Ar5CjIOlK1u5M328kPzfu+alVlLAaJnH4JiNdJn3Ev61IyrKr0l
         JSW07yOjM6X9lCYe0dwl11zVfo+mNPJ0ZYbedaLCn3eg0mc34acM+PiEyKdazkrGpxAb
         aX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508144; x=1706112944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaHsbh7RCmkp9yLbEbqYzsWOHeK8TLMlRdkA6MRQeaM=;
        b=ZCU7ZeYto/Y9Vpb+67UioLde4/aZpCScrzP5dkyODb9zqbYzTtcfg3uBk39xR0rYGL
         tNnetRs8Cun78twq5uHOFsEj5pywXXiLr1BY6XV0zZtdUTXKd1t6tmwK14xLmW+Lps3r
         cZ9W5l/ZbJsBNP7R8JgTW2mAvTF4qiDyVOW0dcYkXa1Hm4F6b/pXMe8EfXqNK0J/oKqX
         ov7bSIbIScZ0o7zFwSTHfFfgdS8nWdWrzcR7FWpliVTnzfDCaQ14fUCoCXnvS414VOIf
         Z/SwuZFRNE7xvluojBrLD5cBXcSF+/FQqwZPvnBTRNkhVg/X3ARbhBk/HpjbtqZKVXT4
         +Dsg==
X-Gm-Message-State: AOJu0Ywm36gQLMF1RJjkrw3wCSQWnUk49lYbAdfo3X38DK0FdDeMnODR
	fkETsGd55TaFrwuGUt++ES/bMAAYGdAlL0lV
X-Google-Smtp-Source: AGHT+IFi6DBWYkbuqj6r7DgSsKVnlynCOg0nmxgcoWhXzp+VcVd1x5+UvfEiauoFonkXUriMmi8ecg==
X-Received: by 2002:a17:90a:34c1:b0:28e:7d59:b103 with SMTP id m1-20020a17090a34c100b0028e7d59b103mr2086563pjf.91.1705508144516;
        Wed, 17 Jan 2024 08:15:44 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id sh2-20020a17090b524200b0028dfdfc9a8esm12634126pjb.37.2024.01.17.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:15:44 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v6 2/2] t7501: add tests for --amend --signoff
Date: Wed, 17 Jan 2024 21:43:55 +0530
Message-ID: <20240117161421.17333-3-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117161421.17333-1-shyamthakkar001@gmail.com>
References: <20240113042254.38602-1-shyamthakkar001@gmail.com>
 <20240117161421.17333-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for amending the commit to add Signed-off-by trailer. And
also to check if it does not add another trailer if one already exists.

Currently, there are tests for --signoff separately in t7501, however,
they are not tested with --amend.

Therefore, these tests belong with other similar tests of --amend in
t7501-commit-basic-functionality.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index c169f10458..bced44a0fc 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,8 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, test reflog,
-# signoff
+# FIXME: Test the various index usages, test reflog
 
 test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -462,6 +461,28 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_commit "msg" file content &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	msg
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
+test_expect_success 'amend does not add signoff if it already exists' '
+
+	test_commit --signoff "tenor" file newcontent &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	tenor
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+'
+
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
-- 
2.43.0

