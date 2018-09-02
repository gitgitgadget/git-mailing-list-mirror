Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0E131F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeIBL04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 07:26:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46784 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeIBL04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 07:26:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id e23-v6so12874722lfc.13
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IlN/9h6sia16YOL2+omg7C2A/CP9QD8xHMZwoNaqkLs=;
        b=oi6Ru59L//XoVZS9OM4i71a19Hm7en6OsmTtblCkg9qjD4FRuK7+zaV7ByQAz/CR5A
         L1kA9SitMUbYcjc8wzPM1rbC+URHITRtfPCTTrI1eg7kAVme3OOyP3UBMerRM73uLAhR
         NE3VPGiubugrRK698zPwm/p4K0xDkdWKGWPVyrsU36mKcOq5OvVcagLrSmH9+DeCSF/L
         ok2b32adm34OKPNm76s1QZejdEwDHfMS1jESEGmwQco81wm2CeK7FyzF3tCK4m24UmLU
         Ulto4aFAPu9fv4PkbQR1GM76loqd5/t2M9oDNxkSH+10JT3MvBNHsSUwwET3sxX8fIXq
         ocKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IlN/9h6sia16YOL2+omg7C2A/CP9QD8xHMZwoNaqkLs=;
        b=fKdQBejzJ/o2U/bRTH5nv0EyKOeWhzROrEVW36iZhYrFhPTQhAD0XvzXoEl9ufIn8x
         FiXk8kTc7VARamVquVb/BJoIk92d+Y/7q2g9ny2JKsPb9v/fZ6YsLu8bzBcc2oqVTS2D
         JCwbsLknGrFVmb3ORuBPfxdJR/KWw/u8xtCCE/je66bWUtQOF3xYLTeaAgF4GdYNwg5y
         8fltpyaMrsyvJ74JuNu+Bz7t3ayzOdRBVh1ZhMghH5sHIdq/GB+ax7fY8GtetW75kTFJ
         BZzOxajrp6K6dfuU+XORgt7UvaEb2x1nPWIfHBwnN/UHcciBT2yp+qbPhioCcKLgsu43
         i4Xw==
X-Gm-Message-State: APzg51BgYg/3OLoS4+ka7t1K1OB437mQWnN8n2QwCPvCMi1i0cMXkqAY
        +hUzat8KrY/mJH/jx7ZXi9A=
X-Google-Smtp-Source: ANB0Vdan69j9o54n8uHI76kF1jtnb1g2gJXw+Isrf4t0GlW8UtMeA4dcHtyR4bJ8iYqw82rNb9HlhQ==
X-Received: by 2002:a19:14e6:: with SMTP id 99-v6mr14430856lfu.26.1535872328209;
        Sun, 02 Sep 2018 00:12:08 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e32-v6sm2848019lfi.12.2018.09.02.00.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 00:12:07 -0700 (PDT)
Date:   Sun, 2 Sep 2018 09:12:04 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
Message-ID: <20180902071204.GA2868@duynguyen.home>
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
 <87tvn8c166.fsf@evledraar.gmail.com>
 <20180902050803.GA21324@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180902050803.GA21324@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 02, 2018 at 01:08:03AM -0400, Jeff King wrote:
> On Sun, Sep 02, 2018 at 12:17:53AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > Here are the steps to reproduce it:
> > >   $ git clone git://github.com/lucvoo/sparse-dev.git <somedir>
> > >   $ cd <somedir>
> > >   $ git co index-corruption
> > >   $ git rm -r validation/ Documentation/
> > >   $ git commit -m <some message> -p
> > >   $ git status
> > > error: index uses $?+? extension, which we do not understand
> > > fatal: index file corrupt
> > >
> > > The 'extension' pattern '$?+?', can vary a bit, sometimes
> > > it's just '????', but always seems 4 chars.
> > > If the commit command doesn't use the '-p' flag, there is no
> > > problem. The repository itself is not corrupted, it's only
> > > the index. It happends with git 2.18.0 and 2.17.0
> > 
> > Yeah this is a bug, I didn't dig much but testing with this script down
> > to 2.8.0:
> > [...]
> > I found that the first bad commit was: 680ee550d7 ("commit: skip
> > discarding the index if there is no pre-commit hook", 2017-08-14)
> 
> I think it's much older than that. I set up my test repo like this:
> 
>   git clone git://github.com/lucvoo/sparse-dev.git
>   cd sparse-dev
>   git checkout --detach
> 
> and then bisected with this script:
> 
>   cd /path/to/sparse-dev
>   rm .git/index
>   git reset --hard index-corruption &&
>   git rm -q -r validation/ Documentation/ &&
>   git commit -qm foo -p &&
>   git status
> 
> Since a33fc72fe9 (read-cache: force_verify_index_checksum, 2017-04-14),
> that produces the corrupt extension error. But before that, I
> consistently get:
> 
>   error: bad index file sha1 signature
>   fatal: index file corrupt
> 
> from git-commit. And that bisects back to 9c4d6c0297 (cache-tree: Write
> updated cache-tree after commit, 2014-07-13).
> 
> If I revert that commit (which takes some untangling, see below), then
> the problem seems to go away. Here's the patch I tried on top of the
> current master, though I think it is actually the first hunk that is
> making the difference.
> 
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 0d9828e29e..779c5e2cb5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -359,13 +359,6 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
>  
>  		discard_cache();
>  		read_cache_from(get_lock_file_path(&index_lock));
> -		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
> -			if (reopen_lock_file(&index_lock) < 0)
> -				die(_("unable to write index file"));
> -			if (write_locked_index(&the_index, &index_lock, 0))
> -				die(_("unable to update temporary index"));
> -		} else
> -			warning(_("Failed to update main cache tree"));
>

Narrowing down to this does help. This patch seems to fix it to me. I
guess we have some leftover from the interactive add that should not
be there after we have written the new index.

diff --git a/builtin/commit.c b/builtin/commit.c
index 2be7bdb331..60f30b3780 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -432,6 +432,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
+			ftruncate(index_lock.tempfile->fd, 0);
 			if (write_locked_index(&the_index, &index_lock, 0))
 				die(_("unable to update temporary index"));
 		} else


--
Duy
