Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45001C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DBB60F4B
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 17:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhG3R74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jul 2021 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3R7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jul 2021 13:59:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F9EC06175F
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z4so12348815wrv.11
        for <git@vger.kernel.org>; Fri, 30 Jul 2021 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr59/iGAXKJvhR+a9kdpCdsOayGaxsyutvxwMdiKPHI=;
        b=hq7J+a+bXgG4eHVZRD0bJbFgMIFKyS/rYOjqwdhzsMlrEBo4Vax0YvnhzqBj0i7aLE
         ACqDYs3/ToYH6I7WUB4z7tj1LF+jNgExsLsWqniw6Xa9imIHdTn2FNXLv2pH8z6pwYge
         5OpWATIUlbkfg0iSkFmIGWDHzzL13hkHcWwgsVxGM1qRpHrWsCg+xPz/aBC2QXIJK39j
         TcOSy+zdmLa/Lv+/ZO0ZxCzhn7L9xRh1FkNf/XNY4AxOiK0SsyZ+ni5eKy9pNvyUzPt1
         o268O5APWjAF7AqRyrCHeyaaV+9J16CbWh/2mCfiNENGKNZM+OQB3XNv2tLS2b3d8LCj
         VUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr59/iGAXKJvhR+a9kdpCdsOayGaxsyutvxwMdiKPHI=;
        b=emoxVmFq66dd470+g3Jzhh8cB2V8nwP5DLKWJ1eQBkjKGJpI84VzKTkoWqiLx2IvXF
         yY8G+CsrLtETkycK+i+OwB0o4jrxCI5gfVPE5E5yfF5CeF5q1hJtC9QG9lHuU6GUZQYP
         jbstcmNw093iXXEW5fVqkI8llAVoi8OymO9YnFisGbzfIfCLQpw+tWlXTG5EPqex5pVW
         Tep35NRfbAQOkGob8IOFqNoyxIxQyoFXBWaJ6ucXlPv0Iw3mlCDPeyJ04EDPKyida9ps
         Jj6Wrv9YpP/EZHBmO8dhWJ/qKf4anwY65YGYyRnjLnhAU5V8PmY5OBMRj3BYHhIeSdXg
         9mng==
X-Gm-Message-State: AOAM532sRah9TJHN1T1T63h76EZBJ/OGieq+vNJKBNsb05F5d5ryLiib
        42ndX12TEOzOJaOLBxj3wkWbRGpjw2UDBQ==
X-Google-Smtp-Source: ABdhPJxLsS4qbYyQWv9qGQ/Y4NQw2RZT7TI3BQlSGt7RipJMwWtLj/rc+7QcRyLHykJzLIOC/UiBwg==
X-Received: by 2002:a05:6000:1149:: with SMTP id d9mr4497732wrx.26.1627667988752;
        Fri, 30 Jul 2021 10:59:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i186sm2540311wmi.43.2021.07.30.10.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 10:59:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] drop support for ancient curl
Date:   Fri, 30 Jul 2021 19:59:41 +0200
Message-Id: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.1071.g36f34456314
In-Reply-To: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20210730T092843Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the feature creep feedback on v3 this v4 ejects the two new
changes new in v3. The below range-diff is against v2, not v3.

I dug into the 7.16.4 v.s. 7.17.0 documentation issue and found that
it's bug in curl's docs, for which I submitted a patch.

I considered keeping
<patch-v3-5.7-b857a9ef7b1-20210730T092843Z-avarab@gmail.com>, but
sequencing it in made the range diff quite a bit larger, so per the
feature creep feedback I ejected it too. Junio: Perhaps you'd like to
cherry-pick it on top too, or it can be dug up post-release.

Jeff King (3):
  http: drop support for curl < 7.11.1
  http: drop support for curl < 7.16.0
  http: drop support for curl < 7.19.4

