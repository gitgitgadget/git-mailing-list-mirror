Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947584A2B
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577816; cv=none; b=ICGGCb73XVx0HceVE5o1GhOgKhqiWw17eyZ+4A0guJ7sD0y3kJVFZQ1kW1IB1OaVYk+4Ra+npq1aaLrnloZFd4KtHE/LMvqgUMF1eqVfChGtUmtsBikcen13yIpCNjPJU+kjcgpjgv4oXBA2qh3g2s9rRJLs7nLp0BPOD2bxlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577816; c=relaxed/simple;
	bh=PNW0cEBGXMMy6yEq1XteCd6b2wGVd/X0vf95GE+Lwaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI2l4NnSrgG9gMX9gDVmzwKcR4Ce6FJvUpE2FBappl7yHZ/F2Bkwsu6FiL5Az4h55DWGFHDnt0zPRPNiiPxCzglj9WoWlQYDFTmPHIFW9Z3aJYUOB8nsIw7rWNbXbr1nzhl27afgWWJQciZq9j5nJrH7F/njrWiQLs7ANC7OXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcJ3R+J4; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcJ3R+J4"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc33aef343so13649901a91.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740577814; x=1741182614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QnSizut7KyAt1a1NZL3LWl/aUIax0VTYua/Q8bKzBfw=;
        b=kcJ3R+J47VLP/qXmHoZzlkGrYsx+wJk2GMSyL6Ma3NMusMmBXOb9Ernp4YZTWp/8gp
         FKaGTEd0sFY8rzLpoHOrlD9I1zjHmz46eeeAfNwGKbSGOGzV6jl7txzESpIhG6jY6oXd
         d9vtZtECl4C4P5IG9dgyLC9bS7bv6qvVGkGSbX1KJOgAOd3iFWbiOPFX+oCcQr1F7dDz
         NRDqDNaRmXm8nl4BJZ4wiWjU0pMPJcdHGCLqX1CRV7qXNqI7d5bSow4rvyk3/devgXZF
         /RzqX04Tjksmj/jcQlrio+gKp8qsshi3iX3RdtwhYY31C1mnS8VHlP4jKIkAGG0tKabC
         tfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740577814; x=1741182614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnSizut7KyAt1a1NZL3LWl/aUIax0VTYua/Q8bKzBfw=;
        b=ODDtamEf67YfpBE4NzWc5DqTVsTZodI/9n0XOVfTtVMS6t7zXzQYZ1vZcaZVX95SUm
         ue7DkX0IPwbbaNIHGEFQ2vCG127WvWKHuiGwsfkfu4fqKt6QwqXYyNZ+gwKoti3fIsCM
         A8yVnhOPqsstk07buN9+DPX7QeAfE8jnA8Gqgjjntfd2l92vLOICNtWaMgEBmYF5EACG
         W1oxxcUTxhqbDE0B1+zAUIL3sXVNVlUrNA7GQo1Pt2ankYxrIQDgk3qDGVVMMvOzwuNP
         4Zf1foCmtfCB5vae+eHQf30e1Tjc0PjS+YmoCamvwHKFNr6fsnbsLczpklnbjFa3QvR7
         pQlA==
X-Gm-Message-State: AOJu0YymYrcPAi/6ToTbGY1OrW2gX8T08BNIQI/2Z5dsb37q//2GTA0P
	mnZWExxSQBJWztb3ZFMXeLckTIhuizQhrJhOCv7Hq4lxpATV3OfZ2+VVEA==
X-Gm-Gg: ASbGnctSka1rgzYAaIoDnT6lkg2iyzafxdtEjnDMzVr+ArRebAwLGxDjDHkwqU78YB1
	eKqI77RFDeTvk4yW42or5lD/e0MPu495pJZXbB45M+PopZa3g+8UTjwPbYL4GOod4fuzN68pjn7
	SYrMXobBOF2erVLyNb4/TsJaQR8ztXvnS9SO915me9sIY1lKYqfOwvm5EgLyFI6eMvSelGkFmZi
	WUM7vsdI0BK2JabofZf4d75f3eTYwIM/wMirh/smjUtW0WdDbiNwUAAK3QSvKM20CIiGBjenYGZ
	lp3YJ9m6XifLnOieHpxPqA==
X-Google-Smtp-Source: AGHT+IG1yDd0yoY3nOHdAl0MF4a72eXQvbB4CVJm20+kW44w6ZLVQhJWx8jl7RM/KVKmqLXf06qHjw==
X-Received: by 2002:a05:6a21:103:b0:1ee:68e3:ff45 with SMTP id adf61e73a8af0-1f10aecf2c2mr6652581637.35.1740577813890;
        Wed, 26 Feb 2025 05:50:13 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aeda818a652sm3133399a12.37.2025.02.26.05.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:50:13 -0800 (PST)
Date: Wed, 26 Feb 2025 21:50:22 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 6/9] packed-backend: check whether the refname contains
 NUL characters
Message-ID: <Z78cHmY7WZvwCpl6@ArchLinux>
References: <Z78bmBSrDR20GY6g@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78bmBSrDR20GY6g@ArchLinux>

"packed-backend.c::next_record" will use "check_refname_format" to check
the consistency of the refname. If it is not OK, the program will die.
However, it is reported in [1], we cannot catch some corruption. But we
already have the code path and we must miss out something.

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
 refs/packed-backend.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b00fca6501..6e7d08c565 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -494,6 +494,21 @@ static void verify_buffer_safe(struct snapshot *snapshot)
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
+	return !!memchr(refname->buf, '\0', refname->len);
+}
+
 #define SMALL_FILE_SIZE (32*1024)
 
 /*
@@ -895,6 +910,9 @@ static int next_record(struct packed_ref_iterator *iter)
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

