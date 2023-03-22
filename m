Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21DFC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 19:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjCVTS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 15:18:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B799A1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:18:27 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j13so19420703pjd.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679512707;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZGofNotE+JCMrTzlMcawMVW/35ReFAq2AnRmLB1Q+E=;
        b=c3fMYIiHEdEJ/BICl7lCHbgQYTAZ4Nwc4QxxMApQEBDyZYFUj6+C2iTvZYVN235YTn
         qT/LsBeRArde6MV1MJwBFN5rDvwc5zQ/3Ow4JfuEpbnaJDny258nY3O5O/3w4C0njmLw
         Afngc1kzzjpYYEnMkCWvYr1y4mmu/VhwhLKUzX5HzQE4bOSUjWIPvs51XASffuHFel4q
         VhDUFsR4k+L30dT2Mm2LBnjLt7u66GgPFfioWV10XHI8uyRfmnNEknuLzANG8ly9QAwU
         b4MGVHA7BuxWJ8JUXdqrxCHDkewYI8bMO7JIxTpO85XVcanLbPzLD3mSbMWvj3S6s9+I
         sbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512707;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jZGofNotE+JCMrTzlMcawMVW/35ReFAq2AnRmLB1Q+E=;
        b=qnpOP1H9AwJYpcDdfmbDauv0PG5P2Hx8pndPAMDBVqrNEcwUR14M8ahjhs7NWhsLma
         WQNJ1CRYKHVdGxsRohS6SjzxtTht+MiQJ4QJN6IzZOxTZXPxRMeNtOfFWGJMJGFOscIB
         B4hFe5EHpneBFTYO04lgHdDYjm3Oe7b3w/HMu6Vnq5TnPyLBYo20ZbQCDHlXYBJJz/pv
         OKMzIdpYS6jt1ESWA1yS0kpUnoHqPCuLS004/TwQcQ4sTwZvCCoKQR9XPFAtqQhOEvav
         K9hUPI9ahy5a8LZzIjlmAcSQ4wah+Ee5QazaxyeE4bqaFBuG746XWtcPBULQV6MU6R0l
         0Pfg==
X-Gm-Message-State: AO0yUKU9U2B8DrcZvn2c1hnQmHjbhxhsFjY53njAFHQ0PnlkeNEp/J14
        FggnoEDBfTo0ZOIlAKxbiK0=
X-Google-Smtp-Source: AK7set8Ngq5One9WZWVHCJaxuBkT4846/GjWhOgUlAUf4e97OIRaObXVFJMrVRynUlHKjjh2530Ksg==
X-Received: by 2002:a17:902:cec4:b0:19e:2495:20d2 with SMTP id d4-20020a170902cec400b0019e249520d2mr4604471plg.30.1679512706845;
        Wed, 22 Mar 2023 12:18:26 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709028f9700b001a043e84bf0sm10889821plo.209.2023.03.22.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 12:18:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc:     "Sjur Moshagen" <sjurnm@mac.com>,
        "Emily Shaffer" <nasamuffin@google.com>, git@vger.kernel.org
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
        <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
        <3FC6072C-5856-437F-9B4F-BC182921426D@mac.com>
        <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
Date:   Wed, 22 Mar 2023 12:18:26 -0700
In-Reply-To: <73af529d-e918-445d-b0ee-9506e28188af@app.fastmail.com>
        (Kristoffer Haugsbakk's message of "Wed, 22 Mar 2023 19:22:09 +0100")
Message-ID: <xmqq355wegsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>             modified:   "corp/Sn\303\245sningen 2013/50 uke/Dramatikk og kj\303\246rlighet - S\303\270rsamisk.doc"
>
>     no changes added to commit (use "git add" and/or "git commit -a")
>
> Note that this `doc` extension was not covered by your update.
>
> But it becomes clean if I remove this line:
>
>     $ git diff
>     diff --git a/.gitattributes b/.gitattributes
>     index bbd8c0db810d..3959fefadfc1 100644
>     --- a/.gitattributes
>     +++ b/.gitattributes
>     @@ -2,7 +2,6 @@
>      # DO NOT EDIT - the file is updated via the template system.
>
>      # Some defaults:
>     -* text   eol=lf
>      *.png    binary
>      *.jpg    binary
>      *.jpeg   binary

The attribute file says "assume everything is text unless otherwise
noted below", which you probably should not lose.  Instead, I would
declare *.doc are also binary by appending a new entry at the end of
the file, if I were managing that project.

