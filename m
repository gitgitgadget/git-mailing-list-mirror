Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EFC2BBCF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484CB22EBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgLESTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLESRp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 13:17:45 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2835C061A4F
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 10:17:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so8055588wmi.3
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWnR1AnkrrLR4qgbxLjozUZCBYDC4XxF46bLzURlBl0=;
        b=rzDax+QsedFuTmlgI4vbdQbfW8Fi9BNmQJyrTNZ81ZMSOUBzQbWBv0Aw8/S4huCmU8
         OZwMp310HqC7a605sIqL8oo/cug3ro0+cMtQ7Q5E73hYldaJFBBbZtn8JuotjLc4obAX
         qWMlQFSvsAbKFuNVQphB09osk4+C36kC4bXTjCDidKV88H32Oyhkr++bToXU77j4Qy/7
         LSYAeKF6XIvSfPzZ7l/IjNj6wjwF95OOSWW83gwBvOXXAfj1lhP5+Kqn+QEM7ra1RPGj
         /DePjzZKaplPbHthSeIQaDG8AQLfyn85qWQaVuRcnnySVtECMtGMjgluwkjNhbcDrga3
         MXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWnR1AnkrrLR4qgbxLjozUZCBYDC4XxF46bLzURlBl0=;
        b=DtSwowS8KeHaAGkpTR8aquXlnkds8u2vWBLOOc/rkDSKZdd03dtMBSvLTbgKuGb8r+
         r8ckMJh9loCpJsO4MjWBRwH2OecWJfdL+B5UeyEHocoe7pAFDe+zikDaYzIDH+YXsG4v
         Y0m7OlcVFLswmWcP47SuASA3STwOMZtIuqLW4VTTpMKPNUXBVEAJ0dcBfQKgEvCBGDER
         cuDbrjPyDjjmzwMxw/VkNyY/kBYm+yIPtadvl9eY8nOSISvSPCVLVgK5E17GLbZ2XQ6K
         YMMsyu5V/61j/l1X8x1TNFo01nb5UTnRGYPLhv5ezWOeKkdUA3A6dPInIMKImoojph5c
         X7TQ==
X-Gm-Message-State: AOAM5310nAfyLsYpSBbEW1lShZDQ/nv0mT167eLyA+OsNArN1YKL9+2r
        b57ifsXjjSqIAKgZiDW0s0Ng/wBwI+MxP5HmLH0=
X-Google-Smtp-Source: ABdhPJzjkNW42ijKlTdEICI/o9wb+N6uxmY19soKafLYkXPw091pDNaaPIscofRtym8XSHEnOobATRUXj1AXwyYc5Zg=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr10155784wmg.37.1607192223493;
 Sat, 05 Dec 2020 10:17:03 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s1wFPQ0mEExYUQfxYx2AjMZS2=zL5ihfjp3qjp+EfNe9Q@mail.gmail.com>
 <20201205040644.1259845-1-felipe.contreras@gmail.com> <CABPp-BE7B5hn3Fc4zD1o+qoqihJqCut=R1TP_fxMXW42+6iL+w@mail.gmail.com>
In-Reply-To: <CABPp-BE7B5hn3Fc4zD1o+qoqihJqCut=R1TP_fxMXW42+6iL+w@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 5 Dec 2020 12:16:52 -0600
Message-ID: <CAMP44s12DENe7KcSxzRAL_u0YZV10o_okzm5fKkjz0W59NrATA@mail.gmail.com>
Subject: Re: [PATCH] experiment: pull: change --ff-only and default mode
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 11:29 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 8:06 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
> This commit message should say something more than just "change x", it
> should have some words about what it is change from or to.  I think
> the thrust of the patch is allowing --ff-only, --merge, and --rebase
> to countermand an earlier otherwise-conflicting option.  Perhaps a
> commit message of the form:

It's not a real commit, it's just a preview at what the eventual
diffstat towards v3 might look like.

-- 
Felipe Contreras
