Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116B1509AB
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776947439; cv=none; b=qxVfMAG0Pp2o310hACxXQg92fgl/aOoK/eEYYGGJrgEwtRDyFMDytISHU4hTZpyeqcG0/saEUFlIW2k/ikCYrD00EmQCY3uVMkG0DkRYI/0qWnmFvChdSXBWm8Ipfqc63Siwp8CbdfUyMjOPKD8Q8zqCrE3MpDRJBetcWfXL8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776947439; c=relaxed/simple;
	bh=RRxQrqc59L3CMoSga0OzXyqNd5GZemSeK6YJCSfYEt0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=m9b2m1aNFhxzHe4Udg3gFICNiXx3et7aZ5EAk+ZQx2fEkyyif7yF367mJQiESn/8qXnXogovSVJmv6DNG9ZlbAwi3cE4DXQ1p2Lk56p6RU5TsM838Qba9Bb+4aOn++l5r816Zm9Jy9qVwx/qIZLlVXfIX1VFqZ9MPPx49zQUoAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpJe+80d; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpJe+80d"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c70b5594f4so723814185a.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776947437; x=1777552237; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fboSC+5JEPlNaGwxjVwi00pOcAQwm1F+WIu4q4tD+/c=;
        b=GpJe+80dLwNxQsNOgI1OW+B45Y0LuYx3efC8OwgxgEANn4IL0UMUDDsWcsqw3ujcjZ
         RRAx0Cm2SfDYMGr9s3EIyBvHNnJrwkFuAZ34fpuVsxtJopiNnjogkyt5j0tns6pI4HD2
         pd5L7oQOqC8aJmlm9NRzt2YK2yAfOyXWgoSrR3c0DCbhUcOnv2oCt1lrFIFUcBF3bu7C
         lAloGbYDtNFAtjPdgu7P9OOm7csIlfQhR37OCKABldMumphETpA8/7d4dgj5+rsSXRLE
         c5pd3C4HhHAEqDXd3gZPHjYbxtKoIQScr3u9HqipmXCULveWbdaMShTfZ4bivIJtSWCt
         ca/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947437; x=1777552237;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fboSC+5JEPlNaGwxjVwi00pOcAQwm1F+WIu4q4tD+/c=;
        b=RVMeTeQNfBEABHGX/iO+m7nR5M4DHDTDtQrekrWeUVZCGdETuNnhnu2cSlo2w2MONP
         1d6DB8VGezLE1in71HrdELGTK8nTUl0clSwrZacXeGiX3QTD4xTIE0Ua79pM1d9VZBL5
         FzbFkJgiN6qsOuc6B+ArOUxVaWZUZ2OnKtAxhnRbsvCwdxqL/ci6sYFjwNzxPd+xfHNq
         gcl0J7oAKSL7rp3ueJTkw7uI4l6mWrUkPrGxb0GUSkyMXvJl5rAAnhYWZNcR5ftG9FJ0
         0IJH6wwdQdL4ZNdxz59TCrAfRfm2sCG1s0TnkSlAj37445XXTVc4Jvd2aOUnPNW3oSfu
         a/eA==
X-Gm-Message-State: AOJu0Yw/vLXzYwLChIuKhjhLZlYEArx2VOujsgHZ/u2FP0wbYOyjQe+y
	8aHevt3W5BZe1ASblsJCv2VeCQ8l6am7K8vSTT/1ER34bWEzUbgkvJqIOso9HQ==
X-Gm-Gg: AeBDievtsDpuwW9G/PcRXCvJJGNxyt9c26ZWVPWKAWqrFlGvZ2imPjAkfn0zbkvbPsb
	Om7zGTKIvZSBY7JmTJatug32PXOxx9bAlw+h8EiRPli6KzOHepMgQcoHydB1CIgZTP/tbCqJqeG
	d5682OseYUP641Z0ZMwok9huMChrxEY8DY9A+qfB7du/VOM3Q5wJZbmNAhLAhFXnTUDWA5xNp41
	6X/8aJw3xZ42qhkuYo1ecEYse1V6gOMigo6rj801ukxA9wn/4wmlTMX0TWhEETLeENH+5vgVtYC
	vwaJkS5SnmyUbpo7tzR+AWA8fh9Mkh0CMqlpVaxYFOVgy7eoT9GGitfDPt3h86ojnTfGG8yPkZg
	ahzOERdR2LmuCOHnxFYcUhaITQ8wHz4TpVqPzXqlIFVQ6oWebt8nMTwdkHw/ZYIFBIzA6T4/H4V
	gO9rui233KATBFQ909xuOk5bJ86VnMTaH7+Ls=
