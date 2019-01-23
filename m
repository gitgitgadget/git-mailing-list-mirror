Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B61E51F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAWXjX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfAWXjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id p7so4549826wru.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=HhAgoYILuQw59+zAnviv3NCjXryTwbOFKv+dWBicu1s=;
        b=gEOw13pvOsB7dLt8NfYkO3NFAuszuGPQWREO00tQBTkBhorr0u+cDepRs+Gz/Q4XDs
         L872A+wRDl3o4ka98CZNbauJK1fMzuVfu+zl7ls1AijRJnWtL2g7/EmZmC94Ehqwy+YD
         0wnoQJ0905u3pysLDUxcwGb23/xogNAzG5mHnPVMsR5vTdxyvt5UkKvueB6GsNBNRpWx
         VuNKMXROOlr7a4QaIVtXA0Jo5Cwk3whRRfNdOdoWWd79MH1mPiGO5n/4mjow6eiCo1fv
         BwGOXhLONwBbeiHvf0CHhBqI0ViKy8BxWROqzusylwzfSVv3twR1lrot0XMSx7TGE/Mu
         dQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=HhAgoYILuQw59+zAnviv3NCjXryTwbOFKv+dWBicu1s=;
        b=tFoZWxUlvGMPvHCLlXaCKUWMsmydaP7FZGwHQrlwfDbzFFGa0ww78fw5vs31S+/+2N
         QM4594JJL3OhfSD9hGUG69eMQAy7to3xHH2Na9vCxui7wK6osrZevESVmGKptFDe2+LX
         ADqFwW/ImlRphm5lnji1pLjhbhfIDBe+q89e1ouIKQ28HfN1HBqjgawr8451XknO18cg
         0Ye8OkAqJtcJL4bKomlGFScxrdAu4cVmxfDoX+iSXVrx8bU2DN28X8XVZTnUAOCT6CYm
         OYxZB5z1pAPwXYCY2rMMxCsXEXlLmpfvYNYmaMKOtE1jgjBdDbSTg+VFu2+zfxqRqSZK
         QLoA==
X-Gm-Message-State: AJcUukeau++/tyNnEXm2NN/eDyg7qFiUUzpw1JiXc7OII8FzHhChqgKf
        8cYHfddQfFG/cYfaCzpfBrAQCl7v
X-Google-Smtp-Source: ALg8bN5jBCPqMY5jWmQBLphD08iKBfP4nuRVyHTfyZWHSUZw010gqgutQhl3dgg3d/BElK/t1SY8Bg==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr4553576wrt.43.1548286756177;
        Wed, 23 Jan 2019 15:39:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p12sm58922530wmi.5.2019.01.23.15.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 20/21] ci: speed up Windows phase
Date:   Wed, 23 Jan 2019 15:35:00 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <6520f4603c78d38f5168164218dc108833a5583d.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqqva2f3pwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As Unix shell scripting comes at a hefty price on Windows, we have to
> see where we can save some time to run the test suite.
>
> Let's skip the chain linting and the bin-wrappers/ redirection on
> Windows; this seems to shave of anywhere between 10-30% from the overall
> runtime.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  ci/lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 91cf1402bf..e1d5222ceb 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -43,6 +43,8 @@ then
>  	BREW_INSTALL_PACKAGES=
>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> +	test windows_nt != "$CI_OS_NAME" ||
> +	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"

A clever and clean workaround.  Looks good.
