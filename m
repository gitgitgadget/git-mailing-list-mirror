Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49339C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiKOTuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiKOTuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:50:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEEC6323
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:50:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m22so38691595eji.10
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kC7c2lyylbZ7JSGwSDPnGefNdoFLhNwnVEgNff+Merc=;
        b=kuCO3DyDrJWeOMM6pg5kPYlG1mQD4+/0PbvWn7+KkD2ljuk5c6DJvE3XoEwbOIEPIv
         sQMIl6sYWN3rNId9T5w0WL7qTYbzjZ+Xm56jlUakuaRRu3vqwAtM8617mGKiUWzuhOVw
         UMJzRgXTL8P9FYSFtO1mX3znRrC5JTf81SUVWnDr0WB1KiFfpe9oY8CegIuDZX3ry/LL
         AeOlcqV3Tqi0CG5st6yZYiA32cttDZ9ntSWeW+/xLeuJBCpdPLMiVtGBYbLmDD5OdDgK
         +srLnovXkc7LGIFWCMk3saxbqs7H9H9V4gGpnc9XVatgbU7q/s0dD7r6H/msmuZiFJsd
         zlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC7c2lyylbZ7JSGwSDPnGefNdoFLhNwnVEgNff+Merc=;
        b=WvTH++Km+0S09CangVjMdknigI61hiBwUWPgZFNVGlys9SgFIEyw+gctPwh8MDq7F8
         GZvmj8Cu8lnBsUZsksAYBiCM4xp295uLcBIoSoyQWD6w/doB+ju9b/2mgBjOeIaOR8PF
         jgdo7rNoieI3QsZ4EJb8AokkFhTrjEDOKn1sa8IgPvdhN1Cq56fmzHjodOU5CUpx7v/p
         6Ja3zc2CBOgpszBfRk+u/ZhdvB9WBjiHhRwXG18SJDqdtcyH2MWPGNUCNU1PCtogcURm
         sB4S58Ry9+cR9HvfyxsqqHk/y3XCQj4kBNhAEaeB7qR9nDEC8jLu1Vdy8ruthjhvWfrC
         M1nQ==
X-Gm-Message-State: ANoB5plrEwAfd2sjm+jRwdGSofdYgNCHtYY3uaBRBXcOA/xMbtv8twKt
        7a76q4SQ8qjERwYlI3xbl18=
X-Google-Smtp-Source: AA0mqf64VU2Nmlt9NJDERABt7VYa4cjjWWTFW0FfW7tjHvcBCLv2zUw/lNszVwUEsJUpFsvRJZK0EA==
X-Received: by 2002:a17:906:6894:b0:79e:1783:7f68 with SMTP id n20-20020a170906689400b0079e17837f68mr15455222ejr.11.1668541841785;
        Tue, 15 Nov 2022 11:50:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906728300b007a559542fcfsm5869887ejl.70.2022.11.15.11.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:50:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ov1xA-003ijF-0I;
        Tue, 15 Nov 2022 20:50:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
Date:   Tue, 15 Nov 2022 20:41:44 +0100
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
Message-ID: <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 15 2022, Taylor Blau wrote:

> While trying to fix a move based on an uninitialized value (along with a
> declaration after the first statement), be0fd57228
> (maintenance --unregister: fix uninit'd data use &
> -Wdeclaration-after-statement, 2022-11-15) unintentionally introduced a
> use-after-free.
>
> The problem arises when `maintenance_unregister()` sees a non-NULL
> `config_file` string and thus tries to call
> git_configset_get_value_multi() to lookup the corresponding values.
>
> We store the result off, and then call git_configset_clear(), which
> frees the pointer that we just stored. We then try to read that
> now-freed pointer a few lines below, and there we have our
> use-after-free:
>
>     $ ./t7900-maintenance.sh -vxi --run=3D23 --valgrind
>     [...]
>     + git maintenance unregister --config-file ./other
>     =3D=3D3048727=3D=3D Invalid read of size 8
>     =3D=3D3048727=3D=3D    at 0x1869CA: maintenance_unregister (gc.c:1590)
>     =3D=3D3048727=3D=3D    by 0x188F42: cmd_maintenance (gc.c:2651)
>     =3D=3D3048727=3D=3D    by 0x128C62: run_builtin (git.c:466)
>     =3D=3D3048727=3D=3D    by 0x12907E: handle_builtin (git.c:721)
>     =3D=3D3048727=3D=3D    by 0x1292EC: run_argv (git.c:788)
>     =3D=3D3048727=3D=3D    by 0x12988E: cmd_main (git.c:926)
>     =3D=3D3048727=3D=3D    by 0x21ED39: main (common-main.c:57)
>     =3D=3D3048727=3D=3D  Address 0x4b38bc8 is 24 bytes inside a block of =
size 64 free'd
>     =3D=3D3048727=3D=3D    at 0x484617B: free (vg_replace_malloc.c:872)
>     =3D=3D3048727=3D=3D    by 0x2D207E: free_individual_entries (hashmap.=
c:188)
>     =3D=3D3048727=3D=3D    by 0x2D2153: hashmap_clear_ (hashmap.c:207)
>     =3D=3D3048727=3D=3D    by 0x270B5C: git_configset_clear (config.c:237=
5)
>     =3D=3D3048727=3D=3D    by 0x1869AC: maintenance_unregister (gc.c:1585)
>     =3D=3D3048727=3D=3D    by 0x188F42: cmd_maintenance (gc.c:2651)
>     =3D=3D3048727=3D=3D    by 0x128C62: run_builtin (git.c:466)
>     =3D=3D3048727=3D=3D    by 0x12907E: handle_builtin (git.c:721)
>     =3D=3D3048727=3D=3D    by 0x1292EC: run_argv (git.c:788)
>     =3D=3D3048727=3D=3D    by 0x12988E: cmd_main (git.c:926)
>     =3D=3D3048727=3D=3D    by 0x21ED39: main (common-main.c:57)
>     [...]
>
> Resolve this via a partial-revert of be0fd57228. The config_set struct
> now gets a zero initialization, which makes free()-ing it a noop even
> without calling git_configset_init(). When we do initialize it to a
> non-zero value, it is only free()'d after our last read of `list`.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> I am disappointed in myself for finding this only after I pushed out a
> hotfix to 'next' and rebuild the downstream branches.
>
> This should be a minimal fix on top of =C3=86var's patch to get 'next'
> building again.

I'm also disappointed in myself, sorry. I *did* test it locally with
valgrind, but obviously fat-fingered it somehow and tested the wrong
version. Sorry!

>  builtin/gc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index d87cf84041..38882a1e35 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const c=
har **argv, const char *prefi
>  	int found =3D 0;
>  	struct string_list_item *item;
>  	const struct string_list *list;
> +	struct config_set cs =3D { { 0 } };

Just "{ 0 }" here instead? I see it may have been copied from some older
pre-image though, and they'll do the same in either case, so it's not
important...
