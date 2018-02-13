Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B0A1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 22:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966003AbeBMWi4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 17:38:56 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37933 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeBMWiz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 17:38:55 -0500
Received: by mail-pg0-f65.google.com with SMTP id l24so932131pgc.5
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 14:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfBmDXOufAjo4iE7MJaT/J3VwBoP5ecs+Dj9gyuVemY=;
        b=RpkFpFo0Sg1urGsfqxomAHDU275Imc8hJ+KKedLf2zK1XPDGrfduzokGVVWS6CrOpX
         /yyQPa4GI1NhQoxeRyhzWssxQhibdEJcOyqyNrnt1nnIYVzl0U0tuzD0TqEj3+B/6nVQ
         6/dILqWdNNrLlAOLyuRqceobO5RdQmxXy3QUBiz2fbA3s3ZhU+feLX8CVw1Tvknoo+Mf
         GxldsoG6xXwRPHqWlno2yJScYEQNvMYQbKMx50ypWmUoUqL5Zznm1SBwX7ed+EkjmbTT
         41AazYa7APiDlmyKTfxc6226J6QHTwBSaI3xpBCqORs1iCIzYUgf9vBO1ucuR0PguUkN
         WjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfBmDXOufAjo4iE7MJaT/J3VwBoP5ecs+Dj9gyuVemY=;
        b=G97rc7brbazQ4j9PqID26v4QgP5LFRcxQ0Sk1aIj2Ns+/UCDird7UjEqDBpjZWTnRW
         LOd/cVNJLTMjNcN9qqm2LuLTF9xQDHl4yjOA+8zei/Nb+PdqJm/uoAB6e86Y8Epyh4F4
         DauHErPG+u77TM6kUt5jmnl4diRvMFAYOJc+zanQdcqrb6sBJRYI7THAe3c15LpssKF3
         ZdR6yoCPWdjVzLz9Ov4P/3keRHbxX65dZIFUaPKhDrpUm4kuO7oeDdre4ydF+wPGA2Fi
         pMtoHC8HTFsFU8CuUVqq4yTSojuAgnyqkIMtJ+M7PIrvM0+KCRvPeDai8S1V/gdK1BfX
         UDbQ==
X-Gm-Message-State: APf1xPBC6NLrWHOB8w2t1X6GNrsZyNM1yTbKjxku3i0QW/i65do0R/JU
        asHdqZYfm8wVdhwsS6fyAXChOLuqIXk=
X-Google-Smtp-Source: AH8x225YN6E1AoUESbyysgTd4XcR1hJAs9bt55F6Z14nfKqqNdhtwKXJ06j3g3c0C4/1elGckcEDSA==
X-Received: by 10.98.137.213 with SMTP id n82mr2664739pfk.175.1518561535153;
        Tue, 13 Feb 2018 14:38:55 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p14sm25441655pgu.7.2018.02.13.14.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 14:38:54 -0800 (PST)
Date:   Tue, 13 Feb 2018 14:38:53 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 07/14] commit-graph: update graph-head during write
Message-Id: <20180213143853.00cbd0fd2a17131beb2e08b7@google.com>
In-Reply-To: <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  8 Feb 2018 15:37:31 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> It is possible to have multiple commit graph files in a pack directory,
> but only one is important at a time. Use a 'graph_head' file to point
> to the important file. Teach git-commit-graph to write 'graph_head' upon
> writing a new commit graph file.

You should probably include the rationale for a special "graph_head"
file that you describe here [1] in the commit message.

[1] https://public-inbox.org/git/99543db0-26e4-8daa-a580-b618497e48ba@gmail.com/

> +char *get_graph_head_filename(const char *pack_dir)
> +{
> +	struct strbuf fname = STRBUF_INIT;
> +	strbuf_addstr(&fname, pack_dir);
> +	strbuf_addstr(&fname, "/graph-head");
> +	return strbuf_detach(&fname, 0);

NULL, not 0.

> +}
