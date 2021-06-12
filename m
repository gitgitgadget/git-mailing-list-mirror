Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535F6C48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 20:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8B261164
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFLUMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Jun 2021 16:12:35 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33486 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhFLUMa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 16:12:30 -0400
Received: by mail-ed1-f49.google.com with SMTP id f5so36189358eds.0
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hi2oh78S3/XMpOmx/A8WZvMrze4tLF8nvm45njbLoXs=;
        b=jshW1aZZPZ+PoB14BvQOtYin7JlqawExY6z7IpTBfES+wy9NlpCQKZqrltsZAS6/e/
         +NP0XlDB6yvewTZdI52pYI70R9ExRjkB5A60CT9wAbXysSYSCBDGpO3fzBdncNQV13s9
         /kiNY0mY7fPEVA0yihJGIEq8vf0Obnp+s3T1SlBnIoRrCnVO30ChnaTYvEHyo/FdxBa6
         SXvLF4AqsvLfsRSUeslBmouau9g4A632ntjiNKoF0EQy768PB0wO5FcNq4uh28qF4pI3
         Ou2akOiTo1/0QNfmWN/SE+Fa+AvCxJ+0shBprrA2rYpZLdKmSHlL2kzS43bbjCWk8/Vo
         DXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi2oh78S3/XMpOmx/A8WZvMrze4tLF8nvm45njbLoXs=;
        b=Snj32LzChqtAlT83+FpRMVHknf6IhRzzdrgpmExKo1vxcxb3uf/mQzPuWe0IVUeege
         NsVjo0/yyuMSXWP1/TISa4ll/J8FR04MeD06gmPgO85JmZB30gQcioQwPVSj+9cjXhif
         cANQsuCJ3uocj7fuchucd0DqiKnyBK9ISIs4mbBtvNknPIg+vQ7m7K+veanZJyk/wm7o
         xDZXaKXI1BGLsGwTO0pBJLRbei6dijQ/kpPg+Rt4SKmWGSd8CWaxwNIuqJyA7DdqSZ5n
         t5dfzoUhh+aiBbKL1YIcACPJL7OrgJD5QsGRR221ocN4/ujPb+6AyyxilsxQqscs32u0
         Zfqw==
X-Gm-Message-State: AOAM531GoAzRHAe8vMYPXlJv+Qo4utm3wY+Ol4gxJQIhp1bP0ARgPxl8
        28oQ6uyrxlCH7y7P5IBPwpQyndOwjtcg5c+cb84=
X-Google-Smtp-Source: ABdhPJyFvBHRjRwOSa45sfeLVeh+aY/F0q2rcms+ltbNlBO1B1rutUdfWBbEJKDZ5GmvDFpOAA3vOg192h+fBREU+wk=
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr9828785edu.273.1623528569509;
 Sat, 12 Jun 2021 13:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.git.1623496458.gitgitgadget@gmail.com> <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
In-Reply-To: <c208b8a45d66556a3f905063bc7c5026ac4f1e82.1623496458.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 12 Jun 2021 22:09:18 +0200
Message-ID: <CAP8UFD0zVLF4ZKorv-8TaEh16-5K1e-=tFafGknucQGU14ZYGg@mail.gmail.com>
Subject: Re: [PATCH 5/8] [GSOC] ref-filter: teach get_object() return useful value
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 1:14 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Let `populate_value()`, `get_ref_atom_value()` and
> `format_ref_array_item()` get the return value of `get_value()`
> correctly. This can help us later let `cat-file --batch` get the
> correct error message and return value of `get_value()`.

Is it get_object() or get_value()?
