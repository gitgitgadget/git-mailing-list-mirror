Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60458FC11
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720986494; cv=none; b=SoJrlaD4Ssi6ugSYewylibjKhORh01I7ARLNbaQing9GTJkAxEv1db+ZOavCDKeVXjcR4xp+KJzAYdVBwUL2VCXmaSTc4FSl8UHNjo9Wa3SCkbMkUU7DoP0pGwNggjQhkHeU9+y0NdNRAFKF2PofcVLZWrDY1godrzcBdmQIU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720986494; c=relaxed/simple;
	bh=jNtpdZimTSAQikQLeB2Tnp1Tf+ruh0pk4D96KW1Op5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/8Sjmds/WWfRAqHg1YsQlC1mKjm+fFZ35hUIRR54mABcMwgzBlgvh4cn5UddQBiJA/Wkt8YBy9EYEPYLVlCNZr8ep8bqFYFMBI4Xk6NHyo73FHAfiXu2Uv/HyRfQBB7GGHYowka0honGuiVbIBHsO40c6ycjjxxXz2iAZuPVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHzFEzAy; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHzFEzAy"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c44ec4f2dbso1909639eaf.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720986492; x=1721591292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVgYvsH0ZQkAGY5bUAaErlnLm0TYSdWpZ8ldRb+BPA8=;
        b=mHzFEzAyb2IS9dXNKJQviom8/3wgJ1YzdPGyItu7jwzK6rCmnMkpZq7lPR+EzGipt1
         rtXeJXl5fPI6XEet1LwIU9hPiv3oXmsKRbV6FtwksLVGONnDiL9NrcX2y6RzzK53HIzq
         Jfjf96ImB9xZBsFdNOuPGP6EGSotChQtfd/L6DTdpj3VJ6fLyu/3QTObSqCliDjhwt8j
         4HnuWHYdyELGKzWgECF4JRvlexAYXli4XfnOOh24tKlpzJYnD3dU8uXG/kXYbfjucMSM
         Ip3N9hu1wS3ZtJRnyDwUdVOvQn4fptgWZng/PKDUFzG13k7LGqX8DVPbDZGDJSgdVEtg
         I3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720986492; x=1721591292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVgYvsH0ZQkAGY5bUAaErlnLm0TYSdWpZ8ldRb+BPA8=;
        b=qOB8vKwXNH0D2UMMUsb5S9vUqNYBA8Vvuyc4ol2syuBdeHW1k5JfYLwKq0CF2EuqgF
         eAULIiu50uBF61z3m/U7l2Ltz65eW/M4n6WvqBvL5ubdm64fWybqIY16pkPQlpcbX+8a
         yqNTalaBzSkeTRqFAwiPZXjMEY11LftxsNLq0VqfjgOcaJJzEleNvKDJj+q+vZvK3KHR
         Lsaiir2jYMltQR4c5mQag9W+ueBKq9/VZnMO+xpZT3gL4KxBxV5VYbQjAC70ejyPh8ma
         6ot87AZTDqCctY2sCrWs5fMOqaFXQhVbbBNede32+oN/yD0xcHp25X9YQHa5gyavXFaI
         8V+A==
X-Gm-Message-State: AOJu0YwBsKUZFu25hjh1OqW3GEqtJvcfsBC41/ovCA6Yx+68TppLVIgr
	t+jebMIlctZ52HHULySXB5Zyj9qHYxcbDUyCm90XPXwNBAjx7XT1CDyl3Q==
X-Google-Smtp-Source: AGHT+IFWFJdBkgheKvZ6tMrSJm28an30OJ0ANVYtvcI3ahR3dE6WnMDxFPu3D4/AjPFRPVUXEzXwNg==
X-Received: by 2002:a05:6820:2686:b0:5ba:ec8b:44b5 with SMTP id 006d021491bc7-5ccdf8902b2mr8353585eaf.3.1720986491701;
        Sun, 14 Jul 2024 12:48:11 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ce758a36cfsm569154eaf.25.2024.07.14.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 12:48:10 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2] doc: clarify post-receive hook behavior
Date: Sun, 14 Jul 2024 14:46:27 -0500
Message-ID: <20240714194626.29512-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712224748.56843-1-jltobler@gmail.com>
References: <20240712224748.56843-1-jltobler@gmail.com>
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

This is the second version of my patch for post-receive hook
documentation updates. Thanks again for taking a look.

-Justin

Changes from v1:
- Removed repetivitve statement about the hook being executed once.
- Slightly reworded statements to improve clarity.

Range-diff against v1:
1:  e4824ba60d ! 1:  747e925dfc doc: clarify post-receive hook behavior
    @@ Documentation/githooks.txt: post-receive
      `git push` and updates reference(s) in its repository.
     -It executes on the remote repository once after all the refs have
     -been updated.
    -+It executes on the remote repository once if any of the attempted ref
    -+updates are successful.
    ++The hook executes on the remote repository once after all the proposed
    ++ref updates are processed and if at least one ref is updated as the
    ++result.
      
     -This hook executes once for the receive operation.  It takes no
     -arguments, but gets the same information as the
     -<<pre-receive,'pre-receive'>>
     -hook does on its standard input.
    -+For a receive operation, this hook executes a single time at most.  It
    -+takes no arguments, but for each ref successfully updated, it receives a
    -+line on standard input that follows the same format as the
    ++The hook takes no arguments.  It receives one line on standard input for
    ++each ref that is successfully updated following the same format as the
     +<<pre-receive,'pre-receive'>> hook.
      
      This hook does not affect the outcome of `git receive-pack`, as it

 Documentation/githooks.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 06e997131b..5459a40326 100644
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
 
+See the link:git-receive-pack.html#_post_receive_hook[post-receive hook]
+section in linkgit:git-receive-pack[1] for additional details.
+
 [[post-update]]
 post-update
 ~~~~~~~~~~~

base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
-- 
2.45.2

