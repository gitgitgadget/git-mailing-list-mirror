Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CDC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 07:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E061927
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 07:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVH1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCVH0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 03:26:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E9C061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 00:26:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jy13so19500765ejc.2
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z1cKzQ85RRN0xxE+9yFKDI5HZMPQh5RlceELq9B/XFs=;
        b=Mxyy6+wXeZE8y0VrRkLQ8h7PjkMnvaSRknYsYJYOeL0lf/QWuyQjreJFaI/5CG5vgS
         JcJ603qXVM8PFyMYZWts/+YbbfpVJECgFAn/TJjqjXUcFGWFd7uQvCjQHinmGyH/DYaC
         8r5EAt6DL8zl8Psw8O7wAjnQroivT7SoIuhYzMZ87oDz27BazUhNoTdcU1kEHMkfvMcB
         kwdh+EViaVpvYQmEU0NBBIcDhwaRYychnPGeTQmKuI/B1e/PPzJVyjw6baIVg3fmJDYW
         KIl6o18rUSxSGjxw1NT9cDSwHCAnLlLXVm0moQIkAOP3MB64j1YbsLUgL6FQt6zLwa98
         W+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z1cKzQ85RRN0xxE+9yFKDI5HZMPQh5RlceELq9B/XFs=;
        b=lo8YJReC+3G3c3mYWH0b0BtLskFWMtDHN7rrB1mDIG60G3VcaUFyegijxll8BZqTpr
         cORSMJojY7Uf+3yfJJ1ZQ+2AAHkWt8fE649XySLzsOPf8s0KsfGQnbBYxnIe0vn6C4Gg
         Z+zG1FxwH7rBvQ/yCQbvT4rqvIK+pM0e12mIugp7y1XkJZmOFX/SRqjDX9MRBripjvjM
         igAwVx+LBQCapyFK7ZqkxaxHFrhvVxwG92eKT+nJ0YExrSqPT7leNzSxnO+kpTHze12M
         ZFIZnyN5lOiKiAsNhiju0K9Zgb/rAUl3ecuTW0lgS+Cdo5+5K1itPc+JjFw8xuzb568w
         U6pA==
X-Gm-Message-State: AOAM531lMDA9ZZ5WuCsVSOamKzoubcwqq1u6rmOPpuhdOyG8XHrP9xic
        rb5GfbxMp8/s+624N++tAxh3aCQhtfz4Vj7oUJo=
X-Google-Smtp-Source: ABdhPJyTKbmCNHgv4pCL+Ng0GIgDIvvm8Ru7QegaJ0mBQGC6AW74DsJNbHanSAE+YE750D/NSIRqnzuzCPY937FCzZQ=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr17956582ejt.216.1616398003192;
 Mon, 22 Mar 2021 00:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
 <xmqqwnu0bga9.fsf@gitster.g> <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
In-Reply-To: <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 22 Mar 2021 08:26:32 +0100
Message-ID: <CAP8UFD0TKFhpQkAk5apUXpEg=tEhHdZxL9USjfxVSiSyYzLT=w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 1:39 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Christian Couder <christian.couder@gmail.com> writes:

> > > So even without this patch, after your first patch that implements
> > > `git commit --trailer ...`, it should be easy to setup something less
> > > verbose and less error-prone.
> >
> > It is nice that it makes the complexity of 2/2 unnecessary ;-)
>
> A little frustrated, both `--own-identity` and `@nickname` seem to be
>  rejected. I will roll back to the first patch.

It's good to want to implement new features, and to come up quickly
with patches, but it's also good to give people time on this list to
discuss the goals you would like to achieve, and which features are
already available or should be implement to achieve the goals.

Thanks for working on this topic anyway!
