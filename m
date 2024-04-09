Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353A156F4E
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699821; cv=none; b=gNo7fdP7sQ4oRO8tvxpAqRqSf+0PMUQx92v7pFIzWnKuC8wGypaAq8WNgSS8V1JpZMj3AMMuSdFwJ9wnT+2le9hwp6/KKmE5pdyVN9OhGfimPNsRzBT0IWv5WhPR0AUxfrW+N4zqQSlfl9nJfUYxuRNlremwOpp8ylksQCipydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699821; c=relaxed/simple;
	bh=62KA4t2sxwFrOYMtUOgehYcpuDUXgLeTd/RyMsUQ7L4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uJt/Gqf/avipl6toxN2b9sDODmgS0MYe12mIvin0wojGm6hID3equZshUGTYogF11g24+g9KRIXLHUlmaRPLCmnO6oZb2/jLd1pRBY1iDgVIsQl4PhfiA7IjMCnJGJ2afltRlLSejKQ4ztwza378zNtObB36HEBsxAPGU4yxH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxcPr8L/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxcPr8L/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343f62d8124so3076061f8f.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699817; x=1713304617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP532l6gyyq/cZ/MAwJWsrmoopdNgNTRDPIdfJGxnY8=;
        b=LxcPr8L/ndC4Zo9yWkcoL5/pehaYLfMXNXMB1z0iPehAbMWwBcnIatuKC5pQ05IXTe
         Nigf2HwZk0th16YI3sj7+y2/a/LZHdT9FN5dtJYEYJoNZTz4cl24NXlzV9us9p92SfrR
         CW6xLNqa+l+u5QtH676oHOoYZ6CeJd5Fs2Ni2wuEjq//xcfFhNbPrO4nMWAJF6S1wsIg
         Xv8ygai04M+pino7NyM379nmo18NpHGFv+CXrYRDD0lk+YV9SfAWTfAncjwMy9WS67QR
         a1tZo2B2gs0eTxCaNtrb2vvAz9mtMBT8pgl40IlkT+YPhxG5V1qrjjxnu63hE3dQeuAs
         nF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699817; x=1713304617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP532l6gyyq/cZ/MAwJWsrmoopdNgNTRDPIdfJGxnY8=;
        b=So3CBmsQfrbPWhiosy0DVMRGaV0Tmu/5337IZus3yIjN9yR+CVyK9ufRAV/5Ke6hcM
         FitgJS7JNRsHjqgPapTDs5psbjuZI4xjDJemD7+WAn3G5a8+Cija6Sy2rI/B/84dUP0K
         6lcuUpqC116j/RhoW9MFHLTAx7Q6qHrdv8hjSAxN8OViFPl6bXV0+V8zw2V4SCjyKFsJ
         w3bPcdHiESt3SyAP0sF2rkscO2iCjthYqycXjn9eG7re9+3MIWewgWGJsISiJvEK1jGa
         Bd8FPk6HiEgQWY64KA+Q2i3/imJoKlppe8wZ+/ZRIhsYKQEjaU0maew1qOqqU5os/rbz
         vl3A==
X-Gm-Message-State: AOJu0Yy8gvte6VL9oP4ou69LKbIOxgsPO+skvfOWBVYhnGP/TPS3XSrG
	dP/X57mS0Jvd5DhzQm9RzxaccS15awoLs9UABo2HUPz2oGth8LNDmpTmMlmh
X-Google-Smtp-Source: AGHT+IHosg1F8Q5nn1pFfp/tlWNrzSJrO5nyn7Dy6jfXni+lHqFqmjcH3q1uuyZY5pzN/E3YZWgtFg==
X-Received: by 2002:adf:ffcb:0:b0:343:ef64:e0fd with SMTP id x11-20020adfffcb000000b00343ef64e0fdmr500357wrs.52.1712699817135;
        Tue, 09 Apr 2024 14:56:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12-20020a5d498c000000b00343e8968917sm11981264wrq.1.2024.04.09.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:56:56 -0700 (PDT)
