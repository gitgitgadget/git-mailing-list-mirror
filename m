Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6612339FD8
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637463; cv=none; b=iG32XF1le1nxA2i4u+q7/Ld+7thiiqxJOF2iNLXwaVYNzjtxENa7gWlKfeXwPkI0mbiJThCnsV4BGI2f8Wdmn0o3LrydSgCpbuPZYJv4cfTWboWKjgwLK1DpiXq/SAhiJzViOZ/REPdzkIhyy/hfkuz03qIJt/YMDvyWyRTNC1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637463; c=relaxed/simple;
	bh=5AJjEN1t4SCmNm8guqWomOc2UU8ZOKaHi76hPHB5VCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyyeWOLcpCF00N2WBotqmnWrqD0izhsIelxHHPKRJbYf3/mR3qeeLW1u6Wvabg5yXOgmONKr5ioPZy9uKG6l6NGBy9pIgjY6QnnM8QT4OpLtL/BsO0YYbK0FuEa3yBEgNYbZsxFDJ2EVkhQkfgdi6dBrm79p7qIKOc3wXMBLGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17tbNrCj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17tbNrCj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59cdd185b9so1016010766b.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 14:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715637460; x=1716242260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtEmjc88KYwogKB4T8gvY/11qgzgpYLwkCCysgXdLZc=;
        b=17tbNrCj8ose6PyzuFgqSebyIZxne0kRs6AYCgOfnFo8nUgQ9perxZHEMy0c7xwqJc
         3vvu/iyvYOm/IPBl1zMfrCQdj6yuFR2aK5mflXpGwGia2L1+0L9PophD56iJ4hcglqAl
         caCXxv8nULM/0SuzM+lRA1hNC25EjU5tuKr1fl4K5xy4Sd7mskpVaSnH8iixqMiYuWro
         XJfwNBUYc2lmGcBidxwOxmUrQg0UNrO1AV29MFT9QExu0nlhyRzwcN26jinPC/k5lsAC
         7OZMvLVPt1v5IvRgMUqYxrN3o1nzk9omD5CRDiSt9re4IkZfXWEQ751Demo4w+5pukIo
         zVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637460; x=1716242260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtEmjc88KYwogKB4T8gvY/11qgzgpYLwkCCysgXdLZc=;
        b=Id0Tx/YkpBuM5ns2ioPJVQ/RoqEH/gKisfEtPTR46bAQ1kHr9zFf/jXJICDKY1rv6D
         9q90kEs+oam0m8fw4mcAlQxe0IX++Hf6PpLq57cA7o8Frwx14gieCc1tPe2McRuYkUwF
         DgE759GiwNgWNS0Lepsk0xjqyHPSFIoIwoOFpkNVFzpKs0tFyNQd4DGMYnaTP2g1AAlA
         /8GynH3+kfggVeR7Z6Pt4jbPnbzDapGPMUm+h5DP7KKWZNcMmx31slnqc4HMy1TSS3az
         /r/T/jQNMHjkakiN7LEyXBr5jZGML668YtQpxsohZx065fy+1tp6ly2ph7KHTYe13sUZ
         CFdA==
X-Gm-Message-State: AOJu0YweuOR5Zkt4Vr0e9QQI7PEMJ4gG5jjNMRriNLjwXRY2BhpXPL6A
	2A/boWUaLmsNjBtspJ9X4/mXslK4BaDOg8/YzLXL8xsRU2ygTzVKRtQ0eHMO4q44F+Wjyi+pfx+
	4a3mmq/goiBkEwG1+QBwiNkn8x6p1t0LqyvFP
X-Google-Smtp-Source: AGHT+IGhB1YJdHVZAynOFxSDiVmw+eu5WXPsP7E3usGP0YeMYDc5vnm91FIc4P4TYoZiORQdgrS7v857X4Vnjnci5MA=
X-Received: by 2002:a17:906:d10e:b0:a59:9fcb:e9ac with SMTP id
 a640c23a62f3a-a5a2d1afc74mr899614066b.11.1715637459370; Mon, 13 May 2024
 14:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715339393.git.ps@pks.im> <cover.1715595550.git.ps@pks.im>
In-Reply-To: <cover.1715595550.git.ps@pks.im>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 13 May 2024 14:57:22 -0700
Message-ID: <CAO_smVijhZYjuZA+Q_1-XNLDC5AkFVf1SMwFyE3f6UCTrrmgZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] builtin/config: remove global state
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 3:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Hi,
>
> this is the second version of my patch series that removes global state
> from "builtin/config.c". Changes compared to v1:
>
>   - Reinstated a comment in patch 5.
>
>   - Fixed a memory leak in patch 9.
>
>   - A couple of commit message fixes.
>
> The series continues to build on top of ps/config-subcommands.
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (21):
>   builtin/config: stop printing full usage on misuse
>   builtin/config: move legacy mode into its own function
>   builtin/config: move subcommand options into `cmd_config()`
>   builtin/config: move legacy options into `cmd_config()`
>   builtin/config: move actions into `cmd_config_actions()`
>   builtin/config: check for writeability after source is set up
>   config: make the config source const
>   builtin/config: refactor functions to have common exit paths
>   builtin/config: move location options into local variables
>   builtin/config: move display options into local variables
>   builtin/config: move type options into display options
>   builtin/config: move default value into display options
>   builtin/config: move `respect_includes_opt` into location options
>   builtin/config: convert `do_not_match` to a local variable
>   builtin/config: convert `value_pattern` to a local variable
>   builtin/config: convert `regexp` to a local variable
>   builtin/config: convert `key_regexp` to a local variable
>   builtin/config: convert `key` to a local variable
>   builtin/config: track "fixed value" option via flags only
>   builtin/config: convert flags to a local variable
>   builtin/config: pass data between callbacks via local variables
>
>  builtin/config.c  | 968 ++++++++++++++++++++++++++--------------------
>  config.c          |   4 +-
>  config.h          |   2 +-
>  t/t1300-config.sh |   9 +-
>  4 files changed, 550 insertions(+), 433 deletions(-)
>
> Range-diff against v1:

