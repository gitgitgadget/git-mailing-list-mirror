Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D31C1ABE
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583159; cv=none; b=A4ZRvhasnjgc8O7yYDAeViQifjQ56q3d8VVFh4H3SmuksLXM9iUvmhm7uEXqbEgv1fT3pl3QzczkRJyVqvCK186ZENZla3c5pBO+lwPTHhX5IKPVZgiaNcMHCBXImWZEEPS/XzCaMDwdeCtjnvHARn10xYTcocOMqmjq5iFI6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583159; c=relaxed/simple;
	bh=Q0yHjm0/uJa0AAruC3fqk6K3HMcq33NPbaVHTSBxXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SiRfO3YPOZOMrTw56WQQomWoBPi2jWmadhIzcLPnQ9XE9kjIXudyQHEFPgImzFzSfQgd78hsac7yTqU84skWm+2ROy/OTbM71iKIz1azg/bREKB4O5YlnJRBg7ooHq+TkxKZGybQ05Ulenm0bJPeDCmDC6VQkszuhfCv5yucwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4MBjgS0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4MBjgS0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so1546778a12.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728583156; x=1729187956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1goZbVpUqBcA+JJH9ZJi9mPq/UqfKzZ3cUUK8wqywPo=;
        b=b4MBjgS0Qh1/2VOJbnsR1BJjwVeqMFVNRqrhZ5zB/WngIKJJUx9bWcDGGqRGniYftS
         7fBnNNjhmStdzyXskITkOu2cldqYS3j1q7zbiHICC/1fNWUo38VxaH8c/id8jkO86lc5
         kJ3DHbqA+Hw7VNZoseX5/0jcSS+LxIiSBys2KYMX1+VI9r52rNFJBhHIZDP1tjPjkF+w
         wwVDcpiSjbBNNvpA2bSlkZuWT3oizb6zOzs+5kSSLbhgyb2pUFEUcqrKx6iCxbsJgMmD
         m3UrXjE6sYw/tGZAVTtwEAjE5Bc5/LsYoNr4LXy9mTi/qUnsJGyGiKyMFpHkFU1gzyt4
         YKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583156; x=1729187956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1goZbVpUqBcA+JJH9ZJi9mPq/UqfKzZ3cUUK8wqywPo=;
        b=bKIt3Ob+SXqmk7TIp0Ro4+utTCU8spQlL2TsaA3NJ6w73jpfof0BPHlRAu9EueiA/g
         k90x5OWIBYFZt7LjWGt6JwxozoZrrBDt5/9h4Wmb4Q1gNnXHXAXk1kOvfyXNaSBlcQ1J
         g0dJw4VyMQddyIx8zUqshIJaUBUW/tw3R7gypZLUBRdiiIa3tEbJEkmL/L+nkLyajTPg
         fZmxR7sY/hJy3r5A4n3MnnKDjroCW4y0razpvG9KS0fMJBC74zpIauWWEJr1U87AFp5a
         PQllAPDfr5IRSH4ejaCERRCbABclirUd5nzivEJ/kn4OTK2a0GgjupeBRlfyGMS9Np/b
         YiAw==
X-Gm-Message-State: AOJu0YwlRtq5X9FvIQLvuk/pTHVGiGE6EyDGr8LWamVVqeo5PLwLb1wO
	YZS67nXSzA25iktW24XcX589ZaB2TpDnWXGkD0uZLovJBVombb0H
X-Google-Smtp-Source: AGHT+IE0lcDrLEfnIVbOVUTXKogY1Thqzz7gahn2Bdrq6y6wTbk6J2Na4P25I1imv6adpAfTLDoCRw==
X-Received: by 2002:a05:6402:4411:b0:5c4:a6f:9be7 with SMTP id 4fb4d7f45d1cf-5c91d57f4a4mr6885996a12.8.1728583155647;
        Thu, 10 Oct 2024 10:59:15 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372608f4sm1059995a12.70.2024.10.10.10.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:59:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	toon@iotcl.com
Subject: [PATCH v2 1/3] clang-format: change column limit to 96 characters
Date: Thu, 10 Oct 2024 19:59:09 +0200
Message-ID: <e22ffbe0f65971579809d817984766af12898127.1728582927.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1728582927.git.karthik.188@gmail.com>
References: <cover.1728582927.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current value for the column limit is set to 80. While this is as
expected, we often prefer readability over this strict limit. This means
it is common to find code which extends over 80 characters. So let's
change the column limit to be 96 instead. This provides some slack so we
can ensure readability takes preference over the 80 character hard
limit.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .clang-format | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 41969eca4b..684ab32d28 100644
--- a/.clang-format
+++ b/.clang-format
@@ -12,7 +12,10 @@ UseTab: Always
 TabWidth: 8
 IndentWidth: 8
 ContinuationIndentWidth: 8
-ColumnLimit: 80
+
+# While we recommend keeping column limit to 80, we want to also provide
+# some slack to maintain readability.
+ColumnLimit: 96
 
 # C Language specifics
 Language: Cpp
-- 
2.47.0

