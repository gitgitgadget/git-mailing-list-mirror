Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0891C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5999610E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhJ1Wnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhJ1Wnw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:43:52 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB25C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:41:25 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i12so2439412ila.12
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEodGaSKCg24SODt2i2seYf2FPXldbNlPiICrvKfZxg=;
        b=loeQemsWxKdpEJQCqM1C3R1Juyxe1LscrKgD9qf3SGemoLP0osvvRwGBSwfavb/Zz6
         anrJQQ/Y8aRthcb22ChnFxzDjrmXCMdgof3ed0vQHjm3XQLKlwBF4ZN4PDrRDSLZQdRz
         CIZ3wI9gvgtf65aFToSDU6Q9xMNWmITJJITldvwWzVOwAGILCxpgbU6yD9SuUXZl+Gfb
         WXU43pknk/Dm3ZvsoyrZINJ76sWKR9eGWeFvr9l/RWAfc4GTWYgaL5nf0WgR48E52e0s
         kSpQ7u9MpiAkzOfB58iJe4Y1X7rRvXZp2Y5rnsz5nzYe+3f59UWk+qjjzDCuq07xWz84
         2ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEodGaSKCg24SODt2i2seYf2FPXldbNlPiICrvKfZxg=;
        b=nk9VQWmWCdGrTmqlrLPsXrQz6XedJk87q6qeVOUDYpsnvPl76ws2LQYXGXhtxKHABz
         pIvZciz2odgqPHhMUMN7c9WpyXnpd0WMN1/2bAURVdMuOofmnVcTPdTzl4UtjUhudpXk
         gpb6tdx9W52vHe+cPg4htOn9I7+DUit1MfJd3xGuJ4LnhD6abl5177kqB/vaU/ejA/1W
         kTJ/BW77iFc0hNlAm0REGMyhQnx/cYbQMgmT09oaT2hmSJljBobkfaj/kczJ+urpYtx0
         EUFNcnw5Uje1ZstV6mGgxMJhW4uoPvwZigNu6sFExKrrtfMEN+HVoZ2ePKYzgzITQC6l
         nsPQ==
X-Gm-Message-State: AOAM530ZIJfwQv0Wu7llYfE0ATEkDB4jLiZ6FVZwiCC0U0EwzClLv2V4
        7tIfUHkWKQ78ezhasubjqLoszMlAgXgO9up9NfvTUQ==
X-Google-Smtp-Source: ABdhPJzWfHF9H8noUSmm0xm1DPIBmychS9qWWHqDJS6F/HdyZQ+GjTIAwtdD5Fy5AhAlqMPp+UZnmVgoTYthYCUZ51M=
X-Received: by 2002:a05:6e02:15c9:: with SMTP id q9mr5124610ilu.298.1635460884393;
 Thu, 28 Oct 2021 15:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com> <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
 <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
In-Reply-To: <211028.86sfwlw10o.gmgdl@evledraar.gmail.com>
From:   Ivan Frade <ifrade@google.com>
Date:   Thu, 28 Oct 2021 15:41:13 -0700
Message-ID: <CANQMx9WPt93e3pNghtG01L4GqGvPgGeRNH4RCedMTV=Vcu8vWQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 9:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Oct 26 2021, Ivan Frade via GitGitGadget wrote:
>
> > From: Ivan Frade <ifrade@google.com>
> >
...
> > +                     if (!git_env_bool("GIT_TRACE_REDACT", 1) || !nurl=
) {
> > +                             die("Unable to get pack file %s\n%s", pre=
q->url,
> > +                                 curl_errorstr);
>
> small nit: arrange if's from "if (cheap || expensive)", i.e. no need for
> getenv() if !nurl, but maybe compilers are smart enough for that...

Done

> nit: die() messages should start with lower-case (in CodingGuidelines), a=
nd I think it's better to quote both, so:
>
>     die("unable to get pack '%s': '%s'", ...)
>
> Or maybe without the second '%s', as in 3e8084f1884 (http: check
> CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors, 2021-09-24) (which
> I authored, but just copy/pasted the convention in the surrounding
> code)>

Done

> > +                     } else {
> > +                             char *schema =3D xstrndup(url.url, url.sc=
heme_len);
> > +                             char *host =3D xstrndup(&url.url[url.host=
_off], url.host_len);
> > +                             die("failed to get '%s' url from '%s' "
> > +                                 "(full URL redacted due to GIT_TRACE_=
REDACT setting)\n%s",
> > +                                 schema, host, curl_errorstr);
>
> Hrm, I haven't tested, but aren't both of those xstrndup's redundant to
> using %*s instead of %s for the printf format? I.e.:
>
>     die("failed to get '%*s'[...]", url.schema_len, url.url, )

Indeed, "%.*s" did the trick. Thanks!

Ivan
