Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE22E57302
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705697959; cv=none; b=MH0HrUS+SsVNDv1aXl5vcmtikBjcEXIHo8Wi99+XrSIj7Reg+62JrU0dqJXOGD/gasOwE2vgYyG7KAT1q3xbRemOINaA+n2xrUZTosqkWCpLZlEeT7QfdFoLCwoppdeCTB/gszwr5/Cq4rlEXOTju+T5gR7qValJa7l3b+bTJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705697959; c=relaxed/simple;
	bh=U1Vk69A3LSlj/+N1ZUpzZYIwLegTNtLG4vT2rPZ6yrQ=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GtDu7t7JRHY0VnA53KTZZSgOf2K2yZW6MlPbgUG4Nbli83H2Xw2q2FTEKZotjRs8xjbdWacx2aGHinM6PdnbZEPt9L4n1yP1dU6aU0RPGs4P8Vo+5ZTUpSQntogFlDVU9yf318LjVhF1Uk1HNI+ro09C9HNsLWNmzvvfGNy5uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/8/FDt8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/8/FDt8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso12924465e9.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705697956; x=1706302756; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pEe0y+a8oEFxuwy1r30r2zFShvqnmflZNrtvRal+42o=;
        b=W/8/FDt81JZa0gHKQHFgsMZCSRaRZ2Wi/CKkn0l7pbBlc87FxT1ZlamYdXiUqozEDG
         M2aJ2Qh30w3sibbqPsbLiGFefKqthBh9Vd5F2fCoLpRQ+4spa8PzowF/XYf3PlrX3KP/
         GW53JqNDG0m/exPpYp7l44bHzCy8IQlcJtIGutV9Wkn1EMbYazgRNoz4GInM+g90j5PA
         BX1bUzVJM6pT2W25L6necpunxyDJeo+fMtytxvVqML9eSZExjffaCGCtsNE0dq1jmznL
         nvbLvrknKGwNfRbBoK6Od/oxJJNuj1Ip2gzXdpjslfYj8VwJpemsLF+6lawPaLVAGvUb
         EiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705697956; x=1706302756;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEe0y+a8oEFxuwy1r30r2zFShvqnmflZNrtvRal+42o=;
        b=KxlHhDKIcKkEbPMLmpZmCNxhdOjMapmV4OozH/A0iBTPWQRVtWozJ+IUzA3v02VJ/I
         ob1DAnFjlY0TFK+Fjfc7gaQ0UT07hOIr4BQk/rIkKtIrmuMfT3+mfG+QCzy7aEKB2IRR
         QYsJ95d4RoeYmepYC1/QWp5aFyMH/ddcAcOhyEBP30KBfHe11l9TWvtkKkqaXZXVyLWl
         FWG7ErFQMOlHu+tHbhDis/Cr3YFyJnPSTgjb5InE/uTvXqEbMgYgL3oWbUW4HYjei+rK
         8YLxwLOO0Fw2n0J7Scvla8WS5VJWotOx+AYKQ9frtpetjgKWMqwwNNWZyQHTTr4j/tkA
         LJNA==
X-Gm-Message-State: AOJu0YzXEBMNPRzmvDqsdCAjJTGWnG89UpOTgY61APm0h2fB7WJfOez1
	0weMzT5/9EEph+1pQcXBZaI4Dxh3m0+5kN6a/9eb/yilwcEkxPj5IOpzvEqB
X-Google-Smtp-Source: AGHT+IEm1gYBRdur5+P/ulXfk4vvasuLGwJjTugj7kzZy2XNzCtZV127L93Gl+7xzP09wC922MjOcw==
X-Received: by 2002:a7b:c4c6:0:b0:40e:6ca1:b0d0 with SMTP id g6-20020a7bc4c6000000b0040e6ca1b0d0mr223879wmk.53.1705697955854;
        Fri, 19 Jan 2024 12:59:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0040e48abec33sm34022061wmq.45.2024.01.19.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:59:15 -0800 (PST)
Message-ID: <pull.1644.git.1705697955144.gitgitgadget@gmail.com>
From: "spectral via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:59:15 +0000
Subject: [PATCH] MyFirstContribution: update mailing list sub steps
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
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
    spectral <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

The documentation says to send an email to majordomo. Doing so gets you
an auto response saying majordomo has been turned down, and to instead
visit https://subspace.kernel.org/vger.kernel.org.html and use the
sub/unsub links.

Update the instructions to reference the supported mechanism for
subscribing to the git mailing list. Include details like these being
mailto links but the subject/body aren't necessary, since it's not
obvious what to put in those fields.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    MyFirstContribution: update mailing list sub steps

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1644%2Fspectral54%2Fmy-first-contribution-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1644/spectral54/my-first-contribution-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1644

 Documentation/MyFirstContribution.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 279f6a3e7ca..2361fe27e97 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -35,9 +35,11 @@ announcements, design discussions, and more take place. Those interested in
 contributing are welcome to post questions here. The Git list requires
 plain-text-only emails and prefers inline and bottom-posting when replying to
 mail; you will be CC'd in all replies to you. Optionally, you can subscribe to
-the list by sending an email to majordomo@vger.kernel.org with "subscribe git"
-in the body. The https://lore.kernel.org/git[archive] of this mailing list is
-available to view in a browser.
+the list by visiting https://subspace.kernel.org/vger.kernel.org.html and using
+the `sub` link next to the `git` list (this is a mailto link; you can leave
+subject and body blank, but you still have to send the email). The
+https://lore.kernel.org/git[archive] of this mailing list is available to view
+in a browser.
 
 ==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
 

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
