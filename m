Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F5429827
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557344; cv=none; b=uHys6to228co8N8zflvywDQjkbOJh3Lvoa1rP2Zm9FQHIwBk29Bc8xQ1OAcbF5vc92X3v4BNG1TdPaguvPKIRuzMmB4Y7soLCrZjVOic7whSuR/XoUKaLwF5IUNrMVQpfowLPjfEJu3OeYFJil0i0G4PBbLGCJMSSTDD/i2C8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557344; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ET2dgJaAk7CpDcs/Vj+fJpHkK6sfAt3KwbxTaStCdnJEVn1xQaQZnN8Nobgyo4KjTven/E8fOiJEB3QliBeZfZMPIEg5aZ3WOVPHtxv9W6i/++pFItp2eLF/RjeKaQTXPdoqwtWpKmztg30TtdGZuJ5T9joOq6W7MOmyYgq50t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWPWd4v6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWPWd4v6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so549275e9.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788557338; x=1789162138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=LWPWd4v6awVgyECFOX8gpwBzoJUnatyA0pmxMHzilavZRgMIexzp90B8HZJIdfmtW+
         xHZdD7BNoJSaKsUOacVa1cXPoUnqE+xKG92huMOglbfAziTdq1EQrx/zb8g1sGx29RTf
         Lx/uoUm58T/SAXW8PpStSk5QmXib29xHdkiVrvMF7F5caycBB9Me5e1y2VsQjkEvE4Q2
         xM4ReXBmDnX0gU6lzIXhUEiZnlJuhd0Ba74Jn6vpSBZMqsTGQAUmPt+bZ6JB13D8ZLu+
         HKDqpt8quYXNmGCA8LlS1VbVJlx4HEi559oulZ+1udIGxArKxRsJ3ZG8M3Ue4RyJ1ZZD
         JY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788557338; x=1789162138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=aVb0sTtgNrt2KFWzujdCeJ7rTgikyPlifaGnyCRXgmw0bWTfj9U4ur0oB89B4OckCM
         sKZg4mSIrL77ffYutuDvJq4bVgGafXoyGSOiyUKoCR8zgmeX2Bipr9OU2lcOymnKxEqv
         n2Q5QkhgJHdadS1U+aJUt8j17DIE4kzKB9CGl37k0McyQ3jJQCkT5A+wkCberJ/SMTPr
         QrpRe9fBYpaBSvCU+r7XymM/gJT4+F8pUnnfMGlBycZ+iHNTDQsYBaBGmb2LR4SxBxHg
         CUsS25+0GqVZFKPf+wSd8tTwQtBs49RRPwjDMS2J3HtR4cQd8uhpSHKYxNJlIxDX4WIM
         IYFQ==
X-Gm-Message-State: AFuF++n2eyMUpELFMA1u/+GAiPVT0srYkLebqGaa0rznRAqkMGvAPOcX
	1+VQ3dHH27f1dU5zd9gfKOgV8l0XfBFCrkXm2q1wh4iwsCFWqwaL8d2N
X-Gm-Gg: AYBFou2kArB/enpMPy+z9cgm6NAk+Hg9ZuRz+BbDl3m9spFjESPfBocIYEgUWnxoBQj
	RXTIxFiMpH6UuXgNpJRsJ1Kse58oWcXUz3db1g1d17UTPa/pISAkK4pTZsPwutujgTzz0wJfds4
	vqv2ZUlXLisdz38EKAZQUB9M7z1Ksyv3NvOQ9Ot5v2eT4XjGsre7iDAm70C9+iPbAv+hBFj9S1Q
	iXw0M6C4LMXrQUCVZEO2r6ES7bHkg4ZGwMOuGnS7v0j7Kd/tjijUMOhOfKUFjsq6OnVBNQXQ1b1
	Epec5FQeP/ai+2rVBYWEtP5d4aIX3T3P2Kh7bcAQCnkVj0R8MkiNdwpzNxRP51JHCQ0ydE2GYCA
	kNotL4Bx4FLEgNHyLVqMlXro+j6xVHGKqsjhzEbv87tKHJVjmx5IATlcBD//XxmM0lcjcTe6BRw
	tOx3EDK/hIFOpUvHqaxbu+c7emWXg/LGAZ8E8OPy/xHIJVxIRgIH8abKIFtsxp1WSbiWZFEjItn
	zy46LYeMUBJDngXI14OzQaudA==
X-Received: by 2002:a05:600c:8716:b0:49a:a101:4157 with SMTP id 5b1f17b1804b1-49cf81f4924mr82287445e9.7.1788557337800;
        Fri, 04 Sep 2026 14:28:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1faf:874b:d20e:6b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm8820051f8f.23.2026.09.04.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:28:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 04 Sep 2026 23:28:49 +0200
Subject: [PATCH v7 1/4] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-758-introduce-hook-v7-1-6c66f0a3a572@gmail.com>
References: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
In-Reply-To: <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqbOBW28Ebsmyur1njesxXxC17kCyiNrCRzr
 NkrRqTTonfRKIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmzgVAAoJED7VnySO
 Rox/9vkMAJg51AS7acXIxVFD6Z/ewmknNPjsfxfnxxJzFcXsFuyukqV/QyXWeFbkmNpaUl/Mfo9
 b168PGvEBUrX++mGoF5MizEFBzWdl7vkmW9u0LaqrN0lUFHOHDKG/9tcOOsVtKbevJyQB84IP7h
 tXzzGwnjNbDYDOQGrUk7oK3b0kAcKYS3wY0tgJLXoI7fVWD+ZhyvjJWW4lsFQYSXpMyESmVdc4U
 /+mJTbCchUTnX10snAQ+F7ppMWvvsr5wStvnovOi+1O6DKj6iS+NkNl14U1h0Yph2UMJdcvaiOU
 /j7UJoOfM7o3j+dNSsq9CGgtMNVr2EgaLWjYyVMfj2Lp5c51JAXmle8Z6YyAbE8aU/rwh2xmF1K
 XopEQrc3OgoBFYGDyAi7ie8UGWYVLeIGYednpqpwiltBDdRBShgcM42XldqDq2Ef3uWrXfPEeC/
 6U6ZU4SFfx/Xe68cql5ZmE+hmObCRnrb1ohy7bnV9exw5wpqyrbL/SpEYAAZFZcrhUzOML9SCo7
 Hs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

