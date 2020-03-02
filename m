Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB14C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 14:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64122173E
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 14:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACXuIl4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCBOKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:10:31 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:42387 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgCBOKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 09:10:31 -0500
Received: by mail-io1-f49.google.com with SMTP id q128so3557274iof.9
        for <git@vger.kernel.org>; Mon, 02 Mar 2020 06:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to;
        bh=n0Gt4n0MuhJX1P+P742cuMoBZM/5ufXHLiyuKcPeU0Y=;
        b=ACXuIl4VwfY9iO9wJ+OvSoj3Go5UU/nqQEh/ZnN/lACmCzUFoqqB51XmaShbS0XfbT
         nqYB+Cf0674t2rEkrSYvlfMyGoxwKh+rn6nT1sFozoW9jHYdiAXgu/LM+ZGQbccor5Ll
         iM8vylYDN1rFEhHm98dG1xKKOYPjHD9fZTjmtR7qO7KgiqQi0QqZwiIXWBE4YyfH5sys
         PElUGbxBe9kIVjeAgCShaMH+bod7jx4ubflXU0Exj3mPHPnHPzRgqqxI8W0lW9kEQOJC
         tIGggx7PxCUTi42yNcWsS95ZxK8JCpBVADt/vho3D8BPTvo1yJ1FRiWNpNl09HcKG1ki
         uFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to;
        bh=n0Gt4n0MuhJX1P+P742cuMoBZM/5ufXHLiyuKcPeU0Y=;
        b=iSXjPsiRBrwsNWegFbr6wASKYJTjN787ietmObvN74fIw+keVmYBzoWXSEtvJ8kdwC
         6IADLDi2Z+oFty/Gr/hTAnw+u7HmRDhwVzOG7LNHzlT5rmuFQ1f1oiKINQVPfsFEDQFo
         7rSXMqjiMvSYRZRFbZtvmWucNUKb9NyU3VPQhNtJjOLiI3SyTwR1v0FfQp27Cij4oCI+
         Bd+7AANzrGG9gvuBnayOyt+N3e/KvUgYFPq74WyKC6HV6FI35DzUam3aVacIqgMS6Y9M
         reuluNQqL1h7b/XSjlbNWh13pc63KFqxByPrv5Q4QE+alAgDGkLEDtJJxjnY30wj0g2e
         S5cg==
X-Gm-Message-State: ANhLgQ0mRrPUAJBkYVX3JaX5h5fHBI26gngSZPqPdG/NCaASvkDoXt0O
        BzbIcseei9YMxBHqsJPK/f6C9VKiZHo2wpVjjNT1sRWc
X-Google-Smtp-Source: ADFU+vvz+j871I+2+LM1YOHQ/4GaSydytQAqHJpYOEGgTRLEineSNrOAYYRhgy5DfG5Dj6YUGNFIAj7ya620Fln8Kn4=
X-Received: by 2002:a5e:cb0a:: with SMTP id p10mr2442864iom.166.1583158229313;
 Mon, 02 Mar 2020 06:10:29 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
In-Reply-To: <CAH8yC8n+ta4BSAE4rEfhKxe3T9poVdc94HvSk=6PEA4YbmwVyA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 2 Mar 2020 09:09:42 -0500
Message-ID: <CAH8yC8km9k3sWKpjuj=69Y8SC=VHcDkBk=8O9RuCDOGtWGyqQQ@mail.gmail.com>
Subject: Re: Commit signing and pinentry problems
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 7:41 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> I'm having an annoying problem that I can't figure out. I hope Git has
> a setting to fix it.
>
> I have a desktop workstation where I sit at the keyboard about 1/3 of
> the time. Git signing works as expected. About 2/3 of the time I SSH
> into the machine. Git signing does not work when SSH'd in.
>
> When Git signing fails over SSH an error looks like:
>
>    $ git commit -S log.h -m "Remove unneeded header"
>    error: gpg failed to sign the data
>    fatal: failed to write commit object
>
> I just noticed this today (but it makes sense)...
>
>     - Go to desktop workstation, log in
>     - Go to remote machine, log in
>     - Sign at remote machine over SSH
>       - Desktop workstation will open GUI password prompt
>       - Remote machine sign operation will hang until GUI prompt times-out
>
> The problem was reported to Ubuntu but no activity:
> https://bugs.launchpad.net/ubuntu/+source/pinentry/+bug/1852696 .
>
> Does anyone know how to use Git to work around pinentry brain-dead-ness?

This fellow's answer fixed this problem: https://stackoverflow.com/a/53641081

Jeff
