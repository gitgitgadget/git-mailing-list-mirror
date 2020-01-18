Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DEC33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038C92469C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzs11pyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgARP13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 10:27:29 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39241 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgARP13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 10:27:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id 73so10029927uac.6
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 07:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JgVgMygzli4feZiWHc67i1Bxq9eqgKu5ztE47KE1F6A=;
        b=uzs11pyIhsPy6TuWRPvYnydcN2kINtGSreC/MFXAZglIqUEO/hcMQmW4RpuseU7g1f
         IFFgejAgAU/2yxs5R3l5P8A8CfRCQqBe3P/IqGad2mnlhEIPo/c0RvgZq2LsIRgjqFqI
         yiXXWQwr57FqU/VKIYvzY+tDmbmm5fzeMksAK6PDaJqjFbqxPi9sQKBke5KSeEm0RqSg
         Ux+aO528k7MeqsCnYmj9qBMVKi3wg1elb5CSDsfoLPIXZYIEfmrHBpNaBrqRw1LQJWHb
         rwr+X1oz/fjoMADLUcIj4tSfGZatu/UvxYCnPa1saWu/+VHkYbzSjDY3139BsybHqPFT
         pJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JgVgMygzli4feZiWHc67i1Bxq9eqgKu5ztE47KE1F6A=;
        b=jQy7VJG0JEE8WvDQvX52zwulueV2P1Dn2SuPpxhVw0bghKPJUblpgCvn3FOYL40H5w
         b+1L+LrrbLhpIHMhCBHdLfPWnCGPm5oILQ5XCSTxeCxcTcxrNIDiXJg/d1WaJTrHsX4G
         Gw5VzaOTe2ZNBhlWwWx59BFo7REfNur0EN5GKCqLjbmbHdmYmiUEjrNRFDx3Kfjnfccf
         Ux4uJeTfkzojjog620kGIU+eP/KoDqdkuhLeSdigW11tQVbJaCw+2PBtbRMaROtVBjge
         UWzWLebMb8c2aslG+hdfVDuqrDQhtDeUkOFUvaunf5w5gfwGyS+izPZMKoYO9QGHccPB
         KJSQ==
X-Gm-Message-State: APjAAAV2tetW4mlpAi+XB/kDRN3IAk3m07uKxX3i9EUWEjvCruDuTzQx
        nckw/YiIjF7sY6W7jjJz/KLxQGF8L8twreXTHO64hQ==
X-Google-Smtp-Source: APXvYqwfn8hgkpcUFLvCQo7T7uNtTr2eyIB4jBjJcFB31OtlsZRcMzYgNvLZShAXIN/7lIdblMfS44zh5+XQnIqY/Fs=
X-Received: by 2002:ab0:6341:: with SMTP id f1mr24154630uap.74.1579361248508;
 Sat, 18 Jan 2020 07:27:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
 <pull.478.v3.git.1579275102.gitgitgadget@gmail.com> <f06f9291b7c357422abad9f9cdd7425ef9e22509.1579275102.git.gitgitgadget@gmail.com>
 <xmqq1rrxertd.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rrxertd.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 18 Jan 2020 10:27:16 -0500
Message-ID: <CAOjrSZsnyt5PO5n74YYC4_T4rw77dEZ49frH4Fq+bKoMBX9exg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] config: refine config scope enum
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So the gist of the change is to split REPO into two, LOCAL and
> WORKTREE.
>
> If we can find a way to state that concisely, perhaps we can improve
> "refine enum" and make it more informative.
>

Should I just say "split repo scope" Or is that too on the nose?

> > diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> > index 214003d5b2..6695e463eb 100644
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -44,8 +44,10 @@ static const char *scope_name(enum config_scope scope)
> >               return "system";
> >       case CONFIG_SCOPE_GLOBAL:
> >               return "global";
> > -     case CONFIG_SCOPE_REPO:
> > +     case CONFIG_SCOPE_LOCAL:
> >               return "repo";
> > +     case CONFIG_SCOPE_WORKTREE:
> > +             return "worktree";
> >       case CONFIG_SCOPE_CMDLINE:
> >               return "cmdline";
> >       default:
> > diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> > index 7b4e1a63eb..535b2a73f7 100755
> > --- a/t/t1308-config-set.sh
> > +++ b/t/t1308-config-set.sh
> > @@ -265,7 +265,7 @@ test_expect_success 'iteration shows correct origins' '
> >       value=from-cmdline
> >       origin=command line
> >       name=
> > -     scope=cmdline
> > +     scope=command
>
> Why???

I meant to put this change into the next series in the patch, but I
must have messed up, so I'll readjust that.


-- 
Matthew Rogers
