Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E1FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 11:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F272E2071A
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiMGDWzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKDLqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 06:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKDLp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 06:45:59 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3317C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 03:45:58 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l10so1632466lji.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 03:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I5OV8YM+8Q/m8Y/JGhrNXBFZ2gSUidbMGDq8Q58I0jI=;
        b=GiMGDWziKFsU5vYsIyUTWivNr86CkoWUfjpJoDyTqS8tWBXINJJa6TKbOMMDBXRn0C
         lyA046K//bDgspW4bt61GfnfJIXDbGB0Qz7V1+NtW8tjdVBidzzUubt3EAgSTYz9gXRt
         ElMDLEIMF+UounQYXiFubGJftuiKGzNj2HcujtKrapWT0kWSHtZIMCpRbYljZQU3Lgtf
         B/xpVf2ISsk3BCjtGpdYw0ewv40J14Czzca253MMaGAdO8+mXRxBpSr4mcNq7VEDpg/I
         48MVpv5gNJDniWpeMduHV364Re4ZmlAJIrB7HKv4dHqaRbtq+lEJUUWpK8YbUcWEVPSi
         vTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I5OV8YM+8Q/m8Y/JGhrNXBFZ2gSUidbMGDq8Q58I0jI=;
        b=LceugkI0y63Byr1GnP2LiW0Fj1GDktUaFcBscd7YjaZyVrauwzdgBA8Mfz9CmbQWmG
         NjcSFdxcLcNZhngu9Gbm0t8zp4UNI/KY3CIWuJXSDBLVBl4g7np6xG8CJZLR+xoV/Z1C
         O6KRciC6RVnZetaCeetUXZI2i3KfnxhEz7gg5nbnoKFYn2tFZQrM9OL9K16s73ZhF1Hm
         lSI2SqGvoY6LVfe4r/JagiCRjppJY1IbKoQ7QZtNXlVd05FEe9XvpyYsMZZfuCBDHOP2
         koNP/M6NBF3ZbuxLoV9B9w+cZifD7ca4vtDOS9qzaOsgLybWLML2EgR3xwxJqYzK5Vno
         11DQ==
X-Gm-Message-State: AOAM532I0RZ5V2nv61TeXMRZEzG9q8H1f0f/oD+Veqx+OrRk+c24Opes
        GislTyNXU0zQMDgisniLvByaxkDbtmLpOjCOFbE=
X-Google-Smtp-Source: ABdhPJw/utjlW0H/YUOwgbiWisznMRJiUv2DkRbsFcInHI+4kXGAMmlH1WiIwo0I2XOxJFK8EgW0GopkmpfulOsPpA4=
X-Received: by 2002:a2e:9951:: with SMTP id r17mr11024630ljj.37.1604490357060;
 Wed, 04 Nov 2020 03:45:57 -0800 (PST)
MIME-Version: 1.0
References: <46BA69FB-B082-4575-ACF1-DC959527558E@me.com>
In-Reply-To: <46BA69FB-B082-4575-ACF1-DC959527558E@me.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Wed, 4 Nov 2020 22:45:20 +1100
Message-ID: <CAH5451kZYL0LsXqVUxJhAA7iQ7GWS5zic5Z1jX_CbCjZWSGW1Q@mail.gmail.com>
Subject: Re: Git Help
To:     Joe Fabre <joefabre@me.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 3 Nov 2020 at 04:37, Joe Fabre <joefabre@me.com> wrote:
>
> Hi Git!

Hi!

> I need some serious assistance.  I have a local repository on my primary =
laptop, and that repo folder is shared on the local network. The primary la=
ptop died (grrr); and I want to create a repo on my back up laptop which ha=
s access to the shared folder, but no .git file.  Also, I=E2=80=99d like to=
 link it to my GitHub account.
>
> Any ideas?

Where was the .git folder located for this repository? Typically it is
a subfolder of your repo.

If it was, it will be on the local network share, and the repo should
be intact. Install git is on the backup laptop and try to access the
repo like normal.

If the .git folder was not stored there, or for some other reason has
not been synced to the network share, it may be lost. In that case you
will have lost the history of your repo, but not the latest workstate
that was checked out.

There are lots of guides on how to upload your repository to github -
here is one, many more can be easily found by searching:
https://www.techrepublic.com/article/how-to-push-a-new-project-to-github/

If your existing repository is still intact you can start from the
'adding a remote' step.

Hope that helps!

Andrew Ardill
