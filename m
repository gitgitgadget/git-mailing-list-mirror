Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE98346A04
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636619; cv=none; b=TQXljFCULTitsbKeBdhmmm4k1qV+mZW/fz8CFGL7ezSsFRxZ8q9plapz0GLoib+TWLa5dvGc6QV8cEy5xi8RwqXL1idS1Ty7u12h/DpJHCx+GvPzQGy1WxYhFF0I5/PR9IiSa1x/IYArmLpDh8z6fD/jKoFeB77pHfDnOYbzZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636619; c=relaxed/simple;
	bh=VBf0d5kt+EAQ+VOLuxtA8jPJjkBbg7CoM6SSPeaaXng=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i/hrD7ym/dVTZNO/qAtW9FobZs0KjiiQqLrP9xOAKAt1Z9vonqI0zJTrfzFHZE3/L+9uCB6blI6kY6pZzTN4sdAzcSwN8mF/pPfhlemXMb6tNSP6Or72Mhmns6gw041IrwW53jaHDNWjAzKxJK2AzWbPy6KBxWN9dob2P3fd5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKAUK+k7; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKAUK+k7"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb49f63238so383334285a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 07:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636617; x=1773241417; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JWLXxDH8wwIVCNNgn4R/OJqRsQ+a3teF55qKue0eB8=;
        b=VKAUK+k70p2+FfDj5g2ur/cXDt04wtenyikhP2cnCQ3qd4uC938JSTRBZt2CZ9s+Uy
         AJsQzLz+dFht86pdPsfCXRJWCUjADpcffSIKOaXMCse4P433edUw+FofDsDXogsvOEx1
         Dy4c+2zW4jkknf5Lvnvq7UOwjj1st0GeT/JJjBtRjCqQ75YHTTMjYA+B4k71ueqR9fFe
         zVr1r+ZCplF3u+bNkQFOQXeWszyhU4soxYp03NE4rEWtFylTjLm8rHjz8DmwuDdlU6Fc
         3Rr6CY4L3Wn18ziSQa36r/f5fNP0P6VEDfmwYnH6VJG2/rIvLdc8xti+wWwMJ/wvnwZa
         vOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636617; x=1773241417;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JWLXxDH8wwIVCNNgn4R/OJqRsQ+a3teF55qKue0eB8=;
        b=BEjA48l8k76i7nVESVnBJoep3PIjoIqmGER7h9RX9I/VGpAAvq5/P3D+n2jzsSOUwY
         nqeWb8Hm1ux+nyaA28eU0L83p4fGY6HwR8x4wc/nNnsO9odlEtU1pCZA6984y1n1HSyo
         E59IvGkShdjwCoJ29ut7HcEZtFNRj+C0QooLuD/y7mR+91RVcQ0WYKWkW8Hc6mpddTCk
         0wuPnomw6XxpMy/uzEksUdD4ZjX4BWg05cbKCGIDw8sxuu0g/+zhNx/FaDaspcbKFPGC
         lAbWT4K0rYHJYMjP54+k8RYYP60Q9fH9IbPgJzOHTAAdb9fo3dEfR4ndfqZF97VN9pPX
         xAHg==
X-Gm-Message-State: AOJu0Yx6wMeiW9hgupguj6X2N+6hI12bjkdxtso+EpmlGRE1wZ6VoIkT
	vtbAG9XCoS1yjrqnJUa/cTEi82sBc2WVqjyFyPmIDvijCSTcgl5VMbFjx4Id+A==
