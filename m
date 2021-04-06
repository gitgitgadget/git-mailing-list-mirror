Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63AC433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2FF613CB
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 10:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbhDFKPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhDFKPo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 06:15:44 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621AEC06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 03:15:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l123so8557060pfl.8
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VN04+Zbgq8Y3Y82M3y9toOeQrFVEb+XvOs8l4c5/o70=;
        b=Z34M5DlagV8I4fy7fAD9GQ0Ss9M+m6BbIp7iOqoxUefqJRYHNwKoqjXes8ONMSu/K1
         xOBUWb3uz9dhNetuOPPASYrKmJuwYs4JsZdoDEGWBTFayVgRBB7wGAz9XktQOg6Sm1ww
         5b3EA7MfzDSGDim3JtTaIxjXWfSk0oBNTpI23MS8fh5SSNP6APg+UcVbf72ENzwcQgqt
         Tdn2UeY6eCO227rb3M30xRpIQshSw8YlVxqyF5PWs+6oqMklZLd0r2Ij+a6Uz5nu5tWM
         ES9G3hoHP66mOvWGLemyLB8O5Vl5XsVEmIjOR4vu2v6uSHD8RGre5kuoNbm+N1sYlRTm
         JtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VN04+Zbgq8Y3Y82M3y9toOeQrFVEb+XvOs8l4c5/o70=;
        b=ClUqqL5+jql2wMNzm60WhPtEsFOqjU+wHo3Ae/eKtNVb0mpwRfPiyzW3T7fvuntv9p
         Uc8XsV9+vlUh6W+Ox7yZtiVeye26yIPB48Umgy7CkKDC1WvEZfw13LP1VrK7hZB259dX
         Ap2v3bdAPVGIzY0QGmcxa+cfQcuvIlsCRY01pBcNECk4k9Yw8zl55mNyQzVFIHMZztq4
         N5D202cCA7Sxsp5iUZui1C9rR6IT1z3UWl4gxLnulWdE9bg/gzeX/1oKVnErVMT4DZwf
         kgYF8WrRBja+6jybllj3o34Zh7dcmDeHZ3BT1Npm9/1iZX7LtWebI1cj5M0v3qMza1vC
         R5MQ==
X-Gm-Message-State: AOAM531AShsMZZO2F+/UwR2u7f4uJt9Sacw1xJ4Q/ZrQBRMIY34UHYnW
        tl44izmSz+/xeihWtdL0c9pFfAHzox9WWOfjMuD8DklaZT2Nsw==
X-Google-Smtp-Source: ABdhPJwe4H0IXoUTzZglrWg52p2FLN6RdaNDk3KklRvgcXu9EJkt2jIz/EZFLfYjuWms2QRB/B+v192dZ+SZApMjmAk=
X-Received: by 2002:a05:6a00:acb:b029:23d:60f9:5471 with SMTP id
 c11-20020a056a000acbb029023d60f95471mr3449366pfl.77.1617704134647; Tue, 06
 Apr 2021 03:15:34 -0700 (PDT)
MIME-Version: 1.0
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Tue, 6 Apr 2021 12:15:28 +0200
Message-ID: <CAMJzOtyzu8y5mWdKXe3MPe8ZoJs8O=me8Xuu0t77YVdAMc7Tgg@mail.gmail.com>
Subject: [Bug report] diff.noprefix config is ignored for interactive `add`
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:
1. Run `git -c diff.noprefix=true add -p`

Expected behavior:
`a/` and `b/` prefixes are not shown during interactive `add`
like this:
```
diff --git foo foo
index 257cc56..1715acd 100644
--- foo
+++ foo
@@ -1 +1 @@
-foo
+bar
(1/1) Stage this hunk [y,n,q,a,d,e,?]?
```

Actual behavior:
`a/` and `b/` prefixes are shown instead. Like this:
```
diff --git a/foo b/foo
index 257cc56..1715acd 100644
--- a/foo
+++ b/foo
@@ -1 +1 @@
-foo
+bar
(1/1) Stage this hunk [y,n,q,a,d,e,?]?
```

[System Info]
git version:
git version 2.30.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.4.98-1-lts #1 SMP Sat, 13 Feb 2021 19:22:14 +0000 x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh

[Enabled Hooks]
