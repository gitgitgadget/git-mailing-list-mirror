Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660A4CE08
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 03:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933786; cv=none; b=K/SZyfdDeFbwFH+AWc5kV7JdOrnwHfaJ2LIir6SbKXbz3n2sXzo29QK5Hz/dWRd7fIgBTIehcsv9FFkFG2NIULtSp1es44C3iilYwqi02vTozMQbVMi5UB4Q9Oo2rteKAKWz3A9iHm9zKWx0p1HJwmomGuivcOrVBVGY3DJ/gJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933786; c=relaxed/simple;
	bh=eDwGNOu6bBMkIWJBwLf6RuS4pCDCrD24hsyADFbIjwM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QMI426Uyd76lBdPAq68B/CUSe+NCpaER49aIGHWEHhFoPonnWehRoxG0cpttVRatTlfOK7FshefZvCpKehY3oR4ITnEStv8iNSgm2gK7hthuVmdfMfjIT+/CdsR91xgsrpwsiHNdtUJdQe/yzQL7w18Amh5jWWwyiWyKvqYQwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9Gat/uA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Gat/uA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b794a013bcso559598f8f.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 20:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753933783; x=1754538583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1I5l9JtN2XKfcSQVgr0NZBS6FBj0g2cp27kvj3ISyo=;
        b=X9Gat/uApW/fadgBmNA9nGKGu/hqvz/ElKA0Vc2XmM4StcDBiBEuTnFh8X6n0Avc0K
         aY1W4QdUkl7HSJLw5KmOvrzqngrDfiRLp3WyoyFXXPIZtALpfIe21PB2vMXXIIJx4Scv
         Fd7ctH+WOPMcDn9gX7b/Z9o80RjbEVTIKazCurhcyB7Po7KzpfOUe5zsTfhHL843XHoZ
         A3gLLSxE5vGWEk9qxB3JvZkGZ6nFJk5vBUX+8/Muqmzyfi7VuuVDY/u1Ql4PkiCtmp8e
         HM0pyLLGz7RPEXoftOCKe4gW0nZtvcOW4H+ruFip+VMFyCMuBLIHb44SlNtAdefbcw8E
         YaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933783; x=1754538583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1I5l9JtN2XKfcSQVgr0NZBS6FBj0g2cp27kvj3ISyo=;
        b=R9aQ54BXQ5AkRMxa7tuH3plAFP2RBQnT6F+YG5E8ooFOUXxzEVvxH6xUJ8abaCIeoE
         YVQlY9FlcKJdfAJEHUECLkRoCT7zS76OVh57B73Z3Ko/F1RAwSihChs3EqYzvpn8ES8E
         6IuZFDikch5Ul3odMVag4lnqaYlneA6fNrlzoIIHvYeEPNH6l75C7U63CDsc8A7DtRgS
         HKk5iCXViVX8lnzSDuN5WiD2sWw96HTuK/pqNN044Z6M6rJh+Xm5pCdnqSM1bjDg9TkO
         tQkRGWzkeXYKuR8IAQxh8IKS/1kOi0vkC9LYgY+a/TU0UYFHDbd3tGAvLnvzqbkMQj2j
         k9Ow==
X-Gm-Message-State: AOJu0YwNlesJJxNqPQhlqm1DQZgVb7Af7DJ+1izxqpMAKF/DJwpDihOI
	G4Vq9y7E/ordYZa5fSDyy8WltJmj+xuT0JksnaHlYDT3ByaJs/eS98hgMIUENw==
X-Gm-Gg: ASbGncvvFk+4rWl+Gy5m9FCGwMbnMgAWXlByE41uf5Mdtu+erLsJsH2RTZLulNeEknm
	Qx9XrbNJcNNfCPRHGV6QwbP1Cubprltwcqd/oZ/Ks7OsrrNAw/gKMyMOoFKzYzKlcjJc8/kO/km
	oi/oNH5f39+kHgHh+HjPFQQKL+ieP0B/iNzcYaKyOpUxRPLQPHOJeMdXVnEjAQPguSpSaHgeWIo
	thQXrDLbFfdGF8w5RrTxqaA+U7ba8kQjpvbMNeE/orn07TEuKnUMVYu8UUTppI2VqGo9XqCsG33
	rwUgkCnY+MmBmEIU/L7NmG9tIJ9Vyr2iPnn6FRsTH5riudjtK4pnD53gcph268vD7gdlfxKFhZe
	CaL0srXyKrSy7jBesrc6NSmg=
