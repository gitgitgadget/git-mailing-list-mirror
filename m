Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C6C1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdB0SQG (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:16:06 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34925 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdB0SQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:16:04 -0500
Received: by mail-pf0-f177.google.com with SMTP id j5so7266294pfb.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/kdYTkVWxxUimDrOSQechZ4NZhq1KggekY36cveFNx8=;
        b=t1oWJHmtsYQjyqUguQfey1lZy8JRIMGdxeE38ktWSfFNTfxm/qqZe+i2aYJUfxcXk9
         3DHclOwNx6k72wkUHg2VEk772IcIoLOgWZOeq5npGMALbKLyoEh8V9FxRS0E0hBHhemn
         2qrqzt3mGMW2M5AH/x6cJAGrU6KrEIcOB6XRixPdqHvEMQiO5f+lt4D0F3lRzNDTNxO7
         CWi4jynvwQeb+wNLk6lWJa7OIWxPGVZVtAzKWHc4li6E33jMMv2g5pjGQdM/R9pNy/Ca
         4N09untF3PZdoDgIyz4iyQngCHHyLgZeTnrFxMM7lQW9Ln3sIegsMmzY9EIx96hOfsgg
         joEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/kdYTkVWxxUimDrOSQechZ4NZhq1KggekY36cveFNx8=;
        b=VjRZRbsi3UTYiZk5Fey7fzr0OZ/1ibUiasynl8GLkA42UzEjtFjoV5T9JEJXc0btF9
         K/IIKmpT1JCrO55ITqlK3twdQdC7vEDMGKkKiyiOUyJrADqdggDhg/gf05h8Ato/A/K7
         wC2djMHduoDleHzwna5SDdSMMX2iG5Ngst5Mplgq8EY473O7QPV7Kno1eAG7Aym0A3D3
         xsmVyrxHYjyjWg6IdoQ7ybSKW5lSJB+lTsWB8FcFZ2Jh55O5KEK3PsrE+YkyTNxthwpM
         lCpsPg3uDHy54SsAtR6STp9ZcUA0gitFT/6gBK6CFi1n7wfZSYH7r1vLVevoJljZh9Yw
         wyxg==
X-Gm-Message-State: AMke39k1zjwUSk2MGiL76gu9JeVEGttBFMZT9jAzxRuaK1Booe+S9gy7uqULtoM9Et5wO//j
X-Received: by 10.84.233.194 with SMTP id m2mr26207244pln.126.1488219280037;
        Mon, 27 Feb 2017 10:14:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:5d0b:b83e:e4b4:f20d])
        by smtp.gmail.com with ESMTPSA id s8sm32018803pfj.30.2017.02.27.10.14.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:14:39 -0800 (PST)
Date:   Mon, 27 Feb 2017 10:14:37 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] grep: illustrate bug when recursing with relative
 pathspec
Message-ID: <20170227181437.GB153455@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
 <20170224235100.52627-2-bmwill@google.com>
 <CACsJy8Df6hhTzx5BNx385T4cuCg5w3nvOioXB=q+NCoW9kA6_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Df6hhTzx5BNx385T4cuCg5w3nvOioXB=q+NCoW9kA6_w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Duy Nguyen wrote:
> On Sat, Feb 25, 2017 at 6:50 AM, Brandon Williams <bmwill@google.com> wrote:
> > When using the --recurse-submodules flag with a relative pathspec which
> > includes "..", an error is produced inside the child process spawned for
> > a submodule.  When creating the pathspec struct in the child, the ".."
> > is interpreted to mean "go up a directory" which causes an error stating
> > that the path ".." is outside of the repository.
> >
> > While it is true that ".." is outside the scope of the submodule, it is
> > confusing to a user who originally invoked the command where ".." was
> > indeed still inside the scope of the superproject.  Since the child
> > process luanched for the submodule has some context that it is operating
> 
> s/luanched/launched/
> 
> I would prefer 1/5 t to be merged with 3/5 though. The problem

We can definitely merge them and I agree that it may be easier for
looking through the logs if they are merged.

