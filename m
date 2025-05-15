Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EFD1AA79C
	for <git@vger.kernel.org>; Thu, 15 May 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318055; cv=none; b=i8PBgVCswOva6MBQFLKd4jf/Aw7RtWOLqS7JarhyGbsJkrlgO40aMI9QDGphmYZJv7sWcB6aRzrCTX6SXC4wITlqa7cW6jga8T44WOvdMfw0tZEalUSryGvddJ7NYaUFZtIHTfMLclzJIa2P4gOZiMD3wdGDwrXjLQWb5o7hXpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318055; c=relaxed/simple;
	bh=4lF+1cCG6iy/1LLrBfjT44ivFg/F0b8LJNnwsyr8u1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D+uVT/rkS8Ll+9JKoB49IjJuczaCzpcDVtxZ7DHKkkFZQW58hBPmj+fssUR26RgI+CVVI41SkMjx6462MX1qNJPJA/xue4A4yXslntCiPkRs3JnTDKcqPyAL7K0BGJninmi38i3FS1PFjSfNbKIhjKOZA4R5TLTa4UdPSaCGp9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwm8VNzA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwm8VNzA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fbda5a8561so1450066a12.2
        for <git@vger.kernel.org>; Thu, 15 May 2025 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318051; x=1747922851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mNAJFRLpah00O7PEs98ETjfxr2Da774b3mdG8PISbQ=;
        b=bwm8VNzAUHmZCpBjpwjW5IaPJbXmCAxtwRr2/P1fh6aRnfMztXKA3BG8DYLxhymMbx
         rwGsZ4EBuaS0WyxMKGXPhvcXcuc+3dsCTUPim8zXqT511hISfPD/QZsVK0ru8IzjcOdb
         j4M4WkJzYg7jwg8/qZfJPd1rPO0VY0CbEyBQ1nuPSyeWNjgXgJAgQ8yePQiKDHeAZnli
         gGH2Wa3hqzZEXRd9ge5uxQDdJyolk11TnnlilSu/2bpcTMDGumb4YEih+3X4E5yXKqXC
         XjOeuk8BJDyIwUlKKAQOZdQ/9DbcaItEWKCXfS2xMmG20kpF9X6Rhsj3kRgn7EEZTLRI
         QNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318051; x=1747922851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mNAJFRLpah00O7PEs98ETjfxr2Da774b3mdG8PISbQ=;
        b=YRZQHcngSblJv3rVTTbvDpNx0k1UEKu7ffZrWVwj+gyPP87QZlJozwxyzxLGRwA1ZN
         fawO61cBl8IS6vIWIisf/FKj+o+rRnEkzk7TzlOrQZgYGtO7BN8YNdKd2+8auRPhxGXM
         zmaMB/atRaHa1wYy5J7VWg29rBdN89dTOgX+E6C4vy2GgUxv0VMnQUZVaHn0UWWH/TAn
         xSMvnGebSZib8+yxMllt/oUAHcO2OI+vxcTTg2oE52I5Z1pHS8uBTxR1V14REPX1wRqt
         ug5wn7vcyYATy/OFJrvN9bdjSQV4pjzMRykA0ewGvkjioXmpNNIIICqA+5JNxrW+OK5f
         o/EQ==
X-Gm-Message-State: AOJu0YwM6iJdnhkQz0vbu/GfXyjn7qaJhZ8LZws7EmcY9efI+Zxe4bRj
	pVLsC+1Dcdvg906lwgWoOxMXpNYQxLYf2V56o/Snyi1BjeghErbYk6fZldV/
X-Gm-Gg: ASbGnctMMMC6FQ0KOCIJuOkjk5WKdQMOidPgE6mjw8qPgfgZuXFeNihcM+wJJTaW6+t
	HbNon4V8T9i+L6iiDZfPB9ySeE5XxoIPWIwN5a4baCNN13tHTlxljp0pQR8OkieFyKEa9fFtOBJ
	UQg6m+touh1hmalAGgsMdMaHuRxGzYX2lid3VUjdwtvrtDIH9nsa+KcnsMhiW8hMKsz0INWDb+8
	CSdyQWTgnafOSGH40v8u8Vs5oTWlspbVlaVAQ4pyM3tmykBHbBz+Bi8G+WqfRB2vtjpKO+89eXK
	ByIJmeCjule+Glunhf4EKPCvCRaESBQr3GtxgmFp4Po2lD/Pe3s=
