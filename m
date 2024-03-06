Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99995F57A
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716451; cv=none; b=RznCjeyjizo8Q6f1RAfLVfP0RaTUK/tXl4eupK5fJ5YV5xUid5O5WTkzGj8kgVD1XUChCmNZWX6jIVYgRrOdk6WMrNzeqrdeP/pQXyzxQj2V8eqWJR4B6M0uCxEUskhc+HvZ9k9PwgTOpNtZWCWwsd56V3J/FSgI3TFmNdFqC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716451; c=relaxed/simple;
	bh=WLv5Z1dgLZgjDAx5iOW0+5nCABWku1wjgPGdSJlryEE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ei5bjr4AlUzmT0kF74uHDLWH/7qa2ewk3TxDwW9wnYGmejOtemPFkemn1Ea2w0+pOzC9LnRjnuSEwsWSxZWiOKsJJrSeqturIa6LYjVDSMongoSmrTd2E3yVuAhPSkfSvlvJCNhcyRa9VLJVZbajAJDLG4JSbEQhjgPwpsFU93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzQv+BB9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzQv+BB9"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412de18edcaso24556465e9.3
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716448; x=1710321248; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhuKyR6TRRs1rE2FIBDlT7LANj8j0lSNxflT9wBwam4=;
        b=UzQv+BB9mObn1ziFGP2cqyRmHl/I3/IRs7D7iwPbhHK97/KoKzXJDmfB4hgN2+RDoG
         7npnVneFDf0IOM4yP05H9jBYBABavDdyfJT5ie4S91Q6hBOV47q8fv2Pw/m3wPktR/xG
         cS34mt2j3nApR9UFWUTLEShpNMjDWo3/GEn4XSnF9AWb3PsVYMqt4KaBHjvgLjL7d8oy
         1MH+mTa1jhQIvdRMMIQajyhEqyAHhR1oWoA812Nxd/CJHBbzwjuw0Nc+ts4aJNg+R5n9
         ISBJm8DIHZmfeNQmQT6lyOWRb5r9I3UhFQTUKnd5+HMXicKyLYS0W7KOdpTKlNJPR/Wg
         1QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716448; x=1710321248;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhuKyR6TRRs1rE2FIBDlT7LANj8j0lSNxflT9wBwam4=;
        b=XTK5qYRvro/ZfAxtNXVbn4EMcIEq7f0TbkDy/xx+zlI7yYMs7sW0LrotUpnqXWuavE
         x3J6v56UKEUe97Xju5QlUUiRLZ3Hnio3wO35OOx6wE8K6nn6v3Kf4Gn0Y5buEdmVA0ON
         jRkr8ipwhYpBFnGJcMkoFnX7MjRehdMPBavofjsE8LsdtjEPIzxr78jAPo0A6I2MUNjx
         2Eo2mOHDewxn3baTjCJNQ/WLYW4OJKE7eqFO3IjJCe/P0q8vZKecCMlcPEuxZLozwSqU
         rgKxZ/lz9c9Kzqe8T9/hPVvMlUpES5Mnsx62lNRk4qIr6+3+FwWlRF/WyysHWjZ4qsqQ
         B6Bw==
X-Gm-Message-State: AOJu0Ywkf1jJKu+DwQ3Z1q71HgutLBw1IPBbuuHkrg3FROUnSBHp0wq6
	hSe0lddZlbokN77xB3ImiBq1jpNC70Lo3M2Eg63D3nGA2KviuJNbRT31cOUe
X-Google-Smtp-Source: AGHT+IHUCNo0IANRD4oAL8Lmdq1u36pmxF0lTBsUaDbtBFVLS8jeGUqhoxlLkMkhC/fkIgy0R80f0Q==
X-Received: by 2002:a05:600c:46c9:b0:412:c1d3:c665 with SMTP id q9-20020a05600c46c900b00412c1d3c665mr11464475wmo.35.1709716447776;
        Wed, 06 Mar 2024 01:14:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00412a0ce903dsm20394104wmq.46.2024.03.06.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:14:07 -0800 (PST)
Message-ID: <pull.1675.v4.git.1709716446874.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
References: <pull.1675.v3.git.1709676557639.gitgitgadget@gmail.com>
From: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 09:14:06 +0000
Subject: [PATCH v4] tests: modernize the test script t0010-racy-git.sh
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
Cc: "Patrick Steinhardt [ ]" <ps@pks.im>,
    "Michal =?UTF-8?Q?Such=C3=A1nek?= [ ]" <msuchanek@suse.de>,
    "=?UTF-8?Q?Jean-No=C3=ABl?= AVILA [ ]" <jn.avila@free.fr>,
    Kristoffer Haugsbakk <[code@khaugsbakk.name]>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Aryan Gupta <garyan447@gmail.com>,
    Aryan Gupta <garyan447@gmail.com>

From: Aryan Gupta <garyan447@gmail.com>

Modernize the formatting of the test script to align with current
standards and improve its overall readability.

Signed-off-by: Aryan Gupta <garyan447@gmail.com>
---
    [GSOC][PATCH] Modernize a test script

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%2Faryangupta701%2Ftest-modernize-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/aryangupta701/test-modernize-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1675

Range-diff vs v3:

 1:  05ee9e8a458 = 1:  14c7137baea tests: modernize the test script t0010-racy-git.sh


 t/t0010-racy-git.sh | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 837c8b7228b..84172a37390 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -10,25 +10,24 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 for trial in 0 1 2 3 4
 do
-	rm -f .git/index
-	echo frotz >infocom
-	git update-index --add infocom
-	echo xyzzy >infocom
-
-	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part A" \
-	'test "" != "$files"'
-
+	test_expect_success "Racy git trial #$trial part A" '
+		rm -f .git/index &&
+		echo frotz >infocom &&
+		git update-index --add infocom &&
+		echo xyzzy >infocom &&
+
+		git diff-files -p >out &&
+		test_file_not_empty out
+	'
 	sleep 1
-	echo xyzzy >cornerstone
-	git update-index --add cornerstone
 
-	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part B" \
-	'test "" != "$files"'
+	test_expect_success "Racy git trial #$trial part B" '
+		echo xyzzy >cornerstone &&
+		git update-index --add cornerstone &&
 
+		git diff-files -p >out &&
+		test_file_not_empty out
+	'
 done
 
 test_done

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
