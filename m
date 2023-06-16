Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAFFEB64DA
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 22:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFPWan (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 18:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjFPWam (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 18:30:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F12D72
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:30:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-982a88ca610so162342466b.2
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686954639; x=1689546639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I+pioIDa9TEEMBfJ0HGyhhGuqZJSnPw9ogHN3vjFFG8=;
        b=rh9KGF3wvOOwe3s7HlLqGGuxLigvpwWMRjjo64DCCYUsffmsBpCa4VLW+ohMCgvE+B
         GRNOvVS5tNzgeBRV4YF7I8ukJv8MFtuDylyshqi88rePdh3feFCxXEQcGWp7RXfu4qLw
         9IiMmD9y/IXaNw9MCQcjn85OdfqFvsIbIYtyZzwH2DNY/NOOOBOHpg14yRprI4AzjRJp
         9/qng/gFvkgtLbxbdHjEZz4/HwDj7gQtmyf8f6L1ivTHEv8avkMNRDfZc5GnEG433nU1
         EN3JcbgnZuE7iy5lotw0/XhPcb1y87zCzd5A2IkLSWbXrVBor6uj94Pw833gX+XLMrjL
         kA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686954639; x=1689546639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+pioIDa9TEEMBfJ0HGyhhGuqZJSnPw9ogHN3vjFFG8=;
        b=k2dBMxglsBPu6zdUDk3Y/jm/MoPgGjQfCiQCMUC7jroRjXTawCYHkl/vZGcDbI/5AS
         RNCvCeC+G7GgvMGllaAH1OUUg+VJdGJfPAjHVAuqdIYBOlTqu1qjaz7YDfJO8VBTl/+1
         j6Jyxp3bm76XM8bZknpmmuaYU/Q7oWFCL+P0eC/EjAbhmEGiMybfKVgWW1kzq72CFEYw
         B5CT68xahmAwRR6hCeaXU39JLJxb/YK6mIRnGxBqrZwXv6WACeCd4920c0+BiLockz7H
         Cg6aNtInqzpbg4CQErr+Kw5C5eHpgVGp1/SNq07GI1akiNHAFKqKAv8e7UiapXxor6S/
         eUSg==
X-Gm-Message-State: AC+VfDxNJYwXtcLQ/YjbnVA78DobVO8HL2eEIfNsoWXaDCstPrCyVEYN
        FjuFqg3BybDbhS/Nmp8QXeEFOe2pjTCYW1ZvZ7g=
X-Google-Smtp-Source: ACHHUZ5Da7ibkMVEciaxCu5FxH7R3PL44zgS33Ui6OwNfdJKNqchkV0PLnpSZQ+y0PaEl7RdzOsaOPfNAIECAjrVK34=
X-Received: by 2002:a17:906:2c11:b0:974:625d:183f with SMTP id
 e17-20020a1709062c1100b00974625d183fmr2588965ejh.36.1686954638889; Fri, 16
 Jun 2023 15:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
In-Reply-To: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Fri, 16 Jun 2023 23:30:03 +0100
Message-ID: <CAGJzqs=K0_jYY-SOMjhLe_k3UzSgzEwy9mYVF=H=CA+ZUAv_uA@mail.gmail.com>
Subject: Re: [PATCH] credential/wincred: store oauth_refresh_token
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 20 May 2023 at 08:20, M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: M Hickford <mirth.hickford@gmail.com>
>
> a5c7656 (credential: new attribute oauth_refresh_token) introduced
> a new confidential credential attribute for helpers to store.
>
> We encode the new attribute in the CredentialBlob, separated by
> newline:
>
>     hunter2
>     oauth_refresh_token=xyzzy
>
> This is extensible and backwards compatible. The credential protocol
> already assumes that attribute values do not contain newlines.
>
> Alternatives considered: store oauth_refresh_token in a wincred
> attribute. This would be insecure because wincred assumes attribute
> values to be non-confidential.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     credential/wincred: store oauth_refresh_token
>
>     I'm not confident in C and found string manipulation difficult, so
>     please review carefully.
>
>     I tested on Linux, cross compiling with Zig make CC="zig cc -target
>     x86_64-windows-gnu" and tested make GIT_TEST_CREDENTIAL_HELPER=wincred
>     t0303-credential-external.sh (with a shell script git-credential-wincred
>     that wraps wine64 git-credential-wincred.exe "$@")
>
>     See also similar patch for credential-libsecret "[PATCH v4]
>     credential/libsecret: store new attributes"
>     https://lore.kernel.org/git/pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com/T/#u
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1534%2Fhickford%2Fwincred-refresh-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1534/hickford/wincred-refresh-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1534
>
>  .../wincred/git-credential-wincred.c          | 40 ++++++++++++++++---
>  t/t0303-credential-external.sh                |  1 +
>  2 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
> index 96f10613aee..dc34283b85e 100644
> --- a/contrib/credential/wincred/git-credential-wincred.c
> +++ b/contrib/credential/wincred/git-credential-wincred.c
> @@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
>  }
>
>  static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
> -       *password_expiry_utc;
> +       *password_expiry_utc, *oauth_refresh_token;
>
>  static void write_item(const char *what, LPCWSTR wbuf, int wlen)
>  {
> @@ -128,6 +128,11 @@ static void get_credential(void)
>         DWORD num_creds;
>         int i;
>         CREDENTIAL_ATTRIBUTEW *attr;
> +       WCHAR *secret;
> +       WCHAR *line;
> +       WCHAR *remaining_lines;
> +       WCHAR *part;
> +       WCHAR *remaining_parts;
>
>         if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
>                 return;
> @@ -137,9 +142,17 @@ static void get_credential(void)
>                 if (match_cred(creds[i])) {
>                         write_item("username", creds[i]->UserName,
>                                 creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
> -                       write_item("password",
> -                               (LPCWSTR)creds[i]->CredentialBlob,
> -                               creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +                       secret = xmalloc(creds[i]->CredentialBlobSize);
> +                       wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
> +                       line = wcstok_s(secret, L"\r\n", &remaining_lines);
> +                       write_item("password", line, wcslen(line));
> +                       while(line != NULL) {
> +                               part = wcstok_s(line, L"=", &remaining_parts);
> +                               if (!wcscmp(part, L"oauth_refresh_token")) {
> +                                       write_item("oauth_refresh_token", remaining_parts, wcslen(remaining_parts));
> +                               }
> +                               line = wcstok_s(NULL, L"\r\n", &remaining_lines);
> +                       }
>                         for (int j = 0; j < creds[i]->AttributeCount; j++) {
>                                 attr = creds[i]->Attributes + j;
>                                 if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
> @@ -148,6 +161,7 @@ static void get_credential(void)
>                                         break;
>                                 }
>                         }
> +                       free(secret);
>                         break;
>                 }
>
> @@ -158,16 +172,26 @@ static void store_credential(void)
>  {
>         CREDENTIALW cred;
>         CREDENTIAL_ATTRIBUTEW expiry_attr;
> +       WCHAR *secret;
> +       int wlen;
>
>         if (!wusername || !password)
>                 return;
>
> +       if (oauth_refresh_token) {
> +               wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> +               secret = xmalloc(sizeof(WCHAR) * wlen);
> +               _snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
> +       } else {
> +               secret = _wcsdup(password);
> +       }
> +
>         cred.Flags = 0;
>         cred.Type = CRED_TYPE_GENERIC;
>         cred.TargetName = target;
>         cred.Comment = L"saved by git-credential-wincred";
> -       cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
> -       cred.CredentialBlob = (LPVOID)password;
> +       cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
> +       cred.CredentialBlob = (LPVOID)_wcsdup(secret);
>         cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
>         cred.AttributeCount = 0;
>         cred.Attributes = NULL;
> @@ -182,6 +206,8 @@ static void store_credential(void)
>         cred.TargetAlias = NULL;
>         cred.UserName = wusername;
>
> +       free(secret);
> +
>         if (!CredWriteW(&cred, 0))
>                 die("CredWrite failed");
>  }
> @@ -253,6 +279,8 @@ static void read_credential(void)
>                         password = utf8_to_utf16_dup(v);
>                 else if (!strcmp(buf, "password_expiry_utc"))
>                         password_expiry_utc = utf8_to_utf16_dup(v);
> +               else if (!strcmp(buf, "oauth_refresh_token"))
> +                       oauth_refresh_token = utf8_to_utf16_dup(v);
>                 /*
>                  * Ignore other lines; we don't know what they mean, but
>                  * this future-proofs us when later versions of git do
> diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
> index f028fd14182..51886b8e259 100755
> --- a/t/t0303-credential-external.sh
> +++ b/t/t0303-credential-external.sh
> @@ -45,6 +45,7 @@ test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
>  helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
>
>  helper_test "$GIT_TEST_CREDENTIAL_HELPER"
> +helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
>
>  if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
>         say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"
>
> base-commit: 9e49351c3060e1fa6e0d2de64505b7becf157f28
> --
> gitgitgadget

Hi. Is anyone familiar enough with Windows CRT to review this patch?
