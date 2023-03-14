Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5425C6FD1D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCNWvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 18:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCNWve (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 18:51:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EDA30299
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 15:51:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so5327pjp.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678834293;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BevaUcop3unCaV3e6WJsN9w/yakGfbEc7kIJdoob8qQ=;
        b=WZjxLRo0tUzyw0r6u8CLtKibmrmYhXEE0KaCQ/ioHVS/Tnwl0XyJd1Zp5uhF2d+P/u
         IVTsudUXhWVTL/cZz+4vzvJdSc2B7WDUPkfM2oWXlci8DYM64MGjvpLJXC+WLbbxGvJ7
         Lsc20JNYwH4kkLWx2a/np/TdvifZicZENZdXF1pVmBEJcM8EBSTP0Jj5JgoBrHR/DWQ2
         WgWmVOSJ30CAu32mhm/ZCV0qStyeWjm/ohDhrHB2ISfAqtQRD+hXtrxP2ZwUF8Rvq+zQ
         76sdllCF13kYK/gppRURkzyUh4V9EW1spJ5d5HW3IFln+vL3T0OFYpTeSreklOYD2kG8
         detA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678834293;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BevaUcop3unCaV3e6WJsN9w/yakGfbEc7kIJdoob8qQ=;
        b=TNgWGdCkjJ6+jpw4RaxheTsDkEwhE/pyJ47b+2vXoVudPjGYzvIfhKEVo3QUVmOr/L
         Rrdh3QYzXoZvBUMyKQh6i3p5vF1EFNnV7YjgAspaWWkzhlj3EGpnG9JI7QgUKAazd6lo
         +qiulyg80bGSPg5pk9i35swh8LGhvFcpQyLALi/Hni2M9zz+6Nws/XQ6/jF//ECYi3v9
         aEiOedtHCJhQocdxfqYcKymsyoTSGAF3QVBntJbE80FeSTgIAc4oZarPrnN36NUG41N2
         84v7krEBuOYAUiNlqaEFcd6OiGTW17cO5FRvHMVZwShwMxl5YzukKK85jtnt9VZTfSIZ
         8ROA==
X-Gm-Message-State: AO0yUKXHSUSKn3QyPGR4Ib8pGxzPZln2NnarYG+UkkH57znrgaHCV8Eo
        cEB3nvy37u0G1cYRRvkQ/zY=
X-Google-Smtp-Source: AK7set+quM5hyzYJnghRM7pK69PBBH7d1MRzPlIjMlYjwWg4wPJV95gDCliBEFtS7Na7nSvMEySmHA==
X-Received: by 2002:a05:6a20:4320:b0:d0:45c0:1421 with SMTP id h32-20020a056a20432000b000d045c01421mr28728256pzk.48.1678834292819;
        Tue, 14 Mar 2023 15:51:32 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b00608dae58695sm2072002pfm.209.2023.03.14.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 15:51:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 1/1] ref-filter: add new "signature" atom
References: <20230116173814.11338-2-nsengiyumvawilberforce@gmail.com>
        <20230311210607.64927-1-nsengiyumvawilberforce@gmail.com>
        <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
Date:   Tue, 14 Mar 2023 15:51:31 -0700
In-Reply-To: <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
        (Nsengiyumva Wilberforce's message of "Sat, 11 Mar 2023 16:06:07
        -0500")
Message-ID: <xmqqpm9bosjw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com> writes:

> Co-authored-by: Hariom Verma <hariom18599@gmail.com>
> Co-authored-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Nsengiyumva Wilberforce <nsengiyumvawilberforce@gmail.com>

https://github.com/git/git/actions/runs/4410308954/jobs/7727652857#step:6:1898

  + git for-each-ref refs/heads/signed --format=%(signature)
  + test_cmp expected actual
  + test 2 -ne 2
  + eval diff -u "$@"
  + diff -u expected actual
  --- expected2023-03-13 23:08:51.495987174 +0000
  +++ actual2023-03-13 23:08:51.519986953 +0000
  @@ -1,5 +1,4 @@
   gpg: Signature made Mon Mar 13 23:08:51 2023 UTC
   gpg:                using DSA key 13B6F51ECDDE430D
  -gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
   gpg: Good signature from "C O Mitter <committer@example.com>"
   
  error: last command exited with $?=1
  not ok 342 - test bare signature atom
  + git for-each-ref refs/heads/signed --format=%(signature)
  + test_cmp expected actual
  + test 2 -ne 2
  + eval diff -u "$@"
  + diff -u expected actual
  --- expected
  +++ actual
  @@ -1,5 +1,4 @@
   gpg: Signature made Mon Mar 13 23:08:51 2023 UTC
   gpg:                using DSA key 13B6F51ECDDE430D
  -gpg: 3 marginal(s) needed, 1 complete(s) needed, PGP trust model
   gpg: Good signature from "C O Mitter <committer@example.com>"
   
  error: last command exited with $?=1
  not ok 342 - test bare signature atom

Are there differences between versions of GPG that, for the purpose
of the testing, we do not care?
