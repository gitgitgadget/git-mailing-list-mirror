Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F4C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 12:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCMM74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 08:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCMM7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 08:59:51 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CDE2CFC1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 05:59:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c3so12934189qtc.8
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678712354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnG5kIxk6cjEeBURxufbWYXg93nu7NqOI1Zb+JTqrhQ=;
        b=VmwNh9UgDgaLRmD+bwwuXSS2JmY08LgEnMGSfKzs+3xnEL3DGicLYG+AHObfcm8nCT
         oKlFSBA2ofHe/6cZ3jxKac8OME4GpFhlqGpkqOo+3hBfVmi4MCH6y6EV4RfveQW3Bk6N
         ON2BU1ipvEX68RBTSHtYWwlgUsjeKl06m01en+Igx8muuc90FkFMRpEtYOw5PKmFq9pY
         xNqsaHlsPX6Z1UIdSbmOlkqk1em+LnVsQZWXkS+Xa+V0ixo0Q1MCV4anlHsZ8O1MO45k
         J9vFpk/XlkvadEJhfDjhprvjq0Yyr/uGnk4JADxzyT6tYgqowS7IZia39quM+e+NMEzz
         17Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678712354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnG5kIxk6cjEeBURxufbWYXg93nu7NqOI1Zb+JTqrhQ=;
        b=4hHa0nTOb1T9dsQ4/Irzwxoyj9DJlKF6BE1y/l9VS2/UzIAdkPKvWL4ZmWI7fangR8
         eTlxYtcgk094YSF/6Y96PJeX+V9bFz0SOr8acgXEihXAO3ZCCKGN3aWjZMfhGLFNoouA
         uTE1729BtGyUgLL+rpUlyOWlneLbAG9cIWmDNyACch8Pez7Shsmgp584nJm1+HUjQNnZ
         EaIM24TgG9nZcq2Zdw9AAQhQzZiD/jbZpsQsX1EnWUyDEt99PhFGdx4FJuX3TIU+fnTf
         R/0lLjWNaqpuJ5Fk2RNOwd9ARRuv4n9wIg55Yyn1Dg4Sa0doSep3JosbVcgdXCUb3zI/
         PpGQ==
X-Gm-Message-State: AO0yUKW5CiXaGCUP/MrWWtikqORfsy41Zca8oSLjKnGpsWE7Pa7OmrlH
        E8ImyKmPuLgV4FmNxazazaFDMBUPtxzyKne1n/BziOclav4=
X-Google-Smtp-Source: AK7set8shVYsPV45CrRFUkkM3YBfOFJZ0l9Xg1aoUXDu63f4WhECsoc04WXPDYWUK14kk9xL8TtwNh2LJW0Ikk7WEJY=
X-Received: by 2002:ac8:11a:0:b0:3b9:a6d6:ff2 with SMTP id e26-20020ac8011a000000b003b9a6d60ff2mr8599755qtg.0.1678712353993;
 Mon, 13 Mar 2023 05:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
In-Reply-To: <CAHp75VfTQZ8vFQXZKgbsedG2BOad-pv9fCVkNkX+kFAxhnhhXQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Mar 2023 14:58:38 +0200
Message-ID: <CAHp75VcZJPysc2-NXTC53XvOwbx-UfPO9SbsBJFb72JGHFyO1A@mail.gmail.com>
Subject: Re: git rebase issue
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2023 at 2:35=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Hi!
>
> Recently Debian has updated the Git to 2.39.2 and broke my user case
> (I believe it's a problem in the Git itself and not Debian packaging
> or so).

Forgot to add that last week it was working nicely (I don't remember
the version, but according to Debian changelog it looks like 2.38.4
was working fine to me.

> So, my use case is to run
>
>   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase" "$branc=
h"
>
> in the repository that is made out of bare + a few worktrees.
>
> Previously everything was working (my bare repository points to one of
> the existing branch:
> In shell prompt: ...(BARE:netboot)]$
>
> With the new release I have got an error
>
>   fatal: 'netboot' is already checked out at ...
>
> To work around this I have to split the above to
>
>   git checkout --ignore-other-worktrees "$branch"
>   git rebase --rebase-merges -X ours --onto "$newbase" "$oldbase"
>
> which makes all these too inconvenient.
>
> Any suggestions?

--=20
With Best Regards,
Andy Shevchenko
