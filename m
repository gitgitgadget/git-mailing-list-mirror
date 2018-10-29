Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7A21F453
	for <e@80x24.org>; Mon, 29 Oct 2018 05:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeJ2OGN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 10:06:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42882 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbeJ2OGN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 10:06:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so7181173wru.9
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 22:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uEAJRLILWudwu5SGgN+IzFedW/6bTVY1Wi0diCoRT6w=;
        b=FYuJuTdB5m18jhZKlEi0jk5P0bqAF1xYvF2TUDrD+TeKXSkkh8wLUETTbANnIULTa0
         zFYymwc93EdQb4hj8Akb4guR7VImTNt0ZBZrOzvms8i0Xs3Iu8WTnpd/d8QIqSWRh6r5
         vjk+pOX7cWbbSyGDKTFMvUGCDbSw5FNDqqu7fTh/HgN3IaVG197NK97fPUsqgC/ZQaLP
         woPEaPsXXFy1lg74CHZeyt5Po8Q1YKtp5Q3U9sXVfiv9bM/PSgMSspYXoCtnLjxEMdNq
         3YjTEvXOQCQyAhNqKGxDFXHW6XiGJl5BMzo0RsdCzaFSUID0ZzDWdo/R/qtnh/ka9Jr5
         8cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uEAJRLILWudwu5SGgN+IzFedW/6bTVY1Wi0diCoRT6w=;
        b=dZUalCO2Q268w2Q8qEWgiqmtuqI7b/mA+5I15w4sH9JSCkWAbJ44lx5aE1YJYLMT2L
         V1SqcMmwdPX28IC8Hn2QbWvfjmKGKO9ekhZB6r42jGjjKH9593An1lzkm67z7LOT3yWM
         tdr3BxHWgHcb5A6pA+ROyIZfh8c1JVmjz4RGy/j83uBK1430hv2VTKklCoLaRtZjek0g
         O+OoFtMupNvZmR3Gr2CkyNjifo/OgZpsGK6+GVccZdbrDIhF1U+1NvEoDV9p8cWrPsRt
         OSq9SQERZ4kx+GBhd6QJW91a1XgchUnwoF5Gsh2gCmvRYwFnnDv/9NT+dr3gvi6cZnAa
         T9Ew==
X-Gm-Message-State: AGRZ1gIZvr/QzDk4Hbw8HRlCfij483jUgRYmSgCbLOgwRP/BRtTUrsUN
        VH+Yx2nERCbS4+BlGEciZE0=
X-Google-Smtp-Source: AJdET5f/R+9eHxhOH8Q3j/dUsd4pLMSc6GD3fhL0Ka6bk4KkTZfDFTt9xFk+tlWW+vr5bgk/Zk0JEQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12-v6mr938786wrm.67.1540790347440;
        Sun, 28 Oct 2018 22:19:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c21-v6sm11461872wmh.26.2018.10.28.22.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 22:19:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 6/8] push: test that <src> doesn't DWYM if <dst> is unqualified
References: <20181026192734.9609-1-avarab@gmail.com>
        <20181026230741.23321-7-avarab@gmail.com>
Date:   Mon, 29 Oct 2018 14:19:05 +0900
In-Reply-To: <20181026230741.23321-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 26 Oct 2018 23:07:39 +0000")
Message-ID: <xmqqr2g949fa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a test asserting that "git push origin <src>:<dst>" where <src> is
> a branch, tag, tree or blob in refs/remotes/* doesn't DWYM when <dst>
> is unqualified. This has never worked, but there's been no test for
> this behavior.

"has never worked" sounded as if there is a breakage, but that is
not what meant here.  We didn't DWIM overly agressively (which would
have led us to possibly push into a wrong place) and correctly
rejected the push instead, right?

> +test_expect_success 'refs/remotes/* <src> refspec and unqualified <dst> DWIM and advice' '
> +	(
> +		cd two &&
> +		git tag -a -m "Some tag" some-tag master &&
> +		git update-ref refs/trees/my-head-tree HEAD^{tree} &&
> +		git update-ref refs/blobs/my-file-blob HEAD:file
> +	) &&
> +	(
> +		cd test &&
> +		git config --add remote.two.fetch "+refs/tags/*:refs/remotes/two-tags/*" &&
> +		git config --add remote.two.fetch "+refs/trees/*:refs/remotes/two-trees/*" &&
> +		git config --add remote.two.fetch "+refs/blobs/*:refs/remotes/two-blobs/*" &&
> +		git fetch --no-tags two &&
> +
> +		test_must_fail git push origin refs/remotes/two/another:dst 2>err &&
> +		test_i18ngrep "error: The destination you" err &&
> +
> +		test_must_fail git push origin refs/remotes/two-tags/some-tag:dst-tag 2>err &&

This made me go "Huh?  some-tag is one tag; what is the other tag in
two-tags/ hierarchy?"  I think you meant by "two-tags" a hierarchy
to store tags taken from the remote "two"; calling it "tags-from-two"
may have avoided such a confusion.

> +		test_i18ngrep "error: The destination you" err &&
> +
> +		test_must_fail git push origin refs/remotes/two-trees/my-head-tree:dst-tree 2>err &&
> +		test_i18ngrep "error: The destination you" err &&
> +
> +		test_must_fail git push origin refs/remotes/two-blobs/my-file-blob:dst-blob 2>err &&
> +		test_i18ngrep "error: The destination you" err
> +	)
> +'
> +
>  
>  test_done
