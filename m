Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D09AC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD21206DA
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6lKeoXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLTW6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:58:35 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41842 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTW6f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:58:35 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so3827146uaa.8
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 14:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AyQz2rd8PLcd4PZv4OG6N9vmSFDMm48GmQOpA822kjI=;
        b=B6lKeoXtPxrLo+wTQsrgPAh/bfn55D7Vh1lXG26xoIYAQ0kw39A0dLAbrUocBZOYcQ
         pNFRXi5/LDjgCmvyOkrapNgxAYEI2ljTaVvKKeGBUePb6h7Fcno0X8tX8u4OgBkappQc
         6oRq55uE8S5T8KDXTCejh8Id8wzqvKp+1LIDhJ94kbUvizIcNmQkaQsuFQjWEcEe2ney
         3gHClOlQUb4kSkNwFooJLxEjEfzCuApHRdvqddrzRmf9z7oaN6bbrKgiJBZXuNCMiv4E
         KUNw2bzKnopHzsD2mBZ5Xln1tM5AfVPbfADsZo63eEhRPebM+dxAYM+4rJLxQDH3nsXX
         QABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AyQz2rd8PLcd4PZv4OG6N9vmSFDMm48GmQOpA822kjI=;
        b=FRlr3tYS3GgqoM/hnyRS7/YyELiLzePoPAhQ0i8T6ZQpIsSVQgqE/CRv6uWcsbLv/r
         +ttzMVclTWkLgKM4AGBgCUIKoi9D7zpvH85CCr6n6cawjHaZ2I5SioqD4Sqy8TYQCXq8
         y7wIwKJlrguGV9FTnIAWjXmHyeXMALcVRV8WAxZRLvGXKi+3Yr+Z9kr9czucFxZzJ+1d
         8p4jp66wsB9VWWVPUhAFm8DTs4r1BbxZqoBBz/w8ILc5KvRKCTYj0ZWs81BUVcmgLFzx
         yMH1dJazvXG+idhQ/qeIhinWMN0df6jKoC8JC1sJdHpqb2+HMDiF24orSO5dtzoRvmgF
         PjoA==
X-Gm-Message-State: APjAAAWnK9jFvdHJEV3qU7eHkwNvW6rX7BfVY1b4euz2cikXye8KyFPJ
        GsRQJrEy3rH7E4JPihz6JRRZoORTV5oBqlar3Ic=
X-Google-Smtp-Source: APXvYqxC7R23PFrpS6rdflFSIpowmxX/ZeXvvJAjkwdwpAMRDfydjAjqIZ//OuoAkrhqZlUgcfPo5O0/ltDjuBIdtoM=
X-Received: by 2002:a9f:2e03:: with SMTP id t3mr10713146uaj.119.1576882714365;
 Fri, 20 Dec 2019 14:58:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
 <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
 <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email> <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
 <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 20 Dec 2019 17:58:22 -0500
Message-ID: <CAOjrSZsiW-vxHKBqbEuBS6rpQ7m22wRp0UwGVVAJE2WE3bh-XQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip,

>The commit message doesn't fully highlight that the config list will
>often be all the users config values, so each value will be
>disambiguated/identified as to it's origin.

I don't really understand what you mean by "it's origin" here.  When
you say origin, do you mean in the "--show-origin" sense of "file/blob/etc."
or something else? Because scope is kind of an orthogonal concept to origin
in that sense as you can have files with different origins but the same scope.

Thanks,
Matt


On Thu, Dec 19, 2019 at 12:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> <mattr94@gmail.com> writes:
>
> >>These are correct changes, but is unrelated noise in the context of
> >>the theme of the patch, no?
> >
> > I think that's the case, would the recommended course of action be to
> > move these changes into its own commit?
> >
>
> Yup, and it generally is a good idea to make such a clean-up patch
> either early in the series, or as a standalone patch (with a note
> under three-dash lines that another topic is coming on top of the
> cleanup), because it would be much less likely to introduce new bugs
> and can be merged quicly to 'next' and then to 'master' to serve as
> a base to build your other changes on top.
>


-- 
Matthew Rogers