Message-Id: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:47 +0000
Subject: [PATCH v3 0/8] docs: recommend using contrib/contacts/git-contacts
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Linus Arver <linusa@google.com>

Make git-contacts more prominent in our docs.


Notable changes in v3
=====================

 * Refer to GitGitGadget via a link to MyFirstContribution (instead of
   sending readers to GGG's homepage directly)
 * Soften the advice for using git-contacts


Notable changes in v2
=====================

 * Improve existing mention of git-contacts in SubmittingPatches (instead of
   adding a separate, entirely new paragraph)
 * Add example usage of integrating git-contacts with git-send-email with
   the latter's --cc-cmd flag.
 * Various smaller fixes to SubmittingPatches

Linus Arver (8):
  MyFirstContribution: mention contrib/contacts/git-contacts
  SubmittingPatches: make 'git contacts' grep-friendly
  SubmittingPatches: mention GitGitGadget
  SubmittingPatches: quote commands
  SubmittingPatches: discuss reviewers first
  SubmittingPatches: dedupe discussion of security patches
  SubmittingPatches: add heading for format-patch and send-email
  SubmittingPatches: demonstrate using git-contacts with git-send-email

 Documentation/MyFirstContribution.txt |  5 ++
 Documentation/SubmittingPatches       | 68 +++++++++++++++------------
 2 files changed, 43 insertions(+), 30 deletions(-)


base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1704

Range-diff vs v2:

 1:  3817e7f3cd0 ! 1:  1f65dc5ba3d MyFirstContribution: mention contrib/contacts/git-contacts
     @@ Documentation/MyFirstContribution.txt: $ git send-email --to=target@example.com
       NOTE: Check `git help send-email` for some other options which you may find
       valuable, such as changing the Reply-to address or adding more CC and BCC lines.
       
     -+NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
     -+include in the CC list. In addition, you can do `git send-email --cc-cmd='git
     -+contacts' feature/*.patch` to automatically pass this list of emails to
     -+`send-email`.
     ++NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
     ++list of reviewers you should include in the CC list. In addition, you can do
     ++`git send-email --cc-cmd='git contacts' feature/*.patch` to automatically pass
     ++this list of emails to `send-email`.
      +
       NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
       please don't send your patchset from the tutorial to the real mailing list! For
 2:  82e5e05288d = 2:  6e8b1b50ac5 SubmittingPatches: make 'git contacts' grep-friendly
 3:  6e6950afa6e ! 3:  7f8fdc053f7 SubmittingPatches: mention GitGitGadget
     @@ Documentation/SubmittingPatches: are optimized for the workflow of sending patch
       your existing e-mail client (often optimized for "multipart/*" MIME
       type e-mails) might render your patches unusable.
       
     -+NOTE: You can also use GitGitGadget (https://gitgitgadget.github.io/) to send in
     -+your patches. The discussion here focuses on using `format-patch` and
     -+`send-email`.
     ++NOTE: Here we outline the procedure using `format-patch` and
     ++`send-email`, but you can instead use GitGitGadget to send in your
     ++patches (see link:MyFirstContribution.html[MyFirstContribution]).
      +
       People on the Git mailing list need to be able to read and
       comment on the changes you are submitting.  It is important for
 4:  fb06d5ce247 = 4:  ef26bdb75c5 SubmittingPatches: quote commands
 5:  a8abcf45881 = 5:  6f71b1731f2 SubmittingPatches: discuss reviewers first
 6:  326afe13315 = 6:  f5e44f69941 SubmittingPatches: dedupe discussion of security patches
 7:  09f4e7ad123 = 7:  e64fc5c888a SubmittingPatches: add heading for format-patch and send-email
 8:  b35748f0cf8 = 8:  4fcab0d3319 SubmittingPatches: demonstrate using git-contacts with git-send-email

-- 
gitgitgadget
