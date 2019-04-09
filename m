Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B414220248
	for <e@80x24.org>; Tue,  9 Apr 2019 23:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDIXnF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 19:43:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDIXnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 19:43:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so345302pgq.1
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 16:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iuQ1SPbyBqpg60Elw+cnZIKM0WtIvQmdSHYqnD7OXR0=;
        b=cE99ndb7vatcntQjVGSaiQs3PlQy2RfbeVujPuuuvrwBteXlgVQEHr5eF2SI23yFTx
         5EYRgXXCq3/jbNLHNIR0Ib4lffQensyh2yWJ6FZoObxwPZI2flQL7KGBcpIelsZtoBcM
         nKs2LK0ADRfiEt/WFwaNjfJFy0fsi1+oS3jgKOa8RJl6U1YNY7pYBjTe8c+BWmEYWyVe
         MmuzWbPsF7ZYiuLhCrefx6eR46nUOE2Rj4GSxi4EHWcHMYucSwsnjwF+M0NWuyQiUCrt
         iWuj+1FphiHn8GyQR7fxwzvQBwbo3xUvTqcapZg3hovR14PFYTKkJgU8d17g5g/3V4st
         8a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iuQ1SPbyBqpg60Elw+cnZIKM0WtIvQmdSHYqnD7OXR0=;
        b=f/5Yt/k3thLmUVgY5NhBWsc7h6n8gerzrqfo72UKybUY4+obwI4efAVYCnHFav3jCL
         oVPQpNgWg1k9urvvED3kWBZA/uwmSeJzX+gay5iNW4Eyep45ckEhREho7K8yD+XFM/n2
         vhDysNga4J6MqkLDa5Dc5GXw/5PEFDGQ/kfnSbwcIZ8TSLDVyN3PEh855KQJHUmfNHlK
         yW5tdE15PqOu7T2vLliiF8BRCIBfdrPEgotMtylS9S0Dmwsw/9R9VK+0K4bi2GFFfYF1
         VcVKJTetEd7YpckwTW5nWTlZqceJ1AxoRt1G+5zyDUIu9qLLIvSjeq0lzzmF+x/i1KiI
         XCQA==
X-Gm-Message-State: APjAAAVKmQuxLgHSJBgpYsdwOAZx4PrEcc4ZCdwYIAZtAMGKhqR/V4Ns
        ytcq2Gu+xgn2W725g29pmXXx/BDRz7Ot2Q==
X-Google-Smtp-Source: APXvYqweSUEb3t85ScQIfFBl2ZzoswEm3spAbDlD6KmFrppkKRvRPagMn+2Zj7aw5NmuwIShJPhhZA==
X-Received: by 2002:a65:6295:: with SMTP id f21mr34853142pgv.129.1554853383943;
        Tue, 09 Apr 2019 16:43:03 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id g73sm61561039pfd.185.2019.04.09.16.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 16:43:02 -0700 (PDT)
Date:   Tue, 9 Apr 2019 16:42:55 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190409234255.GM60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
 <20190409180418.GH8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190409180418.GH8796@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.04.09 20:04, SZEDER Gábor wrote:
> On Mon, Apr 08, 2019 at 02:06:04PM -0700, Josh Steadmon wrote:
> > For large repositories, enumerating the list of all promisor objects (in
> > order to exclude them from a rev-list walk) can take a significant
> > amount of time).
> > 
> > When --exclude-promisor-objects is passed to rev-list, don't enumerate
> > the promisor objects. Instead, filter them (and any children objects)
> > during the actual graph walk.
> > 
> > Remove the mark_uninteresting() function as it's not used anywhere else.
> > 
> > When testing against a large repo [1], this patch reduces the
> > connectivity check runtime from 3 minutes to ~7 seconds.
> 
> This patch breaks test 'repack -d does not irreversibly delete
> promisor objects' in 't0410-partial-clone.sh' when run with
> GIT_TEST_COMMIT_GRAPH=1.
> 
>   +rm -rf repo
>   +test_create_repo repo
>   +test 1 = 1
>   +repo=repo
>   +mkdir -p repo
>   +cd repo
>   +/home/travis/build/git/git/t/../git init --template=/home/travis/build/git/git/t/../templates/blt/
>   Initialized empty Git repository in /home/travis/build/git/git/t/trash directory.t0410-partial-clone/repo/.git/
>   +mv .git/hooks .git/hooks-disabled
>   +git -C repo config core.repositoryformatversion 1
>   +git -C repo config extensions.partialclone arbitrary string
>   +git -C repo commit --allow-empty -m one
>   [master (root-commit) 71905df] one
>    Author: A U Thor <author@example.com>
>   +git -C repo commit --allow-empty -m two
>   [master 202c4a3] two
>    Author: A U Thor <author@example.com>
>   +git -C repo commit --allow-empty -m three
>   [master 4737577] three
>    Author: A U Thor <author@example.com>
>   +git -C repo commit --allow-empty -m four
>   [master d6ba7e0] four
>    Author: A U Thor <author@example.com>
>   +git -C repo rev-parse HEAD^^^
>   +ONE=71905dfcd543b7cbb0b4b66fbd20379e67220557
>   +git -C repo rev-parse HEAD^^
>   +TWO=202c4a3dd9a2dac927f056abb747cce9ea2eb67b
>   +git -C repo rev-parse HEAD^
>   +THREE=47375779ebcca4b422e3afdd14aa37a358081297
>   +pack_as_from_promisor
>   +printf 202c4a3dd9a2dac927f056abb747cce9ea2eb67b\n
>   +git -C repo pack-objects .git/objects/pack/pack
>   +HASH=2e675cd706e508d6c52a21d28cfcddde5ec02a06
>   +
>   +echo 2e675cd706e508d6c52a21d28cfcddde5ec02a06
>   2e675cd706e508d6c52a21d28cfcddde5ec02a06
>   +printf 47375779ebcca4b422e3afdd14aa37a358081297\n
>   +pack_as_from_promisor
>   +git -C repo pack-objects .git/objects/pack/pack
>   +HASH=31f7d2797549ab9b1c425a9e60eb2030481170e5
>   +
>   +echo 31f7d2797549ab9b1c425a9e60eb2030481170e5
>   31f7d2797549ab9b1c425a9e60eb2030481170e5
>   +delete_object repo 71905dfcd543b7cbb0b4b66fbd20379e67220557
>   +sed -e s|^..|&/|
>   +echo 71905dfcd543b7cbb0b4b66fbd20379e67220557
>   +rm repo/.git/objects/71/905dfcd543b7cbb0b4b66fbd20379e67220557
>   +repack_and_check -a 202c4a3dd9a2dac927f056abb747cce9ea2eb67b 47375779ebcca4b422e3afdd14aa37a358081297
>   +rm -rf repo2
>   +cp -r repo repo2
>   +git -C repo2 repack -a -d
>   warning: reflog of 'HEAD' references pruned commits
>   warning: reflog of 'refs/heads/master' references pruned commits
>   fatal: unable to read 71905dfcd543b7cbb0b4b66fbd20379e67220557
>   error: last command exited with $?=128
>   not ok 23 - repack -d does not irreversibly delete promisor objects
> 
> 
>   https://travis-ci.org/git/git/jobs/517874310#L5822
> 

Thank you for catching this. I haven't yet figured out the cause. I will
look into this more tomorrow and then send a V4 once I've fixed it.