X-Received: by 2002:a05:620a:4694:b0:8cf:d80c:5ab0 with SMTP id af79cd13be357-8e78bbef7admr3257923085a.17.1776947436509;
        Thu, 23 Apr 2026 05:30:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.49.14.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe90a4sm1653995885a.9.2026.04.23.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 05:30:35 -0700 (PDT)
Message-Id: <pull.2279.git.git.1776947435168.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Apr 2026 12:30:35 +0000
Subject: [PATCH] push: add push.showProgress config option
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a `push.showProgress` boolean config that sets the default for
progress reporting during `git push`. Setting it to `false` suppresses
the pack-objects progress output (Enumerating/Counting/Compressing/
Writing objects) without silencing the ref update summary line the
way `--quiet` does. An explicit `--progress` or `--no-progress` on the
command line still overrides the config.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    push: add showProgress config option
    
    The amount of output shown for each push is excessive in my opinion.
    
    It can be silenced by '-q', but this has the bad side-effect that the
    success message is not shown. '--no-progress' exists, so would make
    sense to allow this to be always be turned on.
    
    Enumerating objects: 17, done.
    Counting objects: 100% (17/17), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (9/9), done.
    Writing objects: 100% (9/9), 1.32 KiB | 1.32 MiB/s, done.
    Total 9 (delta 8), reused 0 (delta 0), pack-reused 0 (from 0)
    remote: Resolving deltas: 100% (8/8), completed with 8 local objects.
    To github.com:HaraldNordgren/git.git
     + 3b9fc3aac6...6d326b0098 push-use-progress-config -> push-use-progress-config (forced update)
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2279%2FHaraldNordgren%2Fpush-use-progress-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2279/HaraldNordgren/push-use-progress-config-v1
Pull-Request: https://github.com/git/git/pull/2279

 Documentation/config/push.adoc |  8 ++++++++
 builtin/push.c                 |  3 +++
 t/t5523-push-upstream.sh       | 23 +++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index d9112b2260..92f22c8ec3 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -137,3 +137,11 @@ This will result in only b (a and c are cleared).
 	If set to `false`, disable use of bitmaps for `git push` even if
 	`pack.useBitmaps` is `true`, without preventing other git operations
 	from using bitmaps. Default is `true`.
+
+`push.showProgress`::
+	If set to `false`, suppress progress reporting during `git push`,
+	equivalent to passing `--no-progress` on the command line. If set
+	to `true`, force progress reporting, equivalent to `--progress`.
+	If unset, progress is reported when standard error is connected to
+	a terminal. An explicit `--progress` or `--no-progress` on the
+	command line overrides this configuration.
diff --git a/builtin/push.c b/builtin/push.c
index 7100ffba5d..d35f816740 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -539,6 +539,9 @@ static int git_push_config(const char *k, const char *v,
 		else
 			*flags &= ~TRANSPORT_PUSH_FORCE_IF_INCLUDES;
 		return 0;
+	} else if (!strcmp(k, "push.showprogress")) {
+		progress = git_config_bool(k, v);
+		return 0;
 	}
 
 	return git_default_config(k, v, ctx, NULL);
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index 22d3e1162c..27aa87ee01 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -120,6 +120,29 @@ test_expect_success TTY 'push --no-progress suppresses progress' '
 	test_grep ! "Writing objects" err
 '
 
+test_expect_success TTY 'push.showProgress=false suppresses progress' '
+	ensure_fresh_upstream &&
+
+	test_terminal git -c push.showProgress=false push -u upstream main \
+		>out 2>err &&
+	test_grep ! "Writing objects" err
+'
+
+test_expect_success 'push.showProgress=true forces progress on non-tty' '
+	ensure_fresh_upstream &&
+
+	git -c push.showProgress=true push -u upstream main >out 2>err &&
+	test_grep "Writing objects" err
+'
+
+test_expect_success TTY '--progress overrides push.showProgress=false' '
+	ensure_fresh_upstream &&
+
+	test_terminal git -c push.showProgress=false push -u --progress \
+		upstream main >out 2>err &&
+	test_grep "Writing objects" err
+'
+
 test_expect_success TTY 'quiet push' '
 	ensure_fresh_upstream &&
 

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