X-Google-Smtp-Source: AGHT+IEGbKtTMBkqr5rAxw8lPiL+K2XUmQ1fy/k2oujGwDSG2hVVyVdZsxI5+u5wSSY35+CKlFc9jA==
X-Received: by 2002:a5d:64e5:0:b0:3b7:76e8:b9f7 with SMTP id ffacd0b85a97d-3b794fc18f9mr4740119f8f.10.1753933782448;
        Wed, 30 Jul 2025 20:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47908esm885686f8f.59.2025.07.30.20.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:49:41 -0700 (PDT)
Message-Id: <pull.2022.v2.git.git.1753933780883.gitgitgadget@gmail.com>
In-Reply-To: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
References: <pull.2022.git.git.1753860300588.gitgitgadget@gmail.com>
From: "chenjianhu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 31 Jul 2025 03:49:40 +0000
Subject: [PATCH v2] t7450: inspect the correct path a broken code would write
 to
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
Cc: chenjianhu <18230222379@163.com>,
    chenjianhu <chenjianh@kylinos.cn>

From: chenjianhu <chenjianh@kylinos.cn>

Prior to 05e9cd64 (config: quote values containing CR character,
2025-05-19), a repository can trick "clone --recurse-submodules"
into running a post-checkout hook shipped with the project.  The
test was written to make sure the trick would no longer run the
hook with the fix in the commit.

However, the test did not check for the path the hook would
create; correct the path to the expected one if the bug were
still with us.

Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
---
    modify the “foo" file path to "$PWD/bad-clone/sub/foo".
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com cc: Justin
    Tobler jltobler@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2022%2Fcjhxmx%2Fcjhxmx-git-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2022/cjhxmx/cjhxmx-git-test-v2
Pull-Request: https://github.com/git/git/pull/2022

Range-diff vs v1:

 1:  c2d1d8fe884 ! 1:  6434587a075 modify the “foo" file path to "$PWD/bad-clone/sub/foo".
     @@
       ## Metadata ##
     -Author: 陈建虎 <chenjianhu@kylinos.cn>
     +Author: chenjianhu <chenjianh@kylinos.cn>
      
       ## Commit message ##
     -    modify the “foo" file path to "$PWD/bad-clone/sub/foo".
     +    t7450: inspect the correct path a broken code would write to
      
     -    In the t7450-bad-git-dotfiles.sh, when post-checkout
     -    is executed, the actual path where the foo file
     -    is created should be "$PWD/bad-clone/sub/foo".
     +    Prior to 05e9cd64 (config: quote values containing CR character,
     +    2025-05-19), a repository can trick "clone --recurse-submodules"
     +    into running a post-checkout hook shipped with the project.  The
     +    test was written to make sure the trick would no longer run the
     +    hook with the fix in the commit.
     +
     +    However, the test did not check for the path the hook would
     +    create; correct the path to the expected one if the bug were
     +    still with us.
      
          Signed-off-by: chenjianhu <chenjianhu@kylinos.cn>
      


 t/t7450-bad-git-dotfiles.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index 14b5743b962..f512eed278c 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -401,7 +401,7 @@ test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into d
 	git -C repo commit -m submodule &&
 
 	git -c protocol.file.allow=always clone --recurse-submodules repo bad-clone &&
-	! test -f "$PWD/foo" &&
+	! test -f "$PWD/bad-clone/sub/foo" &&
 	test -f $(printf "bad-clone/sub\r/post-checkout")
 '
 

base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
-- 
gitgitgadget
