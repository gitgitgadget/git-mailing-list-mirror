Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCDE149C4E
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898179; cv=none; b=dV1ZrzfLVWslpTHr8esH7nGG0L5bCsAGfqlPxPsZ6bTEn0H/f6JG9vmfmCOH/CNkpykDSrsgaSM92gg02Gy5191q2XWYtxJ8cimsC8OF6bBy+AJxZAbyjyp8gM3s23n1aDBMrY5lZKhHZg67Qk6SGCmodZU1khta03y0vBhpy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898179; c=relaxed/simple;
	bh=0j/OOYMx0gPkfRTMv8RAsOrj96FtwVvTqrqubdYWBMM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QWMnrSHv4P9lVaO89+JDOSP3uKLlTWsPE9zrhCfJJVX83HBryUGh2Dk6/Ek3QJKyUA05nLwdOB7bT9Bv83C5FDhpVpm9fymZHY/wJLEswEXOQR9ivbYxtp0WepxMxBl9X4GOxvKcPMN6/japintHmr3Arg9VcGkwrjkBLfelWWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaezdEQ7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaezdEQ7"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so98765a91.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 15:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722898177; x=1723502977; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HgLoASVMSDc73vcdSbNBgO64vvzeWWz8Z6tKk0U+7Ik=;
        b=NaezdEQ7ODtCvwpACXM4X/ez6SB6z/oJIUv8vPz1B9NQne4yDHxI/IT+g+iIYOnAhY
         avOObUsXsZIH5FhSJAX5eE588FQ2+35gb+LClodNc9sedR8CijnLI5N1CJQZ90EwSi8n
         AXfmzCECB5edzcSRRjc9l/YTWma+2Lepr+aEOGITWPAiVbXuCUMXayCRLAynfzQdL6uT
         D9SGzlfS0omAoXy+6AJRs/KqJpGlr1dlvImHb+h5nq1DcsZGXS1oIfe5AVdCvLyJR6/V
         NnqBHTk/u1GmivyNbppp90kIfyxIcbQpFbp6etadc8Oe55pd0rcnIoEVvm029780KZwq
         X0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898177; x=1723502977;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgLoASVMSDc73vcdSbNBgO64vvzeWWz8Z6tKk0U+7Ik=;
        b=hGQqhu31XmgDq0EJBkFYOQjRGlG1FgmeIrfdLZ9Bi41/oq/TTSm04Zh3g4Y+oc2JcS
         Kab/myi39gSb6w27l/JdOFz1bJIpvfy2JYMhA6HtdRI8iKTYngYDSFL4xdb+Jg2jes3s
         YdRmQjBYUI9909f6WTbX11soAY5H0uF7B0dq0n7CIDuwIHPhnGmD6s4iHy1vymz9U4di
         vUU0EZZjCo79nY33wdjyVKQWujaUZMRCk/SAdrcclLtIn/WlpKmv7muQRjTYCXHBISwI
         Sx/8ClQqi5xoFCpZsxuv8wrQ7DH7byJmAkTHgnNyIlkwfXfVdQLoQuZYBUsv3MfkZpvN
         ez/g==
X-Gm-Message-State: AOJu0YzQf4ccFt4KQyjKCggU/FGaBtTpB+B67InvFCkaLWk4LVJ0xv+0
	xU9Oa6exzKz5ItoJa/rFiXxlP1eF/ZeY6AJmDdaxJDldG8WzN1cyhValtq2IIabEQBrTu+3fE0Q
	0OnROH7WqSPKacbXJHtseVpjVXYUaW+meZSI=
X-Google-Smtp-Source: AGHT+IHTScU5bjZtyXwc65lM5TVM4uEuxYgeIiXysDQoggjUBaLO4duiFD8Kee1Bsn/8wTk5dBr5xI97NzSdPsYX5UI=
X-Received: by 2002:a17:90a:ab0b:b0:2c9:964a:95cb with SMTP id
 98e67ed59e1d1-2cff9552e7amr13554185a91.40.1722898176878; Mon, 05 Aug 2024
 15:49:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Hishmeh <samuel.hishmeh@gmail.com>
Date: Mon, 5 Aug 2024 17:49:25 -0500
Message-ID: <CAGdcVNMPA6u+OiHYWfZvDxHef767Sa_oyK6+v7VjSUt1rNmbMQ@mail.gmail.com>
Subject: Added support for --branch to git p4 rebase in git-p4.py
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I added support for the --branch option to the git p4 rebase command in
git-p4.py. Here's the commit:

https://github.com/git/git/commit/27b68a48969ee9be091abfd971e0c0aa092b1638

Here's the pull request:

https://github.com/git/git/pull/1759

Here's the patch:

From 27b68a48969ee9be091abfd971e0c0aa092b1638 Mon Sep 17 00:00:00 2001
From: Samuel <67290240+shish456@users.noreply.github.com>
Date: Mon, 5 Aug 2024 16:48:55 -0500
Subject: [PATCH] Added support for --branch to git p4 rebase in git-p4.py

git p4 can be made to support branches as streams to an extent
(https://stackoverflow.com/questions/15305357/how-to-clone-branch-with-git-p4).
Unfortunately the git p4 rebase command uses the git p4 sync command,
but it doesn't support any of the git p4 sync options. I added the
--branch option to git p4 rebase so that it can be used with multiple
branches.
---
 git-p4.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index f1ab31d54036be..17a83e8dc07b4b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4270,14 +4270,17 @@ class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
         self.options = [
+                optparse.make_option("--branch", dest="branch"),
                 optparse.make_option("--import-labels",
dest="importLabels", action="store_true"),
         ]
+        self.branch = ""
         self.importLabels = False
         self.description = ("Fetches the latest revision from perforce and "
                             + "rebases the current work (branch) against it")

     def run(self, args):
         sync = P4Sync()
+        sync.branch = self.branch
         sync.importLabels = self.importLabels
         sync.run([])
