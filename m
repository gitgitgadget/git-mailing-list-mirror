Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A61618B1A
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721068719; cv=none; b=V3tDbDk0DjNUle3D76wRjAtZ10W4NnWQnfozZ4kqlxlRlCGLEEPQwVBwMQgAHKb2f5KyxJzSsx3V+pqIuV7Onc2LuMk86AHCmk1Q77WEAzlRxrZOETjjB66Iw8GWPNwwoJCjd3ImLJ4NXq5E/JJ4Ben/w4fLY/sngqk77hb2OOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721068719; c=relaxed/simple;
	bh=QQmx8O5oe5/+jolBfEf6J9jHp77g6fushR8SqgpaVig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXkqtxQq0H3uFmjeIt5IPkuuxunGEia9CVONPhoTxM59Qip18cCfDG6IMgAP7sgK+ox9HC9vEVyIqABWYvixboSQcHrb6JNAEsny0OxWnunfl2NQNn7LRxIjZssP1yM4cdGehH5yMx76YpmCQZkHEXGUlFlzalrn7bspJ2ztplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3L1xNCg; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3L1xNCg"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f8d0a1e500so4150186a34.3
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721068717; x=1721673517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGMVNJsAN0vl1d6EFKBQ9ckmYwbpyuvhl2fXRQJHuFU=;
        b=G3L1xNCg7Kz924qq3ZlOeEUGVbQP4d7R6HnhWh4J+duePXKh5TIrzuhvXtaMz/O6kE
         oPpMLqyLkWMFFTSu49It3nod8n3HRsV2UyZ++gi2dEP4Gk9fsHqFLPTndPrP3x7CMe5R
         3e6q0+ged1n5Hw2D4CrIRkGvwzfKiT8I/V3sZYqHU66uC1/Atrbyn8ajk6F7xyMsneuv
         JdHLJR7ARgUXDQIeQzegwzJqyGjGr/XbBOGKWdKAxkRXRnBNU+51zXD0/iNEsH87AS5g
         +pXgRP8DjJ6Cs17d+BqZnU5xgmrdXe+CeMKYmZSEq9LjoiRexYtxX17r1m53OOAAEEGK
         ISgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721068717; x=1721673517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGMVNJsAN0vl1d6EFKBQ9ckmYwbpyuvhl2fXRQJHuFU=;
        b=sxXGI9jGZLVjIe7kVxp04PJy7S5XvSYedNFBAgfS93E1akA5rYgUcLjEjPN/2OPeH/
         nCTV0nC2qN8T+vdSeq5u+PXemisjMQVFXV6iwW79zmi0BfDHRyxFdQ1GopOeoF50oR5P
         DM/xuDQ2ARQX1+U5mStCOVNDyENX9todjnVKbf1awMpuInxnikbBA0fWLEIlwF5k8Fah
         EEeJRIgp7/+AzcOWUhmu3nrNIvo4Ne/+13LPcFBqAwa4tslKbnH4yGNbqxiOdzHsuD9C
         RoOCz3Ncb2C04Au8jQIkh4PdCusmJnqjGbtDhmDC5E7T4IGalfoR9L/+0h0xo76AS2Q4
         mqvw==
X-Gm-Message-State: AOJu0YxPXpncIO8Jt7iWAkEAV+J5Qs+L3gdWCu5FK7G+AK+BzrXoASza
	eB6U3VbH+gilgxIdwIYNmjaCQDox1eOgjoCctXhzH53+jlpHkvDlBxUheg==
X-Google-Smtp-Source: AGHT+IHvJQMRyfyOOy2kg1vgj2ELVThJadUdNckDWTSm5/rA3ueKXBckjXgMwroWeBq3pKq9YiE0Hg==
X-Received: by 2002:a05:6830:6d13:b0:708:b46d:5c76 with SMTP id 46e09a7af769-708d832e1b2mr896630a34.17.1721068716923;
        Mon, 15 Jul 2024 11:38:36 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0ca79e7sm1068083a34.48.2024.07.15.11.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 11:38:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3] doc: clarify post-receive hook behavior
Date: Mon, 15 Jul 2024 13:37:39 -0500
Message-ID: <20240715183739.7808-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714194626.29512-2-jltobler@gmail.com>
References: <20240714194626.29512-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `githooks` documentation mentions that the post-receive hook
executes once after git-receive-pack(1) updates all references and that
it also receives the same information as the pre-receive hook on
standard input. This is misleading though because the hook only
executes once if at least one of the attempted reference updates is
successful. Also, while each line provided on standard input is in the
same format as the pre-receive hook, the information received only
includes the set of references that were successfully updated.

Update the documentation to clarify these points and also provide a
reference to the post-receive hook section of the `git-receive-pack`
documentation which has additional information.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings again, 

This is the third version of my patch to clarify documentation for the
post-receive git hook. Thanks for taking a look.

Changes since v2:
- Removed added usage of link:*.html reference since links to HTML
  documentation in the corresponding manual page are likely to be
  broken. The provided linkgit: reference should be sufficient.

Range-diff against v2:
1:  747e925dfc ! 1:  963e3ddc83 doc: clarify post-receive hook behavior
    @@ Documentation/githooks.txt: environment variables will not be set. If the client
      to use push options, but doesn't transmit any, the count variable
      will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
      
    -+See the link:git-receive-pack.html#_post_receive_hook[post-receive hook]
    -+section in linkgit:git-receive-pack[1] for additional details.
    ++See the "post-receive" section in linkgit:git-receive-pack[1] for
    ++additional details.
     +
      [[post-update]]
      post-update

 Documentation/githooks.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 06e997131b..0397dec64d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -415,13 +415,13 @@ post-receive
 
 This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
 `git push` and updates reference(s) in its repository.
-It executes on the remote repository once after all the refs have
-been updated.
+The hook executes on the remote repository once after all the proposed
+ref updates are processed and if at least one ref is updated as the
+result.
 
-This hook executes once for the receive operation.  It takes no
-arguments, but gets the same information as the
-<<pre-receive,'pre-receive'>>
-hook does on its standard input.
+The hook takes no arguments.  It receives one line on standard input for
+each ref that is successfully updated following the same format as the
+<<pre-receive,'pre-receive'>> hook.
 
 This hook does not affect the outcome of `git receive-pack`, as it
 is called after the real work is done.
@@ -448,6 +448,9 @@ environment variables will not be set. If the client selects
 to use push options, but doesn't transmit any, the count variable
 will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 
+See the "post-receive" section in linkgit:git-receive-pack[1] for
+additional details.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
2.45.2