Ævar Arnfjörð Bjarmason (2):
  http: drop support for curl < 7.19.3 and < 7.17.0 (again)
  http: rename CURLOPT_FILE to CURLOPT_WRITEDATA

 http-push.c   |  29 +--------
 http-walker.c |  14 +----
 http.c        | 169 ++------------------------------------------------
 http.h        |  46 --------------
 imap-send.c   |   4 --
 remote-curl.c |  11 +---
 6 files changed, 10 insertions(+), 263 deletions(-)

Range-diff against v1:
1:  dcbb6f95652 ! 1:  6bd41764a54 http: drop support for curl < 7.11.1
    @@ Commit message
         Drop support for this ancient version of curl and simplify the code by
         allowing us get rid of some "#ifdef"'s.
     
    -    Git will not build with vanilla curl older than 7.11.1 due to (at
    -    least) two issues:
    -
    -      - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
    -        (http.postbuffer: allow full range of ssize_t values,
    -        2017-04-11). This field was introduced in curl 7.11.1.
    -
    -      - our use of CURLPROTO_* outside any #ifdef in aeae4db174
    -        (http: create function to get curl allowed protocols,
    -        2016-12-14). These were introduced in curl 7.19.4.
    +    Git will not build with vanilla curl older than 7.11.1 due our use of
    +    CURLOPT_POSTFIELDSIZE in 37ee680d9b
    +    (http.postbuffer: allow full range of ssize_t values,
    +    2017-04-11). This field was introduced in curl 7.11.1.
     
         We could solve these compilation problems with more #ifdefs,
         but it's not worth the trouble. Version 7.11.1 came out in
    -    March of 2004, over 13 years ago. Let's declare that too old
    +    March of 2004, over 17 years ago. Let's declare that too old
         and drop any existing ifdefs that go further back. One
         obvious benefit is that we'll have fewer conditional bits
         cluttering the code.
2:  1c9f3bc031b = 2:  fb308258e2b http: drop support for curl < 7.16.0
3:  faae88b7fec ! 3:  fba5560a3ba http: drop support for curl < 7.19.4
    @@ Commit message
         http: drop support for curl < 7.19.4
     
         In the last commit we dropped support for curl < 7.16.0, let's
    -    continue that and drop support for versions older than 7.19.4. This
    +    continue that and drop support for versions older than 7.19.3. This
         allows us to simplify the code by getting rid of some "#ifdef"'s.
     
         Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
4:  9a30e92520c ! 4:  42d1c72ff7e http: drop support for curl < 7.19.3 and < 7.16.4 (again)
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    http: drop support for curl < 7.19.3 and < 7.16.4 (again)
    +    http: drop support for curl < 7.19.3 and < 7.17.0 (again)
     
         Remove the conditional use of CURLAUTH_DIGEST_IE and
         CURLOPT_USE_SSL. These two have been split from earlier simpler checks
         against LIBCURL_VERSION_NUM for ease of review.
     
         The CURLAUTH_DIGEST_IE flag was added in n 7.19.3[1], and
    -    CURLOPT_USE_SSL in 7.16.4[2], as noted in [2] it was then renamed from
    -    the older CURLOPT_FTP_SSL.
    +    CURLOPT_USE_SSL in 7.17.0[2][3], as noted in [2] it was then renamed
    +    from the older CURLOPT_FTP_SSL.
    +
    +    The documentation[2] currently claims that it was introduced in
    +    7.16.4, but the symbols-in-versions file correctly states
    +    7.17.0[3].
    +
    +    I've submitted an upstream
    +    patch (<patch-1.1-953bab490-20210730T170510Z-avarab@gmail.com>) to the
    +    curl-library mailing list fix the documentation.
     
         1. https://curl.se/libcurl/c/CURLOPT_HTTPAUTH.html
         2. https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
    +    3. https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
5:  64e510b4a6b = 5:  e34ab1d1f65 http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
-- 
2.32.0.1071.g36f34456314

