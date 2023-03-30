Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C7AC6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 05:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjC3FvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC3FvM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 01:51:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18BC359B
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 22:51:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so72109168edc.3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 22:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680155469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yfc29W9h1bTLTZ2Mo/kT+jvrKzQW7s7Knfyz+uludao=;
        b=lPwx5yFwyaXtpvFCprPr4p6T6/JRt5pkAXHj1lcmJEWi+cx/NZnihnC9knrKSd9A5S
         vRuMnxR3RJMrXEYdW9OPNNW7bjpsRdU4qGM8nn/WVnhWCgVs8wM7PfjrzRKignZIqwWY
         Xhc0xMCRp7DVr+ly86oQiOFvfo+FiAY1J6TyPoAx5nvlwVL5nRxFibQYSDBV7kuEG9A0
         7VdKtOgm7eyrPRR5TtuXBEBpiMmAc4CsD2MfppS4Owrk3KguGzaktbzIHhMuOX06Mk7m
         SQoOKKMTzgoqEgVi22jyHpHnBon4HJUDkag6nVT//G2w8Xl3KuUTIHsgCzJMGKUaGSi7
         z27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680155469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yfc29W9h1bTLTZ2Mo/kT+jvrKzQW7s7Knfyz+uludao=;
        b=FHmUSaY8zCF0PXqVErta+bR3GSpf1rDfCeW7G34INt1a4i+gz6/HQwk5gsCna2kCA2
         naYUEZWNog+MsqxraPwNXOcgReIUoOKRFKiRpktsaE3Z226PLZKDK4owgUr/gb7RF9A6
         +mEgDruj2zQEOku+J0Emi251gMDJqID0TDXTTtWcYFk/sN0rMuaLSqn4wadlbzATdJfO
         xWG+Z/NrA3SYBH4Li2IjEiRUW0bzYJTAPbMgUmG3erf7yfTjtoOnV1gfy4vlM6SAjVvg
         f/mNb4midz9xJKZJKzNJLtr//vN11nqNxtfW7f3GmjaRQOrdJLJ5rWgJd6KSSBVLL/49
         8I0w==
X-Gm-Message-State: AAQBX9fOSouQ4qgxRaktYUeRxYCmWAav5xePTG7jrHBLqFFvEBdOBmpL
        96MKHCgAxnpq34jcwYIaqaMbaQsf/d+MUqWgB9ufLd5UV00=
X-Google-Smtp-Source: AKy350ZqbuO7gIfNyb0x+lvr0By/mgupqUVRtN0Pq2k3FAZVVMBGU+NzG0HlUXMnX9Cn17T/m65Dq1FVLLwvYnQgzXE=
X-Received: by 2002:a17:906:3118:b0:92f:fc27:8ea0 with SMTP id
 24-20020a170906311800b0092ffc278ea0mr10778975ejx.9.1680155468875; Wed, 29 Mar
 2023 22:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com> <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
In-Reply-To: <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Thu, 30 Mar 2023 06:50:30 +0100
Message-ID: <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Johannes Sixt [ ]" <j6t@kdbg.org>,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Mar 2023 at 13:14, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> And the reason is...
>
> > @@ -195,6 +197,15 @@ static void get_credential(void)
> >                       write_item("password",
> >                               (LPCWSTR)creds[i]->CredentialBlob,
> >                               creds[i]->CredentialBlobSize / sizeof(WCHAR));
> > +                     attr = creds[i]->Attributes;
> > +                     for (int j = 0; j < creds[i]->AttributeCount; j++) {
> > +                             if (wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
>
>                                   ^^^^^^
>
> ... here. Note how the return value of `wcscmp()` needs to be non-zero to
> enter the conditional block? But `wcscmp()` returns 0 if there are no
> differences between the two provided strings.
>
> That's not the only bug, though. While the loop iterates over all of the
> attributes, the `attr` variable is unchanged, and always points to the
> first attribute. You have to access it as `creds[i]->Attributes[j]`,
> though, see e.g.
> https://github.com/sandboxie-plus/Sandboxie/blob/f2a357f9222b81e7bdc994e5d9824790a1b5d826/Sandboxie/core/dll/cred.c#L324
>
> So with this patch on top of your patch, it works for me:
>

Thanks Johannes for the review and the fix. I'll include it in any patch v2.

>
> But I have to wonder: why even bother with `git-wincred`? This credential
> helper is so ridiculously limited in its capabilities, it does not even
> support any host that is remotely close to safe (no 2FA, no OAuth, just
> passwords). So I would be just as happy if I weren't asked to spend my
> time to review changes to a credential helper I'd much rather see retired
> than actively worked on.

git-credential-wincred has the same capabilities as popular helpers
git-credential-cache, git-credential-store, git-credential-osxkeychain
and git-credential-libsecret. Any of which can store OAuth credentials
generated by a helper such as git-credential-oauth [1]. This is
compatible with 2FA (any 2FA happens in browser). Example config:

    [credential]
        helper = wincred
        helper = oauth

This patch to store password_expiry_utc is necessary to avoid Git
trying to use OAuth credentials beyond expiry. See
https://github.com/git/git/commit/d208bfdfef97a1e8fb746763b5057e0ad91e283b
for background (I'll add to commit message v2).

What about Git Credential Manager? GCM has a similar need to store
password expiry, see comment
https://github.com/git-ecosystem/git-credential-manager/discussions/1169#discussioncomment-5472096.

I think OAuth is important enough to fix this issue in both
git-credential-wincred and GCM. Some users might prefer the above
setup over GCM to avoid .NET dependency or if they really like
git-credential-oauth.

Note that OAuth expiry issues don't occur authenticating to GitHub
because GitHub doesn't populate OAuth expiry.

[1] https://github.com/hickford/git-credential-oauth
