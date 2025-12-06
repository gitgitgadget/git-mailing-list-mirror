Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225483595D
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053092; cv=none; b=j4mUODSL4Q+YUYUADpJs1OrfCPUA3n4LL4IAfpaI2epTJyp2+gUJq02TTnOkCvY8fOCL5xtShQ0djI/FJ5RVIoJCntrt/dG/eTymrMv4OH1hZssk2lZkYMbILsoaf3Ftf/IGyP4EGXlXD0AGmzWyA4zbL2jOkhMF227cRBsk7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053092; c=relaxed/simple;
	bh=Q/+or0SNDhqjAMIKSaKeqdfuPdJOr0wQfHBqzpd3vu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaoFAmcPcpnYjZZiBD5FIf7017A74rmUhM4bDvr45UpH0hqO1IGT0O6o7Hk2tcP7QjWzE8f50N1n7gdQMBl4T1foRhViPc3YfoeUkcW8PUDbv9hcfWeUmVhMLu4h35+a4klSmRsg1vtE0S1z9YXhfPHlemsIxYggQTj1jj/FJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=IzWplFs/; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="IzWplFs/"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6444487b34cso1916602d50.2
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053090; x=1765657890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9sx2RWwi/YTb6PlC9GFrzePxdXzjPneVsmeTxtM08s=;
        b=IzWplFs/RBJR4JuZ7FZgfqtQsQeWRfmc1HNPxcv8p0xcE/2Cwj19Tw0S2S/vflmK5G
         6Rmb6P2/htjfCvWWAZ8ykxWLuTYVVuDe/A1VESHz0pj9SQ2L9oH2yubn4JwBsbqnQSrG
         kDsAXWVC1cIlg8rQG+W/HfxyvkbVDM3lqZMBG2l3rxYI7awWhjBUnYKiJ+5WDOppGpf+
         9ru+dAIGVLhE9o0t/LLMkyWywabg7dW1E/xI/nzS1CVgKAUzqB6+79mafD4hb6WLq2M4
         a5hZoVO618OcZ/losn/vrTexjBVItYcuXHm9dJRouETlJZDp8P8WuDtRQB/UST+iFk0O
         T3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053090; x=1765657890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9sx2RWwi/YTb6PlC9GFrzePxdXzjPneVsmeTxtM08s=;
        b=KRb8P34sScrgD6SJYGxg3EXIKkI5kLJLR2hAvEyL3VHmSupqDQL0nTf0h0aKIdtEyv
         YkhGg4hl8mogKkNJPU2M/LnmdPjmoZW6DftSK2WkAMwttKkX7nrkhPOKeUuLjU7UO3gL
         m6OMp1n54pdwJun+V3/vrY7iBPW7hxV0elc9i6WIT6CwNdcjF8A7vKXK9rytyywksRA6
         cXWZIhmbrJeEgGpZI+UdJsvXVaW8sgXrsRLZbX8SMmtKhcIGAdp725EIGG6xETuhKxXx
         z8Z7Y0sY68hr1oy5QMQeD+WUX5MjP4qil8UR5jOF7zvE7Kl9iOTE+Gl30t1MIuVT8ULD
         6ciw==
X-Gm-Message-State: AOJu0YzO5dSbCkVdM+S1ZCYGOqF6Aa6hk13WGzXybDBHLD9U1Srd6JKl
	/Kde4TYY6xtYhLPFrLrwDgF06RwCVdeo8cCidfXsGjW9Dak8AJskektZqP9GB6F/s2mb0LnWFO6
	q14XwoNU=
X-Gm-Gg: ASbGnctjjAJ8AEQ3fjxsPh8APE5LpSfJIB/T4ruCNe12QVl7ne5sYNzqx6x5/g37y1e
	dC+U+7QN2p0jNi8ucF7AGnXqHw7TsHJ8JJawzG+ftWgxsHlfchvuupXslJuapfg1wjRrdP4e+FH
	yogvnJ5SVokX2B1BpmgqtzKoXohP2xjqsVmEA4b7VT5kgbmfy7pb6VAjh3FkhdFKUPiioe6kmot
	a7Bnq8u8oXp7oxha+rfzKOrsItYZMMr+CaBsk2RSEcIhCAuDFMFFyB8G2yF67GPy/rYl7FTyQde
	jRNqDb35DxIXX+lsr1JzXITp4Ei91c2YGUskrPoKPDUZRtVBI49PzQ/6I7TYsjmP3HSIgVASEdr
	CxoQiE63YY18ysJjdCX/QKlKT3QDE8zVncqIvox9dcWz4zBz4RV8BlAqOqVVlrwwPx+WCyTfBPh
	4+sAahkXrjrTapD9/oJvqYXBi06ouAGh9QflTWNTnBI08/6ckqlZJdVQM9rOyrRuUw9/SXv6UjV
	qgx76lBuA8yBMn7VA==
X-Google-Smtp-Source: AGHT+IG9gfEBhG4CyXdwCy/XFd8Cqt8f1nH/xhCvRjzV7Bk7Efm/YPkAVnD/pMTUnnkR14woTQYD2g==
X-Received: by 2002:a53:d047:0:20b0:63e:1df9:c895 with SMTP id 956f58d0204a3-6444e7ce20amr1917553d50.66.1765053089875;
        Sat, 06 Dec 2025 12:31:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f2abfe0sm3392993d50.1.2025.12.06.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:29 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/17] git-compat-util.h: introduce `u32_add()`
Message-ID: <776eb88905f53dd929e5b7cb23593976a2f1aad3.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

A future commit will want to add two 32-bit unsigned values together
while checking for overflow. Introduce a variant of the u64_add()
function for operating on 32-bit inputs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 git-compat-util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 398e0fac4fa..a7aa5f05fc9 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -670,6 +670,14 @@ static inline int cast_size_t_to_int(size_t a)
 	return (int)a;
 }
 
+static inline uint32_t u32_add(uint32_t a, uint32_t b)
+{
+	if (unsigned_add_overflows(a, b))
+		die("uint32_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return a + b;
+}
+
 static inline uint64_t u64_mult(uint64_t a, uint64_t b)
 {
 	if (unsigned_mult_overflows(a, b))
-- 
2.52.0.171.gd6a4e6b6955

