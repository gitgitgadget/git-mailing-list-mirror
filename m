Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDBDC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF67561ABD
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 20:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbhKRUQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhKRUQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 15:16:35 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446C6C061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 12:13:34 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b40so31918686lfv.10
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 12:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUbLVsEW1mPDdIZea0+Ceu7XgoXV0hZfgyjZ+iWTdko=;
        b=F/7vNq1EQRZa/X8hNosii2iUOqbIZnwmjQn9/q43GOxILTenfjvaoex6mOQV1jUs9l
         tySdbJoGEjJFK6HBTGcfgvzBkPrmZjKgUps8faKU1dAqfix+qmxhIVNEJrapjj7VAwHc
         iHXF/xSncGq33qPFQ+Ln2QR13n1X9s8RneC7Kj4UOLxXESuykGzTYAKozE4tTTh2DXna
         ds1xaNeDncM5Ff7yoca5nMLdKhBtQkHIVT8QUMZAnT1ExTeYRdXpjeMHzh7vmbTNTmxB
         Cpm65qbmHuVibyqiZvftqdf+OJ4ziOA0KpyIK3nya5cG6IEmZ76SlxrdPKh76QmiTgsS
         mnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUbLVsEW1mPDdIZea0+Ceu7XgoXV0hZfgyjZ+iWTdko=;
        b=khCo5qMvlYp4AUYVJYtcotkDjKqXYfQqBVcq7UiretoEEMGC9l0ajJ2rVw89L4Y9j6
         YtClriYuTRqoX30ZeiN/3xIkhcSVrZZGiUwa7vAGdJIqINrD5jI6PrWTPYUAeW+PsxgT
         +gUdgfkg/ig4wRsf8Uz+GqXcl/CzFdw6iWK2bKCT1dyEhZa7ICpnZ0jm9L78+pmO37q9
         BMdim6LUo3iTNHfwZKXbUXSv0Sljni8aolrce6npfLV2ABMXTcDHon03ucWYbIt8nExk
         KsFwnAT4SGsUfCO8LnEGj0RVEyny4J9+TaEaw7QK86Nf+jKxYQ/GETDkJ9htkPa1zPeh
         dgig==
X-Gm-Message-State: AOAM530HMGTHTH6hJo147xQ8t1Jz0o3Hp4/tV/yViJbQExpagDiVAiD1
        m4rciFCrFIynVO7sSZ9qLKySDkiF6akW2wxx8euWJ6eB
X-Google-Smtp-Source: ABdhPJwbhFnqxXkZRmVmxYcFJMFvyaH1v6DFlnZiZJUrx57uhSkdgQnOmJYmx3JSFEfYjKNOMLy/2/5YVE25HmxvEAU=
X-Received: by 2002:a19:4312:: with SMTP id q18mr27356841lfa.299.1637266412640;
 Thu, 18 Nov 2021 12:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20211118164940.8818-1-jack@suse.cz> <20211118164940.8818-4-jack@suse.cz>
In-Reply-To: <20211118164940.8818-4-jack@suse.cz>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 18 Nov 2021 12:13:21 -0800
Message-ID: <CAPx1Gvfe46JFeNT8nW6NcFFy7bnR+eWYKS0-5soPVTmPxxJccA@mail.gmail.com>
Subject: Re: [PATCH 03/27] bisect: Fixup test bisect-porcelain/20
To:     Jan Kara <jack@suse.cz>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 10:39 AM Jan Kara <jack@suse.cz> wrote:
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index f8cfdd3c36d2..13f7deea4d81 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -240,8 +240,13 @@ test_expect_success 'bisect skip: cannot tell between 3 commits' '
>  test_expect_success 'bisect skip: cannot tell between 2 commits' '
>         test_when_finished git bisect reset &&
>         git bisect start $HASH4 $HASH1 &&
> -       git bisect skip &&
> -       test_expect_code 2 git bisect good >my_bisect_log.txt &&
> +       if [ $(git rev-parse HEAD) == $HASH2 ]; then
> +               results=('good' 'skip')
> +       else
> +               results=('skip' 'good')
> +       fi &&
> +       git bisect ${results[0]} &&
> +       test_expect_code 2 git bisect ${results[1]} >my_bisect_log.txt &&

These are also not available in old POSIX shell - consider using two
separate variables to hold the two strings.

Chris
