Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017FD2FB
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209979; cv=none; b=aD/GZ+m0O4EBkK7CiXrJ0vk01v0nPjyIWSCpwJk9JLRe2cIGahhD0V/lz2ztPDKeQeT2v9TEGMt0OV5g5BJYkmkjsBdaj0V0SRQejmr9PbAR7xngKATQePVjNpLBD/twe///+FweBoU0QeKyt4Y0cuQwrfXgZWWz2UtOhl6Z14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209979; c=relaxed/simple;
	bh=KbxnRuHyJXge0KaPND7CZm3J4WUpkuSy5j4cuSoNVAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNf4HMPtpFPO0kg2iTP7Z3mE5uICA8NBbcbZVbUS/KH04jDfRLq2sq+2yEeSGFG9zL7TK07nZHXKtT6D8h9Hcr81+CrvFb3yn/IqtfmKudog5HFYdF+13soNlvlFiXmMUSIY/+hHEp3CUmtZgAXfJb9dzfboXEB5XWe3GGQw8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/HroMNY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/HroMNY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso404972a91.1
        for <git@vger.kernel.org>; Wed, 29 Jan 2025 20:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738209975; x=1738814775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMqAIJocEcBVMffq7qJNZiRlafmS6n4xlxyv4gFV2BI=;
        b=X/HroMNYPLaxv59qBl8f0aP47Dd0vvxpVbbkY/DDTIr0SKQkhhL1Hernid+CDRk2Fg
         L6Zx13SYEUEmDD5iCh6/PobSDCneRP0k0UHE8bSptD6X4kEBUoyClNRsmkzVM4dcs2Xk
         99zL+0gaPs8+8l3Ed+syCJWtRWO1JZEXk0qaZ3nXjSCrWAYEd95cb0KpK3hqyjeuQ4VR
         vEj34Ydy3oadHPZRoHvmjDCjwDyVd8lp3NKS3MSbQcqA0DBLEPFBYE5AgGoljend63Rl
         BlK0eZUM8BJ+Uy+4KqE+sSGGCJozvb6WTQeQVOTgnrnaShFJYDwolRCgzN7PxKFB4+FL
         XVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738209975; x=1738814775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMqAIJocEcBVMffq7qJNZiRlafmS6n4xlxyv4gFV2BI=;
        b=aMnUDLsVYa0piiZEqAQz4ZoaYx+VKmgFTgd/TtKb4yKylv/dY0XHBQ2waEHdQTJNcu
         8b6aPJYLrQkLVUrVHTiDRFUcL+gcrEKHPbRZJj3dNLmKvG5CXzNvxjb5qLwzkciGPGtO
         XZ2S+pKUSzm56Crtk2q6ayl0Adn1dkJhL7rn280idMffcya/xVN1dryOarZveQ2NAtWI
         kwuJKczfpeUgvVKL0mehYNE+a/myNKidz35Xpl0alSOKHx++HaQWCqUQayHIBnq5sLa5
         n4evMzlkuht00kdbLrolHrtd+ozTXitQLWGHk8gLq0qXHsEaW1osvwQvkZYAMooqEZwO
         8ZCw==
X-Gm-Message-State: AOJu0YzIOj3Y0AvcVdmevUH5MXrIsMtzqmJnkkydGoJW6mKqGnfmrk8v
	pkICokbwHXF2Sawrgf4QjqG9sQwrCj/ep5LuDbN0aWBLU95A4yXlx1Ly/WRf
X-Gm-Gg: ASbGnctpCNEAiBKZN/Loelb+U874QSnssHqhKNO2xxlKdsR7a+0nNq/buNXuYhTYUfD
	56bNBRreYniihSBduzpnsToNZuog48INYGBV8BF4tHMbFIbLzdL5y8SiSJhc1XSUZKj+Dosvf1v
	78rYDKqqbOVJ5LTdQ6AhL9YkUX7TDyjiJ+819y3PO0rJh7fTGqUUBbxIWJqYBPtmIXADXiBFqYA
	GzXJxHBvMOjuGBy6pUk1IUZWIvDE01k/drt8QH2TsmeXULhOlLDEngd6KnqtX9ATaKOcw==
X-Google-Smtp-Source: AGHT+IFethyzDAzcN35V2sCn/0U3J4zVPagPj4gRybGYsKt6ikenktakjuUkw5Yziw7gKNVOelwoPQ==
X-Received: by 2002:a17:90b:2802:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f83ac5e619mr7195784a91.23.1738209975289;
        Wed, 29 Jan 2025 20:06:15 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f848ade8c2sm448328a91.48.2025.01.29.20.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 20:06:14 -0800 (PST)
Date: Thu, 30 Jan 2025 12:07:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/8] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z5r7EkDwEsxuLJzn@ArchLinux>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r6ZnLH3Ee8IQnN@ArchLinux>

We have already implemented the header consistency check for the raw
"packed-refs" file. Before we implement the consistency check for each
ref entry, let's analysis [1] which reports that "git fsck" cannot
detect some NUL characters.

"packed-backend.c::next_record" will use "check_refname_format" to check
the consistency of the refname. If it is not OK, the program will die.
So, we already have the code path and we must miss out something.

We use the following code to get the refname:

    strbuf_add(&iter->refname_buf, p, eol - p);
    iter->base.refname = iter->refname_buf.buf

In the above code, `p` is the start pointer of the refname and `eol` is
the next newline pointer. We calculate the length of the refname by
subtracting the two pointers. Then we add the memory range between `p`
and `eol` to get the refname.

However, if there are some NUL characters in the memory range between `p`
and `eol`, we will see the refname as a valid ref name as long as the
memory range between `p` and first occurred NUL character is valid.

In order to catch above corruption, create a new function
"refname_contains_nul" by searching the first NUL character. If it is
not at the end of the string, there must be some NUL characters in the
refname.

Use this function in "next_record" function to die the program if
"refname_contains_nul" returns true.

[1] https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de/

Reported-by: R. Diez <rdiez-temp3@rd10.de>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/packed-backend.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 883189f3a1..870c8e7aaa 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -494,6 +494,22 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+/*
+ * When parsing the "packed-refs" file, we will parse it line by line.
+ * Because we know the start pointer of the refname and the next
+ * newline pointer, we could calculate the length of the refname by
+ * subtracting the two pointers. However, there is a corner case where
+ * the refname contains corrupted embedded NUL characters. And
+ * `check_refname_format()` will not catch this when the truncated
+ * refname is still a valid refname. To prevent this, we need to check
+ * whether the refname contains the NUL characters.
+ */
+static int refname_contains_nul(struct strbuf *refname)
+{
+	const char *pos = memchr(refname->buf, '\0', refname->len + 1);
+	return pos < refname->buf + refname->len;
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -895,6 +911,9 @@ static int next_record(struct packed_ref_iterator *iter)
 	strbuf_add(&iter->refname_buf, p, eol - p);
 	iter->base.refname = iter->refname_buf.buf;
 
+	if (refname_contains_nul(&iter->refname_buf))
+		die("packed refname contains embedded NULL: %s", iter->base.refname);
+
 	if (check_refname_format(iter->base.refname, REFNAME_ALLOW_ONELEVEL)) {
 		if (!refname_is_safe(iter->base.refname))
 			die("packed refname is dangerous: %s",
-- 
2.48.1

