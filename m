Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68587C4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLJOqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJOqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 09:46:09 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFF183A0
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 06:46:06 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d128so8794106ybf.10
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 06:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJPE6U4H+BwNBNol2hcxBo1zneGc0k4ovrIdZMX3OS4=;
        b=i4AVvoSdB35+Wq6j2odB2sA7H9wbBtQTQ1Ve/kHSc6q4QqAKB1k/QDo51Zcf8Tqrd2
         tfzCNqbKEprE+pzPxESnS5ghqRsfwUAmPHxQGpvSnj+DgujFCdHMv7Lqbm25gEXpio+u
         Vj0rJQ4obxjX8T0DoRwXko4b8xTaC/blpwpk3gsX9N5BsdWcwRAN5LrbmdzTdguh5mPJ
         Kyy2shv4otNATyxSP+hxsVM4WF34mI6p9a52rMiT4wlk3Fwyp6claGAaUKDe7pUb9OJ/
         NxeiL7u6HA7CwzzAZ7GsaWI7G44NjaiPT6oOb97Od5EuBiZC0325HG0q09plh9kBLD/F
         BoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJPE6U4H+BwNBNol2hcxBo1zneGc0k4ovrIdZMX3OS4=;
        b=IWiJ18FQyR3OIPgf0CHDeXGaEygqQxBOkaGbf6hM3FmPZJsZeaBrPuuXX7MS9K41TI
         qjZwOCMar2naWQdFxFhtNCJFwjejegNHBmkS4173hdh5KlHekAS3koYDg078RVvI1rng
         vS/DgmxMPlezDDqah6SkjlGgFDbhM5K8onDHrnWoU1I+HNNiQX2I1Kv+OaVNt9qxqArw
         VPU5y6VtxPDnZ2JvzUkLsEk7FUbspdW6rn1asA7ZfJF1UHaFhOuJ8GuJwEnopNxGFnBN
         CkQYBOBfk+cPNpjumgZob3mqHRZt8G+VoTz8FixBvfh/THe9Com77y7eX6geyhKjmfa6
         bkXg==
X-Gm-Message-State: ANoB5plkQt22xa9/5OeI85fbbEKEazOuc5T6UYc1ZFS6u7jSWYxR8+FC
        Qruun9xpHrWObIwW1AOPTiREClM2EpQYq0Yp2J9foX/eWEc=
X-Google-Smtp-Source: AA0mqf71DvaU6jIJ9UQeDTh2vepwcoGiOFadRO164amK/z2UEYCFpWobUD3jYwatGX5bAZc6xxXToxr2yT+iX+KhH+M=
X-Received: by 2002:a9d:7656:0:b0:663:c86f:7573 with SMTP id
 o22-20020a9d7656000000b00663c86f7573mr38981027otl.187.1670683095333; Sat, 10
 Dec 2022 06:38:15 -0800 (PST)
MIME-Version: 1.0
References: <20221209210321.709156-1-karthik.188@gmail.com> <xmqq1qp8yvjv.fsf@gitster.g>
In-Reply-To: <xmqq1qp8yvjv.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 10 Dec 2022 15:37:48 +0100
Message-ID: <CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] check-attr: add support to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2022 at 1:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> >     ++'git check-attr' --stdin [-z] [-a | --all | <attr>...] [-r <revision>]
>
> Please never design your CUI to take unbound number of non-option
> arguments before dashed options.

I shall move it inward. Thanks!

-- 
- Karthik
