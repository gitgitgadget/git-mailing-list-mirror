Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2C1C69D
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266776; cv=pass; b=PlgwMKYj3Iissxu1GL8sXT9c7MAkHiyXFLfmxduH7SVFrUDbf7dJwsDuEffIEpdAUjBN5yChoGSRTAZmcuPHW5WjeGj/uwWo/vAR0hdZj3O6p7OqK8w15RJl+ZMzwuP5WILtQVIyEa4djHcsHpkCpAvZknoxs1nzSuYwvODW27c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266776; c=relaxed/simple;
	bh=wcJ1Bc1CHjQnT0WMMPjzjA7T4PNZjjQLnXDb20xllec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tsO0uLtH1nLeC37XIPDv6RDYcM2QR8mZsgcABAMfY+9BIzSnVSSbVLD/C8hb1GM5NSb2DvXm76aX/GAgqCNPU6oclHfbCTG0Qb0SocEWCn4gkGG0Dp49mWvY5IAkimj7zcLhE6v+xqCLNitYs9qE9KYjK3f6F9sHNMojHDX3PGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLjICYx1; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLjICYx1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e1a67d4b8so2036524a12.0
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 10:32:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771266774; cv=none;
        d=google.com; s=arc-20240605;
        b=b7G0UZ1M55/Yeya1yPy5qyxQD95byoED3kp0hCdVkpRQUwtBa3KIYtIwPoIgiwunHi
         8pOAookTXk+B5TGrzbsWwwTwGYWn/ehgXTeKWVUje8IbyYvboIImT6xkMvZMJqqWJlPS
         DRm2peIRq7cMHcwGU429k7S6zqPcGAAnntoiL92DcNgsclMUBb+pFw+tQxy4r2Hanp/j
         bkIWpjZVFiEa/Dp05tya7NzX5jEa5kFPfl0g0k6A4ice/yNHjSGmYf30qFL5TAq2b+xV
         aIsvhNmIokFXc5IXOwaCUgulgx041EMPkPq1tKQsom2jdufUMAgvY019ZFR8Z3oO3yAY
         BMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=thKpvhAN3Ww/dkkJHk+ozJuHOnbudeU45Yd8jQMSd8A=;
        fh=VMi6suD7q0ooNDTHboYltQBU7GDs0CZDgNnvuDGHhno=;
        b=P5VYWRY0xAPhBr3ARmIDoqR17119F6YdQxjzHN0uoYtiTid9Q5z+A98Uviz69m+mBw
         zm42wijVlGjROF6jrjx5X1rhbZEGxr5E0vNX0tJsVTz+yBT/YLe0rUWRI/ujuZAcSBxb
         jfYiBpVXRy2B+IglHcvonb2iW83TjA0CTannk/yvZChDPiTDdRcTQZAy7AD6uONVad9h
         rTPjse3GO6qk4rshgPra/TVcW91Dl1vJX3HuIVot1WPNqoE9R6zrSEuZ85/NJAovK+kx
         7VFYLR7bAiagxEcVjHvnBk4pNA0wJBr2Lw7PHXb7psTM3EGw3xAe/SA6JmEf433cffpN
         B/JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771266774; x=1771871574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thKpvhAN3Ww/dkkJHk+ozJuHOnbudeU45Yd8jQMSd8A=;
        b=jLjICYx17xZR5A/ZIAiTPQgBfWsy8fqkfDcQRaQHbfTqBY4Uq+CmkzlnT/FNY1PbQ1
         sL2xLDzUc7/bjKw/s9Xsqd23jlh5BsqJsUPV5zsLHledTvr/0YhuCeHW2x0Z9BIAtY8W
         5AbGkPTlXOYlk1VKr8lzhPQdFyQuex+ybLgVuXyuLPnXtr1NjGkLtxbzfrJ2/b1lt4yf
         VrnSMHjS41pZcHeyfEvSjVacW8PSPJXQotLZuWsvMc6To8nvV7naDB+8AAAKWrTKvHT8
         s7Td/Xe7FfiMwmwCZNVmzH5IR/09QmwzqUe/EepoXkBFFS6xFbXrao8nVHd2rbCo2xDe
         MkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266774; x=1771871574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thKpvhAN3Ww/dkkJHk+ozJuHOnbudeU45Yd8jQMSd8A=;
        b=ZzfVGGnuR6FgsaEmIehSRD2bs/pQti3m+vFV+vcOiYWjMtmVBR5DpGqqzq6LdKuylA
         HTG/0ut2RlMZw31C1afK2hCV0//GZknI7c5qdsOYWpJnnyaRCSqr3RuCHLhTexsZEFV1
         0GMPfXD97fq+5PfMvQA0hoc7K4MiAahw9a7AXaWcFZZydV5/4dxy9wtwmPh6RGF/FOOG
         DbMfD+oZM8BMOTUQd43Ho3jbk3rxPAyt/AlqJzQ/qJz8y5zXFXQIQ0oF1vwLvxGsPIu0
         HZZSkXbOs5e2Uycck+eguCl6lxu3v0f3nw4tzsitTrx+nbJhqlhkcUApeDKbNdvsad25
         Z9Yw==
