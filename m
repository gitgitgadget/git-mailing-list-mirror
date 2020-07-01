Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEACC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180D32073E
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxRmYCtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGAJxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgGAJxF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:53:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D380C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 02:53:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id by13so9174730edb.11
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wy5MqdW6SAtYUkvQgYVSDhyVQar+XGLrj17DcgOs1Us=;
        b=AxRmYCtBIyEB8uoN+bOL3L6lxiDhKnSPqXth8OjJAQfj/vmIRffKzRaG3SQJvufRcT
         pluRfIuWgBKLpCvVd1efupLIjig4fu3D4oh7KGlGidPw+aCW/GuHVDyxPrPEP1wgNsBm
         Un8EOTxxx2rp7wgVfwUhB27hLReeBEt+mPnwtXfsblCILxZpbUXMwm2crBpyr6IU+G7x
         07FpiLkUADE/gDE/q1pgbusnrwqw4Hh0AuUElvsqSqHmRYvabVmHJWqT1EFrd7hiHFw+
         zlY6tIg2AOm3+cU+Z1UQ6ipxE6kQYAhhKu3lI5Bj9rFyAvctLtjoO0w1JFv6JhrEO8kE
         xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wy5MqdW6SAtYUkvQgYVSDhyVQar+XGLrj17DcgOs1Us=;
        b=sZc0dIAtcJpue0zh/dZVj+TyzM9Gi9q+PIClXT/SCjHeZSBcbBL4PyDiSHNpEMW3Nx
         DqNj5a0mj5qNIe9g/YCowIEf7bALu6UX2yAa7E1ja4W/8LcB4V8+x4x68lBwIEAoWRRK
         O2EzJc8vo5g9DL8Jird1MqIM/PY6P4UHyuz/DnjyBCyQLzjSfK7l49kBAvSfGq6qPWvf
         IV8rORw6N/n2FYrjMggqKSxEFZgSN5gAljePsqg4XN9NWO6EK1OXfzDIKCBbwZObjnHv
         R7O98QB+8xdYDEw5I3u74q8P6dKA3+CHFwU8oT1PG9gjkE7u4p/VWojQM8z9t9hfm75k
         yDhQ==
X-Gm-Message-State: AOAM531BzqgHKMg8vN1ty2wBRuxcLIZ55FQW6bNz+XlEByyF/nS0jYxA
        TU4xd8V1qoL6ddW2haIUa/QHZSpRDw9TC3DUGAQcqVkRKnw=
X-Google-Smtp-Source: ABdhPJxc0/++Sakythbw7pPP2e/MvIyGF9AIyH/P3ul98gOLgmRp5QF46SWhZndctAM53axpsw3Pkoyebqpq+33GT1M=
X-Received: by 2002:a05:6402:1250:: with SMTP id l16mr28646067edw.362.1593597183786;
 Wed, 01 Jul 2020 02:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CkUQ_-_Rzu00w1L7QeMxT73a_MsD=8kY0+wtuRmze4z+1_AA@mail.gmail.com>
In-Reply-To: <CA+CkUQ_-_Rzu00w1L7QeMxT73a_MsD=8kY0+wtuRmze4z+1_AA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 1 Jul 2020 11:52:52 +0200
Message-ID: <CAP8UFD2qbtoXay1AgwrdaJ8XgVkq=NqBTa=KptUTop19xzUVuQ@mail.gmail.com>
Subject: Re: [RFC] ref-filter: add new atom `signature`
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jun 28, 2020 at 12:05 PM Hariom verma <hariom18599@gmail.com> wrote:
>
> Hi,
>
> In ref-filter, we have a bunch of atoms which serves as a formatting
> option for `git for-each-ref`.

Ok.

> Despite of having 'subject' as an argument to 'contents' [i.e
> `%(contents:subject)`], we still have 'subject' as an atom [i.e
> `%(subject)`].
> Likewise for `%(contents:signature)`, we can have 'signature' as an atom too.

Ok. Some things are available in different ways perhaps because of
historical reasons and backward compatibility.

> Currently, `%(contents:signature)` internally uses `parse_signature()`
> that only works for signed tag objects. I plan to expand the scope of
> `signature` by defining it as an atom and will make it work for
> commits too.

Didn't you say already that "we can have 'signature' as an atom too",
so isn't it already defined as an atom? Does `%(contents:signature)`
work for commits while '%(signature)' doesn't? And what happens when
it doesn't work?

> Also, thinking of adding `signer`, `key`, `fingerprint`,
> `primarykeyfingerprint`, `trustlevel` and `grade`[print 'G' for good,
> 'B' for bad...] as arguments to "signature".

Ok, I guess all the above arguments would be new.

> This change will also help me in using ref-filter's logic in pretty.c
> for formatting options like "GG", "G?", etc. To know more about these
> formatting options, you can take a look here[1].
>
> If curious about what approach I'm taking for using ref-filter logic
> in pretty.c, see[2]
>
> Would love hear your thoughts on it. Any suggestions will also be appreciated.

It would be nice to see, at least for the atoms or arguments that you
are planning to, or have already, worked on, a list showing how each
formatting option in pretty.c maps to one or more atoms possibly with
arguments.

For example something like:

%GS: show the name of the signer for a signed commit
  maps to: %(signature:signer)
  status: yet to be implemented

Thanks,
Christian.
