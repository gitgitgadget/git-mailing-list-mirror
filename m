Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE57201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 00:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751386AbdBYAiR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 19:38:17 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:38183 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYAiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 19:38:16 -0500
Received: by mail-it0-f49.google.com with SMTP id y135so40254983itc.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7/9eFBSMa6vvLyX3EV/pyimjkgODy3lttWrs4thh+5U=;
        b=jh9cAbRXvGjcHyALrE65ArHNnJAHEkBXMVxfORV3YCrq2n0Pyg/6KQ8d1dSu/Ze72Y
         HVYAupZwkv7aUo8auoSnVEZ1vTK5eDIUz8jl2aFx2gHIkBGI/WPymiifDvmnQCeHqIqr
         tdnR9Q/03YzJpK47TKI2lqkeBMRT/mLd46LUlRbE16FqcQx+AhUV2F2S9rNvUZWg/ADq
         kawNIa9H0+qd/NkLaczVLW7A+F/YMEDfA4moqIMJ6HHF1ewN1Jo0KUR1ekV78UCkiCjZ
         6miSd+8/N30kJFbAT81w20WI3IMTuG2BNhmSJFFoKO8p3COt2Z0Cax0UUT+6YJW6KfD2
         6T8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7/9eFBSMa6vvLyX3EV/pyimjkgODy3lttWrs4thh+5U=;
        b=M8SINzDjbJvrS+/m0ERyyszTCY7N2ljP2jSdXLH4rnecj28Y5kMQXLOxGO+Wpo1PNR
         sPKMgm9V25D7Y8T1uG/SlgjBKo09tzC2N/bK1VXAI+Yp12aLCS98MtHABh+HJFU5T2BL
         cFyl2IQWrqZu6v1Fxg7G0x3mGA7Lbn2LhmTnGZm4vyUbRlf7ofUFyDi0KRNFuNmwWN0s
         HvAAa1qtg+anTu6bipqr28S/+bAcrtg3jFGsATOMLw2wh8OlGiWUkI2k60U/cvVEJ7/s
         7mPYRUhcyvJYSG8okue4wSoxNvdxFzU7i54uxg+r2ARL4KQgr5ai3oWmTPkpPfTt//QG
         rsDw==
X-Gm-Message-State: AMke39kyaAnWOZWVJrjmuhjlyZD4xXf7nO+DbQcJIczpcaCma5XKe0cC4xQ6TYmzAipy40rxjraGftiaxbHWKvLD
X-Received: by 10.36.225.13 with SMTP id n13mr5183361ith.114.1487982677832;
 Fri, 24 Feb 2017 16:31:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 16:31:17 -0800 (PST)
In-Reply-To: <20170224235100.52627-3-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com> <20170224235100.52627-3-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 16:31:17 -0800
Message-ID: <CAGZ79kYRrAmJ+=563PBkdiBwaUzqqQOMVANT_fTvURFv+=Yiog@mail.gmail.com>
Subject: Re: [PATCH 2/5] pathspec: add PATHSPEC_FROMROOT flag
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 3:50 PM, Brandon Williams <bmwill@google.com> wrote:
> Add the `PATHSPEC_FROMROOT` flag to allow callers to instruct
> 'parse_pathspec()' that all provided pathspecs are relative to the root
> of the repository.  This allows a caller to prevent a path that may be
> outside of the repository from erroring out during the pathspec struct
> construction.
>


> +/* For callers that know all paths are relative to the root of the repository */
> +#define PATHSPEC_FROMROOT (1<<9)

What is the calling convention for these submodule pathspecs?
IIRC, we'd pass on the super-prefix and the literal pathspec,
e.g. when there is a submodule "sub" inside the superproject,
The invocation on the submodule would be

    git FOO --super-prefix="sub" <arguments> -- sub/pathspec/inside/...

and then the submodule process would need to "subtract" the superprefix
from the pathspec argument to see its actual pathspec, e.g. in gerrit:

$ GIT_TRACE=1 git grep --recurse-submodules -i test -- \
    plugins/cookbook-plugin/
...

trace: run_command: '--super-prefix=plugins/cookbook-plugin/' 'grep' \
  '--recurse-submodules' '-i' '-etest' '--threads=4' '--'
'plugins/cookbook-plugin/'
..
but also:
...
 trace: run_command: '--super-prefix=plugins/download-commands/' 'grep' \
  '--recurse-submodules' '-i' '-etest' '--threads=4' '--'
'plugins/cookbook-plugin/'
...

So if I change into a directory:

$ cd plugins
plugins$ git grep --recurse-submodules -i test -- cookbook-plugin/
plugins$ #empty?
plugins$ git grep --recurse-submodules -i test -- plugins/cookbook-plugin/
...
Usual output, so the pathspecs are absolute path to the superprojects
root? Let's try relative path:
plugins$ git grep --recurse-submodules -i test -- ../plugins/cookbook-plugin/
fatal: ../plugins/cookbook-plugin/: '../plugins/cookbook-plugin/' is
outside repository
...
Running with GIT_TRACE=1:

trace: run_command: '--super-prefix=plugins/cookbook-plugin/' 'grep' \
    '--recurse-submodules' '-i' '-etest' '--threads=4' '--'
'../plugins/cookbook-plugin/'

that seems like a mismatch of pathspec and superproject prefix, the prefix ought
to be different then? Maybe also including ../ because that is the
relative path from
cwd to the superporojects root and that is where we anchor all paths?

Easy to test that out:

plugins$ GIT_TRACE=1 git --super-prefix=../ grep --recurse-submodules \
    -i test -- ../plugins/cookbook-plugin/
fatal: can't use --super-prefix from a subdirectory

ok, not as easy. :/

So another test with relative path:
(in git.git)

cd t/diff-lib
t/diff-lib$ git grep freedom
COPYING:freedom to share and change it.  By contrast, the GNU General Public
...

So the path displayed is relative to the cwd (and the search results as well)
In the submodule case we would expect to have the super prefix
to be computed to be relative to the cwd?

Checking the tests, this is handled correctly with this patch series. :)

But nevertheless, I think I know why I dislike this approach now:
The super prefix is handled "too dumb" IMHO, see the case
    plugins$ git grep test  -- cookbook-plugin/
above, that doesn't correctly figure out the correct output.
Although this might be a separate bug, but it sounds like it
is the same underlying issue.

--
for the naming: How about PATHSPEC_FROMOUTSIDE
when going with the series as is here?
(the superprefix is not resolved, so the pathspecs given are
literally pathspecs that are outside this repo and we can ignore
them?

Thanks,
Stefan
