Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DC141F462
	for <e@80x24.org>; Mon, 29 Jul 2019 01:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfG2B03 (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jul 2019 21:26:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39980 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2B03 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jul 2019 21:26:29 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so29962077iom.7
        for <git@vger.kernel.org>; Sun, 28 Jul 2019 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6hxnhuwnfbg8ZA7/e2b9GYQVVQPMLzaVdkEkBXQ3JZk=;
        b=V5nnsY90WJqJlHmHf4VHglllUumN+MZQzq447i3A9QSC23gPxgn8LlEKb4aG8gt9E5
         JrNcpVExRnJ9lB71ogzkU/UrSiJf6cg0SGx7eenBrLVePT4SUf2v9xTZ40t6jcB0gElt
         pezBPPiKeFRcDCkQKcyhtwDnClSC6ftlcG7qzxBfj8wFOGbFdJcDzkxL5jKeccz+Ndc6
         lKLM/bZ9G0OuuGMVIiOtTS9Nzeu8xVDbqEc0CZY5draBb3d2wdpJSFbLXSbntwse6rqj
         gaGP5nazm1mkv9fr/65FZpGl1KEcxaMAUnkRtExlWoG7fe8SvIpNu5dprLEDrjAsGH0a
         k8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6hxnhuwnfbg8ZA7/e2b9GYQVVQPMLzaVdkEkBXQ3JZk=;
        b=KiLfhyWSDL/5XaI9hB6RydlBlNGhmUCyDA/N93hRO8tiUk7QNKi3kY7as1tPyZOnha
         rtO2A11zih6VDnpCQxFYEao8q4eRJTnwPgIlA4AXFQpsyu1xqh02RY1oupALi49/Sbvt
         iCaBr5yWXITAMVe8JlLBu6nEaXlVf5NtQ6tzgjtWu1iDPVJiSPtZfjbvwow5YLyTQLsn
         Mh9N1B8iO7TJwRRubt4EJJge2dEZc6P5hrCdAeQyRGvOSUXEFTj9DadtNQNdQyU0+2uH
         Aop2EVQcIkvIxqXvB8l/2fTAolVdw+WKGv9PZzn/omuKC7sRTG4DAVCtF9zLdSbNmLLq
         HAlw==
X-Gm-Message-State: APjAAAU69eNw1rbvZmfeM+4VrgJ19gFSAsgEJVH5KPp+E4mpTk6Xt8Lr
        slEWWkGFiJL7GrNoip/Du4OIoFGc68d1zmPqC4M=
X-Google-Smtp-Source: APXvYqz3bqE8AMIu8eVLoOP311UvISqdHRIIfPu+CA8oWy3R8kpLda1CQvVOhBdG0TtA1/qAuRZnYq+yoLJ+iuOXeMI=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr54042023ioa.161.1564363588036;
 Sun, 28 Jul 2019 18:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190724151415.3698-1-avarab@gmail.com> <20190726150818.6373-4-avarab@gmail.com>
In-Reply-To: <20190726150818.6373-4-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 28 Jul 2019 18:26:17 -0700
Message-ID: <CAPUEspgStVxL=0SoAg82vxRMRGLSEKdHrT-xq6nCW1sNq7nLsw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] grep: stop using a custom JIT stack with PCRE v1
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 8:09 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> It will also implicitly re-enable UTF-8 validation for PCRE v1. As
> noted in [1] we now have cases as a result where PCRE v1 is more eager
> to error out. Subsequent patches will fix that for v2, and I think
> it's fair to tell v1 users "just upgrade" and not worry about that
> edge case for v1.
>
> 1.  https://public-inbox.org/git/CAPUEsphZJ_Uv9o1-yDpjNLA_q-f7gWXz9g1gCY2=
pYAYN8ri40g@mail.gmail.com/

Haven't seen any responses from packagers but there was a report[1] of
CentOS 6 users
that would be affected, and would certainly make things more difficult
to whoever is behind
the git binary that comes with Xcode in macOS and that is linked
against a system library
(PCRE1) that is IMHO unlikely to be upgraded.

The minimum I would expect if you want to move forward with this,
would be to make
their git not randomly die because of non UTF-8 haystack by applying
[2] and make clear we
will also introduce stack size problems like the one in [3] (as it was
done in the previous
commit)

Feedback on the patchset[4] that applies on top of this to make sure
JIT can be disabled at
compile time and the logic is less messy also appreciated.

Let me know also how you want to keep it on sync, as IMHO makes more
sense inside
your branch instead of as an independent topic.

Carlo

CC +Brian

[1] https://public-inbox.org/git/20190615191514.GD8616@genre.crustytoothpas=
te.net/
[2] https://public-inbox.org/git/20190722144350.46458-1-carenas@gmail.com/
[3] https://public-inbox.org/git/CAPUEspjj+fG8QDmf=3DbZXktfpLgkgiu34HTjKLhm=
-cmEE04FE-A@mail.gmail.com/
[4] https://public-inbox.org/git/20190726202642.7986-1-carenas@gmail.com/
