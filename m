Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0055C433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiCKW5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiCKW5b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:57:31 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB2297A87
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:47:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h13so12607690ede.5
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3iiH4mHOMcJRX6cZvRZLT78E0U1B+8BeSeC01/dl/3g=;
        b=OapJBsAMUWFy3Zey0lA+LU0Bf1uj/tJoKZjKUCyTCmjBi/ayDJMlKVA16BJiPAfmVb
         qjmi+J7jxXpGCkfOZrNVasDzadCSJAMojTduEy5g7dutLXxN3c8FyCjLLsmJR4VeKnIi
         JZt5ZMh1NGCvPqO2AaMVYTzgbgAaeH08U/FKzftUPQczR5IOGB4vcWMpODEL7rv7RVDK
         gtZZ6Nsz1fWrKpP/EOPYqrMpoP2i7APtMOK643XrTWfcGflhanu0vfJMg7baSGArUk5x
         PMHbI13ip7yTq6ZoY/caWMj+exX+greq7JTW1G0xeT4e3PNSBhTlYQxR2dhGA17p/mxK
         B3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3iiH4mHOMcJRX6cZvRZLT78E0U1B+8BeSeC01/dl/3g=;
        b=hR1qTBaU0EsFjdcViA9XnKkH6COZ1gqqIMnJznlr+XoIxnp+YdENgGfS/14EzYYu0H
         uvUgG/VHgjI5HeHQMqY6hgHqRt22+NyolcDEZNLy9b+hLVzdgsBgzSyMRyhCeXV3otIg
         Bu7qC2CeBxNzKk/I8SDVRYHtK3jN0EHzgG8yWfCiBjPOwpeb4ivZp1RkA5NL5hSxZYSC
         yaf5GBLAOgxuL3yWKoJ/kYFocAJ6wm1yUvYbTaqdJfKsqHtxs9lhuvkX2AwpNXLgwY8E
         avDKbWSEI9BZXKM+RuZP4SBVlBGWMma1CILVE/TvWm6Bl2+GlHps4F5JP4B306bf+fiD
         tGlw==
X-Gm-Message-State: AOAM533j2mEpZZp0pCqCFlSMSxnVjsGgzkajh6geehuy4/FyU1gfeU2z
        MJXAQIaScXNpggIbnxzKCPZh4DIdSJ0QsatTWMAsiLusT5o=
X-Google-Smtp-Source: ABdhPJw/DwdtpD9OPaDQk1iAzj9r5qTEeQg6WQqVHvabWQ12Ji7SGwGpaGG0D/VX6ZGt02YIUHEmXprvrTmqX09pv2E=
X-Received: by 2002:a05:6512:33c4:b0:448:7eaa:c47b with SMTP id
 d4-20020a05651233c400b004487eaac47bmr858659lfg.16.1647035315362; Fri, 11 Mar
 2022 13:48:35 -0800 (PST)
MIME-Version: 1.0
References: <CANsrJQd1H-NXVA69HxkzH1ZODTKaLzp-P7B7x+Qpbm5wyJFeDg@mail.gmail.com>
 <CA+CkUQ9gVQ3dxhNpFiA74kx0g5wZg5t1xDfrFzp3Ht6k2oarJw@mail.gmail.com> <CANsrJQdaix6=q=hXeB2kjUW+OTiXhsSCJom5ppa_SjzQaV5G8A@mail.gmail.com>
In-Reply-To: <CANsrJQdaix6=q=hXeB2kjUW+OTiXhsSCJom5ppa_SjzQaV5G8A@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 12 Mar 2022 03:18:23 +0530
Message-ID: <CA+CkUQ_2S78KzCJgFVEo819R1FUEYKZmuuiV3S02Ahnx9h9T8g@mail.gmail.com>
Subject: Re: [GSOC] Interested in the project 'Unify ref-filter formats with
 other pretty formats'
To:     Jayati Shrivastava <gaurijove@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 9:54 PM Jayati Shrivastava <gaurijove@gmail.com> wr=
ote:
>
> For the microproject - "Use test_path_is_* functions in test scripts", is=
 the intent
> to do away with all calls to run_command*  or to only remove those run_co=
mmand*
> calls where spawning a child process is an overkill (similar to https://g=
ithub.com/git/git/commit/ffcb4e94d3) ?
> If it's the latter then I am not sure how to identify such cases.
> Would be great if you could clarify it further.

Since `test_path_is_*` functions are more robust and debug-friendly.
And are just wrappers around `test -(e|f|d|=E2=80=A6)`. So, I think it's ok=
ay
to use them wherever possible.

But maybe someone on the mailing list will be able to provide better
and correct explanation. cc(ing) Christian and mailing list.

> Meanwhile, I'll try to work on another microproject to get familiar
> with the patch submission process.

We generally expect one microproject per student. But contributions
are always welcome :)

Thanks,
Hariom
