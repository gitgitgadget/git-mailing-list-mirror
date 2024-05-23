Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBED273FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438124; cv=none; b=Xc0in2/6BMIidLcy00dd2U+TUsyeqSznQsOqG+MFG/sthsvh5GnnnvWypOtzFcED1xLEH6ixV7Ep3O1uiLTsb2bpzrn7KVkFuNxbky/tOy16ePUzJNIJQmr1yjKbdIDVNhG2/ykXl3N53Jor/3gLWjQ8xCBSmzxr/O2p0S/6Jj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438124; c=relaxed/simple;
	bh=InrIxLZ21i97yZ5gQYuP/QqcWLw8Yc5XNjt7x6yPKrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJKITqUyy9myFyo7qwZM4CCIybBGRJzBIxmoc5/okQTLshqAr5mOg5fmbW171kkjxudkrYMa3R3jLUKCvWaE/ioa3XHGnjBSkRg+FQxdyo3l8m+dKtZzN9wmGgodWjlcEt2Rtm8VcewAq5F/i1JMD/k7cHFwzYDxfenoBdKxr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1OiZeKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1OiZeKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716438122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1bgTsidDxCIHu84my8YvIw/c400mMz313EXbhPpPC8=;
	b=W1OiZeKOKfqk0ubV8VXh7LIau4OGkow9zVN/l7F/Sfv/lc8a8hTyFr/D/p4Ohr3DKROInm
	5t+kxDD3LHCPHHW+ncdvFJcHpR5GYaeOGgLQyEaKGoQvgn1qYzXLg44/+nu7JPq94SY2Gv
	yQxkJ+FyfDQvHd4E/WBLnvbJ6l5VasM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-xaPeYzigORiA-jTnFeu4ZQ-1; Thu, 23 May 2024 00:22:00 -0400
X-MC-Unique: xaPeYzigORiA-jTnFeu4ZQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792d2abbc65so1509453285a.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438119; x=1717042919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1bgTsidDxCIHu84my8YvIw/c400mMz313EXbhPpPC8=;
        b=CPsBIf3ewVY+fGUx0iUKW7BemLhZGCTFUQbh64HdYoJSvppVhwv9xsxgpU+QrmwIGO
         t+SJ8Fub9/5phJfXNKt1EQHlBP1LmKm+RxbnejDRnXq46PmfLItz7r3yWD/VoiDSvCZ7
         bark+7Xbwj4yLyOicVP3CfIaN32u7M6UHK+5j/2JB8tOIe+Cl9fNPPWW3fhsr05Hoz0o
         0ECtbpO171r0yiWiibOmiGY2Cr/C1GzgoVUpRLlnc+L1KwmLnVgIot3XgXz0RsxGVTxm
         ZTKXdQFzSK3msMun2gTVahZurwTeUfjd9oGrZx2ZRPS0BmaBo7HO7GsKJsEN980R72t0
         VRjg==
X-Gm-Message-State: AOJu0Yy8YMWV4ioTnVJBcirNM/DiYQGC/VfeDzXoLORA20vsKV5UIET2
	e7i/TefKQ50ix3PTHAc3w7OmI13rU6kEjzZggZfizqxYiBLoYBTPm+I26fXtFJ4lRM2L/Gxvv2v
	zgJcO7jEPAZLvbE6DiF+LR+UL4/LiK2KoDs1R/OA0hm1Q9qk7EwExIsKx1BljTGW7YD4gwqpslc
	bOlEa7ofbJ0ypphQswvkFwXeZiCNIX5V0HZw==
X-Received: by 2002:a05:620a:5603:b0:792:9ca7:212f with SMTP id af79cd13be357-79499444105mr399928385a.31.1716438119064;
        Wed, 22 May 2024 21:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzTuuIxJXhXG6KtNeM3PkBUkV9a7KbL0YeUrmMRQQ8BdZ+JB6VptA2juAo96Oeyi90Sc1nRQ==
X-Received: by 2002:a05:620a:5603:b0:792:9ca7:212f with SMTP id af79cd13be357-79499444105mr399926785a.31.1716438118655;
        Wed, 22 May 2024 21:21:58 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794807f4465sm412760385a.62.2024.05.22.21.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:21:57 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v2 2/3] Documentation: alias: add notes on shell expansion
Date: Thu, 23 May 2024 14:20:58 +1000
Message-ID: <20240523042143.1220862-2-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523042143.1220862-1-iwienand@redhat.com>
References: <20240522024133.1108005-1-iwienand@redhat.com>
 <20240523042143.1220862-1-iwienand@redhat.com>
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

