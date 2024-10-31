Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB71411C8
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730356031; cv=none; b=pat5VZOGNvDb7Sj222sWmfamfW/xTP48bAc4Bt47WN14MD8qsJScEp0/2nALHQjKSwHpeJdfue3VnKxtxj+7eOh5gOptn2i98zL5JUMxyvQLoIFmkQreF6CYLo3Fveva9XzlcEvNPUNJOwKDN92WFuh4b2Qq7+t3kTWcOu/j5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730356031; c=relaxed/simple;
	bh=PMdw0FTFVG2iUoZMyeWr7FZupnaMUztTqBtsfXjAVNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EjYbn00gxAN3KFXlN+DIsCZiQ2MkUB9ilf9tu5aJSFUfWjcNgZBIDvDH+2cthjuhEjFEkE4A7S+BppjTr6+ghse6xNYzsEUHcj7MXSedoKPILstAV/mn2lifML7R5v/KZpGtWO4gWnYqmLzqauDGte2gpH68z0pIHkHH+NSuMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEUyqi9b; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEUyqi9b"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so4676045e9.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730356027; x=1730960827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=XEUyqi9bNl8gNjXvIsap213VIhSijsJYjgr9vh6km+qeFtQm++3rryRR2cMkgVWG44
         8Xh6C1PeoRdGQyAVmkWU9BbbNOompNhAVV3ivh96RhcpEwlP+x6+axQDHwjSmrFheytw
         xmSV9V4WlQz5ajlnYOaj3Btj+lqsXeqkYeB/ZC7FEeDYtITejophUi+9sMSJ3innzPoD
         KLsPmDlzfYV0nAvkLAndalgQVcFyCOyVzsv5+w6PXQP4fZZZEdZmXahJb8RMhxWrfa8+
         OoeBpNFp3JHJXAKXEEW6MqbyQ03JOqPEeihXovav7vmp4SziQ7gLOf9ihFQBeB8S5jRe
         3TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730356027; x=1730960827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=fUOoVCMwL7D0Yc4WNWhMV10J2H+9HFToeEoCtPcwB/so0iS14EPw69it7yqvvrLmSf
         tywpeWtpoSagfL5egdkus/uKw0OwWNDbhbOdaXDpgL/NOX32siB819J1Mjbkz9nVnnYB
         uDHY5aGqM4k0Uukqd3XJ0q25AYL0D2Fy6xSLOAsc1DK2ZAzy6S6WApngDpg23G2CFe+f
         rvESD9GcVvVUHdcZrIZ7U7Jtcg/jH/SoA0eKKx0O8TUOrc6XDiydMD9fAhoAGpsDSfE8
         +sJ61w2QNDB9QqqSC131elNDRnbURePg2tXBnTKIFs4MkEelXCEqOnC1XpIYXMqni18A
         gZDQ==
X-Gm-Message-State: AOJu0YyF1oNpCVjf/F6ij4csblJl9XgD9DJmLc3ndvwNfCrG3jLaBjL7
	6NHSl+DyB1g1s1F9I5djmwKy08VNIgGOzqgRWZjrvjZlJORc4zIbbUnJTQ==
X-Google-Smtp-Source: AGHT+IEf+d7DYamxfnH1ZgmbDLVK6WD1ad+V/9LduiDEOlsz6f9cVE19g1mkxVQUx7pftr39ulhGKg==
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id 5b1f17b1804b1-431aa7ff3acmr105036735e9.4.1730356027083;
        Wed, 30 Oct 2024 23:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5ac37csm12693175e9.10.2024.10.30.23.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:27:06 -0700 (PDT)
Message-Id: <4f9f898fec1d88d5107a10c4b953caaa98a51f17.1730356023.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
References: <pull.1818.git.1730356023.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Oct 2024 06:26:59 +0000
Subject: [PATCH 2/6] test-lib-functions: add test_cmp_sorted
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This test helper will be helpful to reduce repeated logic in
t6601-path-walk.sh, but may be helpful elsewhere, too.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/test-lib-functions.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index fde9bf54fc3..16b70aebd60 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1267,6 +1267,16 @@ test_cmp () {
 	eval "$GIT_TEST_CMP" '"$@"'
 }
 
+# test_cmp_sorted runs test_cmp on sorted versions of the two
+# input files. Uses "$1.sorted" and "$2.sorted" as temp files.
+
+test_cmp_sorted () {
+	sort <"$1" >"$1.sorted" &&
+	sort <"$2" >"$2.sorted" &&
+	test_cmp "$1.sorted" "$2.sorted" &&
+	rm "$1.sorted" "$2.sorted"
+}
+
 # Check that the given config key has the expected value.
 #
 #    test_cmp_config [-C <dir>] <expected-value>
-- 
gitgitgadget

