Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED3192B76
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514366; cv=none; b=YD8BmJUUX+AqrVee9FdPXRqHh92b3l6ivTNXwUBKkA/L1A7UpFPPqEL8awJ/SRnFfYdwQZLsTWLNcsn6/rEufRZ/2zmT+dJAFsj4SS5jScq9rd6Z+4014BqlhAT+J4M3nXXlwPYdLinIaUZTh39pIgVrzHm3TmsWKlI+N4fM7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514366; c=relaxed/simple;
	bh=PMdw0FTFVG2iUoZMyeWr7FZupnaMUztTqBtsfXjAVNQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NYf6XLWmACjB9amtKdybSMsf0nTWxJ3AQe61QT9hFyFWITT8f8j+l3Br+Yz2VAVoZJnTW1Li+gSXkILDC0uHAXyjpqMzudCcK/yvhWkY7x/A6IauDJKrDXDwmfpLSbDWTAb7uoMzHEVGXgyZsaEf+lmymEejxHzZsPHeXSooL3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El29mzSe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El29mzSe"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so1732022f8f.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514363; x=1734119163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=El29mzSekIAxbykn3AZwNLkD+a/rE0mm+Zy6YOXB69vYUHvCwhk7CJ64kXuiUNiAPe
         UBxR0WObrgqFW0GNmcUdQVwjHz8x8nJXJj5WNh6tx0CD133rZqKmFtw77vssFwhJ+H8/
         MUiQMmZwL6CYvovPTDyQD30w867h+g0Lb6gxkTziac/7bLjad9DyBtBpQI7x0Gw4+09x
         VHbywzY11RQRQS3VuY77PWg+BsZ6wlzZmuC4U9aZC8lrPkwhvJlgJ1KztVyx/ec62f8T
         K3tj08p5q9iVpcGPF0VdFua763BSw6jJZfRUcA4KWhonUUPIJrj9neiZx4T+nVAMrLRd
         rBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514363; x=1734119163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dK2I2TXW5iAu4adBn9RAI0BX8gzXE/7TFrMGsUREmg=;
        b=wdC3eCMkV4mYcUqGV8AsrwyBgvBH3w+1disLmr9h+yz20uP5hDIfsCb8YyZ+BCnZII
         VWvu2sszHqz1v0cP9yHEGhXr2s0Ll4VyuJhapEzohm451G7eerCayMa0hjCQf5be+pFT
         VL7uNIOE/fNr1vHGtwmUnVUv9dOP07W6V9YbBVbgF/t3KWAewkpp9j0X9a8eJm3a6wzd
         VPlbiPFHLopn5wmRyz8G3XOL6/LOjote4TkQykjcFEDyZdc+DNgTh3otaDE0LQAIfVCH
         st3prFXElJg6Aw3cWQqa7ZXS65ofeuYOsugN1OcfcJKHStulw4lOdwm3THsQLRDIPYnT
         lFKA==
X-Gm-Message-State: AOJu0Yx2J9go29rdnNLNwGHhqP03GFz+pwt53LiMKjyJhQCr71pHj66T
	4+ZYIzX7mOPh5Ww4IBDqsT7921XovxOTRriKBljeg07Q2jQ4b2w4pJp4Yw==
X-Gm-Gg: ASbGncvgGO02O6S1IS9lKV0oTw0LPnfza1IjOii8E+22w5ee1t5H9NykO3iZ5InQ0gI
	5RBbkUossHY2NA7i51YVs+DqjQgVSEcrEQFTvKqoRBPBiiK/pycLtizdGKZe3GpUGDy+LIjtD36
	0AbO2fsLU4dMA1RHRS1rLc3vtEf82fMfk0wwSXo4Wg9tlg4iC3s4t0dhUdAnluWbEhtcXrSDqD2
	WkTekPwWShvu0UUjPnOgkDzO9EmJ8dYy2kL5eSWfGgj4Nnl5hc=
X-Google-Smtp-Source: AGHT+IEYCNzJJNhLfg93TH6WJN2kQme10BauS7jGJ1R3lzdC0GEgykvIg5Hh9iCB/UpjM6A6rOnoTA==
X-Received: by 2002:a05:6000:a14:b0:385:f0c9:4b66 with SMTP id ffacd0b85a97d-3862b39b9b4mr3862731f8f.33.1733514362709;
        Fri, 06 Dec 2024 11:46:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbefasm103012285e9.43.2024.12.06.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:02 -0800 (PST)
Message-Id: <cf2ed61b324b019f61afb1b66163b1284e675db2.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:53 +0000
Subject: [PATCH v3 2/7] test-lib-functions: add test_cmp_sorted
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
    karthik nayak <karthik.188@gmail.com>,
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

