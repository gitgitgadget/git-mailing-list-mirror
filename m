Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C95320966
	for <e@80x24.org>; Mon, 10 Apr 2017 17:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdDJRR3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 13:17:29 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35483 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdDJRR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 13:17:27 -0400
Received: by mail-pf0-f176.google.com with SMTP id i5so36297526pfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Nfc/KI02LyAcKGACTlT2P9LlymdWJZJvyWvAJHuaMK8=;
        b=RYv6kLlVyiL+yzcvl7Wg1adsMrLm/K+SK3qU8IJ55Fob4aErZfi2ltFwoji/AomFsZ
         zdhXUbkdLuXmr5IQJHqYC8tC7iMlURGwwnLwS7dwC+MEJyBGH/iL7IbiUfIaHcaOxIB7
         biC9L9ua4m/VPmujwHXdg6RUqmWvfMkjVacVTf/HczgUAIXmx8EnrAv8BKiavpwov5q6
         gEBIMnvzq0H9+BGmOfJMNSM4+SG7wUfOBxwvdcgMC46QqatDwNytgQhBhye1EEmglyAl
         bRNCUimMOy663DGaITd6CaMtyh1YqnkB1erqweFkkPCNYGWWlnwsgXD64dp/mcMafQNI
         ChRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Nfc/KI02LyAcKGACTlT2P9LlymdWJZJvyWvAJHuaMK8=;
        b=V46NJtGMvGpJLmsmnPF25ua7q5HzmQZYByrEDr0Jqit2ApWtxO9yTwd3JOj46Ja5q/
         S6qEbBqGeReLP0iTFrP5PsE7z6BTDK0eoeeF6MGNULQeT94lV+1qHK0i1SHkyp3KPktv
         5eu5mm4fDgVj62IYykMUjSTBsSoi/SXLIanO0KrkEzCDf4hdYq0eFkjtDxVzjmGdyCoX
         mKjhKMz/GJihvNunOHL/Dtx5z8xVPvursZ9MmIXm5ox7L1MSEPx4gRoQiJU1yY8R4O9e
         P4K64TtuLduqpXppaTtFdru3K6kFFEJxPD1+5I+MfksOr2t11NUs+Op8YVQ3TTlaIMvC
         VL7w==
X-Gm-Message-State: AFeK/H2MTGFHM9KlLeWIbsloJYDrfvjHq1WDPWwV6yaeS6MWgXKGYOAS8wNrmnsDib4lLCod
X-Received: by 10.98.30.3 with SMTP id e3mr54938274pfe.48.1491844641864;
        Mon, 10 Apr 2017 10:17:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:7450:6439:e616:4b64])
        by smtp.gmail.com with ESMTPSA id m20sm25883555pgd.32.2017.04.10.10.17.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 10:17:20 -0700 (PDT)
Date:   Mon, 10 Apr 2017 10:17:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: plug a trivial memory leak
Message-ID: <20170410171719.GB113751@google.com>
References: <20170409195900.32701-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170409195900.32701-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09, Ævar Arnfjörð Bjarmason wrote:
> Change the cleanup phase for the grep command to free the pathspec
> struct that's allocated earlier in the same block, and used just a few
> lines earlier.
> 
> With "grep hi README.md" valgrind reports a loss of 239 bytes now,
> down from 351.
> 
> The relevant --num-callers=40 --leak-check=full --show-leak-kinds=all
> backtrace is:
> 
>     [...] 187 (112 direct, 75 indirect) bytes in 1 blocks are definitely lost in loss record 70 of 110
>     [...]    at 0x4C2BBAF: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>     [...]    by 0x60B339: do_xmalloc (wrapper.c:59)
>     [...]    by 0x60B2F6: xmalloc (wrapper.c:86)
>     [...]    by 0x576B37: parse_pathspec (pathspec.c:652)
>     [...]    by 0x4519F0: cmd_grep (grep.c:1215)
>     [...]    by 0x4062EF: run_builtin (git.c:371)
>     [...]    by 0x40544D: handle_builtin (git.c:572)
>     [...]    by 0x4060A2: run_argv (git.c:624)
>     [...]    by 0x4051C6: cmd_main (git.c:701)
>     [...]    by 0x4C5901: main (common-main.c:43)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Since pretty much any non-trivial git command leaks because it skips
> cleanup are patches in this category even accepted? Worth a try...

Some may argue that the program will terminate soon and that the leak is
bounded etc., but I think that plugging leaks is a good thing.  As such,
I like this patch :)

> 
>  builtin/grep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 65070c52fc..3ffb5b4e81 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1299,6 +1299,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  		hit |= wait_all();
>  	if (hit && show_in_pager)
>  		run_pager(&opt, prefix);
> +	clear_pathspec(&pathspec);
>  	free_grep_patterns(&opt);
>  	return !hit;
>  }
> -- 
> 2.11.0
> 

-- 
Brandon Williams
