Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769947F58
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439111; cv=none; b=gpMX+ZRSFHXUDmgDHt2g/oNxSYIGB9C5/Yf0hbMV4JEV6mm5mZ0bNiL93J/B1/mCPL2o9biieYN5qF4m7JBrLpX0fCxpWzkR3LDplrbYJwJwAZ+frx1Mr1lT4wxqLQU5z2lYTucAC+uxG5a04mR+OJBGT+CK5xbV/uFK3fSZ18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439111; c=relaxed/simple;
	bh=PJvtKfLMFKRXxMYXIsU4d1eLp+QyOSaS6BdieMAUKLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3qd8LRsiJ+Ew7Q3Uf33AaRQ8Y97AOWFcoQxShuzg5jvNftSDvmFiX6bdtLieUZLQCnvcqasUqC1udOJZDX9g+BfnaVjHMucPKY8mj7CvsYIYWDHD2l90eb1yqFmxLbtSEgBjmlvqIWlTO2xbhQ/zeay7jidc5cbNAsVRLz2QNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rebp4tVj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rebp4tVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716439108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AotnOA3dFJRsRAdtubd8p/AXYapmtCEf7HP+7OF2O4s=;
	b=Rebp4tVjWA+vWwhUum+zcjRFNFNN/d1Xp0dohJ3duHSRd2VpOfVDyq0hahDTkxVdkOh6yE
	/dGqbVp9f+58wgGWZW/5Zl5ojLBKWp4/7m6ffjvYfUKMiSsb9LVODheuexJBKUAdZ+FxW8
	joTUqlEusRvp505/18+kI5FbQocCCcA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-S56PQx3kPPGd0PMFRs8keA-1; Thu, 23 May 2024 00:38:27 -0400
X-MC-Unique: S56PQx3kPPGd0PMFRs8keA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6ab895670easo12479366d6.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439106; x=1717043906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AotnOA3dFJRsRAdtubd8p/AXYapmtCEf7HP+7OF2O4s=;
        b=j1641nJh5kk1+pjOl06RIhvkVWYhjZLSWvIzm/Lf4oVLAuku97e3Q0RXsMCNQdlYuf
         5GMM92/dyxKDZwveERaVwGxxLatKHaaUSZTyTMgs4zjReiN2DE/ZyIvUgcbreVH61atq
         77YvGe+58YqFnEVZtX3+zers8WwlT1mDNZkwVusBIIDSx3OEuEuj0u97RCjSh3tFL4Ji
         i0xUOphv4nkMkyKWRBpKsFPVUq3P4SntncU59JjZExyQPrmPwI48bRCV/ru48iGzK8/v
         M4fChANUBkNFX7onzU4tNLXeUu3VczC2WXl/s++Q8fk89QC6ewMMtEB6WOdTs8/UrE3c
         RVDQ==
X-Gm-Message-State: AOJu0YytMMm8yjLt6tKhIRWsrs+CGutW066ncfdXC1YEJof/k2xhmjeA
	+UVi7gXWIUuc1EHaemeft0XlJKaIL339YCZ5o5hBQV20Porg7tdBcHVnrF7MdZXUKm0G9JsBDss
	Ziiw+CWX2rdHZUplrcy2GBFzOdmFhNg7oecwVi0sm2Y+4ffnmbJhd4aSaPd7h0HcvbmrpDbQ+D3
	G8Bf/wgaGdwd5EOJTp0jBHjNSJgSb+OUNeqA==
X-Received: by 2002:a05:6214:5a05:b0:6a9:ed54:be81 with SMTP id 6a1803df08f44-6ab808c96fdmr45510746d6.34.1716439106322;
        Wed, 22 May 2024 21:38:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKLMoGvoyAn/+1wQJCpKzVdwWtN+LeZnXccRPId25Ke28d+wEKdr9qp3TYyWWRsTem6ljAXQ==
X-Received: by 2002:a05:6214:5a05:b0:6a9:ed54:be81 with SMTP id 6a1803df08f44-6ab808c96fdmr45510526d6.34.1716439105786;
        Wed, 22 May 2024 21:38:25 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35969bcd5sm80952706d6.53.2024.05.22.21.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:38:25 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v3 2/3] Documentation: alias: add notes on shell expansion
Date: Thu, 23 May 2024 14:37:55 +1000
Message-ID: <20240523043806.1223032-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523043806.1223032-1-iwienand@redhat.com>
References: <20240523042143.1220862-1-iwienand@redhat.com>
 <20240523043806.1223032-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing inline shell for shell-expansion aliases (i.e. prefixed
with "!"), there are some caveats around argument parsing to be aware
of.  This series of notes attempts to explain what is happening more
clearly.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 40851ef429..51fa876c91 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -27,3 +27,24 @@ it will be treated as a shell command.  For example, defining
   repository, which may not necessarily be the current directory.
 * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
   from the original current directory. See linkgit:git-rev-parse[1].
+* If the shell alias is the full path to a binary, it will be executed
+  directly with any arguments.
+* If the alias contains any whitespace or reserved characters, it will
+  be considered an inline script and run as an argument to `sh -c`.
+* When running as a script, Git appends "$@" to the alias shell
+  command when arguments are present.  If there are no arguments,
+  `"$@"` will not be appended.
+** This may initially be confusing if your alias script references
+   argument variables, or is otherwise not expecting the presence of
+   `"$@"`.  For example: `alias.echo = "!echo $1"` when run as `git
+   echo arg` will actually execute `sh -c "echo $1 $@" "echo $1"
+   "arg"` resulting in output `arg arg`.  An alias `alias.for = "!for
+   i in 1 2 3; do echo $i; done"` will fail if any arguments are
+   specified to `git for` as the appended `"$@"` will create invalid
+   shell syntax.
+** A convenient way to deal with this is to write your script
+   operations in an inline function that is then called with any
+   arguments from the command-line.  For example `alias.echo = "!e() {
+   echo $* ; }; e" will work as expected, with the function `e`
+   receiving any arugments from the command-line.
+** Setting `GIT_TRACE=1` can help debug the command being run.
-- 
2.45.1

