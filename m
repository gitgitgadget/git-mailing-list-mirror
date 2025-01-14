Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79AC38FA3
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844543; cv=none; b=WuAxDTSN0CIzeDo82nd4zGcgCYP9y4dhuylrRNqwzJ1Xg8U2aFSzlt3pH1LCMta/u/URCKwgaHyI2SGevAB2JxJ8znsBbREQLl07FwHRQbXorxB1XVv/oOU3fK9njZK8stuURDRtLwIVmHFgm7ekipLXQpHlfX3BjGuQ+sXEftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844543; c=relaxed/simple;
	bh=ow04+7WY6wXUboZvFr6YH5SHFdyWt/JdS2ls6uNG3vc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QzgPTZ28TZxjzNfdkccEg9ck7VQ6QTdmPZEfz/2zz2aPVySa1I5W862tZm6xmkWmcYnIBiqXdSyOjDzZLMgxbmr1cngFhkkmuXj9+rK6YTMNof2UX0hzVAkoNLE5+PsYW9+abNRHvwuLpf+xY8jamfJ7exUdvR38vgsUYn8BA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMZW0Gpb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMZW0Gpb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso36998175e9.3
        for <git@vger.kernel.org>; Tue, 14 Jan 2025 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736844540; x=1737449340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+OePUGJVl4HgumSMIUs3i4Z5DTaCAEFLmhjdtUZGik=;
        b=kMZW0Gpbzp/maHktcUT5lJjRub+NeAxbzEOk732VKGOecS4+twEXsR7am+rzWUwG2q
         mIHwVuQkmm+u2ZzuJXWE2CJ2riAQXDmVsbEycPA546QjB/VooZNVDiUfLD8+zpXYDgOm
         dr61zG3aLpr6Mm6o5KhQlJgrYkvBfqsDpC97BCIRWJsq0MA8OgiMjaovB7eNH5uuNoXG
         9uPT9Um6rcjfroNkcGLcXQuCFJw5Za77D9ouiG56elzncBX6NOEQ1F9Y3svCkjMg4R+9
         7WqvbixMTWfn1+S9luPGmcQxdIqsvCRNOWBhwn6JYHG84s1AMuBzB1zC9NSEEgExY7VZ
         UGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736844540; x=1737449340;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+OePUGJVl4HgumSMIUs3i4Z5DTaCAEFLmhjdtUZGik=;
        b=ZA24ZLLCvBN8fhCfYk+dgW+30iydKC23JUka83wJ4igwNgFdA3gw8MxUL/pr8c/lE2
         dz7QaL6mTRZh/Ldu6NkHIjFTB+8ZTZ2/EFyRC+v2e8ktyjt603hrVrhnGx6gYkxzpWWu
         yp3ytjATmiE4YptBiydn+2I7fEcf1N3ht9Lvru8t8xp0j+s07BlmTHyNl2tEy7ZsV82m
         UdtA2xbt02jF900lcqoxAKwwGT+c8JL4xVCltRpgv7v5H8MdhQStzzb5IjSjye6XOcYG
         T7JhyxWlercQ2sQFSXYsFBCRj7M400gxrAp5WCZKZjssMeeGFXgZBnWGtXItOLVG2NwO
         TeVA==
X-Gm-Message-State: AOJu0Yxv403zurkgeWlR/xrZDr7MeO3g8pH/s75ym9/bGl9B2It7K6fm
	jUDQsYGIadYwoIZciN3zW8rEdk37s9Vu/8LnhyQlOZswKog3sZr3C9FPPA==
X-Gm-Gg: ASbGnctJT5VBbV2ZupZ0xImBX79mpCjDwYXJC4UTgUyUguvzI3Dgyxac0Uc2cTyo9v0
	UGYdImzD3GAQ4x4Ka6D8d1bP4IqSinguaMfK2KnTWDRlOEd2j5vwXO5huULUetvE/FR+Ho93yo4
	pEnNdQG7nHdypPRW62Bu5qj9w1MzwY/SgH+osZTUTD4ZsSbLJCPAXdbrvXEACIAWj4lsqwhYC03
	o1necmfyiixKwsVJaspTLe6uwrpYX4S7vKUX3RzLBQGl3qiPJx0O73UiA==
