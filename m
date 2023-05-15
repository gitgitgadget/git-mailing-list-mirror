Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2FAC7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 10:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjEOKuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjEOKum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 06:50:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B29E7B
        for <git@vger.kernel.org>; Mon, 15 May 2023 03:50:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so18567495a12.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684147839; x=1686739839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBb0rPbXHMpBBq9y+ubjpdDKFn4D673ZGeflQVghVmI=;
        b=rYLvf6H8kg90b3cRQH6pZvd2B4NeFN7MMiSLTunuw1heMdxLCVeZ3BcitwEWX2TiJ+
         aG/1TITd4Rx4Je3mKTCiJiXcXaTRaOvcLhSPzpapqGuD9K3Zm9uYvIwkL5EZBKtUDVi3
         Gp/Z1RQwqXyaiKNyvLWByiGZaWri4iz1RLGPBm1ycSl9fu3sOigd7GngDnMX4q2TgEUz
         /rdzgxbxGeyGIwrxCSjmM8yLE3vSoDr4jl3Lf2LEAf0ByQlRtoHOcZneLkre80G9nzWD
         +EYfuVKlFSyO4Bd3dgVa8c4wJyCQU0SG76Pk8+7LZfT/fZ5ONHyWPTrZRez/VWuYfgWW
         CNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684147839; x=1686739839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBb0rPbXHMpBBq9y+ubjpdDKFn4D673ZGeflQVghVmI=;
        b=LYnWsTyVcgXGsV5TCAW/upxcWfdQhYh/VD893IrkXKjtFCxUDBeHQ4/TzCMI63eDdR
         Y+Av1vS+aeyFVgXZWDlKq0JGDJayBn6xtng9pXlmuvo+O2hS1mHfUk6RxFZdhUU25GiN
         1VILpAuqZORGX0g1p4VwT2XMcq+x9bABoVo0RZTpiYgyu3Kt91ztX0kmfanEA+LBwVnn
         P7HpodAGsuvi/Uh6HuE/lg7gp7jt4MlF8v/wZhFVC7nKUetiuIk0W2PZig9dsbsoU/Ym
         epowQ8I2QjJfhyK9tIrEl9S38CyesozKGqnBG0nDQsFAPhwrT41qSpjfCxZ1sKwxle29
         W1pg==
X-Gm-Message-State: AC+VfDxqCrVoNruKphmz2VhigH5zeaEtomGvaI1DchGacoLoRge71yHb
        nCglhrC9E94LyLkcWqsw+cV3m2OB4Iugu1ef5rkcsOMmu1E=
X-Google-Smtp-Source: ACHHUZ6WYH4jVMm2domKxM2zBBsHYFo5MBD4o0TtI/DsfkAOmSDYOzXKJqiAKzU6ZsMFtwNZezPe+v0YRiT1J3rqX0o=
X-Received: by 2002:a17:907:6eaa:b0:94a:9ae2:1642 with SMTP id
 sh42-20020a1709076eaa00b0094a9ae21642mr33618225ejc.46.1684147838410; Mon, 15
 May 2023 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1469.v2.git.git.1679729764851.gitgitgadget@gmail.com> <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
