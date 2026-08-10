Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07BCA6F
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384415; cv=none; b=MsXRuZSUxHz0kh5Jf26vAedn17TYBw6HHAkuwOCWJJc85ny7ZzlRQjaA0L+FZBZY861VGLywjHRLiK0JiEx0DHO6KzxBRfIZW75O+cFEw03g8ub6tCV49TjKYIq3TM3H6J+eqevSzYsvZJ2dHxwRa5dpaGmA2koFbgQkPGWEnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384415; c=relaxed/simple;
	bh=fawvhSqOKS3xc1UCOdG7FheeKE+PmljwzQ7FBVGY0ug=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MMtzhainZq+2tknZhhyO/jrGrKAw7b2E4d7CTVbnRWXtkZg/4ukUZnmcA0FKnx/W80juFaaJw+IR4Fy3iMpLTi8r+M0y2C0y5asvmotvAHdrClLpdfVb5W5RdM5cmGTzxKP5o7lCLJ3FdMkarz9kBpzPI+vlEE9Vh7/kghwCVKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBOICnqX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBOICnqX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84eb992a881so1594659b3a.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786384414; x=1786989214; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zpdsJ34e51zLahpIdh9goMohE1C2MR0UCMQ5OjYaym8=;
        b=WBOICnqXT+kMC2Jy5gATGLKhQ+hm+KT68vN9ir697cKmnoDjriFVseBt4J43UeDiyv
         HSKsZjSP2VhO4JI40FbHyWNcdpwgc81oZg6TIqzYqa1ct7faxERLTzvrU1uF0thnqG9W
         6psKyZNOlmsnAai3gLWJW+sXZ9wGl4AzrvoUdJS2zuOKrYV1F/CPv3dl8rPvbq4mPTM5
         nrz5veHLFdIJ9+Zr/Pdrvanel/Ppew0OvnkxiRPjc072WV6Msc07ftFuZ7seCnUppRlv
         NTnkvDZiP9Nc9I0nieZSldah/9LCFRi4Y2fPu9hmLFRKfMd5WxWmqlFz184WoGUuxcnL
         jxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786384414; x=1786989214;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpdsJ34e51zLahpIdh9goMohE1C2MR0UCMQ5OjYaym8=;
        b=spKQe1B8kmBP4Drw9zSR49pBUh4QK7nmh2D3olwEdyLa0714Xha1PKw5L1yJldoeAN
         RydLRCcnnf10LU8rtixs8W4Ublrwc6w6uEd9X80V815WWvNDbcYEJZJli1NOHKpcLhKj
         BTVQ7EjysK4GbndKlinik04UyXvrDCBd5S3rX2h9NspMZjdwxz3DFnHBb+5POdaddOBL
         eHDATzZup+XxCr7t0OySEay+FoMkIvsIrfPI2cSiarygSPJ9FYVnDLW5MIOPGU3aI+MO
         7yEENNGczecQYkCyahK1RylgEDE3uVrAIXF3be8Th6fQzHvXy9akrP+xKILMkeKIWU6z
         Rd7Q==
X-Gm-Message-State: AOJu0YzZiweiAGXyS4KBe2lagZpldS7hUxALi2Y3VX6qBqa6cSQnTfSd
	1VZnDI2lb6ISiz1EdD2YH/HXxqKXIxMLBukQqdv93NdRD+4t6gFI/rVzHBGEwg==
X-Gm-Gg: AR+sD12zYxvUbKSzTHCA+3IldwT5XRynARrvT2NJty3bRhVbZv1BZyy4lnrYLd4x3mY
	F7uFpaKuLoXNV2u3QPrlIzIxIQwAcB8/A5pRv2ByYnQE7xwbDBSNKeSvQ9JcibZW4VP46POKFi+
	VzaAZpLoPaZxqtdTbiN+qD6kYqUijYIaYq5UeCur53NCcUlnCm8q4PWx2251KWL8DjQu+IgTbPD
	+ayT0hUuxAWRT/XChGjkIQB5im8+5ygk7KMfAkCSL5egA9qhjR6nMrI30/zt8fKDLirFsLLG/cS
	F6oLluau5nfeiF8vO3edEToZo9eL2GaURVIf0GAggBeu3kh5vo7jVRhVsP8TIChI+XQE+70c5fa
	AaI5WI4dNkriMNLjb/A5Tj13mkFWvHkG1FOLx1eiiqawO+J793s6eLmvLx5RHIfRFnbK24rBseA
	wQ/WQOYSh2VNCw1mx8PFE6zbsPej7HOvxscbr6rJYHMDl2k/cBg4feq2J5fS8V9DjF+Q==