Looks good to me

>  1:  0ba7628126 =3D  1:  0ba7628126 builtin/config: stop printing full us=
age on misuse
>  2:  663e1f74f8 =3D  2:  663e1f74f8 builtin/config: move legacy mode into=
 its own function
>  3:  1239c151d0 =3D  3:  1239c151d0 builtin/config: move subcommand optio=
ns into `cmd_config()`
>  4:  82964510c5 =3D  4:  82964510c5 builtin/config: move legacy options i=
nto `cmd_config()`
>  5:  2e308393ed !  5:  0a6ecae2cc builtin/config: move actions into `cmd_=
config_actions()`
>     @@ builtin/config.c: static int cmd_config_actions(int argc, const ch=
ar **argv, con
>         comment =3D git_config_prepare_comment_string(comment_arg);
>
>      -  if (actions & PAGING_ACTIONS)
>     ++  /*
>     ++   * The following actions may produce more than one line of output=
 and
>     ++   * should therefore be paged.
>     ++   */
>      +  if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP |=
 ACTION_GET_URLMATCH))
>                 setup_auto_pager("config", 1);
>
>  6:  edfd7caa39 =3D  6:  7ab99a27c1 builtin/config: check for writeabilit=
y after source is set up
>  7:  bfba68aa1e =3D  7:  1460d3a36c config: make the config source const
>  8:  6bff0410e9 =3D  8:  018ed0226b builtin/config: refactor functions to=
 have common exit paths
>  9:  a96c122280 !  9:  b5d43b6f85 builtin/config: move location options i=
nto local variables
>     @@ builtin/config.c: static char *default_user_config(void)
>      -          given_config_source.file =3D git_global_config();
>      -          if (!given_config_source.file)
>      +  if (opts->use_global_config) {
>     -+          opts->source.file =3D xstrdup_or_null(git_global_config()=
);
>     ++          opts->source.file =3D git_global_config();
>      +          if (!opts->source.file)
>                         /*
>                          * It is unknown if HOME/.gitconfig exists, so
> 10:  06c1e08fc4 =3D 10:  d66e14af30 builtin/config: move display options =
into local variables
> 11:  9610897662 =3D 11:  63436c3416 builtin/config: move type options int=
o display options
> 12:  eb79462861 =3D 12:  106b8ac8a2 builtin/config: move default value in=
to display options
> 13:  b9ebfbd667 =3D 13:  8a6b555b58 builtin/config: move `respect_include=
s_opt` into location options
> 14:  2b40b784fe ! 14:  0dd22bf51a builtin/config: convert `do_not_match` =
to a local variable
>     @@ Commit message
>          builtin/config: convert `do_not_match` to a local variable
>
>          The `do_not_match` variable is used by the `format_config()` cal=
lback as
>     -    an indicator whteher or not the passed regular expression is neg=
ated. It
>     +    an indicator whether or not the passed regular expression is neg=
ated. It
>          is only ever set up by its only caller, `collect_config()` and c=
an thus
>          easily be moved into the `collect_config_data` structure.
>
> 15:  71d1b7a51b =3D 15:  b656951f0c builtin/config: convert `value_patter=
n` to a local variable
> 16:  c3b340f119 =3D 16:  b56a07bda0 builtin/config: convert `regexp` to a=
 local variable
> 17:  835cc0acfb =3D 17:  323cb05120 builtin/config: convert `key_regexp` =
to a local variable
> 18:  2aee7ec5d8 ! 18:  e972e63be8 builtin/config: convert `key` to a loca=
l variable
>     @@ Commit message
>          The `key` variable is used by the `get_value()` function for two
>          purposes:
>
>     -      - It is used to store the result of `git_config_parse_key()`, =
which si
>     +      - It is used to store the result of `git_config_parse_key()`, =
which is
>              then passed on to `collect_config()`.
>
>            - It is used as a store to convert the provided key to an
>              all-lowercase key when `use_key_regexp` is set.
>
>     -    Both of these cases don't warrant a global variable at all. In t=
he
>     -    former case we can pass the key via `struct collect_config_data`=
. And in
>     -    the latter case we really only want to have it as a temporary lo=
cal
>     -    variable such that we can free associated memory.
>     +    Neither of these cases warrant a global variable at all. In the =
former
>     +    case we can pass the key via `struct collect_config_data`. And i=
n the
>     +    latter case we really only want to have it as a temporary local =
variable
>     +    such that we can free associated memory.
>
>          Refactor the code accordingly to reduce our reliance on global s=
tate.
>
> 19:  625216a774 ! 19:  d83c3d085e builtin/config: track "fixed value" opt=
ion via flags only
>     @@ Commit message
>          is not aware that this is tracked via two separate mechanisms.
>
>          Refactor the code to use the flag exclusively. We already pass i=
t to all
>     -    the require callsites anyway, except for `collect_config()`.
>     +    the required callsites anyway, except for `collect_config()`.
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> 20:  05254d512b =3D 20:  294bcd96a4 builtin/config: convert flags to a lo=
cal variable
> 21:  3a5f059789 =3D 21:  0496b958e2 builtin/config: pass data between cal=
lbacks via local variables
> --
> 2.45.GIT
>
