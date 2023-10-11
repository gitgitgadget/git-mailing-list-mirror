Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B652CD6E7E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 15:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJKPYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJKPYf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 11:24:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1D92
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:24:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so11432469a12.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697037871; x=1697642671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GKm4ogqbRLZf0TuKOUarHG9+OKmfgKJ5kANtc87p+A=;
        b=XlO21QpBFBwbASOc3Gayh2iP9J9xpqxNGAPr+RXPvXGB3vvUoV6hf99B2nbvfr5/Yr
         h965qEVXqf+/gX/lyf9mIBn3gyXhbuaoAdxyR8gb+NX6awSM73NlUk7/NlFQI5uVCLG8
         xIV0EEJnbgYt4RGF1tQk4Cn21Q9ICn5eno6NwZ4IypBRx/yKkOeQsIR0EZwA1Qauuk6X
         2YwAFdq33F2Rq8vM8NAShJp5xdlBQWDpiVd6qQ4/t/cgxf1eSM9mQUWRpNX5dNcj4cRf
         bVhuxHiq/slM8D7TgK5XxThTUwBR5z8UPSklWrM8JoHSmzKNzO7aBLJQtfJ8mkNFJhDi
         M50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037871; x=1697642671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GKm4ogqbRLZf0TuKOUarHG9+OKmfgKJ5kANtc87p+A=;
        b=NWsc01OwTVbZFubJ5v77Peg8ONE6S5lLY8SBSaJF3JAxaDaFO8Buvq08yjgEx3NWKJ
         vBkGPHEGR0chIXGbUx4KEf8emWOnXkDSr9LgFpvoAzCqJtM4mncKxxmUjdXvPwwZy1yl
         Tt9o9h6tUjSLyhe49ASpfpL52XlDIKJPE+yAA0zUVKqAYwkwjHwAKt0hPGzeoblh0//U
         Tn12Is5QvETNVkU33RATshA9Dvndv11jskHyJJFLoq1ZDMFZiuu0hzBUUSASCcoSZ3oE
         pAJy7DXyZ2KR/PJ8yrGyVfb4PemI5BNL6GICe9RT72EB6LTNyY0pV0X78UH/F0je8O8y
         zrkA==
X-Gm-Message-State: AOJu0Yxa3YESCj6fDl1riKOzeFq3UKZVwT+NFORYwSBa47dldMTHfAPi
        8skrDnntJdcJWKqr41PxZAW4l6MfU5vt3kqKn3E=
X-Google-Smtp-Source: AGHT+IGZIcoA4yC4yE7ZO7OxZAtugLLnWkUfcqAPxaSKefbzbI2zFDC+151FiZy+f2e7ZDXmonMIfQ==
X-Received: by 2002:a17:906:9c9:b0:9a1:bd33:4389 with SMTP id r9-20020a17090609c900b009a1bd334389mr17875750eje.74.1697037870444;
        Wed, 11 Oct 2023 08:24:30 -0700 (PDT)
Received: from isoken-VirtualBox.. ([197.211.58.63])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm10112856ejv.14.2023.10.11.08.24.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:24:29 -0700 (PDT)
From:   Isoken June Ibizugbe <isokenjune@gmail.com>
To:     git@vger.kernel.org
Subject: [Outreachy][PATCH 0/1] builtin/branch.c: ammend die() error message
Date:   Wed, 11 Oct 2023 16:24:19 +0100
Message-ID: <20231011152424.6957-1-isokenjune@gmail.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch improves the consistency and clarity of error messages across Git commands. It adheres to Git's Coding Guidelines for error messages:

- Error messages no longer end with a full stop.
- Capitalization is avoided in error messages.
- Error messages lead with a description of the issue, enhancing readability.

Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>

Isoken June Ibizugbe (1):
  branch.c: ammend error messages for die()

 builtin/branch.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

-- 
2.42.0.325.g3a06386e31

