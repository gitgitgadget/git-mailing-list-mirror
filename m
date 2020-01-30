Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8037C33CB3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892B120CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 21:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWTJNgFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgA3V7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 16:59:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37100 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgA3V7z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 16:59:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id cy15so5542675edb.4
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 13:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTBu5yRnNYaKsG/n1KFHHUziqnkX+dOEV2DsVRMi7Nw=;
        b=OWTJNgFgWtz4MTzZW5Hey9bXJMjt5SYfKrJTwDIXhdpPdFf7grZWyNSH9uV7MNLBu4
         ZXZQRemGTruJ71lgjq7o2BMP4K/D7b0j+L0fnJTqhVfLP6w2p+WLy9lHKHkIimN1+Ky3
         tIUBQymhRN1tHpLXQCaFeIdQdCWE0VRCIfVp5Sk0iHAeh/YLHGf6VRrGo3LTH8BcZn0h
         L8OPUBe8fOA5eaz/X/Ki+1x5Vme3CqA9vgDTRBtj2xoy5hZcDROs2QYvwjva5j5fvNUV
         b8JOqINdTJByZcPbAzpdxnoIsGa4/esaTn5SU1mB4/QwP3w9Y70rl/MpkvLw7kdWE6ny
         Cr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTBu5yRnNYaKsG/n1KFHHUziqnkX+dOEV2DsVRMi7Nw=;
        b=aY43rvB2Xu3QKBrNCws+dQp4UI9boq8O9+3tCPtxq/uddk/3oTtDVWHwp4ak7+UgCp
         t0LHL6f41A1L6NypEnE7FgZh4ymuuB0Jco11JI/8c63r3tXxKv4vYtxnjw4yEjW8Vwis
         tF3v1AYzqzrK/PK2Q5RCArNUapdLqlxSIPMkqqsR2Yw51TgNe+8LAu2wRY33z9VCyzzj
         sJ17D439djlgZUlnILbZQPgAJXxw1Q11zlVDcnEF4VMHA3vS0KpmpZr0QyFQbPhhlvJ+
         FRoN4/GhM3BwFE/fUaoYQq2NXpbReJO5z5UQxBCYDK0diGvKEsHDXSsNl5GbWH3zY2Yy
         yvVw==
X-Gm-Message-State: APjAAAWUyycttu/6/8PTqdAKJnoxyMi4DGMgGzqUAUu+QxN5vU+5L2am
        jz9eAP820V9fzvebVGReaznqnNzeAmZ5yvSu548=
X-Google-Smtp-Source: APXvYqyLlygXU47Fa4oXZPLDYiDa5aGP/fhwbwizSVwrsGsKyM40BviNqPhuOsFno5oOxftOtQS5kL+uCbO4ZIK4DuA=
X-Received: by 2002:a05:6402:513:: with SMTP id m19mr5788220edv.387.1580421592167;
 Thu, 30 Jan 2020 13:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 30 Jan 2020 22:59:41 +0100
Message-ID: <CAP8UFD3mhirdjHnT+XRq1mPzii3O+mtAMrYCy7mf4HKQZo8Acw@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jan 30, 2020 at 2:46 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Tue, 28 Jan 2020, Miriam Rubio wrote:

> > +             /* Create file BISECT_ANCESTORS_OK. */
> > +             fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > +             if (fd < 0)
> > +                     warning_errno(_("could not create file '%s'"),
> > +                                   filename);
> > +             else
> > +                     close(fd);
> > +     }
>
> I wonder whether this would be easier to read:
>
>         if (res == -11)
>                 res = 0;
>         else if (res)
>                 ; /* error out */
>         else if ((fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600)) < 0)
>                 res = warning_errno(_("could not create file '%s'"), filename);
>         else
>                 close(fd);
>
> Note: my code explicitly assigns `res = -1` if the file could not be
> created, which is technically a change in behavior, but I think it is
> actually a bug fix.

I don't think so. I think creating the BISECT_ANCESTORS_OK file is not
absolutely necessary. If it doesn't exist we will just check if
ancestors are ok again at the next bisection step, which will take a
bit of time, but which will not make us give any false result, or
prevent us from continuing the bisection process.

I think that it's also the reason why warning_errno(...) is used in
case we could not create the file instead of error_errno(...). We just
want to signal with a warning that something might be wrong because we
could not create the file, but not stop everything because of that.

Best,
Christian.
