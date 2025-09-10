Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986692D0618
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531678; cv=none; b=YPNrFUNLPoNI7IZ9Og4tg36cDMrmNW0YrEBVYdMlFVxOQa8BRUIaiWNz95DfVyK1t6t10NavZm3frgnfToAyOGa2L4SxUhL6gVZccSjyPJaVM0W5CRkHqCPk92l1SIlavcNQSrB9P9LUk8HinYAoMlPdDaQuE3NrJ0oYAKalc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531678; c=relaxed/simple;
	bh=mZ7TuU5uL1VMwecxrVcnD5DFp2EoY+bpejF+gxqud08=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vd5wSGwUezcDKQ07PSz8fNdJieXiCjSWSXgloBu+UcXcBv+NmDNXIr6++KFa1HKekxTOe3NtkRIy+6ri94lDqzK21UStVaFCMUM3mMAJoMy92VTfVPz3a9hFP47bdy2J4nISEvSD7BA2EtqsJS661bkZ5kkxg6W+cVuckEqJOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koykACCu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koykACCu"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so12163015ad.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531675; x=1758136475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFxjJ+riIiG6j9Y8J1OjH+ieXzF6uKGsoqnI46asf9E=;
        b=koykACCuVtKpuQYIJgHamiXUroWEcm4BwS3aX9KALFTR6h+9hB8Z90sUWNVxu5e/sw
         Lvw4eELTxkEATIaF+k+ziKviQc7Vt/M+pJ5lNyzxlw062rGqbwU18RthLpIWG+2kqQLo
         oDHnJQgHIT+YjV0ZU0gaP6I6DGVe2++8F3fNTo2GktUWEe0pkgFYlUQtk9k9XGNp8ygz
         WM/a4V8mpQJl9FhMHVKPXISV6pvCkKYhJEvahXxx4h90bBXMDMmMqFA7CwR9bqap/YSj
         xJejEg36NDhqVS+bwKOWcNGPpaf+m/YK0WseEunUzylOWFYsB/K6JqPvlIxAp7Do+/MQ
         yNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531675; x=1758136475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFxjJ+riIiG6j9Y8J1OjH+ieXzF6uKGsoqnI46asf9E=;
        b=Hp7YEGY/FPw8jY/DP+QlUYlK2NTig78+X+vWTcjclgqgpuqo/na0RuJEQi5D65Kru6
         zkGep2EvAi3LciJMXEAQhEx/ov2oSGjSKJTXvg/wfVWI/D52rgf7xv9WNiuLU1yUD9/E
         BALOPEzEhW3+7EGc/psv74hxPwzUZgtqL3NIQwiQ9Uj8tKUTRtEZ5XMwxXBfnjIV8t6W
         oohrl0cFdus/xPkdByWYhrv+0v1SvmQocBWR+0YbOjv0lMBvevcVZrIIbtVOyAcxTkzm
         8tTCueLTVCJhvRQPgnpkgqud7XnFyVaWQgdVKgVxNhVR3NULt3emYYRj2ZS+wEqZ/mSn
         IROA==
X-Gm-Message-State: AOJu0Ywvwz18tqNF29pDlLzkcunMpQIp4VRe1O8+6NvR5WAX8hu+9WIE
	347EIGE41qgPNp2IoNV6HBJK7hLZG3+jjlQXx4zp8RrPIk0Xs0ZAOOB/vd7m6g==
X-Gm-Gg: ASbGnctcFJqc4AONPxWx0hf+wRvh5IOKe2NfePtacqXLWZeUVUzlVlw6UiEJ6e8dSLF
	sWzKsdYnEjRAdm23V8IwAC958F8vsIM0gVUnANg9H3Gcs4I9DNHkcAP0YYwmOzNcsIILmWn2Rys
	eO2A1Vl9oZDCkeC9ia23CJbk3lcoe30hsaeby1Y8hB4zmTF4jl0IHZFlC9CfGW349vJcDC2Jvyw
	7+cPnBOyFDye1lnLYDAnCmthnRN4ssD/kBOklJPT6fIqy4wgrBbNN3BwmTiyOGw0K2CvqevLyzG
	9q99QK3qe8JDwgIcctjhWUJVFf/31qUebQ/m4Q9JdaIrbwH4LAOV8ehqr85BstIAlCX3pMv36+W
	nMhpjvum/pqn8JP+c02HLrt4BtmM=
X-Google-Smtp-Source: AGHT+IGVmQtryYV4k/cOgAzP0Hwsm7+qlxVwXC26ihsSaF0eXS3GI6tM2KRTJmXW/3cf3to7kWt5Ww==
X-Received: by 2002:a17:902:6a85:b0:24c:7bf0:6e68 with SMTP id d9443c01a7336-25babf09fc4mr5955685ad.7.1757531675333;
        Wed, 10 Sep 2025 12:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a3449f7sm34870425ad.88.2025.09.10.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:34 -0700 (PDT)
Message-Id: <551e56dea6c5a6381f5f2e9fd81882f8104ef233.1757531669.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
	<pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:25 +0000
Subject: [PATCH v4 3/7] doc: git-checkout: clarify `git checkout <branch>`
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: several users commented that "Local modifications
to the files in the working tree are kept, so that they can be committed
to the <branch>." didn't seem accurate to them, since
`git checkout <branch>` will often fail.

One user also thought that "... and by pointing HEAD at the branch"
was something that _they_ had to do somehow ("How do I point HEAD at
a branch?") rather than a description of what the `git checkout`
operation is doing for them.

Explain when `git checkout <branch>` will fail and clarify that
"pointing HEAD at the branch" is part of what the command does.

6 users commented that the "You could omit <branch>..." section is
extremely confusing. Explain this in a much more direct way.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-checkout.adoc | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index d6f4044a09..0db32b098e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -30,11 +30,11 @@ DESCRIPTION
 See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
 
 `git checkout [<branch>]`::
-	To prepare for working on _<branch>_, switch to it by updating
-	the index and the files in the working tree, and by pointing
-	`HEAD` at the branch. Local modifications to the files in the
-	working tree are kept, so that they can be committed to the
-	_<branch>_.
+	Switch to _<branch>_. This sets the current branch to _<branch>_ and
+	updates the files in your working directory. The checkout will fail
+	if there are uncommitted changes to any files where _<branch>_ and
+	your current commit have different content. Uncommitted changes will
+	otherwise be kept.
 +
 If _<branch>_ is not found but there does exist a tracking branch in
 exactly one remote (call it _<remote>_) with a matching name and
@@ -44,10 +44,8 @@ exactly one remote (call it _<remote>_) with a matching name and
 $ git checkout -b <branch> --track <remote>/<branch>
 ------------
 +
-You could omit _<branch>_, in which case the command degenerates to
-"check out the current branch", which is a glorified no-op with
-rather expensive side-effects to show only the tracking information,
-if it exists, for the current branch.
+Running `git checkout` without specifying a branch has no effect except
+to print out the tracking information for the current branch.
 
 `git checkout (-b|-B) <new-branch> [<start-point>]`::
 
-- 
gitgitgadget

