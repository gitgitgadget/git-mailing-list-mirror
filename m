Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F0C77B61
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 06:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjC3GE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3GEy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 02:04:54 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A11BD6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 23:04:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so72185201edb.6
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 23:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680156291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z5q+Zxx/ohoVitoPxin5+0yllVDyAkMnWiOJULJgIfg=;
        b=gZRvmGlpipk+TNXdwJBorZl3Ro3MwAXAMDYe9akn/4E77XBJcjEDe0saDS4NIzjNPz
         FSIMVDOx579uN6z6WyPO2iqjanIu0OcuV379zQcdaUX+Veohgusk8OaFG4FkT5fqGqno
         LAH3zHMfk+WlIWi7WtnhxMP836gXDV8mWHaC/c8RC8C2BhmAgAqXP3f1mtJtDV487lbz
         ULRXie0ea4p/vmcKhNfz6AKGtnwzWA/ggtSa5DYvNBn4/4ak67JgTXr7QMGUnXgC/+e7
         R9Jz3yailUzcBCIerYRSZaVNHUCy+mhi6eFq1ejBcJKKOnBKUZ9B7A1eGj6eW7wxOYyf
         6MXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z5q+Zxx/ohoVitoPxin5+0yllVDyAkMnWiOJULJgIfg=;
        b=pGx9prvXi+OXHp6eNaJN+OG30MnhdA4jFBzraq5UrGEdeV9zmcz6o7UJFBWOYi3nAE
         K30ydfWazYjjDrn1sB+FZ+GvQFsXvEGRFWIImocKvn5DL+8QQpC7LXpXoMwqmiN+ZmzL
         hiPZrD9WRWYXKgZkjPmIXVdE9MUiVdfWpmMMzbg4XFdTt5RcYvHRUDeY35eIbIdbtXzt
         4FYrZFHQZZkU7G2SkR4D0bA+iLeY6LXEP3XpW1jWHoZxHVN6ar91I9zJ/kX3uvLGX7ST
         yoo/WhoZTMji+3jtytzPNbgLotbuTOPQK+Y9z9lH0lHH/HLcOkin8Tw4I93h31KFC97u
         rUDQ==
X-Gm-Message-State: AAQBX9fWX63h6J3rXfzBOgJ51RnnMxpEpFZJwPaJxJV6LWDlpkYKbH2X
        AF+vGSzzVqGTyER5dRSc8lJVWYXeIvwy4YGaA54=
X-Google-Smtp-Source: AKy350bGk/naV02rTHcNYX1SZkrBnYj4GHlWwEcRWiHfAfHCHubWY11+9ozMrlTADn0anFYG8hFJOMZrJ2CK7qiAo5k=
X-Received: by 2002:a17:907:6092:b0:930:310:abc9 with SMTP id
 ht18-20020a170907609200b009300310abc9mr12143536ejc.9.1680156291384; Wed, 29
 Mar 2023 23:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1496.git.1679707396407.gitgitgadget@gmail.com> <8511e030-8167-715c-5ed4-1646e6e9ef85@gmx.de>
In-Reply-To: <8511e030-8167-715c-5ed4-1646e6e9ef85@gmx.de>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Thu, 30 Mar 2023 07:04:13 +0100
Message-ID: <CAGJzqsmd9XAP3wyqTJ2yJt6hTx9LxB0e6qd6YWRt=k_PLuA9Kg@mail.gmail.com>
Subject: Re: [PATCH] credential/wincred: include wincred.h
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Harshil Jani <harshiljani2002@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 28 Mar 2023 at 13:15, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi M,
>
> On Sat, 25 Mar 2023, M Hickford via GitGitGadget wrote:
>
> > From: M Hickford <mirth.hickford@gmail.com>
> >
> > Delete redundant definitions. Mingw-w64 has wincred.h since 2007 [1].
> >
> > [1] https://github.com/mingw-w64/mingw-w64/blob/9d937a7f4f766f903c9433044f77bfa97a0bc1d8/mingw-w64-headers/include/wincred.h
>
> Sounds good, and the diffstat is nice. But not as nice as it would look if
> we retired the `wincred` helper. As I pointed out in
> https://lore.kernel.org/git/35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de/,
> I'd much rather spend my time on other things than reviewing patches to a
> credential helper I consider unsafe.

Thanks Johannes for your reply. What do you mean by "unsafe"? Not
useful in the modern world of 2FA? Doch! You can use
git-credential-wincred to store OAuth credentials [1].

For storage, both git-credential-wincred and Git Credential Manager
use the same wincred.h CredWrite API [2]. This is surely preferable
to plaintext git-credential-store [3].

