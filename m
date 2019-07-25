Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5179C1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 05:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbfGYFLQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 01:11:16 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34224 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390362AbfGYFLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 01:11:16 -0400
Received: by mail-io1-f66.google.com with SMTP id k8so94619562iot.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 22:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5tYycgHdX+T4yQgQepHBZ8nv5KQnrzTedIkzYAuwZKU=;
        b=REwMZLjZ3YPlWD7LA8MKzcjsMkcgox2XSNeiXUCRLkPG0Lvj8StN6Bm9JxBkDQbFkw
         7SQYbDCXcQY3BrTO5coMMbVwLQHZJJyEs6rGrjKGNEINHtgH2RKDK1NdQ4Dh7IMjQ6uF
         8+5k7WGbZi/C8j3MM6xS8ATE4ddA0or65MNrKdPDgs5ZlY2nReGKcL02uqk1SS1IzONY
         sOdBg3w5Ci/cBEG4DJlelJr5U4rbJZpDH63Augr+wFafFeJgRyK9u6omdmdlYcHYYibJ
         wdk6sstGXT2vX/EGKLmyx5gyY/8cJSvYOhRUVExWKCguAfLb1yxiPpkKbXD5DYxdZUfs
         M3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5tYycgHdX+T4yQgQepHBZ8nv5KQnrzTedIkzYAuwZKU=;
        b=Ub6MugKbPk7jsSyrVzU74rufR2iE1W/ZdKpzLJURq0W83NRRfzFFesk4lZwmn3CdC2
         5EEMsppKPruzgzhluks287/Wf2DJ1ywKHBIQoN4IvXSs3mXLLKzOQplwTJsyETfGLHpz
         /X6IaBPzujfcOPChaW7HS6gpilrg4EllGl4zBHTIoM4sP2/57hSNI5NgkEnUXuZzRK3b
         MapyPPxVNw4xkm+kFFv/EyaY0L/+KxDzc1ys9t3fo6hCEz7aQ4+SRgMHK38pUmoCMx+B
         rJD7FOOhyFASuEJJNdnbqOmpg/defF0YvOrXheuGOoN+Mdoaj88LgLF4KrtZNQtRpSts
         pf2g==
X-Gm-Message-State: APjAAAXAGCQzKRqknw6EyHbe4pRCNIhL1V8FgEzgjbsBmGJsjXqMjCAk
        A+amwHEoO1nYYpAbo6nkW58QFd+gOphLjXscaUc=
X-Google-Smtp-Source: APXvYqzNimRtaaHMEA2kmLvs3/bQ1gbLV/a9TdPc+1f4V8ac+hFmPPmrx4iBqFRN2AYHWcX8NIlQj17BeZ1vRJYcjIw=
X-Received: by 2002:a02:662f:: with SMTP id k47mr89193466jac.4.1564031475592;
 Wed, 24 Jul 2019 22:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190721194052.15440-1-carenas@gmail.com> <20190724151415.3698-3-avarab@gmail.com>
 <xmqqwog7qu2r.fsf@gitster-ct.c.googlers.com> <87imrr6vv2.fsf@evledraar.gmail.com>
In-Reply-To: <87imrr6vv2.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 24 Jul 2019 22:11:04 -0700
Message-ID: <CAPUEspjj+fG8QDmf=bZXktfpLgkgiu34HTjKLhm-cmEE04FE-A@mail.gmail.com>
Subject: Re: [PATCH 2/3] grep: stop "using" a custom JIT stack with PCRE v2
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 24, 2019 at 1:20 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Jul 24 2019, Junio C Hamano wrote:
> >
> > Does everybody use pcre2 with JIT with Git these days, or only those
> > who want to live near the bleeding edge?
>
> My informal survey of various package recipies suggests that all the big
> *nix distros are using it by default now, so we have a lot of users in
> the wild, including in the just-released Debian stable.

FWIW neither OpenBSD or NetBSD enable JIT, and the git that comes
with Xcode (AKA Apple Git) doesn't either, while still using PCRE1

> > In any case, if we were not "using" the custom stack anyway for v2,
> > this change does not hurt anybody, possibly other than those who
> > will learn about pcre2 support by reading this message and experiments
> > with larger patterns.  And it should be simple to wire it back if it
> > becomes necessary later.
>
> *nod*

the following pattern fails unless 1MB stack is available:

  '^([/](?!/)|[^/])*~/.*'

the workaround implemented in GNU grep (that uses PCRE1) and the related
discussion[1] are a very interesting read

Carlo

[1] https://www.mail-archive.com/bug-grep@gnu.org/msg05763.html
