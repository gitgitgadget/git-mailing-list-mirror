Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F3C4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 10:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiLWKp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Dec 2022 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLWKp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2022 05:45:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C213D5A
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 02:45:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id c133so4312693oif.1
        for <git@vger.kernel.org>; Fri, 23 Dec 2022 02:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZsXAvSN8UX074fvIfLYJe7kOnMIn33tTJQttrcemmY=;
        b=nxHJb6vL7Dglaw5jfTTtrEaYO35Fy+B31J42DdXXgyK6Ct4p2mBARic2FTRvvuqyc1
         zQhIYMnjBH4OdUOlfc05MNmXO8M41TU+T2+F9+IRUlRTESrqcH1LNhVjqb5zpwvCVf+j
         EpZxcV9uj7Kbj0qJ061UpecaAxN4Urn6Tg+eKyfOs+JFBugyHUYqfx6QwgKkjSaGKkXo
         2sjGwAdZfooLOHZpIphA9Owj/6BMeVDuN5TlS5ZsDejttxXuHqOWQWO1gfMfwSgH948X
         1kkGT2WluTMGoA06ZLJpEVfPTJ5bIASXyDswNt09PLDD8pG20r/wDdejCh7KsRDz1zFY
         ZV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZsXAvSN8UX074fvIfLYJe7kOnMIn33tTJQttrcemmY=;
        b=Oml9ceWplkH1EEATaanUV59xGCoUrxBGp8TqC9ye8Iumim6aToXAOagFpILD7yMx8D
         Dc33Ht/fb6lA2P7GZD1sh05GkmY0PC2jkX85H2dQ9BeTOEF65RkBRjMwGqu1v3z8oKyz
         O1sgkzl7kIcutRlHQNK1x1lJfJ4cXynLho5+aZB5B4EDXfX+YorOVEsJJKVXi75wl00j
         JOgRT7Wg4lUkxCeVhJ20ksaWlB8q8MtdK2qX57sXTwb2K6S2oMxu3OiPqN6h9LA+yaUx
         dIHGpvlyKezXYg/pPBRTxJ1gdnUsRLiT7pTjVgCdbZPbc3tGujx4HK97ueW+wWsN01d6
         1uNg==
X-Gm-Message-State: AFqh2krxL0M0Kvj/ZvoW9z9rkKcfUvu6ygpp+CO+JmVwsPfoDNCaFEP+
        y786MXyMrkCmVg3qiuMtQDxhybtuBsrKhJaMMVA=
X-Google-Smtp-Source: AMrXdXuTj2KjZLWsgK4/Hzkp/YsLFbD8cxRMGIRfRWesRXiCqTwyqA0f4hFUwgRPqf0v+4D5sCDILEn/DPLhwGriKeg=
X-Received: by 2002:a05:6808:18b:b0:35e:6cbc:bab7 with SMTP id
 w11-20020a056808018b00b0035e6cbcbab7mr343173oic.232.1671792324947; Fri, 23
 Dec 2022 02:45:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1671630304.git.karthik.188@gmail.com> <a161dbdf8b70354716d0bfeccc707c242c7f33a1.1671630304.git.karthik.188@gmail.com>
 <cc2e5f1e-8f53-ad83-1f5d-ae910ab60c53@dunelm.org.uk> <CAPig+cTHJzHsUum0RnyCcqxj1qhxJR9EcKRjoShCznQ_oXYHOA@mail.gmail.com>
In-Reply-To: <CAPig+cTHJzHsUum0RnyCcqxj1qhxJR9EcKRjoShCznQ_oXYHOA@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 23 Dec 2022 11:44:59 +0100
Message-ID: <CAOLa=ZRb65r8ifhnNqGv0Mhq1=R-71X5NYgjBLiBkEBhn+nT=g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] attr: add flag `--revision` to work with revisions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2022 at 10:13 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Dec 21, 2022 at 3:58 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> > On 21/12/2022 13:47, Karthik Nayak wrote:
> > > Since we use a tree-ish object, the user can pass "--revision
> > > HEAD:subdirectory" and all the attributes will be looked up as if
> > > subdirectory was the root directory of the repository.
> >
> > We should be clear in the documentation and option help that --revision
> > takes a tree-ish (i.e. --revision=<tree-ish>). Maybe calling the option
> > --tree would be clearer.
>
> If that's the case, shouldn't this be called --source (or some
> variation thereof) for consistency[1] with git-restore?
>
> [1]: https://lore.kernel.org/git/CAPig+cT_xz3m-3kkL_Scf0opNXkikU94kSF46VO8KHkNMWbGzg@mail.gmail.com/
>

Let me rename it to source, and we can discuss on the next version if
the name suits or not.

-- 
- Karthik
