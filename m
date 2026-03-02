Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49C53112BA
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479910; cv=none; b=uh/Je2Ng8NYOcfeVcXa2Al1FPV3bYl668aU8QW7wgGWZ/vlj9r4CxpP8v7rZwJPemnUU7/gynd5/TF+C3ZyoIW8PQwPcJgfQ7fqEg9wq3qU/fauGgy/sac0qvTVk/MvwNn21w3BM/jVb+zkxS1sBqiJP9x1OYAEJSzOKfDFFKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479910; c=relaxed/simple;
	bh=r1cwmeVZ2S5HIz8yn4pYjW26EktNRAVl6EG63qd6dis=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jWEFled8hlflihwUHkNjpOVVWci+Vm7GEFMDxE2a/J/g/6O/v0Gfbvf4hjWHjvYFZ6fVGuTZs5Knxs0+jl4ZlENsY/5wEzjdQfJySnGTRJAtUr4FaTQs6k4R9R85PJCU27/X09gXhG6QugDXHvDGDG1ZEacgWU3yaES0iYsC36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGLu8EvG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGLu8EvG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3bae8d3eso446752385a.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772479908; x=1773084708; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GHL1UjHP1nYVykd23bgfBImcHMi5WfPo/7bl5AU+n7Y=;
        b=NGLu8EvGOF12e+Cyi3GJ/+dExCMhHIu4Giwm4v/CeVnpoV3odvvGfUfDYS66847END
         WDZWF9jiBKk6YZcbMJYLCnwPTDpc+slQsowp0U3U3NtxdIuiyaZZSh8j4hrSH3+NDWNg
         JpjViMuUr1vWwAn/+jwbZMxcshB7IY4NkPzsL2wKMYHu4EaUGKUiIJQzSvYkEr8MB+9D
         MadSAQjYHjHcXikgzYbspqKCqWPbYi2bB/u1MJPlQt7kH+NubvhRK/TCHZery+1B+Lfi
         YkLZW8IwbaOlrnlzqTzu7j0G+YapOO028DT4rxvdT8sFRWGgCEjWyR8knOiXnddl2tD9
         c4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479908; x=1773084708;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHL1UjHP1nYVykd23bgfBImcHMi5WfPo/7bl5AU+n7Y=;
        b=vcqGOFgUw89H/yVmm4AamzL5rtH/zTeAmhmZjGv1gWBeV/LkcqhfofJw6jT7xoNpjb
         tkMtJKgKdbyDz1lpEsRNnuSOT68eUVMywMV/7j5RNsADSrj+xu0MSRcPp1cwIlwakEHy
         xQ0pXPA74XOIk7ZtmZGTEPRlBvdXfVQ+IKsY7K12/JconmLPCIj68l53F4P/iGfaEa7l
         jydXofPflhxOPpjPe4FrNMd4DB+mjaHOpndBYISxaUVl4tidBcPf1isq6Vh/6TjTZ4bb
         6v8Y737mLnmqeP4SJIrx8EJFONXyya0jdQ/BqKAJqq3yNUc47UH4lst1P6LydsPOo3hb
         6dEQ==
X-Gm-Message-State: AOJu0YxqL1pI1FoUYcY3Uaa9vO4Xkg2pGZvSR4mHNdXj2izyo+HbfDgg
	3qoaMaJenfau16TMM7QN3p+LTA5YSPTx1AdyGNrsPvAG6YSksR7lnVz8/vP6mA==
X-Gm-Gg: ATEYQzyT/QUuqHeCu1cwCxKAyjor4rwt/h+QCoIgm9brBEdgHzbaNAyPkMXsydkWmwC
	sYQY/dbuDNofCezhgXMUSPeG5pMUYrcQesJtbcbzIfti4F/HXqco+qbq4U5BNebTm/GZJQIKZ9L
	voEsJZ26+OXLZNAQ0Os+oReux0P48MJHZxd3Qz4gkX3Wan5s9VzWjvr7cZFKaDsYFeHh1FeVntt
	GMVZihA2uCM+fZWt7pKxDnxayffIy429vUZ15LY4rCKM9/bPNyqBmGpj6HbBv7HIRTxfCLtUK+f
	MsZsK55Hd3aitsOZQrBBj4Dg+mmhrLH5xIBcToOgL2PSqHGpGnkLUBkT1tsqal1Wg60AkZSRxvB
	P5pO9+OKOfK4AXZfu2GrC3I7Y71kbZnQ2I8UgoEmxxgT+95tXDGEAaO5fs6jAqViwqUSqBOMK9V
	OiLXv8bSKJs+1GMJsHuHV6zTcUR6msTN5bhvw=
X-Received: by 2002:a05:620a:40c8:b0:8b2:1ee9:dcfb with SMTP id af79cd13be357-8cbc8d70f06mr1482255185a.8.1772479907969;
        Mon, 02 Mar 2026 11:31:47 -0800 (PST)
Received: from [127.0.0.1] ([68.154.116.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0485ca0asm12310876d6.11.2026.03.02.11.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:31:47 -0800 (PST)
Message-Id: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com>
From: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 19:31:47 +0000
Subject: [PATCH] doc: add information regarding external commands
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
Cc: Omri Sarig <omri.sarig13@gmail.com>,
    Omri Sarig <omri.sarig13@gmail.com>

From: Omri Sarig <omri.sarig13@gmail.com>

Git supports running external commands in the user's PATH as if they
were built-in commands (see execv_dashed_external in git.c).

This feature was not documented in any of Git's user-facing
documentation.
This commit adds a short documentation of this feature, making it easier
for users to discover and use.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
    doc: Add information regarding external commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2220%2Fomrisarig13%2Fexternal-commands-documentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2220/omrisarig13/external-commands-documentation-v1
Pull-Request: https://github.com/git/git/pull/2220

 Documentation/git.adoc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index ce099e78b8..da7c1329da 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -345,6 +345,24 @@ users typically do not use them directly.
 
 include::{build_dir}/cmds-purehelpers.adoc[]
 
+External commands
+-----------------
+
+In addition to the commands implemented by Git, Git will execute any executable
+with the prefix "git-" in the user path as if it is a Git command.
+
+All parameters of the invocation are passed to the script, making running "git
+foo arg1 arg2" equivalent to running "git-foo arg1 arg2".  When running "git
+help" with the command name, Git will invoke the man page for the given
+command, making running "git help foo" equivalent to running "man git-foo".
+
+This makes it possible to extend Git with custom commands, without the need to
+change its source code.
+
+Git looks for external commands after looking for built-in commands, but before
+looking for aliases. Therefore, if an external command have the same name as an
+alias, it'll run instead of the alias.
+
 Guides
 ------
 

base-commit: 2cc71917514657b93014134350864f4849edfc83
-- 
gitgitgadget
