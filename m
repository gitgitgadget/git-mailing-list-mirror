Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51589C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297082053B
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 17:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+zsPWvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFMRK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMRK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 13:10:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A0C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 10:10:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e12so8608569eds.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lO0DnCKr07I7aSKyVlas2fTmcCc4sq+AtLoIz657t3w=;
        b=C+zsPWvuzjlT0W4GmrZ3wvyW26qDN01A18kOulLdu13AIu0pzJ3MBntZRPU3Oe5Dpp
         bfx6iJB7FwOU1yAhowPkNyXV/E3pvk7AGRr8J/Tx8lNsH4W4mP0qvRqqz/J543JEVqOj
         Q7/Eo1pje9WvxED+M2IcTeNhE82STmMWhdDbMYQ1US/mo6UPioy0QDl8O7uZd/0MTJ+q
         G5VFVtvgykv24aBL6m76sSBieyK2BuctcPJ1Wr8kt+AnH8BZg0UHzY+b5Av4Um/1pbbc
         nxMxhHiGrRDsvb/W+Gatz51nPMmQryjikdm4n+g3Q8BVf3H+vMiYe9c3+HP3OfkcwG6q
         Cx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lO0DnCKr07I7aSKyVlas2fTmcCc4sq+AtLoIz657t3w=;
        b=pJNKgEZegPZgY5SUhZ1rw2JRJE7/9nQfKtCsZw8wtoktmH6+nt56KTK86nGqB59W5A
         uyPA+dz4st4LOSA9DHNXcsppzK97AWQCoz3yGNwfrSc4wzMl2ylzf9lvTF7BuL8hP9/X
         i0IYKguwRaxL0NkknUwcUf4yUpr5rufh6hYZcjAscvy5UoodEmDqcMlFe4CB1N2CJdWW
         nYIw3Ufl/cP+onmq+ic50kcgkiHgZe2na0rGc5R5Vn5DnT2bsKvMaYwK7rMcHvA6+vkQ
         FqP3nvYs+MUbfRzRBtL8XZrmo7cKKxwf+GqF9gL+wZtYQgV25G/Yr+xSGrK+E34Gl+fJ
         rcJA==
X-Gm-Message-State: AOAM533a79qNu8VI1/TPiv+oyNLBEArTg41fhJilJZgcGFa/kwn9vazO
        msc+A7uk1d6iENTmZDlF+wd7BhI8c0rI8nDsUag=
X-Google-Smtp-Source: ABdhPJzhk1IhDDm/MgKusSq0rTAVHjUyxgVb8PaxfLNYodeBusUDXLh2vp67O8QjOSUCt9gA9udW2lZImt0DFg6rmvE=
X-Received: by 2002:a50:c054:: with SMTP id u20mr17136326edd.142.1592068225104;
 Sat, 13 Jun 2020 10:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
 <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com> <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 19:10:13 +0200
Message-ID: <CAP8UFD0aoNQNcNJytJBazoKj0jvWwykntHHgnYoCBXr6OmGOnQ@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 2:38 PM Curtin, Eric <Eric.Curtin@dell.com> wrote:

> Anybody ever think of rewriting the imerge tool in C or whatever to get in merged into mainline git? Potentially I could do it as part of my masters thesis if Michael H and the git open source community agreed?

(We usually reply inline instead of top-posting here.)

My opinion is that it would be nice to have something like git-imerge
integrated into Git.