X-Gm-Message-State: AOJu0YxyvDTr0EbgwAZeytHnYue4QeQZ5hLhZOvi+Xvzaf7FWXQZMaaN
	NWL7vzYG3zeko7d9VhG+xw2vlwfjDnM2DBMQka06IJj0y9rwPUwbWvjNVXPI5ArX8Z1iOJMFSOy
	fQTzLtMZLEAMEFfwdkebaklp2p2rK7T4=
X-Gm-Gg: AZuq6aJNmsWulKzwai8gG6Zm5+aJ0ATxB+UOgLdBFspwl1cfxodM6HxWmFA9g64TiKo
	ICK0TH3tab6spQNdw8BTBqI32Ym3PUIn99S7fFBg3YBcDfigE8nb3467IjxsDJ7uWc2eOddFIHg
	UQxoTemKtb/pS5uCvQ8qVKs0vi3EYWopCasoqbmioGNw5KlsSwfeG7LGYnIpk5Gyixm15wktI3x
	+/UUPI4AZHV9qQclei+VUKUmm8F/J24pTGSk730ivC8Nc4nVdYwSTkZzo5HcgdauEooTbjnrBb2
	x1KHBIzIz4hDqMDWVz+EBsVbvG99APlZE4aZgyM43+4uIs3FOxKwoU7UMGLofyjSYvZgVZ+267j
	L78y/2SWLW97sEPB1uIf8RMe1XA==
X-Received: by 2002:a17:90b:1fcf:b0:356:41c2:897d with SMTP id
 98e67ed59e1d1-356aaa7623amr11044284a91.8.1771266774300; Mon, 16 Feb 2026
 10:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
 <20260216161513.2533141-1-jonatan@jontes.page> <20260216161513.2533141-5-jonatan@jontes.page>
In-Reply-To: <20260216161513.2533141-5-jonatan@jontes.page>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 16 Feb 2026 13:32:43 -0500
X-Gm-Features: AaiRm52NQV8S9YlBudAtQTZTWA55NE1zfw_tGGJFsN6mslDHeUWXaOPFSCALr9s
Message-ID: <CALnO6CD3QpEZ=689w3mQpc5Hx0bj3+E8gU-JhstYJ9XOvunxiQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] completion: fix zsh alias listing for subsection aliases
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 11:15=E2=80=AFAM Jonatan Holmgren <jonatan@jontes.p=
age> wrote:
>
> The zsh completion function __git_zsh_cmd_alias() uses 'git config
> --get-regexp' to enumerate aliases and then strips the "alias." prefix
> from each key. For subsection-style aliases (alias.name.command), this
> leaves "name.command" as the completion candidate instead of just
> "name".
>
> The bash completion does not have this problem because it goes through
> 'git --list-cmds=3Dalias', which calls list_aliases() in C and already
> handles both alias syntaxes correctly. However, zsh needs both the
> alias name and its value for descriptive completion, which
> --list-cmds=3Dalias does not provide.
>
> Add a hidden --aliases-for-completion option to 'git help', following
> the existing --config-for-completion pattern. It outputs NUL-separated
> "name\nvalue" pairs using list_aliases(), which correctly resolves both
> the traditional (alias.name) and subsection (alias.name.command)
> formats. Update __git_zsh_cmd_alias() to use it.

