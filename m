Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE9C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0782146E
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQbolV+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfLTJaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:30:02 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42368 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJaC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 04:30:02 -0500
Received: by mail-ed1-f54.google.com with SMTP id e10so7595349edv.9
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oVZmK+Y+fDm8T/au+90JOMa2pdJBE88lsjIZJ+vHgNE=;
        b=CQbolV+CfelasqHKeO8z83HHI/2lAZHcwX0UOO4MgM4m4TeHzCu5ls9WhxUYZ0qjXA
         iSV9UDN+817vmsJSGactv11PLsErMEsCwEdf1J7wtCYaHPN5lTCGF3Z7MT3pW26GP6wG
         cyig9a6pvpGaU+ZtQj3dReZjSXvEyn3XOXlqB9PNg+6rwoXtxNnVseN/6HOXnIdxC/Il
         QaiWYMAsSTgt9eK9jeX1vjGidImyb+gaqPnpCsjjd5Xb4I31FBi5CrjtSdkxve1X/PMA
         ta9TpRdN8NLmzFpyEFm7a/8wKkgzIzkDENv/iCUL/+OjZgioc1NyyTquF67u7QboI2zD
         f+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oVZmK+Y+fDm8T/au+90JOMa2pdJBE88lsjIZJ+vHgNE=;
        b=jR1u3J292mMmLieq77VwdvZn7gtbzAHQY+FocnfPPpwxUf9Mm96pHoPfV05dOIXRgW
         QC0L900vaGc6f0msAyarWn08TpjVMhZ4Sng936HHBI7IyZTmz/c+/IRsz7PU0a6i10+v
         rV6R6GGIEm1Xtz5ZJ78OwO7LdDh9K0MA1fN4lq/HyjDzBt2CRqhBUsn1Nij/FYk9vFup
         T2Sjbpnr/SD+QS0hNBGX88f4npk9bohZ+8ppTMm6FPqe9rWHyEVvCinEawaM3p+Filxx
         ot6js3/t9UZJAZqwq+L4o9/ZvocRcXSEp1kxrY04acmLRqz14XaYz6IjytN3kmX6wDJD
         TeOg==
X-Gm-Message-State: APjAAAX6fYfq3mlM0vcwlCgRX/ogfcsMSLRZXAaX/WF1ZE/Nii2HDewz
        6Au4RAGev4YYfIQG9GGA2QB462df4XTIBRiHihvyhAgi
X-Google-Smtp-Source: APXvYqyblveBOvSYyrTcEJbv+GmwZsGBo2J8BY6FvQdl79E6awwGHbHOvZSyJMz2x+JmDM4+X0DnIZlvi9A1RUR91sI=
X-Received: by 2002:a17:906:aec7:: with SMTP id me7mr14598862ejb.81.1576834200135;
 Fri, 20 Dec 2019 01:30:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHCo6soNwee3hN4i6v0KtxphKHa96v--e41KRqfHKV5i45OqcA@mail.gmail.com>
In-Reply-To: <CAHCo6soNwee3hN4i6v0KtxphKHa96v--e41KRqfHKV5i45OqcA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 20 Dec 2019 10:29:49 +0100
Message-ID: <CAP8UFD231wb124-fKQcv-ddG96xncHanOnZA4jWEU3-shxTkGw@mail.gmail.com>
Subject: Re: IaC monitoring with Git
To:     =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= 
        <christopher.diaz.riv@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Dec 19, 2019 at 10:31 PM Christopher D=C3=ADaz Riveros
<christopher.diaz.riv@gmail.com> wrote:

> Would a valid approach for first issue be to set a pre-receive hook in
> our repositories so that before the PR is merged, we check validity of
> the contact email, a.k.a. owner tag (we assume validity means that
> email exist), maybe via ldapsearch or another command like this?

You might find it easier and simpler to use CI tools like Travis CI,
Circle CI, GitLab pipelines, GitHub Actions, and so on to run the
checks instead of using a hook.

> For the second case, I'd assume git does not by default monitor
> contents of files on a regular basis, does anybody have faced this
> issue and successfully found a way to periodically check contents and
> trigger alerts on repositories based on same case (email becomes
> invalid, then trigger alert)?

Many CI tools let you schedule jobs regularly.

Best,
Christian.
