Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6488C433F5
	for <git@archiver.kernel.org>; Sat, 21 May 2022 00:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiEUAwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 20:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbiEUAwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 20:52:43 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666DA1ACFA8
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:52:42 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 125so4822889vkw.3
        for <git@vger.kernel.org>; Fri, 20 May 2022 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQZgmHxtHfPKzF+6C5Ofe26Y8KXr+WD2I7S6rHVh4Y8=;
        b=kTHADPjz+nPxMfVymPyfiq99d9ymr9nmRXt32CwL/xy/VrHdD0mPSwTNGuSkAnshxI
         5+O4QbaCiPw2ajUEEcryrlee13P7ew3XKMNFSlOkMIVPdYHYNL0HHNRHeWEvMoqSI6dN
         93zdG/l7c1mRT/8SmbOztmpYSdnSFXVbuL0Fbd2llOeSEhbem2J5Z7/cJrJiVjXyFOp0
         ufO2YJzmfhWmZPnbJsWdLQetCZ7WtI7pxR7nCrn16ZW5aNQpaXrMysq8XZdHxQEoOaY4
         BAjURL1JKQ7IBCZwwLLdgNV+yeJdaL5Z2oGO+Z2dibWyux6h5pLlpHqHnv8BKGE0ZfYF
         mbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQZgmHxtHfPKzF+6C5Ofe26Y8KXr+WD2I7S6rHVh4Y8=;
        b=yD5BunhfaDr+rJEpAvVzsKLcrVOe4YuYdJQI2bebiuvQqmpcPMqC6/Dn7gXiKiTdrF
         57mFNhLAIQ2FoUrYM0rxNVka0fI0YAT2z7DtaSITyF/R3rn28gynQ6lmiojR93XRAsii
         oiO3BX63fRCwhkR+YP1fAf6SdFkC8DuV0LcAWz3X7xq+0SNmn+HQ8hlkxV24+8/b85Oq
         MU2qZy3BCk2ZqYAb+wEtf2zkOXurLf7adzu3yfmLv/hd+xUi+WlztvvIyJjQ/aBRk/ib
         V1tY6VzlaGpW2R4iUYnIiGEgoWjeXitJbAVuGEdJDhI19TZpVnR59q/Zf7nkOjQ0ceZR
         HUbw==
X-Gm-Message-State: AOAM5318MiVbdyx1VBXzXHWB4V1q2iwZG4bghnWMSzhUed+W517n9bzr
        dot6YqXY4kn1HiLoyGcKe+2PEA+p3WZnFByJ5uQ=
X-Google-Smtp-Source: ABdhPJw9WdRbJj9yja8Jx6qqCVPxZ9k2xo/9vS5JhCO/ZW0/Sh9k9XTajs5y5oLlk+MArhjKqFOlnsND2opLWFWVgxo=
X-Received: by 2002:a1f:5842:0:b0:34e:7a9e:9579 with SMTP id
 m63-20020a1f5842000000b0034e7a9e9579mr5077160vkb.16.1653094361516; Fri, 20
 May 2022 17:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
In-Reply-To: <9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 20 May 2022 17:52:27 -0700
Message-ID: <CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com>
Subject: Re: Investigating Cirrus CI FreeBSD failures
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Ed Maste <emaste@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
