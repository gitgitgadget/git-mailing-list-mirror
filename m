Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869C0C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 11:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616722078A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQNN7LnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgH0LlT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728746AbgH0LkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 07:40:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A352AC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 04:40:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w14so6046317ljj.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VqApV+6q38owufKXTW6oB+LiWywwpnh/K5dOSRRAr10=;
        b=aQNN7LnENp4us3hzHxknC/PP+SDp2TyR0HRVNk3x/M+YEsDA/v/i6uU29hWcQJi5gb
         d/0YM6HSZ6MA/gEE4DP1Ku6AthoNC6W7jfA8BM2dCK5z23ukOL/4wV8XUTHsvUhNGfvt
         iRKkYlDz1V2iZBES4cxe0PoTQdEtlv26jSvWNMdUkBl6lVhTvxd30HKpcK7dnisg2u1e
         CxH4EsC+6Cbul5oWy9s108rr4Q1VNqirjHK/jRWU8o6sKaQrkn+jIvGZA+6NRZMBkmqv
         5uG1EE2WwE4VAMDkylrJhEtWXzEtKsBk5NEae0SwwnlZIdN/JRZRjTgPIluyJgSbW52h
         4MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VqApV+6q38owufKXTW6oB+LiWywwpnh/K5dOSRRAr10=;
        b=ZRe6hWjPgu2R0OR5pt6PM7yj1ZcVn68YQp6Hv0rOdL9p8TCN0acIViCDKO6Gv11jlB
         2Z2ZwS+jn79qeBKfu3cOZTgpFjZUFE4nnCalFL1+EjfBqKD3vrdJlJFkGr4psi2C81KK
         NdUbkmM1J616Gy1rsJERzivFWdk+0D60ef//tKgNGcf4BusKTnGKLjFPOm0C19aeL5k9
         6s1B8WTazOIoQEMJdLyHkehzdgnHZUQY/mSdPsOqpO6WT/dtewC1S8KLgomBrYG5ev2/
         M1k/svv73ZZ3HIDnL2nCu0KyTKL5UKxhMCoT+CdBbXAyls05JCAp4uiopaKOYUAr1aic
         vbew==
X-Gm-Message-State: AOAM530YXLvMGW3T/cB6k0ssC2yNuBcnkGJ3p+TFBJcyamzfD6LlgeQl
        z1kh3r7OLRDCX5N9yo+SBrv9veaFh7tJ3qhMNTIVNQAirlEbPg==
X-Google-Smtp-Source: ABdhPJzgX+o0GteL0xTrjZSLWaUzp5tojjHYeGzso+FDasKV43kQM+LFr9OfiF8ZJ6aBZYN7Wx1d1UJHauHz5j3uww8=
X-Received: by 2002:a05:651c:238:: with SMTP id z24mr10033600ljn.172.1598528406839;
 Thu, 27 Aug 2020 04:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
 <20200827101924.iklvsy6lnscrpojs@yadavpratyush.com>
In-Reply-To: <20200827101924.iklvsy6lnscrpojs@yadavpratyush.com>
From:   Toni Brkic <brkict@gmail.com>
Date:   Thu, 27 Aug 2020 13:39:54 +0200
Message-ID: <CAF2SHyA_bg1wxaDaLN=m2G+0sZB=b30LTnm3rOPVEYgAx9Uazg@mail.gmail.com>
Subject: Re: feature request - add --only-author option to git push
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Hi Toni,
>
> On 27/08/20 09:47AM, Toni Brkic wrote:
> > Sorry if this mail list is not used for feature requests/discussions.
> > This was the best list I found.
> > Let me know if should post it somewhere else.
> >
> > I would like to be able to configure git so that when doing git push
> > git checks that I am author of
> > all patches that are being pushed. If I am not authour it should not do=
 push.
> >
> > The reason for this is that a common mistake that happens when working
> > with gerrit (at least for me)
> >
> > Person A has uploaded patch1
> > I need patch1 to continue development and cherry pick it to my repo.
> > Person A uploads new version of patch1
> > I have finished my patch and push to gerrit. What then happens is that
> > I have an older version of patch1 and thus overwrite the new version
> > by Person A
> >
> > Maybe there is some way already to do this, but I could not find
> > anything when searching.
>
> Have you tried using a pre-push hook? It looks like it is exactly what
> you need:
>
>    pre-push
>      This hook is called by git-push(1) and can be used to prevent a
>      push from taking place. The hook is called with two parameters
>      which provide the name and location of the destination remote, if a
>      named remote is not being used both values will be the same.
>
>      Information about what is to be pushed is provided on the hook=E2=80=
=99s
>      standard input with lines of the form:
>
>          <local ref> SP <local sha1> SP <remote ref> SP <remote sha1> LF
>
>      For instance, if the command git push origin master:foreign were
>      run the hook would receive a line like the following:
>
>          refs/heads/master 67890 refs/heads/foreign 12345
>
>      although the full, 40-character SHA-1s would be supplied. If the
>      foreign ref does not yet exist the <remote SHA-1> will be 40 0. If
>      a ref is to be deleted, the <local ref> will be supplied as
>      (delete) and the <local SHA-1> will be 40 0. If the local commit
>      was specified by something other than a name which could be
>      expanded (such as HEAD~, or a SHA-1) it will be supplied as it was
>      originally given.
>
>      If this hook exits with a non-zero status, git push will abort
>      without pushing anything. Information about why the push is
>      rejected may be sent to the user by writing to standard error.
>
> --
> Regards,
> Pratyush Yadav

The pre-push hook I do not believe could be used to solve it. Due to
that it seems that you cannot have options to
pre-hooks. I only want the pre-hook to run when having the
--only-authors option. Or some other way to not run the hook.

Since there might be situation where I want to change somebody elses patch.
