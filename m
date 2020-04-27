Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53A0C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33EE206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 11:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw5IkBD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgD0LqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgD0LqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 07:46:06 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C338C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 04:46:06 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id b13so25599825oti.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tA1uDG+VFYuL6WEAGRkcnf2BDhJAsEc/IS1sAqnDOT8=;
        b=Vw5IkBD0F/mNgzLc3vO16Gc7+T0us33YWp8p3ltIX1gmE/2FLmBdR902CxoRJt6NgE
         Tli4qNkVNn5UnphB9O7sh/1vAFTykyiT7J1pYNY8imcFhjwj/5z4C7Y+NcM9z3uH5xc1
         syNwxGBkaGgmDgp0uu25JI5I3im6m6BkwNoaH3rxIO39YtvuRlJPOjMPQZNkahfk1Rqr
         F0C/xWU5IxVPhAEXLSxrqwIsaYjQhdmxlmNOuJhoIZUsSHoc11V36ffM3rj+pXV37bmg
         9tp5oPoSilNdx/2NVbOw5UXPe//1x1JYP2ZckXA4hMS9zB8k/doFc0Vy+nrlNjjND/u5
         LPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tA1uDG+VFYuL6WEAGRkcnf2BDhJAsEc/IS1sAqnDOT8=;
        b=J690htD/OYFkAhLbwe1Em1DunOyyUV0hgmcUxxVvTbHrg48RoJTGgobFdWqqlKBkXI
         W8eAfFEYNXwq/2WFe7oTNpuY8pP1NqQt3eF2eDu9vcEX5Ck3z703qRF/PhEQCU7eoADa
         7LAlvv9ZrzGm+wE5Pig45IfOQFbsPyQVXmTWR6A80QOSZl2GmjZ3tnJPwYAsbeY/xagI
         GDrXYJYjxVfBJSqMyGpYOBG9g1WjlpA0VnSj6dwki2rxcwHvp4bI0E2AoBNjfKgYz7lb
         UxYPwWNSUk9eJssSzas4n6bW1eGb+sZT40KRbf7kxow6UbyJ9zwYkL8aAsq4WjCuwSwy
         ccLg==
X-Gm-Message-State: AGi0PuaeaTie6YR7IDqPmyW+HNzsqcdhju/f//GW9CXxPcSMV1r5j8wN
        IObleHY4Bei/MscDjazkt+FQ0C0NBbAHNWXwK98VF0yR++E=
X-Google-Smtp-Source: APiQypLcAy6gNK9i3vWu0189ieJHU8v9MQzmXP8muEnpmaqqbdZcYLx5unoiVXGV7dwNERbnKaMj2ps4LVruaVvv4uk=
X-Received: by 2002:a9d:4102:: with SMTP id o2mr17543456ote.98.1587987965755;
 Mon, 27 Apr 2020 04:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP> <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
 <20200424072049.GC44448@Carlos-MBP> <CANYt6aF1o9fmK2rwAA-LPSbd3TeW+x+6LdUj99sg_ANy3Q0kJg@mail.gmail.com>
 <CANYt6aFN0eAKEhRvNhoiOTu7jO54Kau_ayQMhrdy+7_GPAOCyw@mail.gmail.com>
 <20200425065250.GB5065@danh.dev> <CAE5ih79Chu7pguToRqmXdKh1BuvP3QGVK+8UDj=5F9_TovE86w@mail.gmail.com>
In-Reply-To: <CAE5ih79Chu7pguToRqmXdKh1BuvP3QGVK+8UDj=5F9_TovE86w@mail.gmail.com>
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Mon, 27 Apr 2020 13:45:55 +0200
Message-ID: <CANYt6aFZM+Y2UDyx-J=Z1XyKr11k2EM4=wXiXMe+HG4pPWAWug@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     Luke Diamand <luke@diamand.org>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I could not find a corresponding package through yast on SLES.

On Mon, Apr 27, 2020 at 1:31 PM Luke Diamand <luke@diamand.org> wrote:
>
> On Sat, 25 Apr 2020 at 07:53, Danh Doan <congdanhqx@gmail.com> wrote:
> >
> > On 2020-04-24 11:28:13+0200, Lars Fricke <lars.fricke@gmail.com> wrote:
> > > Just to help anyone who runs into the same problem.
> > >
> > > For whatever reason (maybe broken package on SLES) the wrapper p4merge
> > > was missing from $(git --exec_path)/mergetools.
> >
> > In openSUSE, p4merge is splited into git-p4 subpackage.
> > Which make sense to me.
> >
> > Can you check that?
>
> That seems kind of weird. They have nothing to do with each other.
>
> >
> >
> > --
> > Danh