X-Received: by 2002:a05:6a20:9c94:b0:3c3:91f5:82c2 with SMTP id adf61e73a8af0-3cbadb861admr35318963637.16.1786384413720;
        Mon, 10 Aug 2026 10:53:33 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.200.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a6809sm47252323eec.10.2026.08.10.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 10:53:33 -0700 (PDT)
Message-Id: <pull.2375.v2.git.git.1786384412423.gitgitgadget@gmail.com>
In-Reply-To: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
References: <pull.2375.git.git.1786267394375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 17:53:32 +0000
Subject: [PATCH v2] send-email: clarify missing subject error
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

Clarify that a message file is missing a 'Subject:' line.

Terminate the error with a newline so Perl does not append its internal
source location.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    send-email: clarify missing subject error
    
    Explain the required Subject: prefix when a message file has no subject.
    Terminate the error with a newline so Perl does not append its internal
    source location.
    
    Changes in v2:
    
     * Remove the incorrect claim that Subject: must be the first line.
       Report the missing header directly as No 'Subject:' line in '<file>'.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2375%2FHaraldNordgren%2Ffix%2Fsend-email-subject-error-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2375/HaraldNordgren/fix/send-email-subject-error-v2
Pull-Request: https://github.com/git/git/pull/2375

Range-diff vs v1:

 1:  fe4171b0dc ! 1:  7002c5d5f1 send-email: clarify missing subject error
     @@ Metadata
       ## Commit message ##
          send-email: clarify missing subject error
      
     -    Explain the required Subject: prefix when a message file has no subject.
     +    Clarify that a message file is missing a 'Subject:' line.
     +
          Terminate the error with a newline so Perl does not append its internal
          source location.
      
     @@ git-send-email.perl: sub get_patch_subject {
       	}
       	close $fh;
      -	die sprintf(__("No subject line in %s?"), $fn);
     -+	die sprintf(__("No subject line in %s. " .
     -+		"The first line must start with \"Subject: \"\n"), $fn);
     ++	die sprintf(__("No 'Subject:' line in '%s'\n"), $fn);
       }
       
       if ($compose) {
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'detects ambiguous reference/
      +		--to=nobody@example.com \
      +		no-subject.patch 2>actual &&
      +	cat >expect <<-\EOF &&
     -+	No subject line in no-subject.patch. The first line must start with "Subject: "
     ++	No '\''Subject:'\'' line in '\''no-subject.patch'\''
      +	EOF
      +	test_cmp expect actual
      +'


 git-send-email.perl   |  2 +-
 t/t9001-send-email.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bb8ddd1eef..2071cff6ae 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -863,7 +863,7 @@ sub get_patch_subject {
 		return "GIT: $1\n";
 	}
 	close $fh;
-	die sprintf(__("No subject line in %s?"), $fn);
+	die sprintf(__("No 'Subject:' line in '%s'\n"), $fn);
 }
 
 if ($compose) {
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e9d814a34a..d1393ef197 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1422,6 +1422,21 @@ test_expect_success $PREREQ 'detects ambiguous reference/file conflict' '
 	test_grep disambiguate errors
 '
 
+test_expect_success $PREREQ 'missing subject omits Perl location' '
+	cat >no-subject.patch <<-\EOF &&
+	This is the body.
+	EOF
+	test_must_fail git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		no-subject.patch 2>actual &&
+	cat >expect <<-\EOF &&
+	No '\''Subject:'\'' line in '\''no-subject.patch'\''
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ 'feed two files' '
 	rm -fr outdir &&
 	git format-patch -2 -o outdir &&

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
