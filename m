Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86617C433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C75820715
	for <git@archiver.kernel.org>; Tue, 19 May 2020 00:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUOv40iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgESAaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 20:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgESAaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 20:30:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90860C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 17:30:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so599030pjd.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 17:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pLrWzN/TmZC26Cl90bY5eAzvVHuF9IUCqTzG5GOu0V4=;
        b=RUOv40iY5014AqpKQorS0b2aW2Yyl5Q+Qo5fIgzUnEYx2AXogIVnRhZ053ca31feHd
         JAhD3JYE+Z+ULjKxLuBMSixbSNDixzmbIyzAP131dto+aTy+LQYXJlkvDXt72rO/I+mX
         XRGxF7iv69gtNliMV+3uo59XGlhfl95QmSxna6ExDgNoYG3fzxCgMtAQS+DO76CZq69R
         dw4YMNFTmiobduUwtEtefxYAIvkYUDe3efQQyTZsnFgOAQIRn91x8GDsCnFMy07nJ/6+
         1OgcM7x9szolXiCtufh5QyvI7Fa9i248BKRuUxLV4TdzPiEUlehfxpiasDNzDDLOsXtk
         kCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pLrWzN/TmZC26Cl90bY5eAzvVHuF9IUCqTzG5GOu0V4=;
        b=rcmiFkM7JrxHTHjOE42mS1cE3AR1AMqWFsUgjTykH2f2B92RyWYfWfTqnbSnc210z0
         iHCImQlcgHPg+2ijWuC09Xw6d9p/7F7Ok6FTRZbiIAEHT6LjKmuFVFqeRhXfekzv0rVw
         G4Ko8ccLYiTtNGGOhZsVbB3yzT9JJwuUDIt7URiiQpFNkm/XiAzH2edlmK50CRR16IeV
         Stnnq6y2QxCzBZpfrSbq8/Gs58D6Tuo/NvDpwT/oC0QFWaYwP32MixXrVF4raFSGtMU9
         VbzTrKqGFWfIeMTz6I7eCt3mJlmdHS+qgJXGOWynUC6t5AbiMsJHNAUfjD+Qp5TYvDko
         Kvmw==
X-Gm-Message-State: AOAM531kMQBolmqm3OtWu02tSjFpuHDhg0PPlq4HLbXd1Y9c+wixmjyU
        bvCJIYh0Bjjch29pU7Tf4c0RZfwa
X-Google-Smtp-Source: ABdhPJxJlybCTAy6kmjYZU0C7Dg4kyTalH9BrzVYYQcprGv279jZ0kCpvwwPdUY2gCoZCbtT73jT9A==
X-Received: by 2002:a17:902:a58b:: with SMTP id az11mr8731962plb.172.1589848209005;
        Mon, 18 May 2020 17:30:09 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id 28sm544185pjh.43.2020.05.18.17.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 17:30:08 -0700 (PDT)
Date:   Tue, 19 May 2020 07:30:06 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Laurent Arnoud <laurent@spkdev.net>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200519003006.GC1999@danh.dev>
References: <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
 <xmqq4ksd5ggq.fsf@gitster.c.googlers.com>
 <20200518191205.GA1999@danh.dev>
 <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo8ql0yjg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-18 13:37:55-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > We don't document --relative for git-format-patch, the --relative
> > documentation is placed under the guard, for that matter:
> 
> Yup, since it does not make much sense or "diff.relative" for that
> matter in the context of the "format-patch".  In the same sense, -R
> makes little sense, so sane people would not want to read about the
> option in the documentation, I would think.

Sane people wouldn't want to read that document when we don't have the
config for diff.relative

But, now, we have. Let's document --no-relative, specifically for
git-format-patch(1).

Perhaps something like this (maybe just fixing up to Laurent's)
-----------------8<--------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Tue, 19 May 2020 07:24:48 +0700
Subject: [PATCH] Documentation: document --no-relative for format-patch
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

git-format-patch(1) accepts --relative for a long time, but the
generated patch couldn't be applied without accompanying information.

Hence, we've never document --relative for git-format-patch(1).

Now, we've introduced `diff.relative` config, let's tell Git's users
that they have an option to override it.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/diff-options.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 167b451b89..0f5c108324 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -654,6 +654,11 @@ ifndef::git-format-patch[]
 	`--no-relative` can be used to countermand both `diff.relative` config
 	option and previous `--relative`.
 endif::git-format-patch[]
+ifdef::git-format-patch[]
+--no-relative::
+	Countermand `diff.relative` config. Show all changes in the repository
+	with pathname relative to top-level directory of the repository.
+endif::git-format-patch[]
 
 -a::
 --text::
-- 

Danh

