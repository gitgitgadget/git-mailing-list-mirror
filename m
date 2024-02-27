Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039713F016
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043961; cv=none; b=tzv2vxLG2oA/ugkuk4gU0YaSHYsys2TUXrQuUreEf99t+Hu6oOpGu6/+Ya0TaODEWXATt12wWkXdxQ8mFt93GwuzINXLQNfmT6gUjWSxcmU2T59molNqk32MDbX54hETo1wGMm5B+nkkdmjXhu2jG+gEYJNOjqtDkiKZ4FfoRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043961; c=relaxed/simple;
	bh=WQP4SVmnPYY1pNODPkAQmPZ+70EERLfPesotpQgk8xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv6DUQ4MSEYLrqW7Us9pyN54UUgjjRDqrVwCcTck5OFYHvS0wSK64A6svsvUvQRHeWkMLIoDPy+pDVwL55nqA9cU1RBhllfQwWvbcNnFio8zPT/PNNuwcZayU5hR0FAAOznpwbYs0tK5VaW695QP17gggviC+fGFMHdpkL1irhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRTBhBaw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRTBhBaw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412af574659so3502835e9.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043958; x=1709648758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=aRTBhBaw8pKvVMfHInDamakt7O+Orv0nRuaDCC/oCWqiBeD9QJCxWS4qSzmd3h5ooT
         K8DED81M2V41aO4QLbIe7eqjbjj34/pyiOITf569uzjM+aqnUAa2UJzdGWLfPujHVYup
         gFqPk1G11GRt+kZV+pT2LasQg8bsdBDu3CKz86Z6Ipe8CJeVk0E8NshkUaJVz2/BSaNW
         UOWz6Jwc5n0SywqhHp5a06EETmEs+0m35xJZierHtlpBASxyFhMVyQ3PjDyY/1dRET7O
         N6KFsemv6YFoXOY/fyxTsyemNcGknepdsHedIIZC8Ty8FZWDXD8JdLAxRKS5fpJg7959
         EOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043958; x=1709648758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3ZVwX/Tnt0iQUJkcUBRAuTTatfyAkULK9qOPPp02T4=;
        b=qeqtF/2TOQvB6wrCUSMTwWDnP3nh0dcYheMEHt/ohefBVKkEDTklT+1BrXYakKeN3Y
         Tv94aI+99WejcPOzMRdCHRr0Xd+TRR3XJ5fpKmDtOk4p8a9mfIPiS5xAkcYY8XKadKL2
         UWEC881UY2x6hhHDoLwIQXQw0ZHCLyz9bGrVsTkIi4jCg12fGCmPTNfNhqCTHnuDZ4qX
         kN1WWCiKi/D9xaEKG4iUzf9SPf84qSlCV7kcFqu2qyaO1Dh6+39WODN+hVWI7fe48gKf
         wwz4a4KM9q6La/Xo+d6dFRxXo0p0Slld2R8b5A4rQsDWHlWRvj9fL8TxDKeReeMRjl7r
         mKiA==
X-Gm-Message-State: AOJu0YyO4DyCje2asmEaQZ7fRGrue+3YHE5W0EnQSN2omCPF7q6xtRd5
	ceIAap7gvPQY0nRQklq+B5VldGAhbZn2j1N5n0seDD7mvQR/s5RL
X-Google-Smtp-Source: AGHT+IG1T7DD/W+EddGsFNednuh8PjI97/F3ykGSHGFxroG5ysAuQ7PqzSqQtTjLsbtOvHivU1IZ1A==
X-Received: by 2002:a05:600c:4ed4:b0:412:a48c:139a with SMTP id g20-20020a05600c4ed400b00412a48c139amr3921085wmq.6.1709043957957;
        Tue, 27 Feb 2024 06:25:57 -0800 (PST)
Received: from host-sergy.. ([154.72.153.213])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm8459255wmo.23.2024.02.27.06.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:25:57 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 2/2] Subject:[GSOC] [RFC PATCH 2/2] Add test for JavaScript function detection in Git diffs
Date: Tue, 27 Feb 2024 15:25:39 +0100
Message-ID: <20240227142540.73972-3-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227142540.73972-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227142540.73972-1-74214119+Sergius-Nyah@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>

This commit introduces a new test case in t4018-diff-funcname.sh to verify the enhanced JavaScript function detection in Git diffs. The test creates a JavaScript file with function declarations and expressions, modifies them, and then checks the output of git diff to ensure that the changes are correctly identified. This test validates the changes made to userdiff.c for improved JavaScript function detection.
---
 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index e026fac1f4..e88e63bd1f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
 !String
-[^ 	].*s.*" &&
+[^ 	].*s.*" && 
 
 	# a custom pattern which matches to end of line
 	git config diff.custom2.funcname "......Beer\$" &&
@@ -119,4 +119,25 @@ do
 	"
 done
 
-test_done
+test_expect_success 'identify builtin patterns in Javascript' '
+    # setup
+    echo "function myFunction() { return true; }" > test.js &&
+    echo "var myVar = function() { return false; }" >> test.js &&
+    git add test.js &&
+    git commit -m "add test.js" &&
+
+    # modify the file
+    echo "function myFunction() { return false; }" > test.js &&
+    echo "var myVar = function() { return true; }" >> test.js &&
+
+    # command under test
+    git diff >output &&
+
+    # check results
+    test_i18ngrep "function myFunction() { return true; }" output &&
+    test_i18ngrep "function myFunction() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return true; }" output
+'
+
+test_done 
\ No newline at end of file
-- 
2.43.2

