Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B466D504
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243836; cv=none; b=repM/VT2TemPOwwws/apRX8yUgZxYEgKjj2l7N2okO9hhyp4B9RbJ2xn2bNBPz50ECo7agjaejaW+DHsJaUH/CmUpnnslbkH/nGCb/nZAFTgpAnb9x5d1rOR3gVJAgQi+Yn1fReGOdGzo6jrTk5Kdmr3Gg7lXqhxdi+x5XpWC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243836; c=relaxed/simple;
	bh=QQH146pqeDik1wUsYqv+TrKNYOEdezDBaNFX6/MIXIg=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YpS8Fs2aGyY0w9VnEGXFDJ/08sF+YA3yF7K0kWwCMGuH3DHcdAUH4v1qE5GYQoRIT++t/VWr5woXMwNV6nfnXElja7Q1dg06I+qReckASuiilsktvCyXMr1h/icDct/wfwxRc0lD6bHj0Tf1DJOXBTDVZVKDU2IB/8E2cOh7lHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6n5c7gr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6n5c7gr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e1692fb02so341001f8f.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709243832; x=1709848632; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/c6RqRVwIdtCvSCONl4uWUsTInpJi4chTbptlG2uvs=;
        b=I6n5c7grCEHl0AWvipF50aFMq4T5eFbQ6UUmaEQF4kv7GCB4A+n8a53uwMjOL7trnU
         zTFyGajKAawEowCKn9l26N8V9VMt32cfymbnYuu2dauwPM+yGphPEkXQtb+NsVZD/1ZX
         a//ReLwGGW7avxXle5+1phTQayoHPfrpAvq8PhxSiiBA0i+FLBYakH9t/K/FDanx4d7t
         Rh3palaQir1Rx9oT7kWjTmXBvmFjslDqJOmwCNMRCODWCAPOR/u1HUqdVqpAMSkQugCA
         FWgSk+ijgBinbML6dWc/ZW3DR1tI/j0r1cJmsY3rcEYNLsUWzJcRxBdpuqwaPAY4ScGd
         47iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243832; x=1709848632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/c6RqRVwIdtCvSCONl4uWUsTInpJi4chTbptlG2uvs=;
        b=k0vAlUUlUYgDSMZmykBR19SQgGNGjTmN0K6xWJOLsYPB84nNbowmZcrZ0ubVb+9jTR
         2Rp2G4ewZKyle7PHUfC4LzIKY9iKolj0GQxEfX2Q+WxeArKZsrqFKfSCSpORhR+97gvn
         9QxhNFr95qplO9YilOKIdM1q0c4Bj9y40hDBAamxQLh6r0AreuuohP1N516MA3nFMsRJ
         0v9Ut62TwCduS/hcbD+d1c8pusb/xbXaMYyrqsmvEDzIGTUrV0aQS1bPYSS30O/EtJx6
         qdhnoDJw5Q8Xbn+AeiDQYx5Me0P+fDtP77ZTTN2n0Ut5/cgPza50FUpiJ5PrsA/q9ILN
         JvoA==
X-Gm-Message-State: AOJu0YwnEkTeevRqzGpozeXq8h5j9YhsBTNKEa/i8y4y/VB+UexgNMef
	XwHqCMaF/5DVoRU30Ra7Bb1SNAQ2UKhWJoUR49KWuDRmuQWpT8VbZRNO4W3N
X-Google-Smtp-Source: AGHT+IHhe3JLmDGf4bpg4wqX4jWmgZbaLFbD9tn09ZlfJ4wnfjq5Nqh68NpqRjnNqv9T9QEx6HusvQ==
X-Received: by 2002:adf:e6c1:0:b0:33e:1e0:2679 with SMTP id y1-20020adfe6c1000000b0033e01e02679mr177826wrm.47.1709243832154;
        Thu, 29 Feb 2024 13:57:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu28-20020a056000079c00b0033dc7e50488sm2864772wrb.96.2024.02.29.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:57:11 -0800 (PST)
Message-ID: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com>
From: "Aryan Gupta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Feb 2024 21:57:11 +0000
Subject: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1675%2Faryangupta701%2Ftest-modernize-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1675/aryangupta701/test-modernize-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1675

Range-diff vs v1:

 1:  06377119ea3 ! 1:  fa381d0b57a tests: modernize the test script t0010-racy-git.sh
     @@
       ## Metadata ##
     -Author: aryangupta701 <garyan447@gmail.com>
     +Author: Aryan Gupta <garyan447@gmail.com>
      
       ## Commit message ##
          tests: modernize the test script t0010-racy-git.sh
     @@ t/t0010-racy-git.sh: do
      -	test_expect_success \
      -	"Racy GIT trial #$trial part A" \
      -	'test "" != "$files"'
     -+	test_expect_success 'Racy git trial #$trial part A' '
     ++	test_expect_success "Racy git trial #$trial part A" '
      +		test "" != "$files"
      +	'
       
     @@ t/t0010-racy-git.sh: do
      -	"Racy GIT trial #$trial part B" \
      -	'test "" != "$files"'
      -
     -+	test_expect_success 'Racy git trial #$trial part B' '
     ++	test_expect_success "Racy git trial #$trial part B" '
      +		test "" != "$files"
      +	'
       done


 t/t0010-racy-git.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
index 837c8b7228b..2ceac06c9c2 100755
--- a/t/t0010-racy-git.sh
+++ b/t/t0010-racy-git.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='racy GIT'
+test_description='racy git'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
@@ -16,19 +16,18 @@ do
 	echo xyzzy >infocom
 
 	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part A" \
-	'test "" != "$files"'
+	test_expect_success "Racy git trial #$trial part A" '
+		test "" != "$files"
+	'
 
 	sleep 1
 	echo xyzzy >cornerstone
 	git update-index --add cornerstone
 
 	files=$(git diff-files -p)
-	test_expect_success \
-	"Racy GIT trial #$trial part B" \
-	'test "" != "$files"'
-
+	test_expect_success "Racy git trial #$trial part B" '
+		test "" != "$files"
+	'
 done
 
 test_done

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
