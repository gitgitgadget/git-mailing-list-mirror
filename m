Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C23C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiG0JRW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiG0JRU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:17:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B51EC49
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:17:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w5so8176661edd.13
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=J3Xkh39HgytOpg8h8rIjf5eaMuVb02bW/msbud0PLVE=;
        b=l+aO5jtfNsNl1RbrxTcfoGyaSXOg/2gQtTPIEUZ+IuzIx1KdvS85FaBS8KiGZGvOWg
         93t5lAOkXF5CXigfuLX3DVHfsImzv8ay1uh4i3Ledzx4vIaoS1bFbtOVZ2oUrQP4A6bt
         pw05bvmqg1iEbG/7QpclCbRAlm+kTpSveC+FSz8YgzG1KRgzOlqiwazQc6njInHkiSKM
         uAgaYL3jqnR/c/UmKYitAKEG3QppkE6rQRSf7deaGqNXX3wTUlYFFIGUaJB99UocPKn/
         TSB0JoplfdMm4wi4Rw6d1y7lBfBMANTsPjTf/yXPfzGd8SNTNPn6grgSUTWMdZGWiS1i
         G+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J3Xkh39HgytOpg8h8rIjf5eaMuVb02bW/msbud0PLVE=;
        b=5m67si/N8/kTiBK4ZUt7pCdUbtqaARA1kokHP2cfO4M/LqylKWXqPk7B6+V7q/eBGw
         joKyAz9XVwEV8fbrKg8sjXcxCLrR1QWs7F+corkWkXhHezQCNtOJpZYnjq8DN08Lp1mP
         YAWQZGua+jJ3aLHlxEOHQQWgR3dY1QjSnEvuvFtixJ/2m6AFCQf1jtMO3DawMYZSpDTH
         H7l3zPzvCb0joUYrm7KQVR4a77N5Pl3tblpJuNIbNWA3MA3LRRcdUt1+hdDwye33sY8z
         NFIY1n18Y/MH2Sw2krdnc7iIrblqduyJlYtMiObctOe9yn5boadmU6OHA54Y3tTnAW/0
         eBEg==
X-Gm-Message-State: AJIora9+2ySAU8RGpIJ2ykYd8IWwjQR2xDV8SvXWKyVXCwJygnvQF8Tw
        kqiOtEhcON/jGo1oeSggZto=
X-Google-Smtp-Source: AGRyM1skCBsf+XAvs00iY2bATbez1VKz/nuwaQJqxOpOFP5TfcOJfTgag1Fipc67SGUZvcDW783u/g==
X-Received: by 2002:a05:6402:27c9:b0:43a:d14b:1fa5 with SMTP id c9-20020a05640227c900b0043ad14b1fa5mr21873704ede.245.1658913437534;
        Wed, 27 Jul 2022 02:17:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b0043bbc9503ddsm9863843edt.76.2022.07.27.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:17:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGdAJ-006bFK-Tz;
        Wed, 27 Jul 2022 11:17:15 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jay Berry via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jay Berry <jb2170@selfadjointoperator.com>
Subject: Re: [PATCH] Use 'Everything up to date.' instead of 'Everything
 up-to-date'
Date:   Wed, 27 Jul 2022 11:15:37 +0200
References: <pull.1298.git.1658908927714.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1298.git.1658908927714.gitgitgadget@gmail.com>
Message-ID: <220727.86r126lxt0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 27 2022, Jay Berry via GitGitGadget wrote:

> From: Jay Berry <jb2170@selfadjointoperator.com>
>
> There are two hard-coded
> `fprintf(stderr, "Everything up-to-date\n")`
> which I have changed to
> `fprintf(stderr, "Everything up to date.\n")`
> since most other strings used localised versions of `up to date.`
>
> Before (stupidly inconsistent):
> ```
> $ git pull
> Already up to date.
> $ git push
> Everything up-to-date
> ```
> After (consistent):
> ```
> $ git pull
> Already up to date.
> $ git push
> Everything up to date.
> ```
> Signed-off-by: Jay Berry <jb2170@selfadjointoperator.com>
> ---
>     Use 'Everything up to date.' instead of 'Everything up-to-date'
>     
>     There are two hard-coded fprintf(stderr, "Everything up-to-date\n")
>     which I have changed to fprintf(stderr, "Everything up to date.\n")
>     since most other strings used localised versions of up to date.
>     
>     Before (stupidly inconsistent):
>     
>     $ git pull
>     Already up to date.
>     $ git push
>     Everything up-to-date
>     
>     
>     After (consistent):
>     
>     $ git pull
>     Already up to date.
>     $ git push
>     Everything up to date.
>     
>     
>     Signed-off-by: Jay Berry jb2170@selfadjointoperator.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1298%2FSelfAdjointOperator%2Fup-to-date-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1298/SelfAdjointOperator/up-to-date-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1298
>
>  builtin/send-pack.c | 2 +-
>  transport.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 64962be0168..cb3c6ff8300 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -338,7 +338,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (!ret && !transport_refs_pushed(remote_refs))
> -		fprintf(stderr, "Everything up-to-date\n");
> +		fprintf(stderr, "Everything up to date.\n");
>  
>  	return ret;
>  }
> diff --git a/transport.c b/transport.c
> index 52db7a3cb09..c40d15647ff 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1416,7 +1416,7 @@ int transport_push(struct repository *r,
>  	if (porcelain && !push_ret)
>  		puts("Done");
>  	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
> -		fprintf(stderr, "Everything up-to-date\n");
> +		fprintf(stderr, "Everything up to date.\n");

We don't want to take this change for the reasons discussed previously here:

	https://lore.kernel.org/git/CAPig+cRRxYmFqYimTHSi9uzmWU0FRXQ2hGXJK6jYLJcsFce_Rw@mail.gmail.com/
	https://lore.kernel.org/git/20191122180433.GA57478@generichostname/

That "don't" is up for discussion, but a subsequent re-roll should argue
it based on the points raised there.

If we *are* going to change this then:

 * We should mark this for translation with _()
 * Don't have the translation include the \n
