Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B41B1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfBST7g (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 14:59:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33867 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBST7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 14:59:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so23440117wrg.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 11:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QDq57+RdOgsEfGLkOla5iNNETLHuK6CagP9znkeV8t8=;
        b=X5HKjKyrf2sUGF2HVPdnVLTgf4K3QWQ0U9gfqlZqW/S4c26H/e5i2xTsP61LXcHJng
         0bIyxE1s8iF4RI9XzuqPys1FsrT79d0aUz2HMAGPR3XiWehlGK0AXZSh04iw/SVYnGgq
         CsM6X83KS0fhGNq+J523ostdHQCfBKTxqmjReP4kDXeF8to+QIyKebd0Wjs21u+g6/b9
         mfeR9ADqvYFUsNPc3MTA0HzMaKIpOHlZtLocAZ6L6hp92pjORBBU+kuYKEdjCAVDDmmR
         Fp8NGVjKul0YLr6uCnF/7f0fWE+FYZfMxggQ1YQkXeBLeLiAM1s8Q2rDOvFMQSwyoRMd
         q6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QDq57+RdOgsEfGLkOla5iNNETLHuK6CagP9znkeV8t8=;
        b=eN5zNvsszEkqtwvkWzRR/uGcNTJGRw2qRZE9lL02/Br708DVPZL3h9nrBuIPsER/H9
         lU2/tLd5KX8bDjoTGjpxJO4LYY4bgpLA5WXKL/3qYX1/XGBNQoVuBdeWv6s8cls2FQzy
         +vlI967xmN13Ipx0oKCpO8ZArEwuOFmA3CfcyxJw+aw/eb071Dmbco8wjwXBaXZkyzv0
         7ahAvjm0zZxAZHY1ZjRaoCv7/cfw+AnBFbQAj9V4BVCaq4GqexiqVVSgJR0+/Jg7SzHy
         nuXAj2dR3YWuWABM3tIgAvVMam/0u8ejLNR1vpt6j6m06M5NZmqsMWys1a9mha3GKTZ5
         0uwQ==
X-Gm-Message-State: AHQUAua0VU2H23D1cd3U76vkVsldW4tlPpFokMvY0/fcgjEWKa1p4c58
        qZ4yxQNASO6lnqFySrJkBMA=
X-Google-Smtp-Source: AHgI3IZjCV4kDDvFurVCm/rKqjnCNcP5YzB628ECJ2wKO+lcFgK4wXR7ACXumE2wWv/piEfo/pEt8g==
X-Received: by 2002:adf:ee8e:: with SMTP id b14mr21157360wro.71.1550606373840;
        Tue, 19 Feb 2019 11:59:33 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b8sm3624059wmj.35.2019.02.19.11.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:59:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
        <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
        <20190208113059.GV10587@szeder.dev>
        <20190210221712.GA9241@hank.intra.tgummerer.com>
        <20190211011306.GA31807@szeder.dev>
        <20190212231837.GI6085@hank.intra.tgummerer.com>
        <20190219002336.GN1622@szeder.dev>
        <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
Date:   Tue, 19 Feb 2019 11:59:32 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 19 Feb 2019 11:47:51 +0100 (STD)")
Message-ID: <xmqqbm371rdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
>> > index c77f62c895..3dab488bd6 100644
>> > --- a/builtin/stash--helper.c
>> > +++ b/builtin/stash--helper.c
>> > @@ -231,6 +231,7 @@ static int reset_tree(struct object_id *i_tree, int update, int reset)
>> >  	struct tree *tree;
>> >  	struct lock_file lock_file = LOCK_INIT;
>> >  
>> > +	discard_cache();
>> >  	read_cache_preload(NULL);
>> >  	if (refresh_cache(REFRESH_QUIET))
>> >  		return -1;
>> > 
>
> So this is working, but it is not the correct spot for that
> `discard_cache()`, as it forces unnecessary cycles on code paths calling
> `reset_tree()` (which corresponds to `git read-tree`, admittedly a bit
> confusing) with a fully up to date index.
>
> The real fix, I believe, is this:
>
> -- snip --
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 2d6dfce883..516dee0fa4 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1372,6 +1372,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
>  			}
>  		} else {
>  			struct child_process cp = CHILD_PROCESS_INIT;
> +			discard_cache();
>  			cp.git_cmd = 1;
>  			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
>  					 NULL);
> -- snap --
>
> And the reason this is needed: we spawn a `git reset --hard` here, which
> will change the index, but outside of the current process. So the
> in-process copy is stale. And when the index' mtime does not help us
> detect that, we run into that test breakage.

In non-patch mode with pathspec, there is an invocation of "apply
--index -R" of a patch that takes the contents of the HEAD to what
is in the index, updating the on-disk index and making our in-core
copy stale.  Wouldn't we need to do the same?  Otherwise, the same
"reset_tree()" you are tryhing to protect with this discard_cache()
will call read_cache_preload(), no?

Among the calls to reset_tree() in this file, I think the one that
follows the "reset --hard" (your fix above) and "apply --index -R"
(the other side of the same if/else) is the only one that wants to
read from the result of an external command we just spawned from the
on-disk index, so perhaps moving discard_cache() to just before that
call may be a better fix.



