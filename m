Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07EDC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 10:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30820873
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 10:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij6N3T7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgBMKHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:07:42 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:46234 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKHm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 05:07:42 -0500
Received: by mail-ed1-f51.google.com with SMTP id m8so6067068edi.13
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 02:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJLu+DRC0WXvnG3gB+z7FPkMReuZrJjtHBVQULGjvzU=;
        b=Ij6N3T7Iks7Gqj+EA172HAsDQ1zM/mGTALAK6Fy7UDX+u5S5XtHnkrfYmbsSGB6iAX
         YwcMNmwrWURUWWaO+3OROcFa4L2C2AApUfrICMfSp+SJdTd1BpDArkiPGQqad26TjidY
         RPkhI4ByJDWsDUL4nGxUgo5/zobdLuCfYSvPC4A1sL5VhDaZNTJb21U6TCdvp/1PYC5r
         OtxGwz1AXniXr+ABCRnPZLnL+ZR7904MM+wWfQkxy75cQfrGG0sdFu9qdW8dQFqUQm5e
         PPhZwogU/f5UwUzK4Bqqw6DEBD8lfYi7x+u69MI/X1jiGyMgdkMI9Oxju7EIjakJhG8r
         NWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJLu+DRC0WXvnG3gB+z7FPkMReuZrJjtHBVQULGjvzU=;
        b=rZ1yoNWbQSNnwo+PHRHmYIUjYoQJJtUzanQbukPP4SmP23VXlqtgwYOpr3r+7vsB8I
         u1LXw+oFzTYUN5WTGNMVueayvlLWU/9wtVReW/wvOusWJMPxyN5xTKL4GpbcNhmjQu5d
         VAZZRqWsS1rBX2KpACfAa0gOPIYuDHaaYW4P/FbNOByCD179I027prWRheymXoZaYPYv
         Uy6j1TStHYek3zLEFRfGrcmMqSr9UflAECeekdAvA+3XSp+2PSxUxLpsEAp0Rj7ADCuo
         8BVeGwRZ7k2ytj7tIFFrFcNutLz4nXRczmsGNt6/Iv5reFs61YK4/3EVfJCLCQTar9u4
         E2xg==
X-Gm-Message-State: APjAAAUx4Q3Mn/AuMjMhg0T3HPSVtwr+fVh4hZgngEKoaKOm9v4V+Agk
        Srb+J8eh9OYgqV9Q6gZmYUGPZFfwCyc1uIuegiI=
X-Google-Smtp-Source: APXvYqwPIqCJpEkXAkrB8dHuFGh+jR2NUkPUnurXcnu3EWT/712tX1FzPm1e/kDpUBis6IlVSd2KHweUL31Qcgbb1pM=
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr14595080edb.362.1581588459633;
 Thu, 13 Feb 2020 02:07:39 -0800 (PST)
MIME-Version: 1.0
References: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
In-Reply-To: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 13 Feb 2020 11:07:28 +0100
Message-ID: <CAP8UFD3Xi_56qqiDstquHZ9i=RDF_ka7NJMniiw5cvcrV90oLA@mail.gmail.com>
Subject: Re: How to force configure script to use curl ?
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Feb 12, 2020 at 11:09 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:

> I was trying to build Git yesterday on a Ubuntu 14 machine that was missing the package "libcurl4-gnutls-dev" necessary to build the http(s) remote helper [1].
>
> Doing just
>
>     ./configure
>     make
>
> built Git without support for the http remote helper, as expected.
>
> However, doing
>
>     ./configure --with-curl
>     make
>
> did the same; it did not result in an error saying that the curl headers could not be found (which I expected).
>
> Is there a way to force the configure script to error out if it does not find curl (or any one of the optional dependencies that I happen to need for my build?)

Using the configure script is not needed. Building Git using just a
make command can work.

You might want to try it and see if it fails as you expect when
libcurl4-gnutls-dev is not installed.

In the top level Makefile you can see all the variables that can be
set to customize the build.

These days the configure infrastructure is not as well maintained as
the Makefile.

Best,
Christian.
