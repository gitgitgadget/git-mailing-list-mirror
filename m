Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E3A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbfCYMDB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:03:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34169 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730605AbfCYMDB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:03:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so9835681wrq.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3WYviVIr01Z+srjK7ETIk+5zkQjvFvEx94yZg1/IWYI=;
        b=P2Xfura8vN+KYQDYJil/Rfni0F7FdEv1Yq/uG7483TN4IhuWCaFzbDiJrJpk+gO+fh
         WXLT7cvVY3nIq1KtvhIKErYII7J6gyskAPMoFWNGKO+7T/Y46QSE3BorBipUhh2yFIk1
         0I8/S4LtUHJWUEw2Ctwlwi/n9/9REpOgHDvMrmeUJ+snw6PCv0WJigQoBHv4Myzsyxvb
         /nMG2+HeoF5cCeqWpdDyEv4uMj6JisHTjcBRxQaq9xN6HAjC3+3z6y1GGqdHOvCZv5Pd
         msY/RD+MeXu956JKhMVZjRQO85qx5zw5OhpaROG9i0UPNkjqc3SeakWKs8Zr390TQx8E
         cEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3WYviVIr01Z+srjK7ETIk+5zkQjvFvEx94yZg1/IWYI=;
        b=X0kEJy8hwxRvr6wQJv/fB65YboPDJcapF5osqvLuYJXw1ZSDVUclVkLjQDNGBhOvi0
         GbMX+HsLB006XSXwfPtTdvq4zu8GOtfLGJYFQsgekM9Igbzl73o6xhtRCAqx/G9Dqiyk
         7UpXQAJnY3mmHLK5jEUOrWjKshNeibezXmQyvah3H3dA3JS8aQWihRuW+AGA6qb6Txme
         ma6E1cadHxlmdhQqWi3GGgxBhVntehkIgtGTPDkUD/Lii0WVDPqNcYBaoexNq57WTIzo
         AB4foWo2/OGI1A0JR9kB57Xf1P0WUiu5kPfskhyA6BnUYaJIXdbkY8iS5+L0pnP7GgT7
         kmjA==
X-Gm-Message-State: APjAAAWSW/XRmRqdH45MNthPio6bX3r01c/3cysI/1bdOIiUfhrrG1Hw
        kVeO7VkhRJfb4A68BvqnEl2E4Tg9
X-Google-Smtp-Source: APXvYqxKasxUSlefNobGA5QpH+l9g1nxZzABgO6uZI7s4Lbm4CT7hB4SnR7sDm6iN4bO2ofPQP935Q==
X-Received: by 2002:adf:e683:: with SMTP id r3mr3223943wrm.286.1553515379705;
        Mon, 25 Mar 2019 05:02:59 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s12sm15076274wmj.42.2019.03.25.05.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 05:02:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] commit-graph: fix sparse 'NULL pointer' warning
References: <1908832c-8dd0-377e-917b-acb33b00273c@ramsayjones.plus.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <1908832c-8dd0-377e-917b-acb33b00273c@ramsayjones.plus.com>
Date:   Mon, 25 Mar 2019 13:02:58 +0100
Message-ID: <871s2vcgb1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 23 2019, Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi =C3=86var,
>
> If you need to re-roll your 'ab/commit-graph-fixes' branch, could you
> please squash this into the relevant patch (commit aeb244adbc
> ("commit-graph: don't early exit(1) on e.g. \"git status\"", 2019-02-21).

Thanks. Will squash & re-submit. It's still just in "pu". Is there a
compiler that warns about it? Didn't on clang/gcc, but then again it's
just-as-valid-C & just a style issue, so compilers don't care...

> This same commit (aeb244adbc) also removes the last call, outside of the
> commit-graph.c file, to the function load_commit_graph_one(). So, this
> function is now a file-local symbol and could be marked 'static'.
>
> Also, the function verify_commit_graph_lite(), introduced in commit
> d8acf37ff7 ("commit-graph: fix segfault on e.g. \"git status\"",
> 2019-02-21), currently has no external callers. This function is also
> a file-local symbol and could be marked 'static', unless you have plans
> for future external calls?

Fixing these too. Just missed them. Thanks.

>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 4696ee0036..680c6f5714 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -100,7 +100,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int =
fd, struct stat *st)
>  	if (graph_size < GRAPH_MIN_SIZE) {
>  		close(fd);
>  		error(_("commit-graph file is too small"));
> -		return 0;
> +		return NULL;
>  	}
>  	graph_map =3D xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	ret =3D parse_commit_graph(graph_map, fd, graph_size);
