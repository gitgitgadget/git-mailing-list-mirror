Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75495C433E3
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 496FA2255F
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 17:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UflRfvTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGNRAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNRAA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 13:00:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D92C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 09:59:59 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ga4so22877799ejb.11
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vDSfs3ANiz/Goyy04BLGzPXxqcG8RFv0Pl5I6/cgJog=;
        b=UflRfvTiGOX9VPKIBDFwYN6V8KA4wdrCXd+pR3P7SEbC1ovA8U2cGYKjJ59E7ZAG/B
         Z4iHkY+nxppXSnifHvcTCDWgSxT8NQtOv4a241r4uDMf5H8ybHDEsYtKwuImgGI0Seou
         2k3YwfGlrYu2rl7QQ+0oTybGFnrdA97HU4iwM6Pxp3eIeJZynRfuVtTRxIiLo32VoZJs
         qFIC/FGhum1DRW5B/Wttql7CSkFavXOYKQv1h2C4zSY6Jm4dHz0W7tTW7mqluADJhwY0
         vZx+SJn09MjkmlxZWRWiTq5NjSAD1g5WHO64y1VVLu2Fx04ThKpLs0sW3t9fP3b9C8lP
         aiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vDSfs3ANiz/Goyy04BLGzPXxqcG8RFv0Pl5I6/cgJog=;
        b=kuwgTshkYNI0m5zGUOylTfuG7QwlU2YqYRgIVh7hMCXKJr5jllCuruU/mbsR9aIEy/
         FmYxt/ft6xnh0LwwQE3sYduIz0aO2VTqj9aTnZmmh8y7qOBf76q1yOK3T379QoLxRqQE
         ou8cqWoQWPTjsyGEgDPkclMQDz/f4nqlL7QoOoawsv3vlawQLUKT4eQ/WrKzeI3AF19P
         u3E7QY7/cU9ivrSYps5XQaiVgmZHSxe89G2UXhqbdW7T1k6JqWMP0eCfmjyb/qpsE8Sc
         YG9RwrAhcir5ZUhY5M7Pfmrnv1v+/097qPmgMY+HP+tutzEDNDO/yy0FsFzO/BebRT9R
         +DCQ==
X-Gm-Message-State: AOAM5310xe+iJEyA4DtVPPzu5q+wxSEaLGP3MWWKFRnxHHsQGpkSTDtd
        2cPZ2xMkdvmADVLFNiEgd8FYOwPaixhdFNrl8VVVgdU=
X-Google-Smtp-Source: ABdhPJygwRSFFBDpX84+I/XhXbxC7+h+zWCqrvz3XXE66R8iiv5RXcJU55Q52cPBzT+8YdGPDnXqzhwuK+BgAbHI2No=
X-Received: by 2002:a17:907:4003:: with SMTP id nj3mr5310918ejb.278.1594745997885;
 Tue, 14 Jul 2020 09:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
In-Reply-To: <CACwCsY7YSn_mbtFv3QjL5dY80G6e_r-gGC3SGo5rO5b8LGXxVA@mail.gmail.com>
From:   Larry Martell <larry.martell@gmail.com>
Date:   Tue, 14 Jul 2020 12:59:21 -0400
Message-ID: <CACwCsY7P5NiQL5ajHMOWo2EPiQZKUj_m_AVbtGy=z=twChimjw@mail.gmail.com>
Subject: Can't checkout branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Been using git for a long time, first time I have seen this. I am
unable to checkout a branch.

$ git status
# On branch master
nothing to commit, working directory clean

$ git fetch --all
Fetching origin
 * [new branch]      deploy     -> origin/deploy

$ git checkout deploy
$ git branch
* master

$ git checkout origin/deploy
Note: checking out 'origin/deploy'.

You are in 'detached HEAD' state.

I tried deleting the local repo and recloning, but I got the same
results. I see the branch on github. I can checkout other branches,
just not this one.

What could be going on?
