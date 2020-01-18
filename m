Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54CBC33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828132468C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rga/fbEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgARPdU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 10:33:20 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41613 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgARPdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 10:33:20 -0500
Received: by mail-ua1-f65.google.com with SMTP id f7so10022014uaa.8
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1V3LePD/f6pu69xRMa1ifqdUZMoPP7Hy1RIZw0bZcU=;
        b=rga/fbEtFkfovEZcoV7WXAZVBJAZszwxs5Bd8sCbE4neGegxapS3K/M+xpsUmQcPEz
         T1+bDJRfHEVMeblU8YZHQz0w27GiuXIDbZbz4U4+MWs4iLxkbYFByaWg7TqDzKRfwmAA
         7DDECGU+0Vfs4OEpBCxYTbz1D+FEqBVhIKmzrptrZDG7JQ4hS/0wgdUV0whkIZLbFvHF
         a+8W5/YvDo8GtfW45jko139b04irMZNv4f8VJOQ69pZzS1ae8iOIRZcVMIrY+smoJqk/
         zomW01cboHzB94VUodVd7X0UNvZbbJth8AYHgH/xyL+WJejik9FKrZjTiamvXCQTxhYY
         CHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1V3LePD/f6pu69xRMa1ifqdUZMoPP7Hy1RIZw0bZcU=;
        b=jRlZb8kl1Zz8mEVczRvS3l21oEvhIJkvXPAQnu2n34dQ8GWkbnkM6a1DuZQJoz7cgF
         NKB0LalU/0r9eoetrEEh/E7rjBc0R38HdNWkfmxIVgmxEcxQPPoDndbq0fdeg2Q/D/NM
         NSe98kMOcFI6j1uHF+GU8ER/GpxznEPMKmuGGwfwp2Is178IWsqMDKUs8YjfCeaOSLTH
         1EMXXyemndduEt86nP5wHAzsBzB0DRVMi+tsxOeH3lEuaqDG3aQTtWgWmJnkcXfTOsuE
         678Ptrc7iQAnXmwoDQUyzJKfflHZAlY7k+5Rj/c2h9ajvo439SsBGNp6leX987MnWFot
         hshQ==
X-Gm-Message-State: APjAAAWwgQBDx56c8CAAUPXho37hcEvftD7V7ido4fZUA1cJxfdpFmPa
        fM/v11CiHMdZqPm4Z5qtQpkeCiL7djSoh7y74EQ=
X-Google-Smtp-Source: APXvYqwH6+EO0Xo0ncrrEVz9qSLDAN6uhu5UJcTFw9BA38TXJpifp51JB3DVIJjkxongS9187ZqOrsSg4NPYnLzqB8c=
X-Received: by 2002:ab0:2150:: with SMTP id t16mr23665761ual.61.1579361599530;
 Sat, 18 Jan 2020 07:33:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v2.git.1578565001.gitgitgadget@gmail.com>
 <pull.478.v3.git.1579275102.gitgitgadget@gmail.com> <97b8a7641d1ae76b9b4766a8f96c77af1aff55f5.1579275102.git.gitgitgadget@gmail.com>
 <xmqqwo9pdchx.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo9pdchx.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Sat, 18 Jan 2020 10:33:06 -0500
Message-ID: <CAOjrSZvm3yNH+moCJUdmJ7S2snD8MdULuBimWrvF8vNU0PVqLg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] config: clarify meaning of command line scoping
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> we have such a scope for one-shot settings and these three
> sources are already treated as the same class.
>

So this isn't technically correct, as before the final patch of this series we
technically don't set the current_parsing_scope for those options.  This
doesn't actually affect anything though, because before then nothing actually
checks the current_parsing_scope during such calls to git config.  As such,
it makes sense to me to keep that part of the commit message.

> > This patch introduces
> > CONFIG_SCOPE_COMMAND to reflect this new idea, which also makes
> > CONFIG_SCOPE_CMDLINE redundant.
>
> The change in this commit is to rename CMDLINE to COMMAND.  That is
> what the proposed log message for this step must justify.
>
>         We internally use CONFIG_SCOPE_CMDLINE for the scope for the
>         configuration variables that come from "git -c VAR=VAL",
>         "git config --file=FILE" and "git config --blob=BLOB".  As
>         we are going to expose the scope names to end-users in the
>         next step, let's rethink the half-cryptic "cmdline" and
>         instead use a proper word "command" (the settings from three
>         sources in this scope are all in effect only during a single
>         invocation of a git command).
>
> or something like that.

I like this explanation much better so I'll roll that into the commit message.
>
>
> > --- a/t/helper/test-config.c
> > +++ b/t/helper/test-config.c
> > @@ -48,8 +48,8 @@ static const char *scope_name(enum config_scope scope)
> >               return "repo";
> >       case CONFIG_SCOPE_WORKTREE:
> >               return "worktree";
> > -     case CONFIG_SCOPE_CMDLINE:
> > -             return "cmdline";
> > +     case CONFIG_SCOPE_COMMAND:
> > +             return "command";
>
> The only externally observable effect of this patch is this output
> string from test-tool and we are not breaking end-user experience,
> but I am not sure if this churn is worth it.  I dunno.
>
> In any case, the change to t1308 we saw in the previous step belongs
> to this step, I think.

Yeah, this was my bad...



-- 
Matthew Rogers