> description is very light there, and the test demonstration in the
> diff is simply switching from failure to success, which forces the
> reader to come back here. It's easier to find here now, but it'll be a
> bit harder when it enters master and we have to read it from git-log,
> I think.
> 
> I'm still munching through the super-prefix patches. From how you
> changed match_pathspec call in 0281e487fd (grep: optionally recurse
> into submodules - 2016-12-16), I guess pathspecs should be handled
> with super-prefix instead of the submodule's prefix (which is empty
> anyway, I guess). The right solution wrt. handling relative paths may
> be teach pathspec about super-prefix (and even original super's cwd)
> then let it processes path in supermodule's context.
> 
> Does it handle relative paths with wildcards correctly btw? Ones that
> cross submodules? I have a feeling it doesn't, but I haven't seen how
> exactly super-prefix works yet.

I'm not 100% sure about the relative paths with wildcards.  I did notice
that this series solves one problem and introduces another (recursing
from a subdirectory doesn't work with this series) so I need to
rethink the solution a little bit.  And I'll take into account wildcards
as well.

> 
> There's another problem with passing pathspec from one process to
> another. The issue with preserving the prefix, see 233c3e6c59
> (parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN -
> 2013-07-14). :(icase) needs this because given a path
> "<prefix>/foobar", only the "foobar" part is considered case
> insensitive, the prefix part is always case-sensitive. For example, if
> you have 4 paths "abc/def", "abc/DEF", "ABC/def" and "ABC/DEF" and are
> standing at "abc", you would want ":(icase)def" to match the first two
> only, not all of them.

Hmm...yeah its a really difficult thing to get 100% correct (as I'm now
noticing).  It also makes it a little more challenging because you don't
have the same state in both processes (child and parent).  I'm thinking
I may have to a little bit more work, which is more involved, to
properly handle the pathspecs passed to the children.  As in we may not
be able to pass the raw pathspec used in the parent to the child and
instead may have to do a little pre-processing on it.

> > underneath a superproject, this error could be avoided.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  t/t7814-grep-recurse-submodules.sh | 42 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> > index 67247a01d..418ba68fe 100755
> > --- a/t/t7814-grep-recurse-submodules.sh
> > +++ b/t/t7814-grep-recurse-submodules.sh
> > @@ -227,6 +227,48 @@ test_expect_success 'grep history with moved submoules' '
> >         test_cmp expect actual
> >  '
> >
> > +test_expect_failure 'grep using relative path' '
> > +       test_when_finished "rm -rf parent sub" &&
> > +       git init sub &&
> > +       echo "foobar" >sub/file &&
> > +       git -C sub add file &&
> > +       git -C sub commit -m "add file" &&
> > +
> > +       git init parent &&
> > +       echo "foobar" >parent/file &&
> > +       git -C parent add file &&
> > +       mkdir parent/src &&
> > +       echo "foobar" >parent/src/file2 &&
> > +       git -C parent add src/file2 &&
> > +       git -C parent submodule add ../sub &&
> > +       git -C parent commit -m "add files and submodule" &&
> > +
> > +       # From top works
> > +       cat >expect <<-\EOF &&
> > +       file:foobar
> > +       src/file2:foobar
> > +       sub/file:foobar
> > +       EOF
> > +       git -C parent grep --recurse-submodules -e "foobar" >actual &&
> > +       test_cmp expect actual &&
> > +
> > +       # Relative path to top errors out
> 
> After 3/5, it's not "errors out" any more, is it?
> 

Correct, will fix the comment.

> > +       cat >expect <<-\EOF &&
> > +       ../file:foobar
> > +       file2:foobar
> > +       ../sub/file:foobar
> > +       EOF
> > +       git -C parent/src grep --recurse-submodules -e "foobar" -- .. >actual &&
> > +       test_cmp expect actual &&
> > +
> > +       # Relative path to submodule errors out
> 
> ditto
> 
> > +       cat >expect <<-\EOF &&
> > +       ../sub/file:foobar
> > +       EOF
> > +       git -C parent/src grep --recurse-submodules -e "foobar" -- ../sub >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> >  test_incompatible_with_recurse_submodules ()
> >  {
> >         test_expect_success "--recurse-submodules and $1 are incompatible" "
> > --
> > 2.11.0.483.g087da7b7c-goog
> >
> 
> 
> 
> -- 
> Duy

-- 
Brandon Williams
