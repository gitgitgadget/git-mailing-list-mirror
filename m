Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770FC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 02:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiBVC02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:26:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBVC01 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 21:26:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6A25C5E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:26:03 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bq11so11987302edb.2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 18:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TrDD4N7586W/bnkfJLjfH7HDIbiJpGFInRq3ZYZayfg=;
        b=fmcKgX1+1rRMmGPME0YRQgAleWsm+maAmeCj4PrbF1hP6cRg9/waC/udzMxzy8L+aM
         CEPC1C5ElLk1tDXJCbr3Jb09NYMYZLDC/tXhXwLl3pZLE815jG02xx4tZThNTyN/pux3
         laHx2SXK6vCFoeR84sNwjR7A2HAx5h9ScvtJepM0+cBhAYINZFiDo4JelCTH4cAadpXy
         VhxiGoobmUSYfjy6ad6LXlmioXDFaz4+nEWKipmslC3smaOs6S7Cm47Jx0u2choefnw3
         b2Umu1eU+bAuEoA/Mj7v7zNIT4hwmPCLgqbZkAaTyKCxjJjPqAWxX4mshboy1R7F1pf0
         GRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TrDD4N7586W/bnkfJLjfH7HDIbiJpGFInRq3ZYZayfg=;
        b=D3Rp9kSJenuURvPY5jdtR7B6mRR50it4f650qx1k75MagLUvm2dXc295CnybKla9Eb
         f+1cLzpxNQHV250mYy4n2wMmv9RYqUGqsrDpZnHyhGKM1KyfDHGIftNXfSUkOl43Eueo
         tl8hDUIty8ZuF9rVotIsjRtViXHUJJOQryIQj12k/rfoo57rp6rRGk5AaNil2YMib457
         mmqqMsSGC1NNCFzATzLuph7ZZL/bvrZdYT32jBpaX6/j4ppW4+DyzYOZsb/1yKoDTLwf
         irNapc+Ro5SXVFYiITyx9vTGxag5AiUhzauuPRjPYmYwYSoru6MxIYzs//jmp1kBl4nN
         pR4g==
X-Gm-Message-State: AOAM533M6m316kIt6YdXXoLtHSadTwAAZF/SkKFL7pbEOZikysYjn8N7
        h9ORrZ9qnINzkqaIeN8DR5t53EoWKI/FNc5LUfE=
X-Google-Smtp-Source: ABdhPJy8VDgLMOM0JZp82AZAzt5FSjp7nGcN3V2cT4KsSfbnoW6mDoWNTmxO7LPJ9xMkws/xmpTDqd5QBt0mprQz3Io=
X-Received: by 2002:a50:9ea2:0:b0:409:5438:debf with SMTP id
 a31-20020a509ea2000000b004095438debfmr24275271edf.126.1645496761627; Mon, 21
 Feb 2022 18:26:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202212100080.4418@tvgsbejvaqbjf.bet> <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
In-Reply-To: <220221.86a6ejakun.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Feb 2022 18:25:50 -0800
Message-ID: <CABPp-BHmU8-a+McANE2bdAndGEtVudr74FHEEj6K6NwYECEZ6Q@mail.gmail.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse patterns
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 2:57 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Feb 21 2022, Johannes Schindelin wrote:
>
> > Hi Elijah,
> >
> > In addition to Stolee's feedback...
> >
> > On Sun, 20 Feb 2022, Elijah Newren via GitGitGadget wrote:
> >
> >> diff --git a/config.c b/config.c
> >> index 2bffa8d4a01..68e877a1d80 100644
> >> --- a/config.c
> >> +++ b/config.c
> >> @@ -1520,6 +1520,11 @@ static int git_default_core_config(const char *=
var, const char *value, void *cb)
> >>              return 0;
> >>      }
> >>
> >> +    if (!strcmp(var, "core.expectfilesoutsidesparsepatterns")) {
> >> +            core_expect_files_outside_sparse_patterns =3D git_config_=
bool(var, value);
> >> +            return 0;
> >> +    }
> >
> > The `core` section is already quite crowded (for which I am partially
> > responsible, of course).
> >
> > Maybe it would be a good idea to introduce the `sparse` section, using
> > `sparse.allowFilesMatchingPatterns` or `sparse.applyPatternsToWorktree =
=3D
> > false`?
>
> There's a large list of exceptions to this, but generally we have core.*
> for cross-command configuration, and <cmd>.* for command-specific
> configuration.
>
> Excetions include http.*, mailmap.*, pack.* (arguably), trace2.*.
>
> In this case though we have 2x /^core\.sparse[A-Z].*/ variables in
> git-config(1) already.

Those wouldn't be an exception as worded.  They are very much
cross-command configuration variables, affecting basically every
command that touches the working tree.

> So perhaps we could name it like that, then at least you'd find all of
> these in the same place when looking through that documentation,
> although a name starting with "core.sparse" might not be otherwise
> ideal.
>
> There's also no law that says we can't have a three-level variable as
> core.sparse.*, perhaps that would be the start of a good trend, and it
> would sort adjacent to core.sparse[A-Z].* ...

Interesting thought.  I'm curious what others think of this.
