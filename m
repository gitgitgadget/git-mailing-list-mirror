Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6B7764E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707314252; cv=none; b=AZvk5ZD/O4Fzx7dIjvaY8XDDiOwYana+wexozQ76QbakHuu0cBNnI4Eh6a+U1vEVPQuhox7RgXc68QlSh/hGJp3f97+DTgqAST7Vr+EuhuNTteOIinerEtuAyDhZmUDSojDZ4n5843EGHCmW46EzVGtftm0k3JdhG4jCvxxw/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707314252; c=relaxed/simple;
	bh=PmqHB5y5U446xv7VWJvWV/3yhGd9WE+lVTXi/DJGO2E=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P51/pGphF6Dz2eaP154G42fLPYZcbYXvD0lyhCcOc64RdyGcfy/RwU+L5GN0XZ7xuR0vaaG7txoHPWhHAaYe+aBTLgRQmqY/dCxEDPmcSnVCwbs11Lxov22cI0+cGJw8UH6RHFcw6P71kOfr6O3I+QrjNeLErCw4Jc+u/QucSiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kr+Zk1+o; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kr+Zk1+o"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-410177e41a8so3665105e9.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 05:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707314248; x=1707919048; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3l94OWSY3OZlmacbpR3duYObjxr9j756/7RhSLSdP5c=;
        b=Kr+Zk1+o5cTKecWeKYiYW8erpPX12+7DCqF0joand11mWER3fxJknbUQVat6tenCQN
         +1QubUdHwtXXWEXT4xHs2BdXw0T3Qy+ZVkqYcMbZC8O5+LvLhurTKzVjH4AXNO30uT/a
         xd7/EYIyHQuKgybItvyzBUDFhtW770rZNqfTUdL+rQxlLZ+b8uViNGWIEVczpjouzboS
         syl8LHej1K7xyx/dvFe4hFXFizLddp2upBMZItEEq7hh7fHFRVCLNMU7yNKh97HMn01F
         vdzlrjcil0nyvllDx6VblsJ+y3oQ/8JIng13J9l+eBbdrzRLoc9AVUYXa8YtVzWFZyEw
         7IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707314248; x=1707919048;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3l94OWSY3OZlmacbpR3duYObjxr9j756/7RhSLSdP5c=;
        b=XT4QhDgLgMXTlamon1wwYRiapnsYJgziSAZsGxphHQuF7FB3H0aLfK33XU775oIixB
         RcvUTf+SAjzWZlPYS8FozO6pmmR5ym2V7bwDaPAFjNv7o+3WRcB2EM5ASNiLkZaPi9C2
         3aibrPLlzCbFdLC0yf1nZ1uxxVoomE0Me8ZBdXNS9oBqHFKj+2xVkEjbk4Fa9L/QQRBi
         FXFC3GcOtIoROeJH9rBfiVdiGJzbVwigjfm+Vaw7B7iMv3s/abAJENEfbS5TWEOnYxIu
         m2fZboTHcASj2ElThlkJuc8xi5Hvo2tFhqBeXVFKuK0P56Cp4EnScpK3v5CfLC2xDRbb
         L4lw==
X-Gm-Message-State: AOJu0YyfHq8lflfrHs36jD4+Qk6MNFt1HnesLCXJCHbNpDV8suuG2xZr
	WCKLkJ0ctG8h26EnfKiGzVUrcAVW83nL1q0NZ3wbFNTNRs3Riq5gO4Dw+/j5
X-Google-Smtp-Source: AGHT+IFH0X3K2PMwxWcNFh7QaoYRnDDwU0GcbrefBz06VY+i8+L8vLB1R1wBerKG59oaqMYmsCnUlg==
X-Received: by 2002:a05:600c:4587:b0:40e:38c4:e7a0 with SMTP id r7-20020a05600c458700b0040e38c4e7a0mr4012904wmo.30.1707314247843;
        Wed, 07 Feb 2024 05:57:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVepx8dYfniH8MWRgq7qaHQIUXO2dj8ZE4RniOWlsMCognTugvRrF3mjvPHE5HnqezkdtQ1+6wczhh58MwbpXV7PF7cbDi+ddQzdbVPxxlofszhjEKiGXth19brqpnUZ3/lOXgq2NqNqz88NQlXzEaTpkui8ckquG1eYTgY
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11-20020adff2cb000000b0033b278cf5fesm1568130wrp.102.2024.02.07.05.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:57:27 -0800 (PST)
Message-ID: <pull.1652.v2.git.1707314246530.gitgitgadget@gmail.com>
In-Reply-To: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
References: <pull.1652.git.1707153705840.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 13:57:26 +0000
Subject: [PATCH v2] commit.c: ensure find_header_mem() doesn't scan beyond
 given range
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kyle Lippincott <spectral@google.com>,
    Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    commit.c: ensure find_header_mem() doesn't scan beyond given range
    
    Thanks for the feedback, Kyle and René! I have update the patch to
    actually solve the problem at hand but I am not very sure about the
    resulting dropping of const-ness of 'eol' from this and how big of a
    problem it might create (if any). I wonder if a custom strchrnul() is
    the best solution to this after all.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1652%2FChand-ra%2Fstrchrnul-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1652/Chand-ra/strchrnul-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1652

Range-diff vs v1:

 1:  1c62f6ee353 ! 1:  dcb2de3faea commit.c: ensure strchrnul() doesn't scan beyond range
     @@ Metadata
      Author: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## Commit message ##
     -    commit.c: ensure strchrnul() doesn't scan beyond range
     +    commit.c: ensure find_header_mem() doesn't scan beyond given range
      
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
     @@ commit.c: const char *find_header_mem(const char *msg, size_t len,
      -	 * at msg beyond the len provided by the caller.
      -	 */
       	while (line && line < msg + len) {
     - 		const char *eol = strchrnul(line, '\n');
     -+		assert(eol - line <= len);
     +-		const char *eol = strchrnul(line, '\n');
     ++		char *eol = (char *) line;
     ++		for (size_t i = 0; i < len && *eol && *eol != '\n'; i++) {
     ++			eol++;
     ++		}
       
       		if (line == eol)
       			return NULL;


 commit.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index ef679a0b939..9a460b2fd6f 100644
--- a/commit.c
+++ b/commit.c
@@ -1743,15 +1743,11 @@ const char *find_header_mem(const char *msg, size_t len,
 	int key_len = strlen(key);
 	const char *line = msg;
 
-	/*
-	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
-	 * given by len. However, current callers are safe because they compute
-	 * len by scanning a NUL-terminated block of memory starting at msg.
-	 * Nonetheless, it would be better to ensure the function does not look
-	 * at msg beyond the len provided by the caller.
-	 */
 	while (line && line < msg + len) {
-		const char *eol = strchrnul(line, '\n');
+		char *eol = (char *) line;
+		for (size_t i = 0; i < len && *eol && *eol != '\n'; i++) {
+			eol++;
+		}
 
 		if (line == eol)
 			return NULL;

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
