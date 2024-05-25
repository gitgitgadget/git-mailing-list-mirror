Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C54127B5F
	for <git@vger.kernel.org>; Sat, 25 May 2024 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716680713; cv=none; b=XaVn3xKD08GT6zzlrbzyC85Rvp9Zz8Z8k/NHhNgkBciaiBZMouVn7As3LavNjb8/tYYfEpE7kxvA6aaFXccmAQBfrYJ7/mkzSP0DfGh9JXMuORzEXVq3ZC7yucXJ1nrooXPIHf8Bmy0cD+Sw6WbGXBasMjaHFJ4oH2peX3UEPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716680713; c=relaxed/simple;
	bh=lmqbNgGMmABTQP5nSU3AMvzls+Vfe0MU4r19Mys/S7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+xipyPc42K+RALRhU53yfZfxX9Nu/GvhXPTmQwDWCt892+KeZDU0mfr3d0wFFsojZlQX+fRfl52rj5kQYAvaw6wxnUKL3BpgEpgGjuuR5OSHZlOn9i8ak+0F4aNVFL6suvjdwRZq/S4g2c/6wPr69u1SQIfVIaF+PLPt5/dNms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BiRxOnsE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiRxOnsE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716680710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HA6j17gQrsO2y+zRbGT2fkxHEsbsSXgNNVrSzERTX+0=;
	b=BiRxOnsEw7Q/hJ6EF1b9IShO2RqD5UEXSIMhKkhsWqcYJj3LeATLHSDHeM2ioQvFjR9xNY
	86mLQILlqDuFScJzr7Bt2DCARX7PzEw8/8ftWQlf5/GeQiBHpPJ+qKSIhkli8hmOpBo1jI
	bcjyfYvDvn4sOZ1OHuvKxlM+RVXDxpU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-AMvkHxl7M_yl1amHu2sJnw-1; Sat, 25 May 2024 19:45:09 -0400
X-MC-Unique: AMvkHxl7M_yl1amHu2sJnw-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43fb0949d28so33746911cf.0
        for <git@vger.kernel.org>; Sat, 25 May 2024 16:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716680709; x=1717285509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HA6j17gQrsO2y+zRbGT2fkxHEsbsSXgNNVrSzERTX+0=;
        b=SA3jSIc+o/r3D/8TpQK6q9A+UafNr2s+fvE1NhX/8tiFOW0wZDqOtIY/pM4BaGUFKC
         D5w9Z8NUNyOKcRJvO+MPgixc5WRf0N0XbMSDkwTINLU0rfyt3n8VwnodV9awaGiQuMrB
         bXdyboj3GgimWMky/DPwIei4KlX+D4tcMylce8NEoI3g0imOH3W9TDiTRF/MNO4Lk0KZ
         0oGsNayx8argjBaGrhAzf0QSenzJ1+Per4Sa+M4EY//NjxbhKG9qcHJ01UlGZjhaS3Mm
         MrlXwqvRUMtY8S7HgngviaPTJxfVpWFTTBVryZSXCHmYMI8k/Cx+OrQMgB672wVR8v4d
         P3OQ==
X-Gm-Message-State: AOJu0Yxe5kdS+URdJPmBmPkIGrZYrLW15tYzrot9EqbykX79wpSNlMU3
	eq9PaiHBtE83bxbDKw5NMoFusdOCwj6JAWLpvwGLbcXFLVZloxYI6A+C7fbZvR6LmrSu7Tz2Qcv
	CP/yXHxQfCpTI3b5KHapSP/iX0/G5o+Hh2XiB4jD4RXg37/8xTJxCq4CmjiZLf4LennFN7yjR3D
	InC3YxPOrOG/z5m5OClqm+Yx4TM0sII/DgpQ==
X-Received: by 2002:ac8:5781:0:b0:43d:fd98:78b4 with SMTP id d75a77b69052e-43fa746b344mr168227281cf.17.1716680708525;
        Sat, 25 May 2024 16:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCOAzLpsQl5T0EfwJ6ySBBlSqNpEur7qkFHuCPQZsTIqirZQj8ynHv2qN0JMYETj1fJDT1mg==
X-Received: by 2002:ac8:5781:0:b0:43d:fd98:78b4 with SMTP id d75a77b69052e-43fa746b344mr168226971cf.17.1716680707909;
        Sat, 25 May 2024 16:45:07 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb182c636sm20553761cf.52.2024.05.25.16.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:45:07 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v6 2/3] Documentation: alias: add notes on shell expansion
Date: Sun, 26 May 2024 09:44:34 +1000
Message-ID: <20240525234454.1489598-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525234454.1489598-1-iwienand@redhat.com>
References: <20240525012207.1415196-1-iwienand@redhat.com>
 <20240525234454.1489598-1-iwienand@redhat.com>
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
 Documentation/config/alias.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 40851ef429..f32b86cde3 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -27,3 +27,31 @@ it will be treated as a shell command.  For example, defining
   repository, which may not necessarily be the current directory.
 * `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
   from the original current directory. See linkgit:git-rev-parse[1].
+* If the shell alias is the full path to a binary, it will be executed
+  directly with any arguments as positional arguments.
+* If the alias contains any white-space or reserved characters, it
+  will be considered an inline script and run as an argument to `sh
+  -c`.
+* When running as a script, if arguments are provided to the alias
+  call, Git makes them available to the process by appending "$@" to
+  the alias shell command.  This is not appended if arguments are not
+  provided.
+** For "simple" commands, such as calling a single binary
+  (e.g. `alias.myapp = !myapp --myflag1`) this will result in any
+  arguments becoming additional regular positional arguments to the
+  called binary, appended after any arguments specified in the aliased
+  command.
+** Care should be taken if your alias script has multiple commands
+   (e.g. in a pipeline), references argument variables, or is
+   otherwise not expecting the presence of the appended `"$@"`.  For
+   example: `alias.echo = "!echo $1"` when run as `git echo arg` will
+   actually execute `sh -c "echo $1 $@" "echo $1" "arg"` resulting in
+   output `arg arg`.  When writing such aliases, you should ensure
+   that the appended "$@" when arguments are present does not cause
+   syntax errors or unintended side-effects.
+** A convenient way to deal with this is to write your script
+   operations in an inline function that is then called with any
+   arguments from the command-line.  For example `alias.cmd = "!c() {
+   cmd $1 | cmd $2 ; }; c" will allow you to work with separate
+   arguments.
+** Setting `GIT_TRACE=1` can help debug the command being run.
-- 
2.45.1

