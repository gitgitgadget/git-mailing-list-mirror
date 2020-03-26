Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D6C2D0E5
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CE420714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uB8dfetn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgCZPff (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:35 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:45426 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgCZPfd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:33 -0400
Received: by mail-ed1-f47.google.com with SMTP id u59so7271080edc.12
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=uB8dfetn+lxKtKvgj63c1y3ilKQKvZQwKXLT4oxMGhF41V7LckGFi6mLq64y25qTMt
         LuDxM+DzWFNKPa4++cvRGKCdwxcJXiFC+0qD3flFNK/Wm9afck1WB8GzOOFSkxGQy1rK
         9Ulw/rmTvPCCSipIlLqJJTAxqoeibaxsmAPeTytPbIzpVuXyXNn4PCO7db8Y46qgZSA1
         p67CZ53rODghIo5pnCHYrSubTXe5ienoy62aM9c44Nqf5wJUlWTi9jCbNw/RMEacx/rR
         UpNBaLT2kdeWgv02veI5vXNm08PfqIWtYXjCoMU/cVgPhsrBnKBOHy7hVqa1E4L5RBp3
         +WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=JZdt43pP8Joff4oag7Whr6nsUpRZtNd8I0z2legEwMRXIOGdantRvRS4Ef8y0CyLxi
         R8gMdBG/unPgujMmHrpHIVfWMAZiMRs6IYDN7+AtKg3TVDs4SzewZmnwu6fbqJ86pDoZ
         psrGhPMu4ZmLh4mA41TxK4CrytaMIviKDcGLnetjmlzACswOMlNQUJ91t3V5b8Aq/5KL
         zVfOUlnTrwSMcmQfi/ZHeBjTwxHBZL0g8lSYfhYXuaGUDvxP2SliMK76+3gSSo0XxMbh
         2Tubd8GghYCFJKGxsD+qVXRSguS7L9zkjNVdTM05Jlwyew98Fdspe0/U+LanRpBF9vq3
         Zs8g==
X-Gm-Message-State: ANhLgQ30v2SS0aFL/HBmdUugMsfUG8mhg41WqLQmhBiwVEo5+cI0dkzy
        89f1Tu7WJ8O1R7Wrh1OaJAadZMwi
X-Google-Smtp-Source: ADFU+vswB2H5QCSWx0IPlI9t8AcODfm8yRETd3n99HyU6Sb7Pyg+w9TZGstza6bjSCQaQ5kU71c0hA==
X-Received: by 2002:aa7:d581:: with SMTP id r1mr8787240edq.335.1585236930958;
        Thu, 26 Mar 2020 08:35:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm329799ejx.53.2020.03.26.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:30 -0700 (PDT)
Message-Id: <287a21f1033b2a74420029c529ad4db956051a85.1585236929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:24 +0000
Subject: [PATCH v3 1/5] tests(gpg): allow the gpg-agent to start on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows' SDK, we use the MSYS2 version of OpenSSH, meaning
that the `gpg-agent` will fail horribly when being passed a `--homedir`
that contains colons.

Previously, we did pass the Windows version of the absolute path,
though, which starts in the drive letter followed by, you guessed it, a
colon.

Let's use the same trick found elsewhere in our test suite where `$PWD`
is used to refer to the pseudo-Unix path (which works only within the
MSYS2 Bash/OpenSSH/Perl/etc, as opposed to `$(pwd)` which refers to the
Windows path that `git.exe` understands, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 8d28652b729..11b83b8c24a 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -29,7 +29,7 @@ then
 		#		> lib-gpg/ownertrust
 		mkdir ./gpghome &&
 		chmod 0700 ./gpghome &&
-		GNUPGHOME="$(pwd)/gpghome" &&
+		GNUPGHOME="$PWD/gpghome" &&
 		export GNUPGHOME &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-- 
gitgitgadget

