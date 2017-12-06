Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006A920C32
	for <e@80x24.org>; Wed,  6 Dec 2017 22:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdLFWA7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 17:00:59 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:36055 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbdLFWA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 17:00:58 -0500
Received: by mail-it0-f51.google.com with SMTP id d16so9852698itj.1
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 14:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jRS4O3ekBhI9A8LVzcz/ODiAbjFQjA0gyct3WgncIRw=;
        b=I6iSkcrHoS7kMpij4TclYsg/pIDZcQuHdFxEbJWxBljyPnh4TCNxuJzLFfZjfMpfoC
         8v8phjXtCgo+latlNzloJsX45WU1rE/Tlw0sVo0T6lJesmi+Xb4ITwc3k0V55YDJFzFl
         DYA+Anhcd8Gl4YO12V3RS0OKxdRvsiLKmSfWGzNmcGOj2cr6qU0OUpEBj58GZkZVPJp6
         H5YZG8HQYBNY+DHh4z/5VEaTX8UZYbB7UWEsnkGPM4KpId7pCrlWMwQzLMD2VP0IVIoC
         SQXkoCFW/0pmuEDbvf97+vbQ8MuvO4n8MJEpsC6BREAEJo7wjvFswYzZagkYHsSvVzqY
         333g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jRS4O3ekBhI9A8LVzcz/ODiAbjFQjA0gyct3WgncIRw=;
        b=AQMWvNNcnOwzGZMMuCjDrspxd49zdbD1HVC1Fjv3yhsUEq9D7T+KhbdmwFSzC+751v
         gk30JwfJwgru4ggZ4kx9XzgvZRe78hAIJWFEkSPWbjA/7DmPNpuv+iWnHX0zw62ODwpH
         fUmXt1DBj4WArDir4EP+d5Gmc/xACBiiOub3CVSizfZsSQmAfEG5Yqqv3E3BddBq6oUT
         q8yEo9KTwVi+dqhN3fotBTu7bmrvivBLs1bm2SLt+h6d/PGAofOSf1rvRriMrivpf4RX
         y3NaWGT2DyrB5ln9bnpNnUPKrj8JaoOumXIqDTIYMJztd3Z2hxtig3xzDthVKXImyBzb
         aEjg==
X-Gm-Message-State: AKGB3mIXP/e78iC2L4/2ODYCoBax9EhYkYJDL0P1Pl6zs/Sf2Mw6oU1m
        jNFvV2yK0HLJK5pdQDScIG1aefCFADc=
X-Google-Smtp-Source: AGs4zMY41DTPUnPyRUTFs4lx2auXJ54+ihhbFLYMlMWza5bYlQ+5OIsH8slSJUiAGzRZnbcd5ggwYA==
X-Received: by 10.36.19.10 with SMTP id 10mr23363971itz.94.1512597657430;
        Wed, 06 Dec 2017 14:00:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:1db0:e823:6c98:b5e2])
        by smtp.gmail.com with ESMTPSA id r95sm193345ioi.49.2017.12.06.14.00.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 14:00:56 -0800 (PST)
Date:   Wed, 6 Dec 2017 14:00:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, ben.boeckel@kitware.com
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
Message-ID: <20171206220055.GB118027@google.com>
References: <20171205194801.GA31721@megas.kitware.com>
 <20171205221337.140548-1-bmwill@google.com>
 <CAPig+cS6zf3AvQVi7PZf=ignL-7JZKzYUyN9RoJSPZzL=Dj7FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cS6zf3AvQVi7PZf=ignL-7JZKzYUyN9RoJSPZzL=Dj7FA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Eric Sunshine wrote:
> On Tue, Dec 5, 2017 at 5:13 PM, Brandon Williams <bmwill@google.com> wrote:
> > A regression was introduced in 557a5998d (submodule: remove
> > gitmodules_config, 2017-08-03) to how attribute processing was handled
> > in bare repositories when running the diff-tree command.
> >
> > By default the attribute system will first try to read ".gitattribute"
> > files from the working tree and then falls back to reading them from the
> > index if there isn't a copy checked out in the worktree.  Prior to
> > 557a5998d the index was read as a side effect of the call to
> > 'gitmodules_config()' which ensured that the index was already populated
> > before entering the attribute subsystem.
> >
> > Since the call to 'gitmodules_config()' was removed the index is no
> > longer being read so when the attribute system tries to read from the
> > in-memory index it doesn't find any ".gitattribute" entries effectively
> > ignoring any configured attributes.
> >
> > Fix this by explicitly reading the index during the setup of diff-tree.
> 
> This commit message does a good job of explaining the issue, so
> someone who hasn't followed the thread (or has not followed it
> closely, like me) can understand the problem and solution. Thanks.
> 
> A few comments below...
> 
> > Reported-by: Ben Boeckel <ben.boeckel@kitware.com>
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> > diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
> > @@ -110,6 +110,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
> >
> >         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> >         init_revisions(opt, prefix);
> > +       read_cache();
> 
> 557a5998d (submodule: remove gitmodules_config, 2017-08-03) touched a
> fair number of built-in commands. It's not clear from the current
> patch's commit message if diff-tree is the only command which
> regressed. Is it? Or are other commands also likely to have regressed?
> Perhaps the commit message could say something about this. For
> instance: "All other commands touched by 557a5998d have been audited
> and were found to be regression-free" or "Other commands may regress
> in the same way, but we will take a wait-and-see attitude and fix them
> as needed because <fill-in-reason>".

I don't know if any other commands have regressed.  This was such an odd
regression that I think it would be difficult to say for certain that
there couldn't be others.  I did go through the affected builtins to see
if I could find anything.  I came up empty handed so I think we should
be ok.

> 
> > diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> > @@ -636,6 +636,23 @@ test_expect_success 'check with space before tab in indent (diff-tree)' '
> > +test_expect_success 'check with ignored trailing whitespace attr (diff-tree)' '
> > +       test_when_finished "git reset --hard HEAD^" &&
> 
> A few style nits...
> 
> > +       # Create a whitespace error that should be ignored.
> 
> Comments in nearby tests are not capitalized and do not end with period.
> 
> > +       echo "* -whitespace" > ".gitattributes" &&
> 
> Please drop unnecessary quotes around the filename, as the extra noise
> makes it a bit harder to read. Also, lose space after redirection
> operator:
> 
>     echo "* -whitespace" >.gitattributes &&
> 
> > +       git add ".gitattributes" &&
> > +       echo "trailing space -> " > "trailing-space" &&
> 
> All the nearby tests use some variation of:
> 
>     echo "foo ();  " >x &&
> 
> which differs from the "trailing space ->" and filename
> 'trailing-space' used in this test. Lack of consistency makes this new
> test stick out like a sore thumb.

You're right, when writing the tests I didn't really consider the
surrounding ones.  I'll make the requested changes.

> 
> > +       git add "trailing-space" &&
> > +       git commit -m "trailing space" &&
> > +
> > +       # With a worktree diff-tree ignores the whitespace error
> > +       git diff-tree --root --check HEAD &&
> > +
> > +       # Without a worktree diff-tree still ignores the whitespace error
> > +       git -C .git diff-tree --root --check HEAD
> > +'

-- 
Brandon Williams
