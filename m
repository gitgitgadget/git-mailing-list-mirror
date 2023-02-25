Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95712C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 19:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBYTFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 14:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYTFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 14:05:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C018AA9
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 11:05:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s26so10007351edw.11
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 11:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwNKcaIY3gTCblxErLVma+ZasCemheQ1/+T/wnfLj5E=;
        b=Y+6TrtMmKqAncofPYt+G2BxfZ7uy9wHKe0BThBn+ZrOfcEKqTd7/GiQb8lMEKdVwT5
         BuiwsI/EtHhAPgd9Xk5AHYd5A897fFg6UX7IE3cFIH8lUn3M2AMxNsHpOcMTw540O+gv
         2om9mL08d6cb3G4HDJoF4PiNEncgDqJSJjdSyqNZj1RlgqrYM3uD4LS2gzKB0jHS0FY+
         bkplkyY0Q8Z8MRXba331ikxWvZuzjwzRpMp/BxAf/ohJliakoYI1vrV7v3qgJQmw6Uos
         xGJQicKIfw+eIy4AF2rHMEBM8FU1MVSB68w7UaCmJhXupykfigUFWJ2O0Sad70RBRxhj
         CXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwNKcaIY3gTCblxErLVma+ZasCemheQ1/+T/wnfLj5E=;
        b=R7YVZ0VI0EUEy4g08vEVAeJqk4fW7uOpRXJQNcV8aGnEStHJ5IjuvOzXDtgdM9EP7n
         Xvmh811CnNXxj4dtS1ZhI3+pK0lmp7Rz4X0aUrVgNdAW6iKPY0w39LhCpjVIxEowz/oY
         nfcx9f/BCQtJbXa54/c4ZP/8UdKlOq5Fcoo0ATcP7vu1JALAKX2t4OmVKqAS944JjsFc
         By0Od3YeBjQsUuxC03EGVtJjmc8JYobYJFOOKhJT2WqO9nQl0ofx0I2kF4Du23wzmx0P
         zUkYkDsMgD0x7qQrT7NHEVASWTz6r+HWOAfGlHgYJ5sGLr65D+aSkAvaAf+GbD5LflTb
         OfQw==
X-Gm-Message-State: AO0yUKXyzhersRnsU8ztDV9EqTxNk+KPWm6zFQX0rlIV1XlylVLEUsbR
        o9ArjplCXXYkhs2LbINXc3LWD59ZBqU=
X-Google-Smtp-Source: AK7set9JqtdPUAX/CYg4Us1AkD8JwKq9Mx/5XWBrb1toKE20keddOgPXxtL1E/6BKmz65E7SvWN0ew==
X-Received: by 2002:a17:907:8d17:b0:8f0:4a90:a764 with SMTP id tc23-20020a1709078d1700b008f04a90a764mr3622647ejc.23.1677351928331;
        Sat, 25 Feb 2023 11:05:28 -0800 (PST)
Received: from titov.fritz.box ([216.24.216.236])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b008dceec0fd4csm1108982ejz.73.2023.02.25.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:05:27 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2] test-lib: drop comment about test_description
Date:   Sat, 25 Feb 2023 20:05:26 +0100
Message-Id: <20230225190526.21780-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230221232245.155960-1-rybak.a.v@gmail.com>
References: <20230221232245.155960-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a comment describing how each test file should start was added in
commit [1], it was the second comment of t/test-lib.sh.  The comment
describes how variable "test_description" is supposed to be assigned at
the top of each test file.  However, even in [1], the comment was ten
lines away from the usage of the variable by test-lib.sh.  Since then,
the comment has drifted away both from the top of the file and from the
usage of the variable.  The comment just sits in the middle of the
initialization of the test library, surrounded by unrelated code, almost
one hundred lines away from the usage of "test_description".

Nobody has noticed this drift during evolution of test-lib.sh, which
suggests that this comment has outlived its usefulness.  The assignment
of "test_description" and the process of writing tests in general are
described in detail in "t/README".  So drop the obsolete comment.

An alternative solution is to move the comment down to the usage of
variable "test_description".

[1] e1970ce43a ("[PATCH 1/2] Test framework take two.", 2005-05-13)

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---


  On 2023-02-22T00:22, Andrei Rybak wrote:
  > Move the comment describing how variable "test_description" is supposed
  > to be assigned to just above the usage of the variable in test-lib.sh.
  > 
  > An alternative is to just drop this comment, since assignment of
  > "test_description" and the process of writing tests in general are
  > described in detail in "t/README".

Here's the alternative solution described in the commit message of v1.
I put the RFC tag in the subject, because I'm not sure which of the two
approaches -- move in v1 or drop in v2 -- is better.

 t/test-lib.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d272cca008..62136caee5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -645,12 +645,6 @@ u200c=$(printf '\342\200\214')
 
 export _x05 _x35 LF u200c EMPTY_TREE EMPTY_BLOB ZERO_OID OID_REGEX
 
-# Each test should start with something like this, after copyright notices:
-#
-# test_description='Description of this test...
-# This test checks if command xyzzy does the right thing...
-# '
-# . ./test-lib.sh
 test "x$TERM" != "xdumb" && (
 		test -t 1 &&
 		tput bold >/dev/null 2>&1 &&
-- 
2.39.2

