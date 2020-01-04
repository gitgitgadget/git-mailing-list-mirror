Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C7CC2D0C2
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAC424650
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ka9aDHYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADRZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 12:25:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726004AbgADRZF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Jan 2020 12:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578158703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MHPuB6mMVSgBuVNdrFQcfBt+AiF1gXWdoIjTzFN+CU=;
        b=Ka9aDHYBjsPVDC89Yu+bd3x/Dl0zEXqAgCCZ49gXMN+0VG2cQD1obyyDD/Wo9vVsHhbHKk
        BTFFzhJ3KQCYxo2PwJ4q5tmm9jV0lllNRfQPwE/uRSanjKLOzpXIoeNG2Al1Ein9rpjjI2
        N5f3unsubYPixxAD5LczBg93N/Cc7KM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-xri7dEuYMcaULZGsdd79Jg-1; Sat, 04 Jan 2020 12:25:02 -0500
X-MC-Unique: xri7dEuYMcaULZGsdd79Jg-1
Received: by mail-ot1-f70.google.com with SMTP id t10so5701497otc.9
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 09:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3MHPuB6mMVSgBuVNdrFQcfBt+AiF1gXWdoIjTzFN+CU=;
        b=QTpnhIikkMPbYf0HzWCSXzCjNwR6Rt5w9Yy+tV9l9FrJiiQt6cnxBzegrmkhRotKfF
         xTnn291lfrVSSTJHqcINTN2dzcjlXixUoNkL3I2FYXCdMN5286NRUf++d9XgYiHXi09r
         r7ZVIThtfGEEMpdJOIgaWnIQsqEcporDg977PtnUwVNeoymXv8c9oyc95I49Ky8GmrFw
         HCU8zUMD+p73vli5rBKhkVJqcEv1qvPyWAM3gxJask2eeRd8EFXXPD+KUC5HMMt8aiog
         kpKeAcfNYgj5c8vp0BrgVn43G/vUbI1BAASzmN2UXanHDaiJ0UHh+GgPxyYJ9g9JipwW
         F5kg==
X-Gm-Message-State: APjAAAVv4InpWZoUNTvi6X0omI7oAHj+bxHlrCLCzwmTBPVJif1+A/xq
        AML4Tr0W6etOU35wccmr29oOOC1/EK0QAAM/owqdhevulrCoO8bW9yqaVAYzxNqjt4OZ809N7ux
        +Z8FTGz1Yi5zlStiBAg1JdaV50Kk+
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr70714435otl.368.1578158701886;
        Sat, 04 Jan 2020 09:25:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxPxjmnvZ8Y+pr5jjwbDvdi+c9KNy8ba8ddsnrqEuz2+t8/e0+SMbpVOTZyBSiIEzxA2Usqg6M/RpCL5L1xZI=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr70714419otl.368.1578158701684;
 Sat, 04 Jan 2020 09:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20200103120613.1063828-1-marcandre.lureau@redhat.com> <20200104004516.GB130883@google.com>
In-Reply-To: <20200104004516.GB130883@google.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Sat, 4 Jan 2020 21:24:48 +0400
Message-ID: <CAMxuvayT8FtovVnWU4bjQCP26drN37yuPG2+G2jAUsm0Ns_AYA@mail.gmail.com>
Subject: Re: [PATCH] RFC: commit: add a commit.all-ignore-submodules config option
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Sat, Jan 4, 2020 at 4:45 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Marc-Andr=C3=A9 Lureau wrote:
>
> > One of my most frequent mistake is to commit undesired submodules
> > changes when doing "commit -a", and I have seen a number of people doin=
g
> > the same mistake in various projects. I wish there would be a config to
> > change this default behaviour.
>
> Can you say more about the overall workflow this is part of?  What
> causes the submodules to change state in the first place here?

The most common case is, I guess, when you work on different branches
that have different (compatible) versions of the submodules. It is
easy to go unnoticed then, although I am usually quite careful what I
include in my commit, and will usually add changes interactively with
add -i instead.

I often rely on git commit -a during an interactive rebase. I check
the project at various points in history, find a small fix, and git
commit -a. At this point, I may have included a submodule change
inadvertently that may happen later in the series for example.

>
> [...]
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> [...]
> > @@ -1475,6 +1478,11 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
> >               return 0;
> >       }
> >
> > +     if (!strcmp(k, "commit.all-ignore-submodules")) {
> > +             commit_all_ignore_submodules =3D git_config_bool(k, v);
> > +             return 0;
> > +     }
>
> nit, less important than the comment above: no other config items use
> this naming scheme.  We'd have to come up with a different name if we
> want to pursue this.

Sure, I am open to suggestions.

>
> If I want to disable this setting for a particular "git commit"
> invocation, how do I do that?  Typically when adding new settings, we
> add them first as command-line options and then as a separate followup
> can introduce configuration to change the defaults.

--all=3Dno-ignore ?

>
> To summarize: I'm interested in hearing more about the overall
> workflow so we can make the standard behavior without any special
> configuration work better for it, too.
>
> Thanks and hope that helps,
> Jonathan
>

thanks for the feeback