X-Gm-Gg: ATEYQzw8uyXKtCiogjLi9aQHAQGJqfgKPsUq+s2UfVo4+2G4d/oocloqrfbjDB5Ll+0
	Q0zjEO9ARJxEHhBTAErXgZ92PD4HVN+25bpR3Bopnb3TyKkg4esf9jM1aN0rN5YlohLRFY7vZ/n
	4p7Mvq+FFjaixGyGvM9Fw3tu/jjyAWGACotpFGBHZH/Qm3UpwEAJoQyGyuApodpgQkbl8tR2maJ
	TUBSnCPmjEVOOWEBnFEISOk6vH9Kk19+A3j2TZTt3N/AjGkuwX+539FdRjlV/nZH+zBSFBSADwA
	0JBpCfqYfYbwD6j2hOYG4sMc9ZXUd5M9SBEAfLgjZ4fAP0W7sneAOBTROryeDuXYxPKOmBZANHH
	FJGSFzsxa7nt4TWUkTKXGm8cxOhNALGDZTzTfuE/nu0iAcjWsxMxhACnTi8vlywmv9lwwr2PbFt
	hvoSxV6qgRikAcukp1C4NEMZIWrOo=
X-Received: by 2002:a05:620a:bd3:b0:8c7:f55:2062 with SMTP id af79cd13be357-8cd5afac552mr238995985a.61.1772636616018;
        Wed, 04 Mar 2026 07:03:36 -0800 (PST)
Received: from [127.0.0.1] ([172.200.183.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf66b9d9sm1660274085a.12.2026.03.04.07.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:03:35 -0800 (PST)
Message-Id: <pull.2220.v4.git.git.1772636614850.gitgitgadget@gmail.com>
In-Reply-To: <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com>
References: <pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com>
From: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 15:03:34 +0000
Subject: [PATCH v4] doc: add information regarding external commands
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
    Omri Sarig <omri.sarig13@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>

From: Omri Sarig <omri.sarig13@gmail.com>

Git supports running external commands in the user's PATH as if they
were built-in commands (see execv_dashed_external in git.c).

This feature was not fully documented in Git's user-facing
documentation.

Add a short documentation to describe how PATH is used to find a custom
subcommand.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
    doc: Add information regarding external commands
    
     * Patchset V2 have spaces instead of tabs in one of the lines, it is
       fixed in patchset V3.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2220%2Fomrisarig13%2Fexternal-commands-documentation-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2220/omrisarig13/external-commands-documentation-v4
Pull-Request: https://github.com/git/git/pull/2220

Range-diff vs v3:

 1:  f90ad791d5 ! 1:  516ad65d8d doc: add information regarding external commands
     @@ Commit message
      
          This feature was not fully documented in Git's user-facing
          documentation.
     -    This commit adds a short documentation of this feature, making it easier
     -    for users to discover and use.
     +
     +    Add a short documentation to describe how PATH is used to find a custom
     +    subcommand.
      
          Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
      
     @@ Documentation/git.adoc: System
      +	When a user runs 'git <command>' that is not part of the core Git programs
      +	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
      +	in a directory on `$PATH` is invoked. Argument passed after the command
     -+	name are passed as-is to the runnable program. These commands precedes
     -+	alias expansion.
     ++	name are passed as-is to the program. To execute `git <foo>`, `git` finds
     ++	command `<foo>` (either a core Git program found in 'GIT_EXEC_PATH', or a
     ++	custom one in a directory on 'PATH'), before trying `foo` as an alias.
      +
       The Git Repository
       ~~~~~~~~~~~~~~~~~~


 Documentation/git.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..9c2a8978c7 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -487,6 +487,14 @@ System
 	`$HOMEDRIVE$HOMEPATH` if both `$HOMEDRIVE` and `$HOMEPATH` exist;
 	otherwise `$USERPROFILE` if `$USERPROFILE` exists.
 
+`PATH`::
+	When a user runs 'git <command>' that is not part of the core Git programs
+	(installed in GIT_EXEC_PATH), 'git-<command>' that is runnable by the user
+	in a directory on `$PATH` is invoked. Argument passed after the command
+	name are passed as-is to the program. To execute `git <foo>`, `git` finds
+	command `<foo>` (either a core Git program found in 'GIT_EXEC_PATH', or a
+	custom one in a directory on 'PATH'), before trying `foo` as an alias.
+
 The Git Repository
 ~~~~~~~~~~~~~~~~~~
 These environment variables apply to 'all' core Git commands. Nb: it

base-commit: 2cc71917514657b93014134350864f4849edfc83
-- 
gitgitgadget
