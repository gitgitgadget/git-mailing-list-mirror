Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C24C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 10:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC996100C
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhDAKC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhDAKCX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 06:02:23 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEFDC0613E6
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 03:02:23 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so1580136iog.13
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 03:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=irOIipm+6KC9uAvffhyjobBC+BQdq71imxBfugRemyo=;
        b=WuRIW5Lvuvx3v2OGMWYzMv8W1tH5HU2lwd0WSoQowFn9dv0abcRxZ+ljwODHWi2NmF
         smzH1kW3WHlWbWNF4XteF5ZQrRD13JwdsS/l5iQn4gJrg5i0Khz94WmIN0zvlqJvJmaL
         a2UckDH8KevQounB42FyW4nwPan92agVTXdVMD+JVd8PR0l/FsIS19otxzxVqwHnOwhg
         9yYLhbfgM/fVjBO3r6j1vD7Ryqs6aGJ7bsWGDoDHCgzU6RM+pRl+BplnIJaGVnCL8wyu
         LTXHYOgbHMfUwR0zhTpdgrNIhg+CoppEbgIlhCIbmAVMCZFR0qbzifBhkPc8IXv1LvFU
         sPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=irOIipm+6KC9uAvffhyjobBC+BQdq71imxBfugRemyo=;
        b=mvbj8xvFNmlUEsbe1kHH8XpF1B0sI9iJDnFuCSSKDH98D9MBxCAHnHshg59GX05qgX
         It+PfNsSkzxe4tDGO6cL9BnzQJ1ryQfOFVY0YYm8bCRVzh5t908IhJDrj5n4uzgeiax6
         lfy2K+ppA92mP8UpuiHs2bRVBAbiZGKuZGL5Iw1EtzWTU5IK7SvdRR3tsxbMMMZ1+7lk
         Hq46B4+loFOZyvTRjd7xhvszgM7qduidfoLnfnPxtXVeFxX+EriO/ixYbXQ+bUM+4da2
         a0KYctZBO7Me2ChF49+lZ6+c78kuauF++AjzgMfVuoW4sGrf3h3/lLqmoJoK1dnt6KE3
         yyvA==
X-Gm-Message-State: AOAM532364BBqGcWYNuGwwrMroxcHR2rmc9nqZMFA4rqtv5V8MSgjt5H
        KLziYCirKWk1c2vbReZkHu/Oj2ZiAXlQ5ecsOPY9eXhXCOh3o/94
X-Google-Smtp-Source: ABdhPJz/mL0/2EGdmeQ9BK1S4JMqNjj36CT+OrUU0u8cCbv6rsUVzmxRmFI2ZCy3wXGW38ryPJhE8zSQJefN8Gwgydw=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr6055875iom.68.1617271342831;
 Thu, 01 Apr 2021 03:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com>
 <pull.913.v5.git.1617185147.gitgitgadget@gmail.com> <CAP8UFD0a_HQ9bEQLASn_D1jj+ut+okENJs=aENDxTDL1f2VZKQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0a_HQ9bEQLASn_D1jj+ut+okENJs=aENDxTDL1f2VZKQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Apr 2021 18:02:09 +0800
Message-ID: <CAOLTT8QxB==BPfwBVex5uof=3EBGdEoTPci7PP1K0mfkQY-5aQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] [GSOC]trailer: pass arg as positional parameter
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:28=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Wed, Mar 31, 2021 at 12:05 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > In https://lore.kernel.org/git/xmqqv99i4ck2.fsf@gitster.g/ Junio and
> > Christian talked about the problem of using strbuf_replace() to replace
> > $ARG.
>
> It's better to sum up a bit the discussions. It's nice to provide a
> link to the discussions though.
>
> > Now pass trailer value as $1 to the trailer command with another
> > trailer.<token>.cmd config.
>
> If this patch series introduces a new trailer.<token>.cmd config
> option, then I would expect one of the patch in the series to have a
> subject like "trailer: add new trailer.<token>.cmd config option".
>
> > ZheNing Hu (2):
> >   [GSOC] run-command: add shell_no_implicit_args option
> >   [GSOC]trailer: pass arg as positional parameter
>
> I guess the "trailer: pass arg as positional parameter" is the one
> introducing the new trailer.<token>.cmd config option.
>
> Also it seems strange that there is no space between "[GSOC]" and "traile=
r".

Thanks, I'll fix them.

--
ZheNing Hu
