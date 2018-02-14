Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99731F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031970AbeBNWqI (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:46:08 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44118 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWqH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:46:07 -0500
Received: by mail-wr0-f195.google.com with SMTP id v65so1523265wrc.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FvnpZFjsM3+EOpKwq2Y+8Laydgrz9uiQTFzKUU0aVZs=;
        b=jIKsn8b5ZREirLtYTR11LCmfQyhXFYUIJhR1siqxYjBY9V+76PQMU9dGfUbtKNEqEp
         qC8S6clHijSpFHESXla26I5QYDDjpC64kTPSRVcIw4qNZplfujUSNpezTGFUuOTID63P
         a1Tq+3xmqhe1NvlAKItz67o/xcaAzPJdnUQyfOKIjgwzao5sZaFLwKj6/m2CZN6WotVa
         mPp3A9k310Ka0vbNFic/hxq/soBDehoWcQLt6Npk7EO1PPlfJq8oEsb/W5StKXWg+Xi9
         +Nyp3/cD2AH1zHwDVCpbqvcYyQdq2Xrj+u1FQpg7TVjIu8PTSpdsabNHwTTzy9G6Sncg
         saTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FvnpZFjsM3+EOpKwq2Y+8Laydgrz9uiQTFzKUU0aVZs=;
        b=pqLaqmiP0pIWEor8VKGoj7WeFV4oFvm56jnf8QvIYKmrTmnvhOYKS1oBchAPSoZtfZ
         HSf7+XOARI2SR4HHyvmZpCr57vUkrES+RVuC9eAZBqaUPtl7mO51JTILnSpiSl9gaHUr
         LidoxymofHJPM01r7VHBo8uM5gnY2PuAIyFdiKjBURjJItuv+AJYSypkBaa5E3Vl/Oo/
         q1sCbbPoHebsuSNuGnJI6KOdyj/GU2gyh4OskPgHWFvZWHawCHXiWNXXXKIFLLwtneXq
         NNCULX4jvlQ5UqRvu4CrcdrLSa6qnXFZVP3yx21MFpxgb3/Vo4cQRbS/8YmF+urn87U1
         J3Fg==
X-Gm-Message-State: APf1xPAITzec8Vx6dNfQ+SE/Z3js8AsdfSxBGDwiU4LPtDJoPVb8dR56
        Pt/SV+pxnl5KNGAbOmbKjMqgMHDw
X-Google-Smtp-Source: AH8x224FZj9MwItNiicIVnSlbqYK2+T0FDePPoI1NVQZAX2ATy1jsmS19U6iIJrWNdusQ/wNIeh7kA==
X-Received: by 10.223.200.144 with SMTP id k16mr668070wrh.282.1518648365462;
        Wed, 14 Feb 2018 14:46:05 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id l9sm30786539wrl.1.2018.02.14.14.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 14:46:04 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, doron.behar@gmail.com
Subject: Re: [PATCH 1/2] parse-options: expand $HOME on filename options
References: <20180214101019.gaenosifgq3wx2nm@NUC.localdomain> <20180214105149.28896-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214105149.28896-1-pclouds@gmail.com>
Date:   Wed, 14 Feb 2018 23:46:02 +0100
Message-ID: <87wozffavp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Nguyễn Thái Ngọc Duy jotted:

> When you specify "--path ~/foo", the shell will automatically expand
> ~/foo to $HOME/foo before it's passed to git. The expansion is not done
> on "--path=~/foo". An experienced user sees the difference but it could
> still be confusing for others (especially when tab-completion still
> works on --path=~/foo).
>
> Support $HOME expansion for all filename options. There are about seven
> of them.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  parse-options.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index d265a756b5..c33f14c74e 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -38,10 +38,13 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
>
>  static void fix_filename(const char *prefix, const char **file)
>  {
> -	if (!file || !*file || !prefix || is_absolute_path(*file)
> -	    || !strcmp("-", *file))
> +	if (!file || !*file || is_absolute_path(*file) ||
> +	    !strcmp("-", *file))
>  		return;
> -	*file = prefix_filename(prefix, *file);
> +	if (**file == '~')
> +		*file = expand_user_path(*file, 0);
> +	else if (prefix)
> +		*file = prefix_filename(prefix, *file);
>  }
>
>  static int opt_command_mode_error(const struct option *opt,

On current versions of git:

    (
        mkdir '/tmp/~' &&
        cd /tmp &&
        touch '~/foo' &&
        git init --template=~
    )

Will create a /tmp/.git with a 'foo' file, whereas now it'll expand ~ to
$HOME. Since this changes the behavior of this and presumably some other
options it seems like something we should have a test for.

In general I'm mildly negative on adding this, for every user like Doron
who'll be less confused by a hack like this, you'll have other users
who'll be confused about git inexplicably working with ~ in the middle
of strings, even though;

    $ echo git init --template ~/path
    git init --template /home/avar/path
    $ echo git init --template=~/path
    git init --template=~/path

I think it makes more sense to just leave such expansion to the shell,
and not try to magically expand it after the fact, since it's both
confusing (user: why does this work with git and not this other
program?), and as shown above changes existing semantics.

We'll also be setting ourselves up for more disappointed users who'll
notice that e.g. `git clone file://~/path` doesn't work, but `git clone
file://$HOME/path` does, requiring more hacks to expand ~ in more
codepaths. Will they also expact `git log -G~` to find references to
their homedir in their dotfiles.git?

I think this way lies madness, and it's better to just avoid it.

But I think that if we're going to keep it it needs some tests & docs to
point confused users to.
