Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1528CC33C9E
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6D22075A
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjZKHVhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAHAbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:31:39 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:33495 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHAbj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 19:31:39 -0500
Received: by mail-wm1-f54.google.com with SMTP id d139so15327004wmd.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 16:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sm2JDCQ7x9S+59W7/ghkKziSvfqJlV8aDe0jw85nQ5w=;
        b=XjZKHVhR0WGmlHIb0v6j9j/U6/q0y42V66FwE9xLIFDYqTesHQsuVTz2oCutRVCGju
         az6VTvGo9D49+54NX0MBqwoqV5TpF8E1Zqf6w0ZTyOyT8jOpUlZ8vddmL9Oj9CFA8w6l
         1kBGn/Nbq1Ut7EhdBU7uW6efIorYkckS9/pqt5f0ndryAAutSj0qgkykfHVBXnUslEC4
         A1kOUq5ArZAb3rLED46vf0OYS6oYNy6Xg+zmHXGDcmP+F2dZna+Ds1ILolzcC7Nn02gU
         O7y+CP2n2oWIAWNdz+QYWbCCeSQrQ4aS36cGQbj03dDBUUf9UjlrCFb2SC/g66MLUMHM
         fp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sm2JDCQ7x9S+59W7/ghkKziSvfqJlV8aDe0jw85nQ5w=;
        b=VBePDQ+TY4C0v9KXnrrtR6v53d9tLVNix58p/AECSZR6Viwb0cbwoRo55g7hJzTIIY
         MXKRXWyo2JVb1UkhTfjtpxMNhJffBncYECVGqWHqPThVeEhjHmL8WvTsnnsqvzKAFptf
         2+vEhQtPoITRAlL468YRfv4qgYSGXW2FlnLrdujoJRbml8yD3475PTwn9Zy4NY9sz2C+
         WupzWa6JGnS+uXO2hewSe1gCtO4Ib7x5osIkWmI829mgEB6znYRDhlLO3984O1UgJBp7
         dAoDBDbupvmWpyhuGhvo9dI6K1vt0UlV6Fw3NY3QMZIhxuAKx9h6HOR1WPz9UuiHmGkP
         g+0A==
X-Gm-Message-State: APjAAAXB7RlOuA7usxMnuXx1ge/1mGt5GGfsosl4prYiz3BCo9D3eTos
        2Cllbxh/lSFVkc3PtjIQlMXpPn3f
X-Google-Smtp-Source: APXvYqw8WpAdScPP4Bnqxx0RqGEhFSYfLVK5ZOp6KKStkUvqDRFf4sUh562CQxycuf43u274lStRhQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr863379wmc.21.1578443497946;
        Tue, 07 Jan 2020 16:31:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1609186wmm.15.2020.01.07.16.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:31:37 -0800 (PST)
Message-Id: <pull.515.v2.git.1578443496.gitgitgadget@gmail.com>
In-Reply-To: <pull.515.git.1578391553.gitgitgadget@gmail.com>
References: <pull.515.git.1578391553.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Jan 2020 00:31:35 +0000
Subject: [PATCH v2 0/1] [Outreachy] doc/gitcore-tutorial: fix prose to match example command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example was
changed to use "git switch" rather than "git checkout" but an instance of
"git checkout" in the explanatory text preceding the example was overlooked.
Fix this oversight.

Heba Waly (1):
  doc/gitcore-tutorial: fix prose to match example command

 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 8679ef24ed64018bb62170c43ce73e0261c0600a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-515%2FHebaWaly%2Fgitcore_tutorial_typo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-515/HebaWaly/gitcore_tutorial_typo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/515

Range-diff vs v1:

 1:  ee8636e0ed ! 1:  0c75cd8f97 doc: fix a typo in gitcore-tutorial.txt
     @@ -1,6 +1,11 @@
      Author: Heba Waly <heba.waly@gmail.com>
      
     -    doc: fix a typo in gitcore-tutorial.txt
     +    doc/gitcore-tutorial: fix prose to match example command
     +
     +    In 328c6cb853 (doc: promote "git switch", 2019-03-29), an example
     +    was changed to use "git switch" rather than "git checkout" but an
     +    instance of "git checkout" in the explanatory text preceding the
     +    example was overlooked. Fix this oversight.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      

-- 
gitgitgadget
