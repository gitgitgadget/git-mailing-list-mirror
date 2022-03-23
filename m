Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC0C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 05:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiCWF3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCWF3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 01:29:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802B64FC73
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 22:27:48 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r22so428449ljd.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YRmLIoPdRvfWllgHz9atCI+RR+vLnPhvwtBIohqPxp4=;
        b=I15uEo+AvrMldbbTaqWrab7OBCUUAvwgG6FvKzgtl+cg+u8/hdTDgJ0imc1KqnUTGJ
         63rbknc8nW6fXLX/zaFSoTDnZaE5TeuIOOvF4oOnRnLo5qcnsuKi6tCZrwlyJn28GoRs
         KxtEhrQYvVp5wMn2qrLC4Jyp0gvaw4yErW9i30b9Jc2AftQlTPEZjdNCFY6e01igk2L7
         9bYBVz/8L16wfJNZONMjVe9ES8GE6nao/x3IfFDg4/ZLdXEKUrUuLFEcTHQdM+PeaxAS
         85lTOFw2HNV+3akeXoSNvt8e8VTTYtQ9SNENbwTtd+tYGwmx/Y8U6Ee56IcdjA2NZRg+
         7fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YRmLIoPdRvfWllgHz9atCI+RR+vLnPhvwtBIohqPxp4=;
        b=cMvPrxdsrfDNO7FF4QXCvS30mpkozA+NJglaMEmCRgsgXjkTwNfD2nNU5F44ma5u6X
         WvjG+Y15Q/qcyljKzb6hqs8TkNVCX6lhJltdZPHOBKBN5roUvjw73/OW6gW7R3ITCUci
         XjU1jw5CSKFyExarHyaE3Oj2Mt+QtbwtzpVACokds1jN6T68FIo+D5UGTZg2HRp4yAyp
         16bw14OCFDgUvHIeT/nMDwuOXwmfjD3XYJhRzw3k7oycTy2p2vfji3PiljmvVKPYNklM
         vhz6EQCRYydwA5WZ6783X137KfIQt1ExdPnple+xbrud6jZUeH3xjG86qlH0zWAmSUYg
         PI3Q==
X-Gm-Message-State: AOAM533xFGAdHE53v8a/XmIZ6bZR6ijT3DMU0aKIK/6V4CYN4qrRgD3I
        Px4Yj9fMEP0qmx3fzourGtOI8PdZFFwzgNJADaI=
X-Google-Smtp-Source: ABdhPJxFkJilGvbTUQcsHBH7ON6+GasPTkUDb2oNbH0yL3JI5Txf8Ni2cI3h/logLYOfTtOzHtKI3aVFcLxHsYEPA5Q=
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id
 c5-20020a2ebf05000000b00247b233cfbamr21810763ljr.131.1648013266633; Tue, 22
 Mar 2022 22:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANQDOde2OG8fVSM1hQE3FBmzWy5FkgQCWAUYhFztB8UGFyJELg@mail.gmail.com>
 <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-patch-1.7-e03c119c784-20220323T033928Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-1.7-e03c119c784-20220323T033928Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 22 Mar 2022 22:27:34 -0700
Message-ID: <CANQDOdd6w8d_1sx8Sob3EZ4+hy7m1DBdN4EYFJPExLmTgr5Kqw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] write-or-die.c: remove unused fsync_component() function
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 8:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This function added in 020406eaa52 (core.fsync: introduce granular
> fsync control infrastructure, 2022-03-10) hasn't been used, and
> appears not to be used by the follow-up series either?
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  cache.h        | 1 -
>  write-or-die.c | 7 -------
>  2 files changed, 8 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 84fafe2ed71..5d863f8c5e8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1766,7 +1766,6 @@ int copy_file_with_time(const char *dst, const char=
 *src, int mode);
>
>  void write_or_die(int fd, const void *buf, size_t count);
>  void fsync_or_die(int fd, const char *);
> -int fsync_component(enum fsync_component component, int fd);
>  void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg);
>
>  static inline int batch_fsync_enabled(enum fsync_component component)
> diff --git a/write-or-die.c b/write-or-die.c
> index c4fd91b5b43..103698450c3 100644
> --- a/write-or-die.c
> +++ b/write-or-die.c
> @@ -76,13 +76,6 @@ void fsync_or_die(int fd, const char *msg)
>                 die_errno("fsync error on '%s'", msg);
>  }
>
> -int fsync_component(enum fsync_component component, int fd)
> -{
> -       if (fsync_components & component)
> -               return maybe_fsync(fd);
> -       return 0;
> -}
> -
>  void fsync_component_or_die(enum fsync_component component, int fd, cons=
t char *msg)
>  {
>         if (fsync_components & component)
> --
> 2.35.1.1428.g1c1a0152d61
>

This helper was put in for Patrick's patch at
https://lore.kernel.org/git/f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.164690=
5589.git.ps@pks.im/.

Thanks,
Neeraj
