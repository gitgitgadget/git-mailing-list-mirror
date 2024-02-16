Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAA39856
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124957; cv=none; b=POpq6xAkJA6r4S9A6IY+SD1TBPLZwQhdST+bYvfEygXi29vTmWxipOuyWTVQ8JytnAWfKoXozIOCiWIPTuWhT7IXaxBbA7hW0XlZUnQJ1StUSabjPoQwinPgcOaIZ66A/bP9RjrirGGBPQlf2Rlv8w0jTqy6BXyaUqONLhCaFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124957; c=relaxed/simple;
	bh=VtcouaHw6ztbGb3EWtk4zEbxwTZdAZDIvLKHObqns28=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FxAfZiwe8d8KiebdLPkFKu36Tldbm3IaXKELwnEAs8JSCgXurFZPH5FlX2eUZ3nqJFkLs6FxOzMPQFPQ3wIP809oENxODzJCVYS7W6va5CyqGf+c1IyBwhYwmxT+js+tbCyr6ci/p2RAG1S1BAl0IU92pvByE03WRnnTARa7XwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaOqITZd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaOqITZd"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so20756645e9.0
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124954; x=1708729754; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=UaOqITZdnwxE6rOFTPzRFW8nIS9qNptH0ekYljucWVRB5YBC1L55pba0Dg4uiQZrm9
         jVgVg/XSbvkD7UOSta7xgUOD+dh/0RTlzWx5zKhOcq5hy51vOWOv5aKSnzM+J53yrCO8
         e2SXQw8HKaiN4yyiF40fQxPmRLF66UNlg+TfP4tPkkOXYxNsXbZbgkhnbc/f9ACJdKxq
         lxQQ9YPFzuo6w/z7AkVT8qUdpSs4eoP+7xsdxqCcvoC06YgDhGFCHjTqcqd2irZvuqJD
         /yRiHblMu+RGHhau6/yin7D4oM3deWF5RDWB0nqhI2kZF4O51n/KTl7e3ZgaLGYG/J8P
         T5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124954; x=1708729754;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNGSXY0lACUj57g92wZ8kTjwAhEGXfhsU6tUIWHtlMI=;
        b=HMk2GtsLW6Wb1aWgVrrgq9blU8Jt5g66sGwHDCcPzYUrHIHYHxHqOSuxG1b4hqZ5k6
         t++b32JPpzj5DIJTpP5wqIrtsZabcZvFL8AoqmRagmsEhvdawwVYJp/mvp7oxawtwXR3
         4rUtTw33xzpz8YFycCo3ZU5qSD3zjGmq7RT9fodVaOhP06nvD6+2Nw3MBw8IIQ4yaZ5Y
         8uoWjGW0uOvvWzCO3nUSkzK0pO9Gjh9BPboxrTQlq6o5kHhylXcJr4/qB2Jk+HfpkLDW
         15Zxcw9rKPY4CqvbLvdb6iSYr9GzhXi5pbHfquIJKXdJL5RiipxU4Bh0LTbejv0BoUZH
         3UuQ==
X-Gm-Message-State: AOJu0YyktmZPtheB3wW5d115URdPTR5fwDSbDrkBKqMK47KYaqOUEGh0
	tflKJMqVJTJScsxeIWuvb/vPY9e1wnEXCHwGTubLks2iCS1thpjhkvsEWpM9
X-Google-Smtp-Source: AGHT+IHK8quNm/DAJ2O2dBDtnuDjqBn1rR7O0JkANoKcLF1HZNXJOszi2rTO+UMOdLjR+wn9MhqTcQ==
X-Received: by 2002:a05:600c:511b:b0:412:5652:138f with SMTP id o27-20020a05600c511b00b004125652138fmr573749wms.16.1708124953587;
        Fri, 16 Feb 2024 15:09:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c231700b00410b0ce91b1sm3484836wmo.25.2024.02.16.15.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:13 -0800 (PST)
Message-ID: <652df25f30ecc8227bef5109b0f7b47817386b13.1708124951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
	<pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:02 +0000
Subject: [PATCH v5 1/9] trailer: free trailer_info _after_ all related usage
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

In de7c27a186 (trailer: use offsets for trailer_start/trailer_end,
2023-10-20), we started using trailer block offsets in trailer_info. In
particular, we dropped the use of a separate stack variable "size_t
trailer_end", in favor of accessing the new "trailer_block_end" member
of trailer_info (as "info.trailer_block_end").

At that time, we forgot to also move the

   trailer_info_release(&info);

line to be _after_ this new use of the trailer_info struct. Move it now.

Note that even without this patch, we didn't have leaks or any other
problems because trailer_info_release() only frees memory allocated on
the heap. The "trailer_block_end" member was allocated on the stack back
then (as it is now) so it was still safe to use for all this time.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 3a0710a4583..e1d83390b66 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1111,13 +1111,12 @@ void process_trailers(const char *file,
 	}
 
 	print_all(outfile, &head, opts);
-
 	free_all(&head);
-	trailer_info_release(&info);
 
 	/* Print the lines after the trailers as is */
 	if (!opts->only_trailers)
 		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	trailer_info_release(&info);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
-- 
gitgitgadget

