Return-Path: <SRS0=caIn=3X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F6C35249
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 00:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A014420661
	for <git@archiver.kernel.org>; Mon,  3 Feb 2020 00:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="j2q8xERc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBCAMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 19:12:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35400 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgBCAMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 19:12:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so8459011lfe.2
        for <git@vger.kernel.org>; Sun, 02 Feb 2020 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dlx0CqItQics7St/oV4lvN7qJDbYdu9uNdZTZdVoHOk=;
        b=j2q8xERc81V80zxOnt4VV5LgJDqs5LzOhuIvUNcVlpP+fUWWi5LJ6cDXjtR7LT1n4F
         Zbd2xNGxf3nHjuGzliVJs2N+f7PYbxq1Rf0tmnOQx/98VPNJCfBM8nJAWgUrUnukeqDo
         pBWfKc9r4T2X07V0Qfzn4uEtJ4OegQoArafs8sxdevbWwf7YkLvjGrD0xiAiyes8UFd6
         qUin8i7MvMRDpn3Zm+IZ/PDyIrF2PRn+/z51Y7sWlpU2g8BUvokFZfANFE0Rsp7flexr
         TEqp+qB7465U865xZ4J3+h02luW2jcSOt3FmJNpxHzoyTwXxZApSIRm5/z8jahIhA/UM
         CM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dlx0CqItQics7St/oV4lvN7qJDbYdu9uNdZTZdVoHOk=;
        b=KmOciT3aY20p6Wk7U535htW6NODjXHfMciLsrgwPngjalbRo5KiMEnMNZT5j5ILSAN
         v1JWcOp2PDSbhZ2SK+O859FDDLzWMStdYr4eyvRYilNAEXxCxPR5JiU0Uq9pk95IwrpB
         17J6SpPBzpAKn7MZwP5X4cBvN7/eGKC/Xo0q4GyyUxnz7GAIMOGCdP1UpFElx3PMn01f
         oDDetUOm3zSKfKzHeUm+oOl+A8VBmXW7xaOR8vMh26dekb3Vvb1cpEB623Um2qKzC+rd
         Z8K2YfecvWsjypUUh0Ww9WAHT9hT23Ug26pn8TVT5WwZp3XE5Zto1aNmCh1inSWCF9Hb
         jhRg==
X-Gm-Message-State: APjAAAUZAVCwhJjxQQ5SskxVlMWi3rqePQwnwDX+9blRdCczlzuf7d7l
        FqSIgOBvM7enbDB2NUCvAMsbxOQLozS2BxY4Y8ozMQ==
X-Google-Smtp-Source: APXvYqz4NApML+BKDCmVDMJIqVrJ6jiOy5rErByrns3hz0geLQ7JxSAWzRHfjKvkgBE/CgJXDjxvFUc3vrt7lGiQPlI=
X-Received: by 2002:a19:ca07:: with SMTP id a7mr10680316lfg.103.1580688727193;
 Sun, 02 Feb 2020 16:12:07 -0800 (PST)
MIME-Version: 1.0
References: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
In-Reply-To: <CACbxD0AG_eX4kH3SyY7FWZLcd4FymuOQ6Kii0czHFJ8SPyEdcw@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 2 Feb 2020 21:11:56 -0300
Message-ID: <CAHd-oW5DSOUQXN-d8CEhRL4RS=s_WAzXEF_fSVvh9JdRZCEX6w@mail.gmail.com>
Subject: Re: Need help to start contributing
To:     Manav Agarwal <dpsman13016@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Manav. Welcome!

On Sun, Feb 2, 2020 at 9:27 AM Manav Agarwal <dpsman13016@gmail.com> wrote:
>
> Hey there! I am a shell script and Linux kernel programmer and looking
> forward to making contributions to Git. May you please help me out
> with some getting started links. I would be very thankful to you if
> you could help me out with that.

You might want to start with the MyFirstContribution[1] and
SubmittingPatches[2] doc files (they are also available at the
'Documentation/' dir of the Git repository).

Also, I wrote a "first steps" guide, which is available at [3]. I hope
you may find it helpful :)

[1]: https://git-scm.com/docs/MyFirstContribution
[2]: https://git-scm.com/docs/SubmittingPatches
[3]: https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
