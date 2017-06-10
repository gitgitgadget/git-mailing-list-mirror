Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE611F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbdFJBdp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:33:45 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34117 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdFJBdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:33:44 -0400
Received: by mail-pf0-f182.google.com with SMTP id 15so6081362pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Abt7++teq8Fg4BHYZNlATAvm6SvFdnQ/xKbX9/ziATc=;
        b=bim6RDlnCqayMw0avpDwaL7a730HcpmyHtCCSp059OCsvUnLBl2cMw0jg/GAvtGIdH
         gteXqPNXyp7r8fdSrvvRmqdhWT//uawf/WN/2OJ6LPooXO1902H7COWTbtBbKJ4LZxxL
         eftxvjb6fzxcJvMlHZC5Z4TZ3DNjWRlXV0/otJGU8XzbLiHJIKwXWpbpdgZBm68ODQCs
         6ATWhRNgBHfZDptntcwNlfBxZXNwawJNgXX4pV4Kor16pJDYoot/WhFYK2U82pkxoFEH
         zueXwIPnv2FubgCyL/nvQ0OS6k9SYaiUjiN5qd/cajs6G7DEF3JgfXe0zmNM1C8qIdjg
         y71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Abt7++teq8Fg4BHYZNlATAvm6SvFdnQ/xKbX9/ziATc=;
        b=kiDhct2cNZ/OZkqjvyXOhCHdWdZdDdvGDKSRib3b/pDOQZESN4PvR8Zg4cjxOFmM/I
         xTtISyPTV9BlvuqU+hA35uGiP4V/4PqAFNvnacLiB+nPNgGGu5Z4ssXVoKyDyaZnZUTV
         XMewpgHEE+nsVsW+NdUtw9CACjjRgU5q3pchKJ84BhZnE9DuQUoaIHkqeZLW1BGe+hPE
         eiuk87mrY6rMovfQgF41lLa7LxquVolmBBOef3JWJILxvsepnvCpmjuaCjwsveD9jUhp
         w8x6kwcjCAiPyZ/21BCay9sMJ57D7F7gNXm5cpwUVE0yQE0ZD2JpBxzQu7AHCzfDTanc
         s6oQ==
X-Gm-Message-State: AODbwcB6Vmxp4MLPj1ugpXJqKWQ90Z209PQMH4s99DBS7QCjbXZCFIVI
        5l68Ko/18u2SISho19w=
X-Received: by 10.99.122.13 with SMTP id v13mr39185256pgc.98.1497058424025;
        Fri, 09 Jun 2017 18:33:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id w67sm5117473pfi.2.2017.06.09.18.33.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:33:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] Use the early config machinery to expand aliases
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
        <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
Date:   Sat, 10 Jun 2017 10:33:42 +0900
In-Reply-To: <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 7 Jun 2017 18:07:03 +0200
        (CEST)")
Message-ID: <xmqqa85g62yx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> -static char *orig_env[4];
> -static int save_restore_env_balance;
> -
> -static void save_env_before_alias(void)
> -{
> -...
> -}
> -
> -static void restore_env(int external_alias)
> -{
> -...
> -}
>  
>  static void commit_pager_choice(void) {
>  	switch (use_pager) {
> @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  
>  static int handle_alias(int *argcp, const char ***argv)
>  {
> +	struct strbuf worktree_dir = STRBUF_INIT;
>  	int envchanged = 0, ret = 0, saved_errno = errno;
>  	int count, option_count;
>  	const char **new_argv;
>  	const char *alias_command;
>  	char *alias_string;
> -	int unused_nongit;
> -
> -	save_env_before_alias();
> -	setup_git_directory_gently(&unused_nongit);
> ...
> @@ -308,8 +265,6 @@ static int handle_alias(int *argcp, const char ***argv)
>  		ret = 1;
>  	}
>  
> -	restore_env(0);
> -
>  	errno = saved_errno;

The save/restore sequence was an unnecessary hassle, and being able
to do this without chdir'ing around is really nice.

Thanks for working on this.
