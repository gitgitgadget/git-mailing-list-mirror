Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39256C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A5C20700
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 07:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOmFabgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXHJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbgDXHJi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 03:09:38 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E73C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:09:38 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id j26so10779162ots.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 00:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/cVz6a1UYHYV8JcJ9RZOujiCwmhH0wMYUiqmt5ArKhE=;
        b=lOmFabgVf0Cx1RMfj5LaQ7TUW/GGZth46Smqs0ZOlqE5Rrn1AIyJ4fHjowCRQc+IJG
         ZJOeTB4rnfwRfCslhnZx1sGZjvsmfLG90nUHv7WbOvpCXkfUWXNONY4+Dmw2TMRTLIc9
         vGzC/WY1vs+zkVX2v5wgQPYIXo9bkVYppgJ1L9VEdpd2znipnxHkiOImfzhV6L/uQVLT
         +Yoj+nroZCjGfjmboREwarZzsshpaDMC7xd2khNWiMuVhU9VZMerAd0aBQ4mCVWGsRrO
         BZ2KuxwxmhSzBomFFOjz4HSI9HVG6i6+dolSWNt2Mkrj/0DiaizVLF/WeXpQnIIkYzRD
         sNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/cVz6a1UYHYV8JcJ9RZOujiCwmhH0wMYUiqmt5ArKhE=;
        b=asBmB6286ioRdWcgMk7UtF0vS78IsRV4WDvlRxb7zKoB4O3HejrVeQx8kmb+3Si1s0
         jODATbed1M9ZxsY9vypLa0r0jyed93JGx3T/wR+XkMpDaW781iwFquKoo8ZQRWbf3hmq
         ahbHo2yx0L05g8jc7rrnhHhcWyUBkJJaFkhs0+WqKkgiqx0ypIYDejFLcxxwKe9tGHqm
         kLazPKX3SsNc8W0rRyIrqAWca5oYCHW5Xq9wvHepoVVJzMJaVnJYvg3ohbQyDdTr6vMP
         oQIemmHuo756UwjF2MzpoDk/Ophu1mOkEbTBZnHBc+hguKA1li+UwISJkJef7s7MTxvV
         4lgw==
X-Gm-Message-State: AGi0PuYtD2e6rhUdkt9z+GJltpWwxwBy8hJ7/fKKvV+z+1z05FAqVKBZ
        OYu5AQ1ZyLmDn1xQYuCm4/z33xYQfl2FXpzHIfA3+SIw
X-Google-Smtp-Source: APiQypK84thMrfPFy481U6vV0xpEJs33x+akELLwSZMbuoSE6m97yUv4mosBkBDz8wnCmyDt/4G9cpJilZLw3HJlLss=
X-Received: by 2002:aca:fd93:: with SMTP id b141mr6096617oii.177.1587712178162;
 Fri, 24 Apr 2020 00:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANYt6aFi+6vKRD71digEh-D0RKkLPBRtek5t8zA-8_cPzwexkQ@mail.gmail.com>
 <20200424064805.GB44448@Carlos-MBP> <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
In-Reply-To: <CANYt6aFjp4wVzYk85Ag9mH3AWp4qUS3+4xsGioyQknKz9tmRUA@mail.gmail.com>
Reply-To: lars.fricke@googlemail.com
From:   Lars Fricke <lars.fricke@gmail.com>
Date:   Fri, 24 Apr 2020 09:09:28 +0200
Message-ID: <CANYt6aEP4u0vg9tRrtB6A_xY7JcQ5w_RBzDAMnvcW6mnEEr9mQ@mail.gmail.com>
Subject: Re: p4merge no longer working after upgrade to 2.26.0
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forgot to mention - p4merge is in my PATH

On Fri, Apr 24, 2020 at 8:57 AM Lars Fricke <lars.fricke@gmail.com> wrote:
>
> Thanks Carlo for the pointers
>
> git mergetool --tool-help indeed does NOT list p4merge.
>
> So support was discontinued?
>
> Configuring it as merge.guitool also does not work.
>
> Regards,
> Lars
>
> On Fri, Apr 24, 2020 at 8:48 AM Carlo Marcelo Arenas Bel=C3=B3n
> <carenas@gmail.com> wrote:
> >
> > does it say it is "not currently available" if you run:
> >
> >   $ git mergetool --tool-help
> >
> > does it work if you do :
> >
> >   $ git config --global merge.guitool p4merge
> >   $ git config --global mergetool.p4merge.trustExitCode true
> >
> > or change your PATH to include the location of the tool?
> >
> > Carlo
> >
> > PS. mergetool.prompt is a valid confguration, but not mergetool.$TOOL.p=
rompt