X-Google-Smtp-Source: AGHT+IFDuR25oCojEFj6dvHwGDJU0PDDpOB4qzyzLvrpWfNvecdpZubu6USnRWxLsZYkf2wbZA/5eg==
X-Received: by 2002:a05:6402:395:b0:600:28b4:baa8 with SMTP id 4fb4d7f45d1cf-60028b4bdc0mr386560a12.25.1747318051069;
        Thu, 15 May 2025 07:07:31 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d70e296sm10259434a12.75.2025.05.15.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:07:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 15 May 2025 16:07:27 +0200
Subject: [PATCH v2 3/4] send-pack: fix memory leak around duplicate refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-3-80cbaaa55d2e@gmail.com>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
In-Reply-To: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2322; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=4lF+1cCG6iy/1LLrBfjT44ivFg/F0b8LJNnwsyr8u1g=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgl9R/XbkLuceJXZvcwCvfBoR3K558bxI57E
 wwXSFUJr5AxsYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoJfUfAAoJED7VnySO
 Rox/uPEMAIV4yYQsDaIw57Sig/QJ2vCqBxFXw6/DucdV7SBzgj2sXxa9/d9wQLF3rOxTQ6ZAUGE
 HqvVZL+aZZdm6CfKor1IFNrpTnj4T52228ns8fgFhpOZJwdAJDtWUWY/ZRJIO5jnciZw6jTagNe
 z7T/jLXS322ct+xoqp0qS6ahBPaK4O8x1gkoVGgQWkOCAmpRKTAwtCEmNcxDzskZuKQOp+DVxes
 XqiikmRz6zIjgc2TXw9pSqx3NHZR6lvF/uxz5p8gZrer2aylriN7T+O3pWtWn7eNKkXWzQsPtm1
 92EMMIWo9TDxnDjHt4XTGK/Qmdg/gmwF+NNM//vvqu/g7hCDGxD8xfErXF9RGKM+Di4GX0flbEe
 i+ehFgwma+miOGNxo+83uwG7IQNcGY2OReVmzs8X3vAStcQLJbeFHr/AxEiLyeIAw0saqBogAdM
 4Y+EGgNvTzWi9N+RqGDDfcNShU+0RcL34wWdGdYZfbeH/KnGFe9WtERmtOyrGum7ZpQcp3m8Gy7
 WI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'git-send-pack(1)' allows users to push objects to a remote
repository and explicitly list the references to be pushed. The status
of each reference pushed is captured into a list mapped by refname.

If a reference fails to be updated, its error message is captured in the
`ref->remote_status` field. While the command allows duplicate ref
inputs, the list doesn't accommodate this behavior as a particular
refname is linked to a single `struct ref*` element. So if the user
inputs a reference twice like:

  git send-pack remote.git A:foo B:foo

where the user is trying to update the same reference 'foo' twice and
the reference fails to be updated, we first fill `ref->remote_status`
with error message for the input 'A:foo' then we override the same field
with the error message for 'B:foo'. This override happens without first
free'ing the previous value. Fix this leak.

The current tests already incorporate the above example, but in the test
'A:foo' succeeds while 'B:foo' fails, meaning that the memory leak isn't
triggered. Add a new test with multiple duplicates.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 send-pack.c                | 7 +++++++
 t/t5408-send-pack-stdin.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 5005689cb5..4cd41a64ce 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -260,6 +260,13 @@ static int receive_status(struct repository *r,
 				refname);
 			continue;
 		}
+
+		/*
+		 * Clients sending duplicate refs can cause the same value
+		 * to be overridden, causing a memory leak.
+		 */
+		free(hint->remote_status);
+
 		if (!strcmp(head, "ng")) {
 			hint->status = REF_STATUS_REMOTE_REJECT;
 			if (p)
diff --git a/t/t5408-send-pack-stdin.sh b/t/t5408-send-pack-stdin.sh
index 526a675045..45fb20179b 100755
--- a/t/t5408-send-pack-stdin.sh
+++ b/t/t5408-send-pack-stdin.sh
@@ -73,6 +73,12 @@ test_expect_success 'cmdline refs written in order' '
 	verify_push A foo
 '
 
+test_expect_success 'cmdline refs with multiple duplicates' '
+	clear_remote &&
+	test_must_fail git send-pack remote.git A:foo B:foo C:foo &&
+	verify_push A foo
+'
+
 test_expect_success '--stdin refs come after cmdline' '
 	clear_remote &&
 	echo A:foo >input &&

-- 
2.49.0

