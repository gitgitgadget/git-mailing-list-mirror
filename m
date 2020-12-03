Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766E0C433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2443F208A9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLCSzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLCSzu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:55:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068CBC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 10:55:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so1667586plb.4
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 10:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZNRcjwYLfS3UX2eUnAvLLFyYUafqe5hxo9V+wU1OWgs=;
        b=rKcSWeTQtw5G3NNiL/bitTeisNl8ejruAjpjJkKe6lA1PBVam8zY4o4dRyDvCQc6sG
         E29AnFA2SJKzmXplf+6SsbB/Olww8fy+925SkQtZdlO6VzbzGEPqdUmnx08Ke9naaMzJ
         ZagaycGrXUqF41YWCsug1j1c8HT0ceGZAJteK670VFxEeimAtoiTKcmFt0g+AkmcTN9b
         i06miJPxHGvshc/MG6mjjTlZxU0oWEQC5yBVdFGbdQj1xqq+GZETRXcRkt8XDPMdjixr
         0eR/voUqieISBRjVelZ1sjI21Bdn3RSJRGlh6ZXLIdsAFHifNfWYDMAxsONWOQJAz4bU
         4zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZNRcjwYLfS3UX2eUnAvLLFyYUafqe5hxo9V+wU1OWgs=;
        b=KzWeSrXHigp2rcHulR3TMmA7UbUn1Gt0ffoy2QyVOyiucm36EyGJvtiBg6b+LVoXtu
         eYcK+2RWc2vPd9UvuJWTv6XgjDUdVnbVdSqKYtJ5n0th3rF1+e7FliMVZ5DTHMdTReEg
         xyRUIJhc1NTdnW3IaUandblKQ3wJbkc6Wr2wycfNKbqAmS3h+m5M4UIXpiMTb/Cq50n1
         mKPO6g+XsH/4mEEBGVfVT0c0LHnWdc0TkUZ4ZPwFN7YmccCGe6PINuIUWkf83spOTG+j
         5qDDGv8+MI6rFcITxv5LQGG40NOtOCc5UXHhqBgxNQi48musWYKWRtfEcyjCIHLtasz6
         V3Xw==
X-Gm-Message-State: AOAM533VGgDip4vdhLsssLEhlwX46pq6Jbw8k3aYQ8Iy2DpxE9F45bXx
        DhcrT44YNRKgZm30WNqOT49G7hpBXmywc+si
X-Google-Smtp-Source: ABdhPJwlZocGvBF0xqOxMjb27F3hDsCsnfmV0qPJ5OmfUqLyhC1pRHMFWF0kz9DxBKn/4PORdYmcDQ==
X-Received: by 2002:a17:902:44e:b029:da:b944:b798 with SMTP id 72-20020a170902044eb02900dab944b798mr571040ple.6.1607021709156;
        Thu, 03 Dec 2020 10:55:09 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w14sm2571964pfj.53.2020.12.03.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:55:08 -0800 (PST)
Date:   Thu, 3 Dec 2020 13:55:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 0/2] upload-pack.c: fix partial clone allowed filter
 regression
Message-ID: <cover.1607021483.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's a regression fix that I noticed this morning while deploying 2.28
out to GitHub. The gist is that we accidentally call
'string_list_clear(..., 1)' when freeing the list of allowed/banned
object filters, but the ->util pointer either contains '0', or '1'. So,
the free() of the util pointer is bogus, and we end up crashing.

The fix in the second patch is straightforward, but it doesn't work
without the first patch, which teaches 'git clone' to match 'git fetch'
and not ignore an error from 'transport_fetch_refs()'.

Unfortunately, this regression has been in Git since 2.28. Fortunately,
nobody has seemed to notice, so I doubt that it's bitten anybody out in
the wild. But, it's still worth fixing, since it is so obviously broken.

Thanks,
Taylor

Taylor Blau (2):
  builtin/clone.c: don't ignore transport_fetch_refs() errors
  upload-pack.c: don't free allowed_filters util pointers

 builtin/clone.c          | 15 +++++++++++----
 t/t5616-partial-clone.sh | 10 +++++++++-
 upload-pack.c            |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

--
2.29.2.533.g07db1f5344
