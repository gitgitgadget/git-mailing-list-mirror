Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003C7FBC1
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719556655; cv=none; b=rBeuJda7gDKyh0/UXb0r0KLcQfCGgzGPptfTF0ZnovV+K90e18WOImoh9AbX0jhfm6Pe7tNvji12fM/nlqq2t/rzHGJuZCdu07py6UJJUHWaDNq6wQ/vEgQ61og/tHsudGidAMZbOx7SPvSqBl4NKwrZOC2K6OxZuCpAV7cxizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719556655; c=relaxed/simple;
	bh=whBOa+e0rTItv+W18a+Kfok3zqsNWeqCc9aVf04Kjks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxsO9R7m48nsg8sEVrYX5a44hQK9+R0B5QnHvb0CrP7RyXWptSic/sFl0qh9kiTxjdsQYxzOQiop/2ftQljE5kMG9KQsJE21PSWYO+U8Q4FE8wfkHrFHNPwRB/5mNkJzdUFFJesB7UOJ85toF0qv+BLD2Uvny7n+4KDkRQfctCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArAfEb4Q; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArAfEb4Q"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d561e564d0so154532b6e.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719556653; x=1720161453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJGDfO5+rCQHcXLZ2juVKKM4NHiM6JoO/Tsycmu++N4=;
        b=ArAfEb4Q1L1sGu8jTY5eNYYK9PGgRkyp85/ncud7n75TEFWlvzCJYbmGbtexM0owgd
         bq0kEM6zVSP08k5BiM2fO9pVFLiIRUIkos99A4TlgBH7Iq2ecjQxYFJ0WUultPjk69TA
         +cJcaoevgiglag3lMFWTwuO0I1YKhjNGbbajZKDYS6kw/7WrJAqbLBOZRJoDoKZrVHA1
         JYqJQdm9nwWz6l+HwFjlE/+1O6MuT+KfzFi6k/CIUEx+qG4btHYZpLQ9b2ECDxWvE8ns
         yn+Cr4haq9gIKJCEtmZ8zpFjggusJzn3MbSAv8pJkANHqC99AAQrk41J7UoaalsND1CF
         uLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719556653; x=1720161453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJGDfO5+rCQHcXLZ2juVKKM4NHiM6JoO/Tsycmu++N4=;
        b=pmEE9cu08sBxW23MhjdQFnHO9jXCCKfqx2C4wmEfkbK5KqLUNIMPdDh4SoXE8ksoe/
         2rFb6JjhnZDdreNrP8IcIh42iCXshY/pd2PjzBQn1lCVmcjCgfNNb301nJa3NJ9nTRG5
         nsnQVa4/HlCUIvmtMj0j28ixskB9fFw/Z1vLJDyopAUoUthv9nANTHBKauNp1YLWaXAt
         /i1Ld+qh/IDcUiJ+e5aHcpfBCo3JwrkMFLqy3+NFyk+ZkGTFTH0ISR+1si6w9b5IqoBs
         NAw2AhmHjnr7c7n7D+2GvbawypU+UyesitQ1uRCjKWLECgDOul+dLdizfK/8OL6nJ4G2
         b3tA==
X-Gm-Message-State: AOJu0YwxLiwNRL8++8g9jarQsJovVmjLMqMnLdYPL9k+YeAeuxHsa9gk
	RPtv5frgxdj1ZhAmIzsefJvLGW7vJIXAepEzhy8Wc/ZOaqgqLq7/z1BYiS8QeDY=
X-Google-Smtp-Source: AGHT+IEG/zluRNv4E4YkV1V3rduGz9ARHz1fzqKA/mNTbnsWvzGHg2QlUD3p5H1NBBwf8viIkJwCUQ==
X-Received: by 2002:a05:6808:1492:b0:3d2:1f71:1901 with SMTP id 5614622812f47-3d541c915a5mr18169030b6e.29.1719556652728;
        Thu, 27 Jun 2024 23:37:32 -0700 (PDT)
Received: from Ubuntu.. ([117.99.235.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70804a93ce7sm786003b3a.207.2024.06.27.23.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:37:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 09/11] t-reftable-record: add index tests for reftable_record_is_deletion()
Date: Fri, 28 Jun 2024 11:49:39 +0530
Message-ID: <20240628063625.4092-10-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240628063625.4092-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for index records.

Add tests for this function in the case of index records.
Note that since index records cannot be of type deletion, this function
must always return '0' when called on an index record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index f2422a7af0..55b8d03494 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -466,6 +466,7 @@ static void test_reftable_index_record_roundtrip(void)
 	reftable_record_key(&in, &key);
 	test_copy(&in);
 
+	check(!reftable_record_is_deletion(&in));
 	check(!strbuf_cmp(&key, &in.u.idx.last_key));
 	n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
 	check_int(n, >, 0);
-- 
2.45.2.404.g9eaef5822c

