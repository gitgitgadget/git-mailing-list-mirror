Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53BDC2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864252082F
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7afHAbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMOzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:55:00 -0500
Received: from mail-vs1-f51.google.com ([209.85.217.51]:44901 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMOzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 09:55:00 -0500
Received: by mail-vs1-f51.google.com with SMTP id p6so3733653vsj.11
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5xe7rERR9CTqBJiGKvioVWWbiCGkB+YuQC+3PdjGno=;
        b=P7afHAbVk6eHYtdJ4o4w41IK4RnkCBr26d9DQDhbNLU9F8Chtq0q6FWAq4vxYEnrR1
         1uiiu8I3E2oaQQe5swdDvRsxLBeQ0wlo3EUF1c1fRS/0f3Kn3P1j0X60xcHJ/3GtevVv
         uos2eQm1JrqzgNdJPgcLUC5US0hQy3aEbGkICbYdgR09RSA0yxgGo444TH4VbdRJk9ZU
         j7JsTOrivprmFuT7J33VmJuUinV0yKJ6tr/AbiSA0nPRx3XCL4eo+vQM7kYTFfwH5tLx
         IgDUnS26q411D68Ef9nw2myBwD2/rvNeNkQpBBZwEABMTiSuablOph9v0+SqpRej262M
         DjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5xe7rERR9CTqBJiGKvioVWWbiCGkB+YuQC+3PdjGno=;
        b=lT97QZpSTGARi7QDBhYTZZ7VhDNQ86jFNGNrRbX1whA+dHvsKfcJMF9lcSn6ZvpTcV
         sZe6gUM/5Pp4hQTOdpQ3IV9fh9u60lir4gVd7LUGYu5VjkXp8yjhECm22EJoL1uZER19
         RELGj3gdbgekme7Zs1+Fn91RFbC77qBxqQ8liCPbsHt4CJYFWBkjlPN8zJbHGjIBnq4k
         AHvfi9laaD4HaseugbOYiIKAfjiySi27N7PFw8ORzno8pMR9nTdTCORVEzWQXAaD8hYK
         t+GS4ucZPdHx6YI3NLbEg/YJNSRDMW+3+lOafFBrh9VcAUH3cPyt2uqy0QueE/HJWt0/
         ceoQ==
X-Gm-Message-State: APjAAAVewX5MzfM1vwlKrNzStzts2H6LZ7WAm638hvE708EfBHsReTeQ
        Pj2B4yXAwvrcpuxnWFQbXntiXXD6wkRaZBpkCAdCnQ==
X-Google-Smtp-Source: APXvYqzHwxTAxqphG5aIzS2yUJvj25Shw8zCH2l1XjpnjKeaM1uBWoUFWlH+46lyLHr5pfv5L/6o3R1SJ24Da98Dngk=
X-Received: by 2002:a67:15c7:: with SMTP id 190mr2220489vsv.178.1581605699301;
 Thu, 13 Feb 2020 06:54:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJFfRmt65DV5bZa5yTvg9sDb8SS8dFFyX7Zm23T7mAHL58v1Lw@mail.gmail.com>
 <014f01d5e27c$5f5166d0$1df43470$@nexbridge.com>
In-Reply-To: <014f01d5e27c$5f5166d0$1df43470$@nexbridge.com>
From:   =?UTF-8?Q?Martin_Vejn=C3=A1r?= <vejnar.martin@gmail.com>
Date:   Thu, 13 Feb 2020 15:54:48 +0100
Message-ID: <CAJFfRmt3w60Yq+HS9oVmGtfPMzLeKzFSnkwS7v4_xe+eEWSxzw@mail.gmail.com>
Subject: Re: Calculating major.minor.patch from commit hash
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 3:46 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> You should consider using annotated tags and the git describe command to derive your release number. [...]

I'd like to avoid tags in this case, because a new tag/deletion of a
tag could change the hash->version mapping and I'd like that to be
stable.