X-Google-Smtp-Source: AGHT+IEzNMbnXBUb0pj5w5/xRXaRIx45iy26cf604jhbnuY7umKCVKlD9f1wXLBF0H2f8A9fpYtDDQ==
X-Received: by 2002:a05:600c:a01:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-436e269715amr208244525e9.13.1736844539315;
        Tue, 14 Jan 2025 00:48:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8214sm14135992f8f.78.2025.01.14.00.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 00:48:58 -0800 (PST)
Message-Id: <pull.1867.v2.git.git.1736844538005.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
References: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
From: "Rhythm Narula via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jan 2025 08:48:57 +0000
Subject: [PATCH v2] docs: mention source of tasks in MyFirstContribution
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
Cc: Rhythm Narula <rhythm.narula26@gmail.com>,
    Rhythm-26 <rhythm.narula26@gmail.com>

From: Rhythm-26 <rhythm.narula26@gmail.com>

MyFirstContribution guide lacks clear guidance on where to access
list of bugs or feature requests. Improve visibility for contributors
on where to find open issues and features that need attention.

CC: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Rhythm-26 <rhythm.narula26@gmail.com>
---
    docs: updates MyFirstContribution guide to refer current bugs and
    feature requests
    
    cc: Carlo Marcelo Arenas Belón carenas@gmail.com cc: Emily Shaffer
    nasamuffin@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1867%2FRhythm-26%2FupdateContirbutingDocumentation-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1867/Rhythm-26/updateContirbutingDocumentation-v2
Pull-Request: https://github.com/git/git/pull/1867

Range-diff vs v1:

 1:  d3e264b1cc5 ! 1:  d1e83439133 docs: update contributing guide to refer current bugs and feature requests
     @@ Metadata
      Author: Rhythm-26 <rhythm.narula26@gmail.com>
      
       ## Commit message ##
     -    docs: update contributing guide to refer current bugs and feature requests
     +    docs: mention source of tasks in MyFirstContribution
      
     -    The contributing guide is updated to include references to the current
     -    open bugs and feature requests. This update aims to improve visibility
     -    for contributors on where to find open issues and features that need
     -    attention.
     +    MyFirstContribution guide lacks clear guidance on where to access
     +    list of bugs or feature requests. Improve visibility for contributors
     +    on where to find open issues and features that need attention.
      
          CC: Johannes Schindelin <johannes.schindelin@gmx.de>
          Signed-off-by: Rhythm-26 <rhythm.narula26@gmail.com>
     @@ Documentation/MyFirstContribution.txt: of invocation during users' typical daily
       
      +:mailinglist: git+subscribe@vger.kernel.org
      +
     -+Here's where you can find bugs and feature requests existing in the system:
     ++For future reference, here's where you can find bugs and feature requests existing in the system:
      +
      + - Git uses a mailing list for discussion on bugs, features and patches. Search for relevant topics or tagged issues
     -+   like #leftoverbits in the archives: https://lore.kernel.org/git/
     -+ - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues, https://git.issues.gerritcodereview.com/
     ++   like #leftoverbits in the archives: https://lore.kernel.org/git/. If you encounter a bug, have a feature request,
     ++   or wish to discuss or share suggestions, please use the mailing list. You can find more details in the <<getting-help>> section.
     ++ - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues [NOTE: This is for feature requests only],
     ++   https://git.issues.gerritcodereview.com/
      +
       [[setup-workspace]]
       === Set Up Your Workspace


 Documentation/MyFirstContribution.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index e41654c00a6..630a68b650c 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -109,6 +109,16 @@ of invocation during users' typical daily workflow.
 (We've seen some other effort in this space with the implementation of popular
 commands such as `sl`.)
 
+:mailinglist: git+subscribe@vger.kernel.org
+
+For future reference, here's where you can find bugs and feature requests existing in the system:
+
+ - Git uses a mailing list for discussion on bugs, features and patches. Search for relevant topics or tagged issues
+   like #leftoverbits in the archives: https://lore.kernel.org/git/. If you encounter a bug, have a feature request,
+   or wish to discuss or share suggestions, please use the mailing list. You can find more details in the <<getting-help>> section.
+ - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues [NOTE: This is for feature requests only],
+   https://git.issues.gerritcodereview.com/
+
 [[setup-workspace]]
 === Set Up Your Workspace
 

base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
-- 
gitgitgadget