In-Reply-To: <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>
From:   M Hickford <mirth.hickford@gmail.com>
Date:   Mon, 15 May 2023 11:50:01 +0100
Message-ID: <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com>
Subject: Re: [PATCH v3] credential/libsecret: support password_expiry_utc
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 May 2023 at 08:05, M Hickford via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: M Hickford <mirth.hickford@gmail.com>
>
> d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
> introduced this attribute.
>
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     credential/libsecret: store password_expiry_utc
>
>     Patch v3 fixes backwards compatibility.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1469%2Fhickford%2Flibsecret-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1469/hickford/libsecret-v3
> Pull-Request: https://github.com/git/git/pull/1469
>
> Range-diff vs v2:
>
>  1:  1e27677b6f5 ! 1:  b46594c8897 credential/libsecret: support password_expiry_utc
>      @@ Metadata
>        ## Commit message ##
>           credential/libsecret: support password_expiry_utc
>
>      +    d208bfd (credential: new attribute password_expiry_utc, 2023-02-18)
>      +    introduced this attribute.
>      +
>           Signed-off-by: M Hickford <mirth.hickford@gmail.com>
>
>        ## contrib/credential/libsecret/git-credential-libsecret.c ##
>      @@ contrib/credential/libsecret/git-credential-libsecret.c: struct credential_opera
>
>       +static const SecretSchema schema = {
>       + "org.git.Password",
>      -+ SECRET_SCHEMA_NONE,
>      ++ /* Ignore schema name for backwards compatibility with previous versions */
>      ++ SECRET_SCHEMA_DONT_MATCH_NAME,
>       + {
>       +         {  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
>       +         {  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
>      @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(
>       -                                    SECRET_SCHEMA_COMPAT_NETWORK,
>       +                                    &schema,
>                                            attributes,
>      --                                    SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>      -+                                    SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK |
>      -+                                    // for backwards compatibility
>      -+                                    SECRET_SCHEMA_DONT_MATCH_NAME,
>      +                                     SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>                                            NULL,
>      -                                     &error);
>      -  g_hash_table_unref(attributes);
>       @@ contrib/credential/libsecret/git-credential-libsecret.c: static int keyring_get(struct credential *c)
>                         c->username = g_strdup(s);
>                 }
>
>
>  .../libsecret/git-credential-libsecret.c      | 39 +++++++++++++++++--
>  t/lib-credential.sh                           | 30 ++++++++++++++
>  t/t0301-credential-cache.sh                   |  2 +
>  t/t0303-credential-external.sh                |  2 +
>  4 files changed, 69 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
> index 2c5d76d789f..182f0805c2b 100644
> --- a/contrib/credential/libsecret/git-credential-libsecret.c
> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
> @@ -39,6 +39,7 @@ struct credential {
>         char *path;
>         char *username;
>         char *password;
> +       char *password_expiry_utc;
>  };
>
>  #define CREDENTIAL_INIT { 0 }
> @@ -54,6 +55,21 @@ struct credential_operation {
>
>  /* ----------------- Secret Service functions ----------------- */
>
> +static const SecretSchema schema = {
> +       "org.git.Password",
> +       /* Ignore schema name for backwards compatibility with previous versions */
> +       SECRET_SCHEMA_DONT_MATCH_NAME,
> +       {
> +               {  "user", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +               {  "object", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +               {  "protocol", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +               {  "port", SECRET_SCHEMA_ATTRIBUTE_INTEGER },
> +               {  "server", SECRET_SCHEMA_ATTRIBUTE_STRING },
> +               {  "password_expiry_utc", SECRET_SCHEMA_ATTRIBUTE_INTEGER },

I've been testing this patch with credential-generating helper
git-credential-helper. It works, but because libsecret overwrites
items if and only if the attributes match exactly, you end up with
many items in the secret store that differ only by expiry date. This
is inelegant, and confusing to users. Please hold this patch, don't
merge to master. A solution might be to store the expiry date as the
secret of a separate item (even though the value is not confidential)

> +               {  NULL, 0 },
> +       }
> +};
> +
>  static char *make_label(struct credential *c)
>  {
>         if (c->port)
> @@ -78,6 +94,9 @@ static GHashTable *make_attr_list(struct credential *c)
>                 g_hash_table_insert(al, "port", g_strdup_printf("%hu", c->port));
>         if (c->path)
>                 g_hash_table_insert(al, "object", g_strdup(c->path));
> +       if (c->password_expiry_utc)
> +               g_hash_table_insert(al, "password_expiry_utc",
> +                       g_strdup(c->password_expiry_utc));
>
>         return al;
>  }
> @@ -101,7 +120,7 @@ static int keyring_get(struct credential *c)
>
>         attributes = make_attr_list(c);
>         items = secret_service_search_sync(service,
> -                                          SECRET_SCHEMA_COMPAT_NETWORK,
> +                                          &schema,
>                                            attributes,
>                                            SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>                                            NULL,
> @@ -128,6 +147,12 @@ static int keyring_get(struct credential *c)
>                         c->username = g_strdup(s);
>                 }
>
> +               s = g_hash_table_lookup(attributes, "password_expiry_utc");
> +               if (s) {
> +                       g_free(c->password_expiry_utc);
> +                       c->password_expiry_utc = g_strdup(s);
> +               }
> +
>                 s = secret_value_get_text(secret);
>                 if (s) {
>                         g_free(c->password);
> @@ -162,7 +187,7 @@ static int keyring_store(struct credential *c)
>
>         label = make_label(c);
>         attributes = make_attr_list(c);
> -       secret_password_storev_sync(SECRET_SCHEMA_COMPAT_NETWORK,
> +       secret_password_storev_sync(&schema,
>                                     attributes,
>                                     NULL,
>                                     label,
> @@ -198,7 +223,7 @@ static int keyring_erase(struct credential *c)
>                 return EXIT_FAILURE;
>
>         attributes = make_attr_list(c);
> -       secret_password_clearv_sync(SECRET_SCHEMA_COMPAT_NETWORK,
> +       secret_password_clearv_sync(&schema,
>                                     attributes,
>                                     NULL,
>                                     &error);
> @@ -238,6 +263,7 @@ static void credential_clear(struct credential *c)
>         g_free(c->path);
>         g_free(c->username);
>         g_free(c->password);
> +       g_free(c->password_expiry_utc);
>
>         credential_init(c);
>  }
> @@ -285,6 +311,9 @@ static int credential_read(struct credential *c)
>                 } else if (!strcmp(key, "username")) {
>                         g_free(c->username);
>                         c->username = g_strdup(value);
> +               } else if (!strcmp(key, "password_expiry_utc")) {
> +                       g_free(c->password_expiry_utc);
> +                       c->password_expiry_utc = g_strdup(value);
>                 } else if (!strcmp(key, "password")) {
>                         g_free(c->password);
>                         c->password = g_strdup(value);
> @@ -312,9 +341,11 @@ static void credential_write_item(FILE *fp, const char *key, const char *value)
>
>  static void credential_write(const struct credential *c)
>  {
> -       /* only write username/password, if set */
> +       /* only write username/password/expiry, if set */
>         credential_write_item(stdout, "username", c->username);
>         credential_write_item(stdout, "password", c->password);
> +       credential_write_item(stdout, "password_expiry_utc",
> +               c->password_expiry_utc);
>  }
>
>  static void usage(const char *name)
> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 5ea8bc9f1dc..9ebf7eeae48 100644
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -43,6 +43,7 @@ helper_test_clean() {
>         reject $1 https example.com store-user
>         reject $1 https example.com user1
>         reject $1 https example.com user2
> +       reject $1 https example.com user3
>         reject $1 http path.tld user
>         reject $1 https timeout.tld user
>         reject $1 https sso.tld
> @@ -298,6 +299,35 @@ helper_test_timeout() {
>         '
>  }
>
> +helper_test_password_expiry_utc() {
> +       HELPER=$1
> +
> +       test_expect_success "helper ($HELPER) stores password_expiry_utc" '
> +               check approve $HELPER <<-\EOF
> +               protocol=https
> +               host=example.com
> +               username=user3
> +               password=pass
> +               password_expiry_utc=9999999999
> +               EOF
> +       '
> +
> +       test_expect_success "helper ($HELPER) gets password_expiry_utc" '
> +               check fill $HELPER <<-\EOF
> +               protocol=https
> +               host=example.com
> +               username=user3
> +               --
> +               protocol=https
> +               host=example.com
> +               username=user3
> +               password=pass
> +               password_expiry_utc=9999999999
> +               --
> +               EOF
> +       '
> +}
> +
>  write_script askpass <<\EOF
>  echo >&2 askpass: $*
>  what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index 698b7159f03..f5ba727e53b 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -30,6 +30,8 @@ test_atexit 'git credential-cache exit'
>  # test that the daemon works with no special setup
>  helper_test cache
>
> +helper_test_password_expiry_utc cache
> +
>  test_expect_success 'socket defaults to ~/.cache/git/credential/socket' '
>         test_when_finished "
>                 git credential-cache exit &&
> diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
> index f028fd14182..f1478680bff 100755
> --- a/t/t0303-credential-external.sh
> +++ b/t/t0303-credential-external.sh
> @@ -52,6 +52,8 @@ else
>         helper_test_timeout "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"
>  fi
>
> +helper_test_password_expiry_utc "$GIT_TEST_CREDENTIAL_HELPER"
> +
>  # clean afterwards so that we are good citizens
>  # and don't leave cruft in the helper's storage, which
>  # might be long-term system storage
>
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e
> --
> gitgitgadget