An alternative would to be to post-process and turn
"alias.name.command" into "name", but this solution is easier to parse
(won't mix 2 formats).

> ---
>  builtin/help.c                        | 15 +++++++++++++++
>  contrib/completion/git-completion.zsh |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index c09cbc8912..f02308a391 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -54,6 +54,7 @@ static enum help_action {
>         HELP_ACTION_DEVELOPER_INTERFACES,
>         HELP_ACTION_CONFIG_FOR_COMPLETION,
>         HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
> +       HELP_ACTION_ALIASES_FOR_COMPLETION,
>  } cmd_mode;
>
>  static char *html_path;
> @@ -90,6 +91,8 @@ static struct option builtin_help_options[] =3D {
>                     HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
>         OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
>                     HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT=
_HIDDEN),
> +       OPT_CMDMODE_F(0, "aliases-for-completion", &cmd_mode, "",
> +                   HELP_ACTION_ALIASES_FOR_COMPLETION, PARSE_OPT_HIDDEN)=
,
>
>         OPT_END(),
>  };
> @@ -691,6 +694,18 @@ int cmd_help(int argc,
>                                help_format);
>                 list_config_help(SHOW_CONFIG_SECTIONS);
>                 return 0;
> +       case HELP_ACTION_ALIASES_FOR_COMPLETION: {
> +               struct string_list alias_list =3D STRING_LIST_INIT_DUP;
> +               opt_mode_usage(argc, "--aliases-for-completion",
> +                              help_format);

style nit: I _think_ this line could be unwrapped?

> +               list_aliases(&alias_list);
> +               string_list_sort(&alias_list);

It may not matter much since lists of aliases are probably not
humongous, but do we need to sort? I don't _think_ "git
--list-cmds=3Dalias" does, for example, though I'm not sure about "git
config --get-regexp" that's being replaced. Leaving it in the config
order could even be a feature, so I can put easier-to-complete aliases
earlier in my config?

> +               for (size_t i =3D 0; i < alias_list.nr; i++)
> +                       printf("%s%c%s%c", alias_list.items[i].string, '\=
n',
> +                              (char *)alias_list.items[i].util, '\0');
> +               string_list_clear(&alias_list, 1);
> +               return 0;
> +       }
>         case HELP_ACTION_CONFIG:
>                 opt_mode_usage(argc, "--config", help_format);
>                 setup_pager(the_repository);


> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/g=
it-completion.zsh
> index f5877bd7a1..c32186a977 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -202,7 +202,7 @@ __git_zsh_cmd_common ()
>  __git_zsh_cmd_alias ()
>  {
>         local -a list
> -       list=3D(${${(0)"$(git config -z --get-regexp '^alias\.*')"}#alias=
.})
> +       list=3D(${(0)"$(git help --aliases-for-completion)"})
>         list=3D(${(f)"$(printf "%s:alias for '%s'\n" ${(f@)list})"})
>         _describe -t alias-commands 'aliases' list && _ret=3D0
>  }
> --
> 2.53.0.83.g660bbd62ee.dirty

The Zsh hunk looks straightforwardly correct, especially since the
output format of the new help-mode is unchanged, thanks.

--=20
D. Ben Knoble
