Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB47C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582002071A
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 20:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WURhxOAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgAXUtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:49:51 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37037 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387394AbgAXUtu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 15:49:50 -0500
Received: by mail-ua1-f65.google.com with SMTP id h32so1311828uah.4
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acp69mcmUbG/82rbNzaoHtKwdm3M51SducdCfECk6Qw=;
        b=WURhxOAvB1CRMAM+xEo2kJklscBTEr0nGtwr9s35e8Car99C+ugLGmZDKlNrPDl9HN
         78zzs0lqJxXc/ugj2E8vqjG6Yq4XHxsllxJiQBj2ulxPBoV8IEj3uuCwbwV/+Vj0ZKtO
         +jjH1g46RlkgcyZNPTtU1nlcUbQkJgPE0xXKnTSSTvWTghxCuq/h0liNmMr54xlpJjCn
         i1hvhET8BWs9LECFEzTszIGhLa9FGrp43qHsdlEqPsFpE2eDvnUk9kVIZGf+sJtMUd5e
         7ExzWVJ3Br+2xFuTEOj39qMfs1ai62zsAJY1jRCAyrv+7FqYh6vuR4++EDLg0T5u9fH/
         zSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acp69mcmUbG/82rbNzaoHtKwdm3M51SducdCfECk6Qw=;
        b=Of96c0Wzq75e6LE47d00IVDEVcQ6wLWSmeGFAIThIPkquHI1EzsmMcMtXkktC+HkmH
         f9WBwT5XUH+eZlvPvgjkWUzAPfrpSw8jIqu4FbPUc0jE4TahM/0cfP/NutQqbZHce80c
         cAUFTvgz2u9Da7ZC1RaSA0gVa617Xh0++zldMcCXgZpONDb2Cuh4M3aCscQWve4ipHpG
         C7FDce2yn+WzRdapjlLDsxe4NYexk9jYVWmI35/TszcG9+1LNNj2gI/6T1dfvABRRd2x
         HmohyGx/z0OtmQbfmeDNeBHXPE1A7eCnomGorInjtJgr4+s4nG3gmDwalUo3SL1qR9le
         DN5g==
X-Gm-Message-State: APjAAAU8O9za8MJ/ntR70kmWuulz9iE6T2ADbHjV/X0MzGNVo4QLcORG
        oiXa5y43nAwInnn3jjvcbIuPkPIxiktuGI07Dvs=
X-Google-Smtp-Source: APXvYqwJfdUujYeNzdQo2s6XoRn5mcIMEEFjTWXXHvQXNKIfmAxvj/E3YZiLAZTJMjPCrm6Oq6tYpydJV3/faEI+aJg=
X-Received: by 2002:ab0:4931:: with SMTP id z46mr3020866uac.119.1579898989507;
 Fri, 24 Jan 2020 12:49:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
 <pull.478.v4.git.1579825267.gitgitgadget@gmail.com> <5549db7e39bf38aa5cc42292421f4676e3073b7d.1579825267.git.gitgitgadget@gmail.com>
 <xmqqblqszjs9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqblqszjs9.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Fri, 24 Jan 2020 15:49:38 -0500
Message-ID: <CAOjrSZsTZic1daj7zG1tZbgENUxt7XGU3mTJAC4_gdiybFMt0Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] config: add '--show-scope' to print the scope of a
 config value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this was a mess-up on my end.  I had meant to rename it to
config_scope_name() (after talking with Bert) but it appears that I
had messed up, so I think my mistake wasn't to rename the function, but
to fail to rename it.  So I do apologize.

On Fri, Jan 24, 2020 at 3:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +const char *scope_to_string(enum config_scope scope)
> > +{
> > +     switch (scope) {
> > +     case CONFIG_SCOPE_SYSTEM:
> > +             return "system";
> > +     case CONFIG_SCOPE_GLOBAL:
> > +             return "global";
> > +     case CONFIG_SCOPE_LOCAL:
> > +             return "local";
> > +     case CONFIG_SCOPE_WORKTREE:
> > +             return "worktree";
> > +     case CONFIG_SCOPE_COMMAND:
> > +             return "command";
> > +     case CONFIG_SCOPE_SUBMODULE:
> > +             return "submodule";
> > +     default:
> > +             return "unknown";
> > +     }
> > +}
>
> In earlier round(s), this was called config_scope_name(), wasn't it?
>
> "scope_to_string()" is a much worse than "config_scope_name()" as a
> name of a global function (e.g. we won't know what subsystems other
> than "config" may want to use "scope").  As you remember, Bert's
> "remote rename" series wants to use a public interface like this
> function, and the series expects this function to be called
> config_scope_name().  Let's not rename a public API function
> suddenly---it disrupts other topics in flight.
>
> Thanks.



-- 
Matthew Rogers
