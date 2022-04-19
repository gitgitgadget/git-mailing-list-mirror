Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F69C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 19:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355976AbiDSTjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 15:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355971AbiDSTjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 15:39:14 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE08B4090B
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 12:36:30 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q129so19252135oif.4
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=OE2v+v0av5VbGvGbJQhyvU+l0zsW8Af8Occvs88ODgE=;
        b=UUUMSi7sQ+700FlHv9qvIXzH5ZXUGr5GFboz5cIG5dsvFQE8mMe02PAQ97MosYqH7Q
         SSFw2pexhByvUFIdRGlWe6iNJLtg+pY8k2E2wqMhx/d/AzuexMPzA52VbqCT31soXGeH
         nbCpTUb//kVo6Vj+ryDeUHcwv5pAHsHPyfWvC+JR9+2zIDukFKZ65WKy08bNw0cNJtDX
         /uycS/q6FIVX2cKT0DIxE726wITg79mfM5MIyki2SIq5OUd9fihvNHUrQv0dfhrsI5dx
         pNIljm2UqDpbB9Q67/wMfGbhQkqSbVjlX1JhuGsRJoEfpZ26HsjmbXuZn1hIkDjtdKPV
         Tldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OE2v+v0av5VbGvGbJQhyvU+l0zsW8Af8Occvs88ODgE=;
        b=fjYv/bM5NZSFn0sE5YU2V0sQqLXIx8Ap+XkBqVRJZ1j5moyl1WFiYvr0yW6jbFmoRp
         27dgAQQyH7rj1jML8hJGsM3FwRWrY8nZMRRw4nDbW2tCwR7lILJie7uCkOHVE2aszesc
         F34CibPW7TwCvi5CZbJJduH03tTuig9hZIIMBTA3/idCF5Yuh4GH/W6VLf/5L1DRq9sb
         NIQSMuONuGojUTTEHjp1EE5HzlHKNZ2flo3kQ02LmpXM2FsoZfLF5wrfumtUMyDdE7Wu
         lUsM0Abk8MCHOsqpyo0/BSPOpLDMMN9QKb/6WBAdKsDT250qdprdni+Yt2GaD3grnC8Z
         pUgA==
X-Gm-Message-State: AOAM533IZnfhBdlgVlLUC9kl6yVAh5EyMgNGY5QwDV2tSuMsdvCYuO78
        8t4Pri7VZ/S5ho1TVMuEXZOjGYsaPobI/B0K+s4ad32HnBs=
X-Google-Smtp-Source: ABdhPJyzZlcRoLuUFgUhHTWjpzFbGcuxi18ALfa2civgVOHKxVZAyhecJoB/i2JFUiD4syTn+sxqEiIItk/H68s1rpI=
X-Received: by 2002:a05:6808:1592:b0:2f7:3095:b7fd with SMTP id
 t18-20020a056808159200b002f73095b7fdmr87516oiw.190.1650396989968; Tue, 19 Apr
 2022 12:36:29 -0700 (PDT)
MIME-Version: 1.0
From:   Kevin Long <kevinlong206@gmail.com>
Date:   Tue, 19 Apr 2022 12:36:19 -0700
Message-ID: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
Subject: help request: unable to merge UTF-16-LE "text" file
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

I've been struggling to merge branches because of a UTF-16-LE (with BOM?) file.

Windows 11 / git version 2.35.3.windows.1

The problem file is a .sln file (Visual Studio "solution"). Edited in
both branches. It is a "text" file, but is encoded as such:

FacilityMaster.sln: Unicode text, UTF-16, little-endian text, with
CRLF line terminators

I have tried several "working-tree-encoding" settings in
.gitattributes in my local working directory, to no avail yet:

*.sln working-tree-encoding=UTF-16-LE eol=CRLF, results in:
error: failed to encode 'FacilityMaster.sln' from UTF-16-LE to UTF-8
warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)

*.sln working-tree-encoding=UTF-16 eol=CRLF, results in:
warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)

*.sln working-tree-encoding=UTF-16-LE-BOM eol=CRLF
error: failed to encode 'FacilityMaster.sln' from UTF-16-LE-BOM to UTF-8
warning: Cannot merge binary files: FacilityMaster.sln (HEAD vs. master)


Hoping for some suggestions. I've also tried to save the file as UTF-8
in both branches, commit, then merge, but still that did not work. I
just want to merge it like a normal source code file.


Thank you,

Kevin Long
