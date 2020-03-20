Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373D3C4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 17:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF6620739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyef4lam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCTROY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:14:24 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:43962 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTROY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 13:14:24 -0400
Received: by mail-lj1-f176.google.com with SMTP id u15so6961324lji.10
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 10:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJY180/C3LrNM0fnzoBm6ofJngAjsfeabncC+Rr7TSY=;
        b=gyef4lamHOTJuCE7N7ApqW1rFa2xXJDN/g1/FXNMYVg0UnLVJErdGyelsngSpPw/RZ
         PrSP7wUg+CCNEwIW8Yrv153M6kLDnLCU0G5NqkdYY969Zc+ILnih6JzGq5uPuciJdQ6E
         GYLdIjyvaOrXErSPvzXvOk2ZYS2QTkxF7QjcAuRmtqb3MimUk+zssfsOjexBku/86A2S
         ZkmMYCuFgeUDP7ICOhRITg2TcIVwzphOeAesTTxkTpgzGGbQAD0316s1peF9vBieGFNn
         uIXIDxqIeeUX0Vr0cvqJr8ORm3yXfjJJZLGz2GUBZ5nMA2BQetzwZeGBO7GUucgk6kBz
         aJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJY180/C3LrNM0fnzoBm6ofJngAjsfeabncC+Rr7TSY=;
        b=DmX5XJ4K/5FMoH9G2BUHImIfgqWZtCkeA7LQbFVmY6ded3xaxGZwKMarCpNTBMh7LF
         /6RwPzS/ymoMnkAswXRB3YE4lx38XogT1sz2bE/myBa421zmZme0TmxKupaT2MZGqz7Z
         mZMxzR7hKJHJ3H1DWHhYlnYjqkxKnHV2fGRsrRc7yDOLxlef32qyqAeG8ro9zW6aVVhx
         0rBC9orUMoAAZNkV4ButdGKjItrbSyAdUf7FF7BXsA87WlH08bYQw1LB/cjPrDps+gs6
         HDi6nZ7PiJsF2iSuvHkCSqRmZG0a2gyWtVdzELA4vJokwRXeKN5KqpBMOHv3oY+ff9QB
         6/Jg==
X-Gm-Message-State: ANhLgQ0czF/baofyYOxDHBM5kSR1spr5Cxo2FRflUMT15rnfHdS+joRR
        cGv5nDSJX5QgSorWRfVs4pM/VpJrM17JHgmHsISIpgDE+Ko=
X-Google-Smtp-Source: ADFU+vtz0Uo9j2u+uCAmwP4tUXSt0a610DyPNtfcTGvYU5sxspGUvbHQ/bYKQUbl3EfnHFm9zxllVzK6XThlFdjH4k8=
X-Received: by 2002:a2e:98da:: with SMTP id s26mr6249819ljj.155.1584724461970;
 Fri, 20 Mar 2020 10:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200320130845.23257-2-harshitjain1371999@gmail.com> <20200320155604.7854-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200320155604.7854-1-shouryashukla.oo@gmail.com>
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Fri, 20 Mar 2020 22:44:09 +0530
Message-ID: <CACuU+s-s2zMJq5xymyTz45AVyT0gL1sgcpk3rUcA-Bp-D+F=2g@mail.gmail.com>
Subject: Re: Re: [GSoC][Patch]
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Fri, Mar 20, 2020 at 9:26 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Hello Harshit,
>
> > The tests in t4131 leave a space character between the redirection operator
> > and the file i.e. the redirection target which does not conform to the
> > modern coding style.
>
> > Fix them.
>
> I think something like,
>
> The tests in t4131 were written a long time ago and hence contain style violations
> such as an extra space between the redirection operator(>) and the redirection target.
> Update it to match the latest CodingGuidelines.
>
> may be better.
>

Please see the comment made by Junio Hamano, pasted below:

"written a long time ago" does not have much value by itself (it
does serve as a backstory to explain a half of why it does not use
the more modern style, though).  "have a few style violations." is
almost meaningless (otherwise, you would not be doing a "modernize
style" patch in the first place ;-).

I myself also agree with the above comment and hence, wrote the commit message
accordingly. What do you think?

> Also, when you deliver a newer version of the patch, i.e., version 2 in your case,
> you have a [PATCH v2 1/n] as the subject, so that people know that it is the v2 and
> hence avoid confusion.
>
> If you are using 'git format-patch' to formulate your mails, you can do:
>
> 'git format-patch -v2 <..>' to get a v2 based mail.
>

Oh nice, didn't know about this. I will keep this in mind for future
patch submissions.
Should I do this for the current patch as well?

Regards,
Harshit Jain
