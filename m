Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767761C54A4
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898828; cv=none; b=ls7a66snW8HkiB/CwDbc9FmK7JXxLnoJW2Apr3BM1YrVvvcCRuI3GV85s40qswC6S+B0tVt0dlnNFnv/7cGuiSHPcgrUMSj/5jDgdkjr6snTswlB/gitxKKw5rgroTduKpHW4qThKtmRlDwKvMpsDIz8DJX+ajlzWoHCepVXqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898828; c=relaxed/simple;
	bh=8T2UCdjSXSwqFmhj4MAHT9nZHFKA156xwfqP/euEr6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O86Sr4OqUJoWC0Yn8v2rXAkl5DhGVKl1Z87eEi8um4Ico3tg0IETNECliNrs5BfZbVJ2ph0F0WDbvE+AKxiuye4jjy8IWY8GuBuxvcQyWAxAfPahbNJIs7I2r5BiaH7y5nU3EY5gzouhqcQW5l2yJC3BsBN3buNr7UCvLxR2BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTrc9IzY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTrc9IzY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3cd821c60so517560a12.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 22:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733898823; x=1734503623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUJYImH9KbEfelezgsKyr0GU7/pksSBxA3JcvekS0NA=;
        b=cTrc9IzYv2rSD0meO8Yp8wU99DSnbCLHHCPEf3Gyc0QojFk4KkODRacDKBXdKqRAho
         iEgXFGX7gqAz5KTd8hE+MFXw4nboN7Q+dFrCfeJ5sElpV+epcp10DZ8eK9BAeeEo4loJ
         5gNUL5gRWmsU/NeB+1E5SdBuLqfp/O2CjKSMGvgI6xW+xjfgD591gOQrQB+RuogZlP5V
         prnx968sfZWaUWmDFPgtFqya1Ppm9lgwdocAR48GahdeBGejP7pQu1ENxCbHq70TxrIj
         9eJ8TXNNcif4j8aIkiDnbEgiCoCS4yZWMFAF//zFW2CnswUXPKhRP4oV6D2U0vBwI5qI
         NP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733898823; x=1734503623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUJYImH9KbEfelezgsKyr0GU7/pksSBxA3JcvekS0NA=;
        b=s3WlBqzAh2bzgpKU/0fhtzg88mS11gYIl5Zy5GJ6az+KtilqB11mwCCgqNX8dccDhP
         xt1XNad52+YQhTAUpsa7H+4rYb/Ng3Z85fN0BLbj7Z1r7xmgMknF6SNOB5GBU+bC4hiP
         PlerthV9xBh3G7XOqyE8spjyFNMsueXLdzGDnXwxaCqqcR5qmqzvUTVqjuTifLM++wrA
         Rf9wriPoC0B1l7YLLRBAbKt3xzGDtXcjVSFzWbgeyRfJI1FLqbPFGel7IApb4rsojRQo
         QaKr34PilnjtcppF8CnahPH/w/CuMKXKv0w0jLZa+yQtwoDLb+AYE0fYd8JpNfPuxTNB
         rIWg==
X-Gm-Message-State: AOJu0Yx14OzaTOLpOJlZB8bx2jy2vzxY+pn5EOSrUAcpBfL0tML0YDo5
	ZA+lcydN93FnxD5a6VmRntSp/FiVywzlrAP/OWfK6VrAB+y+VGEIrZi0Txem
X-Gm-Gg: ASbGncuSWaPjXJI0xWCnCMzDpFE0bQfWPcVDukVSkMv9pkN2MwDf6/BuIWKaEQp4CYD
	hb35vOD4STib0qlepKJvqxknW/TF4irgkMzW8MqNg0IYESPZpQzx9dEpyJKX+tec6L5TVAyDQzg
	Dh7CqfFzGWE6ZgMX9O19pO7OTalidpnPDdoDbBJ41+9MlRFmTFpaAfCUaij/cMLG1UxXjHqyK/j
	zxzX4QXzTpO1bJiBmI+jY6LMxopHfX0Ydc9Xu9xHEMqo7mdDiFdnnG6WkgJhFs=
X-Google-Smtp-Source: AGHT+IFYFAmb5Lo8TwnlHzKibwGoInQOaw4B6vGG28graNwX9B0TNTxB/o/O14wJA+vzK0zFimQSsg==
X-Received: by 2002:a05:6402:5193:b0:5d0:bf79:e925 with SMTP id 4fb4d7f45d1cf-5d43314d34cmr465921a12.6.1733898822809;
        Tue, 10 Dec 2024 22:33:42 -0800 (PST)
Received: from localhost.localdomain ([5.29.161.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d00a0370sm6875803a12.6.2024.12.10.22.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:33:41 -0800 (PST)
From: Roy Eldar <royeldar0@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>,
	Roy Eldar <royeldar0@gmail.com>
Subject: [PATCH v4 2/7] git-submodule.sh: improve parsing of short options
Date: Wed, 11 Dec 2024 08:32:29 +0200
Message-Id: <20241211063234.7610-3-royeldar0@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241211063234.7610-1-royeldar0@gmail.com>
References: <20241210184442.10723-1-royeldar0@gmail.com>
 <20241211063234.7610-1-royeldar0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some command-line options have a short form which takes an argument; for
example, "--jobs" has the form "-j", and it takes a numerical argument.

When parsing short options, support the case where there is no space
between the flag and the option argument, in order to improve
consistency with the rest of the builtin git commands.

Signed-off-by: Roy Eldar <royeldar0@gmail.com>
---
 git-submodule.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index d3e3669fde..fd54cb8fa6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -77,6 +77,9 @@ cmd_add()
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -352,6 +355,9 @@ cmd_update()
 			jobs="--jobs=$2"
 			shift
 			;;
+		-j*)
+			jobs="--jobs=${1#-j}"
+			;;
 		--jobs=*)
 			jobs=$1
 			;;
@@ -431,6 +437,9 @@ cmd_set_branch() {
 			branch=$2
 			shift
 			;;
+		-b*)
+			branch="${1#-b}"
+			;;
 		--branch=*)
 			branch="${1#--branch=}"
 			;;
@@ -519,6 +528,10 @@ cmd_summary() {
 			isnumber "$summary_limit" || usage
 			shift
 			;;
+		-n*)
+			summary_limit="${1#-n}"
+			isnumber "$summary_limit" || usage
+			;;
 		--summary-limit=*)
 			summary_limit="${1#--summary-limit=}"
 			isnumber "$summary_limit" || usage
-- 
2.30.2

