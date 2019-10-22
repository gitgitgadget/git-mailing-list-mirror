Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754F11F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 23:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfJVXgC (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 19:36:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38733 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732792AbfJVXgC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 19:36:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so17747219wmi.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wG05NeEZdQT2Qxu6qNuUk0OaiJf2oro5Xom4bSxHp5A=;
        b=XxP7oXi0Q2gy2AguHkv7Q9R20tDU6IL7VTJJxS7wfOmtz9ThDAhXOA3dUkpI4VYtF1
         6G2K0nZ2Bwelhz+qpjTk3Vga6URfqZfwreH74tL9J/3kAH/+raQy52TyrYqdm+N5eYU7
         SqCDa1FMBIwdyPwrkkPmPHC0PvRzW/JVJC70yyW5vQ7oIJ/GYbfO93GiViv3ovqjd3Pp
         LX3gk11GODvn+pk+rGaOgahxdRM+de+J4DTtzS5yFHTdMMnlcCU5hnY+JB8bGyMEj2UG
         34efDnKsSLLPraGFHx4GNlvyVtHrkudauMh7+Uyh3M3X50srqMeGrRInRGZP27+VlRxm
         ZKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wG05NeEZdQT2Qxu6qNuUk0OaiJf2oro5Xom4bSxHp5A=;
        b=HWQ04TaqGErTH/BTjPFBfGM6urg33c0PJT/NlA9TIUvr+vcKt0yO8i6RtGw+5fKYnz
         FdmtE3296lJ3fsA7N3GUBlNxH87l0fjRLVKdZpIpxfpCSCqV/uTtzhe2ps8PanJakxqo
         B0cP520i7tf3vYNyACeSfVcOIay6b2+pz0OSlpdD81fEvIa2SEK4rdzwkLUCegNKaOJd
         qB9OyZWcew2au1514O/WAhIYb6hoMkrn98GSMMTwLFRj4u1h52u1kqP2ZyYieQD9ytEw
         4XcgsRjrfTwi0i4woXrz8/w7WtJ3SWgu+J/RlBNUghM3ccwoSvbU+WBT/czJhpoiCJTs
         VqUA==
X-Gm-Message-State: APjAAAWHb/RZNnRO5ozJHowLuXutppaAFeuwPLV1lXhmKIg52w0wXxhQ
        wOf3ogsLqAmS5VBk+bs+4Dc=
X-Google-Smtp-Source: APXvYqwp1Jl71eGIbveFKUKANE0sJT4SSWJcteapxjcF7ONZpqOtnqzaJ9l+0nNbiu8igc1hTuCTHw==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr5032842wma.2.1571787359789;
        Tue, 22 Oct 2019 16:35:59 -0700 (PDT)
Received: from szeder.dev (x4dbe0456.dyn.telefonica.de. [77.190.4.86])
        by smtp.gmail.com with ESMTPSA id p12sm7471268wrt.7.2019.10.22.16.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 16:35:58 -0700 (PDT)
Date:   Wed, 23 Oct 2019 01:35:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix writing first commit-graph during
 fetch
Message-ID: <20191022233556.GF4348@szeder.dev>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <a1e5280d4b61a972426063574f1ea890a7dab73b.1571765336.git.gitgitgadget@gmail.com>
 <20191022203316.GC12270@sigill.intra.peff.net>
 <20191022214553.GA18314@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191022214553.GA18314@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 05:45:54PM -0400, Jeff King wrote:
> On Tue, Oct 22, 2019 at 04:33:16PM -0400, Jeff King wrote:
> 
> > > I have failed to produce a test using the file:// protocol that
> > > demonstrates this bug.
> > 
> > Hmm, from the description, it sounds like it should be easy. I might
> > poke at it a bit.
> 
> Hmph. I can reproduce it here, but it seems to depend on the repository.
> If I do this:
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ecabbe1616..8d473a456f 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -583,6 +583,14 @@ test_expect_success 'fetch.writeCommitGraph' '
>  	)
>  '
>  
> +test_expect_success 'fetch.writeCommitGraph with a bigger repo' '
> +	git clone "$TEST_DIRECTORY/.." repo &&
> +	(
> +		cd repo &&
> +		git -c fetch.writeCommitGraph fetch origin
> +	)
> +'
> +
>  # configured prune tests
>  
>  set_config_tristate () {
> 
> it reliably triggers the bug. But if I make a synthetic repo, even it
> has a lot of commits (thousands or more), it doesn't trigger. I thought
> maybe it had to do with having commits that were not at tips (since the
> tip ones presumably _are_ fed into the graph generation process). But
> that doesn't seem to help.
> 
> Puzzling...

Submodules?

  $ cd ~/src/git/
  $ git quotelog 86cfd61e6b
  86cfd61e6b (sha1dc: optionally use sha1collisiondetection as a submodule, 2017-07-01)
  $ git init --bare good.git
  Initialized empty Git repository in /home/szeder/src/git/good.git/
  $ git push -q good.git 86cfd61e6b^:refs/heads/master
  $ git clone good.git good-clone
  Cloning into 'good-clone'...
  done.
  $ git -c fetch.writeCommitGraph -C good-clone fetch origin
  Computing commit graph generation numbers: 100% (46958/46958), done.
  $ git init --bare bad.git
  Initialized empty Git repository in /home/szeder/src/git/bad.git/
  $ git push -q bad.git 86cfd61e6b:refs/heads/master
  $ git clone bad.git bad-clone
  Cloning into 'bad-clone'...
  done.
  $ git -c fetch.writeCommitGraph -C bad-clone fetch origin
  Computing commit graph generation numbers: 100% (1/1), done.
  BUG: commit-graph.c:886: missing parent 9936c1b52a39fa14fca04f937df3e75f7498ac66 for commit 86cfd61e6bc12745751c43b4f69886b290cd85cb
  Aborted

In the cover letter Derrick mentioned that he used
https://github.com/derrickstolee/numbers for testing, and that repo
has a submodule as well.

