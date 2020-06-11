Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EEAC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2349206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 11:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=goodman-wilson.com header.i=@goodman-wilson.com header.b="gAXjWNYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgFKL7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFKL7w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 07:59:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903CC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 04:59:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k11so6153166ejr.9
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goodman-wilson.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SJUT4hqnIu5tUJU0pWwpEkats+K1/+F4/Sz0fTj+0X4=;
        b=gAXjWNYTLqLOSMhTWKCFMTFh2Ywl4eGAmQ+qV/wKtBnYwQGdeXZxpPD1eBF3a6tkkK
         +c4x8emoP1GYVO27z5CZUg0f12KpElQWOXZEWJjnjSLoAE+aSUShTbkHs1tOEacuPxDn
         LrfmAx/2o82/pXou2R+1JRZwJaVEdyNzA2D772pMIpgfl1Ttyto3p9pE+nT7Ctj83bKb
         10WpTnLV34kG58F1QW3vSMr4QR7hxj8LrjYzu6oAhhBdTPBOj02fvCBOaXw1AIsQ6ZW/
         cTkCv4KED58Il2xdm7+t0JwqjUHzNgbm5qSRl+argKVquWmvijbP3f/8AjE+8cKMYNPU
         qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SJUT4hqnIu5tUJU0pWwpEkats+K1/+F4/Sz0fTj+0X4=;
        b=XVA+s15lraCAR9GOydM6bxNaADl9+5E+YcY/RivBX7r4gFUJLnE7SwldZKW+r+nnZg
         7Oo/xtJ8yQ/urgYBcWHRni6sLMm4U8Jj4rcUETEBys65R93rs6wK113FsC7F8ieTIY3X
         SRLV1rk3obB9lY4SeANIEeHn11doEgShNVBkE9RzH71btXNOLASJCMRIGf6hB22yq3K3
         sE222LZfagpyYcqkQonRvdhmODsO3q6QYZmDVx9wiPEs1MZDaoGGEXKw96UJrpMTFFcA
         Gb45julxiQaOhP+1FdTXIn7EnzMgoKXgUetfSC6U00fQy3RXZur1EYRKBMBuShsBJlQG
         eA+w==
X-Gm-Message-State: AOAM533zMYSuALWsTHgZYIU/muHkrsalA2e4PnBecUdiQ9MZsbTWdsK2
        k8FKj7zaSpVdmFWWbfT4jnMFb23cIHJoYVhIak/i0A==
X-Google-Smtp-Source: ABdhPJykpaPH+bBg3cLOyMCHsCt/yhkSqVpJme6JgREZGOeuJ+RHkLoutzq4kHZZv3IWik9gYMWu5yzqYQhfDYItUn8=
X-Received: by 2002:a17:906:768e:: with SMTP id o14mr8327361ejm.497.1591876790390;
 Thu, 11 Jun 2020 04:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
 <20200611115215.GQ21462@kitsune.suse.cz>
In-Reply-To: <20200611115215.GQ21462@kitsune.suse.cz>
From:   Don Goodman-Wilson <don@goodman-wilson.com>
Date:   Thu, 11 Jun 2020 13:59:38 +0200
Message-ID: <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 11, 2020 at 1:52 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
> Indeed, the flexibility to choose the name of the default branch can be
> helpful for projects with specific naming, especially non-english
> speaking projects.
>
> To that end I would suggest adding -b argument to git init to be able to
> choose the default branch name per project. This should select the
> initial branch name and also write the it as the default branch name in
> the repo configuration (if git continues to treat the default branch
> specially).
>
> This can be used in documentation to use the new name immediately
> without breaking existing workflows that rely on the 'master' branch.

I _really_ like this idea (and your reasoning). Seconded.

Don Goodman-Wilson