[1] https://lore.kernel.org/git/CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com/T/#md6a0bbf7a36801652c16afe6f5c9dbd19914b2a7
[2] https://github.com/git-ecosystem/git-credential-manager/blob/main/src/shared/Core/Interop/Windows/WindowsCredentialManager.cs
[3] https://lore.kernel.org/git/CAGJzqskRYN49SeS8kSEN5-vbB_Jt1QvAV9QhS6zNuKh0u8wxPQ@mail.gmail.com/


>
> Ciao,
> Johannes
>
> >
> > Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> > ---
> >     credential/wincred: include wincred.h
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1496%2Fhickford%2Fwincred-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1496/hickford/wincred-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1496
> >
> >  .../wincred/git-credential-wincred.c          | 61 +------------------
> >  1 file changed, 1 insertion(+), 60 deletions(-)
> >
> > diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> > index ead6e267c78..6e5a91a7168 100644
> > --- a/contrib/credential/wincred/git-credential-wincred.c
> > +++ b/contrib/credential/wincred/git-credential-wincred.c
> > @@ -6,6 +6,7 @@
> >  #include <stdio.h>
> >  #include <io.h>
> >  #include <fcntl.h>
> > +#include <wincred.h>
> >
> >  /* common helpers */
> >
> > @@ -33,64 +34,6 @@ static void *xmalloc(size_t size)
> >       return ret;
> >  }
> >
> > -/* MinGW doesn't have wincred.h, so we need to define stuff */
> > -
> > -typedef struct _CREDENTIAL_ATTRIBUTEW {
> > -     LPWSTR Keyword;
> > -     DWORD  Flags;
> > -     DWORD  ValueSize;
> > -     LPBYTE Value;
> > -} CREDENTIAL_ATTRIBUTEW, *PCREDENTIAL_ATTRIBUTEW;
> > -
> > -typedef struct _CREDENTIALW {
> > -     DWORD                  Flags;
> > -     DWORD                  Type;
> > -     LPWSTR                 TargetName;
> > -     LPWSTR                 Comment;
> > -     FILETIME               LastWritten;
> > -     DWORD                  CredentialBlobSize;
> > -     LPBYTE                 CredentialBlob;
> > -     DWORD                  Persist;
> > -     DWORD                  AttributeCount;
> > -     PCREDENTIAL_ATTRIBUTEW Attributes;
> > -     LPWSTR                 TargetAlias;
> > -     LPWSTR                 UserName;
> > -} CREDENTIALW, *PCREDENTIALW;
> > -
> > -#define CRED_TYPE_GENERIC 1
> > -#define CRED_PERSIST_LOCAL_MACHINE 2
> > -#define CRED_MAX_ATTRIBUTES 64
> > -
> > -typedef BOOL (WINAPI *CredWriteWT)(PCREDENTIALW, DWORD);
> > -typedef BOOL (WINAPI *CredEnumerateWT)(LPCWSTR, DWORD, DWORD *,
> > -    PCREDENTIALW **);
> > -typedef VOID (WINAPI *CredFreeT)(PVOID);
> > -typedef BOOL (WINAPI *CredDeleteWT)(LPCWSTR, DWORD, DWORD);
> > -
> > -static HMODULE advapi;
> > -static CredWriteWT CredWriteW;
> > -static CredEnumerateWT CredEnumerateW;
> > -static CredFreeT CredFree;
> > -static CredDeleteWT CredDeleteW;
> > -
> > -static void load_cred_funcs(void)
> > -{
> > -     /* load DLLs */
> > -     advapi = LoadLibraryExA("advapi32.dll", NULL,
> > -                             LOAD_LIBRARY_SEARCH_SYSTEM32);
> > -     if (!advapi)
> > -             die("failed to load advapi32.dll");
> > -
> > -     /* get function pointers */
> > -     CredWriteW = (CredWriteWT)GetProcAddress(advapi, "CredWriteW");
> > -     CredEnumerateW = (CredEnumerateWT)GetProcAddress(advapi,
> > -         "CredEnumerateW");
> > -     CredFree = (CredFreeT)GetProcAddress(advapi, "CredFree");
> > -     CredDeleteW = (CredDeleteWT)GetProcAddress(advapi, "CredDeleteW");
> > -     if (!CredWriteW || !CredEnumerateW || !CredFree || !CredDeleteW)
> > -             die("failed to load functions");
> > -}
> > -
> >  static WCHAR *wusername, *password, *protocol, *host, *path, target[1024];
> >
> >  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
> > @@ -300,8 +243,6 @@ int main(int argc, char *argv[])
> >
> >       read_credential();
> >
> > -     load_cred_funcs();
> > -
> >       if (!protocol || !(host || path))
> >               return 0;
> >
> >
> > base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
> > --
> > gitgitgadget
> >
