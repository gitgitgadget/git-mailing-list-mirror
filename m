Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C09C47257
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1BF2084D
	for <git@archiver.kernel.org>; Sat,  2 May 2020 21:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPWu00d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgEBVF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 17:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgEBVF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 17:05:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028BDC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 14:05:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so1783831pjb.0
        for <git@vger.kernel.org>; Sat, 02 May 2020 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Vbx96IPbiYgcyQ5+APJeqtdXDVyZgcQC29MTZqlA1RY=;
        b=bPWu00d8lOBhp1rcgDiMF1hG8cshJ/TZzUMOGFhBKMSgXhevnT/vAzqoXFSOpSDQlz
         2HigPShmA2fzsA1kl51Mv4mYY23EIJSFHnzetnpxwkn3wKbD1Zs2hb5HuWQUeWImT3TL
         vRRLD6p05z30DNN/cpl+c0rc5kYJ7CqXgUlO6cI0SE3FQKErx4FxfAhcDvVB5fin0FLS
         V2LPymwflG+AarsxbbS8u20aiJo6k6izlaRP0+tcSCcMgWG/cK1T9zeSC8l8yVHifx5H
         87xFgvDgnhDC02SPKdyh1NAtny7YjLpizbUk92SSqvXE5WJqkGEIW16V7lfqwl56mNKK
         CqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Vbx96IPbiYgcyQ5+APJeqtdXDVyZgcQC29MTZqlA1RY=;
        b=G70JF4VDA+11n1ezOKMbu+hnpl1pryvgBz8mXG0t0D8Wn9Q6FgXKJxv6mO2j02RyHi
         RZVO2aPaWPmtJ79c22PHrYhzv27Gxrm+SPYJ0x+7X0oxlMrlHifgp5xWp4x3RAXkyMYz
         9eUNwoKhQgMPL4NZCm3JiuwjumNkzKjlrC0RiG+yyxCY6CbBbnDpZT2BpZuNXT5OcAQT
         xTwcWnd/b3MbkrkvyyumZNVa07cp2FeI2na+NWXa4nshDQ3r/WktlE/bXW+kS0YjGDhL
         vXJadJ/IAKAA3lqZA4H5IXAwtBABZgXFMk/leQ+rIwTvVJwDlkyVa30BkAuWee3DLmXP
         9MhQ==
X-Gm-Message-State: AGi0PuY+ST1O2vHrCAW6oDbk9HRrnehJsKLpBO5vVlUKdlmNtjoq/HgY
        4ErauGqdTJLB7tzVUozcaBs=
X-Google-Smtp-Source: APiQypIkhy60NvxYnkeIaFlxym1psC2wjBNVX986uvpnVkEi5XTDzW5m7CixaLH+56ZtrkYKO9J2RQ==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr10555867pls.291.1588453555306;
        Sat, 02 May 2020 14:05:55 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id gl12sm2813759pjb.27.2020.05.02.14.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 14:05:54 -0700 (PDT)
Date:   Sat, 2 May 2020 14:05:53 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     dirk@ed4u.de, sunshine@sunshineco.com, peff@peff.net,
        jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v10] credential-store: ignore bogus lines from store file
Message-ID: <20200502210553.GA41113@Carlos-MBP>
References: <20200430160642.90096-1-carenas@gmail.com>
 <20200502181643.38203-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200502181643.38203-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dscho,

this was tested[1] in windows and was able to reproduce the bogus issues
with credential store in macOS using t0302.50

[1] https://github.com/carenas/git/actions/runs/93858709

Junio,

will followup with a more comprehensive fix for the problems with '\r'
which will obiously need also changes in credential.c, but that IMHO might
be more of a prerequisite for the next iteration (the one that warns)

would be very helpful if you squash the following, otherwise

Carlo
-- >8 --
Subject: [PATCH] SQUASH!!!

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t0302-credential-store.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 9fd0aca55e..a05b64c8b3 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -120,7 +120,7 @@ test_expect_success 'erase: erase matching credentials from both xdg and home fi
 '
 
 invalid_credential_test() {
-	test_expect_success 'get: ignore credentials without $1 as invalid' '
+	test_expect_success "get: ignore credentials without $1 as invalid" '
 		echo "$2" >"$HOME/.git-credentials" &&
 		check fill store <<-\EOF
 		protocol=https
-- 
2.26.2.686.gfaf46a9ccd

