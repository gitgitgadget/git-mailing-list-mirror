Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12E8C6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 14:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240684AbjDGOYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240670AbjDGOYW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 10:24:22 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBAA24A
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 07:24:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-545e907790fso682887477b3.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 07:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680877460; x=1683469460;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycaMS4xZyE8p3zpx736r8PjNnCvNBJaKBn2+Q0humOc=;
        b=oTlS+TFB2mSDkCqvMNE0a8jA8iFGuYHpwO0lyqdlb8YFrjM7x4usQ9VEt28rJSKOsV
         3McIShDOPYpir+zCWjRuMjHMxK2afL+SJyhlBXJJeqi1THWM4pxwUa2Uo21Aysyv9esa
         Aawp8IIZrsS//5AQ4NqEnecnDBE9Ib0IP0n6EWEpyag2MPsqCkBppTrwT4LOTEHMvOpT
         cCi1Id/qznLLDh5E+fV5bDeA/eaNA73QhvTH5xM1IIMDWZTxkIxxPFSX8o2sorDDR1te
         BC48M/+BqRtI9QkfdZCx3LwsQ2av4++4O+csuWgOkV4IyT0Hm6tkw+oAHxz6KFvFztY+
         ZjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680877460; x=1683469460;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycaMS4xZyE8p3zpx736r8PjNnCvNBJaKBn2+Q0humOc=;
        b=FgF0YCOZVz9/VG0i9kdvbGNnJ3tLtlje5nhSJy7OGYQOpyhfqAMDijXIj5ftJM+sxL
         yiA5AkCTFr0643jQyHayQJY7tmD7JcgSe74ppk4S3yF7AzM4E2Fj8Fa9M5XmYeuY21zI
         ajUv82NmVqa4vnFph8uiUEOXvdtBup1RisfvUeNXg9UyLit42zHGF11wgcT/MXaDV4od
         cXhdEfFwMnRY5+cYSQ2AYrRMS6FEoZpTanWdO4uIMF5qvFHJOHU0XgoaHzEta+ezdhns
         CU7kAFtEIN5izFAH+MGv21Io8YVqW/vEemltOILl1V74QJE7ibybEGCnV82gtdaHOFyM
         jYDQ==
X-Gm-Message-State: AAQBX9e6BN2VFGU/VhkzOV/x0QaB1eln1juZKOe5AJZHGi3O8DOJZd+b
        Hv7r1ebK6uGtczeWBIYgJeOazxNnaOh5Nj8TDdWtyxOTMm/NVMb68s8=
X-Google-Smtp-Source: AKy350Z0tJiZGNENp0RfHsrGj1bV9+prH00j/GbZ8drVgjBDqP1a37bFkarl3Z5rrm9Tnl6ldBkaGrjFp4ykRRuIRnU=
X-Received: by 2002:a81:ac15:0:b0:546:63a:6e23 with SMTP id
 k21-20020a81ac15000000b00546063a6e23mr1246058ywh.0.1680877460282; Fri, 07 Apr
 2023 07:24:20 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 7 Apr 2023 22:24:22 +0800
Message-ID: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
Subject: [Question] Can git cat-file have a type filtering option?
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sometimes when we use `git cat-file --batch-all-objects`, we only want
data of type "blob". In order to filter them out, we may need to use
some additional processes (such as `git rev-list --objects
--filter=blob:none --filter-provided-objects`) to obtain the SHA of
all blobs, and then use `git cat-file --batch` to retrieve them. This
is not very elegant, or in other words, it might be better to have an
internal implementation of filtering within `git cat-file
--batch-all-objects`.

However, `git cat-file` already has a `--filters` option, which is
used to "show content as transformed by filters". I'm not sure if
there is a better word to implement the functionality of filtering by
type? For example, `--type-filter`?

Thanks,
--
ZheNing Hu
