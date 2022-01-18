Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8637DC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 22:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349846AbiARWWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349904AbiARWWj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 17:22:39 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4FC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 14:22:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m4so1807118edb.10
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 14:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8OD+3Ot/N8BC37GEvufSmke0HxGbX0yp/Dx6BWxTrzk=;
        b=JaRqkt1YdY7KVv8qSCbKKNaZUVXUQ+Bk1EVd1/hQY1rE8xOqFOhJzD5J420BerFK08
         VPIBVnA80TADI1q7zHSXr1jd/jM1Y23Gv7ULacYK7OQGQ9tTqSpopgnxUTuJGeIapbRN
         g0zU/SYlAONUKljWWaDJTqRVi7sw+kpLmWm/tQZWFxHQv+ubpTeaFsPHdMg3Wzvy5rPr
         nLVOK3JTnHPJ5aw3j5kLijiZYmucJp6hG5ETs23nU/YnFkbyIHKP83GrJOmiACbSS8z+
         pz/jysb17Mb4djFD590cvHYhTkuovtJfrUXZcL2pufLVWnbzbqnJj2qoT3IYfz5dwVo1
         1MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8OD+3Ot/N8BC37GEvufSmke0HxGbX0yp/Dx6BWxTrzk=;
        b=JN1MbDoMZIApXlrgS7Cjtwx2r2waKqLq578REmGHkzshmpEN7b1s7X2hxfEtpnpkEI
         J6GrNPPTyY7XUhWddio4DSORk5AxvXuoI9eOflAzNHyarXWRJbGvX59FWLPM0KuPrlyH
         E0iTGyMQ/s4F4ktcdXD41cIFaCevwlkrL5bot0+8RKp8AWqBDGtCzNdkRn8a9Nspfx6P
         AGRQ3/bDLaxHEdCN7HLBZfYYPQ3Szj1nwXBaaeXkr5/4D9XCncBFsSZceDKxwZTAaYRG
         CXn9kk8KSUUcCroh1H4TAoKrUT/a5EtPdGWWoS4/YDFLtf2R73N6/9sM6SM5jdmWUhvs
         CxPw==
X-Gm-Message-State: AOAM533hTKRDDnqwRz57a5cOwTtdOQ5A0uvf5cHWijG6Tkio39Fbqqli
        PL+V0kDYzYePA95B+KatOHqX9vPAN/4=
X-Google-Smtp-Source: ABdhPJwACbOd7LAG73KAu/oUwtvfIVch0pc+dZ38DzBKdEHNfyyNLs/3gj1llQsWzNp9aFQmZKJVsw==
X-Received: by 2002:a05:6402:41a:: with SMTP id q26mr28082099edv.387.1642544557055;
        Tue, 18 Jan 2022 14:22:37 -0800 (PST)
Received: from szeder.dev (94-21-146-14.pool.digikabel.hu. [94.21.146.14])
        by smtp.gmail.com with ESMTPSA id bt11sm1195183ejb.108.2022.01.18.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 14:22:36 -0800 (PST)
Date:   Tue, 18 Jan 2022 23:22:34 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Message-ID: <20220118222234.GB2632@szeder.dev>
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 15, 2022 at 05:03:24PM -0800, Elijah Newren wrote:
> On Sat, Jan 15, 2022 at 1:57 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Mon, Jan 10, 2022 at 06:59:51PM +0000, Lessley Dennington via GitGitGadget wrote:
> > > Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
> >
> > None of these patches touch sparse-checkout, but only the completion
> > script and its tests.  Therefore "completion:" would be a better
> > matching area prefix.
> 
> Thanks for the detailed feedback and guidance in your review.  Very
> helpful.  I'll omit quoting most of it here, but I do want to comment
> on the point about directories.
> 
> ...
> > > 4. A list of directories (but not files) is provided when users enter git
> > > sparse-checkout add <TAB> or git sparse-checkout set <TAB>.
> >
> > Why limit completion only to directories?  Both of those subcommands
> > accept files,
> 
> Discussed in part at [1], but let me give a more detailed answer.

It was a semi-rhetorical question.  Whether the reasons for expluding
files are sound or not, it should be convincingly justified in the
commit message.

> Both of these commands accept not only directories and files, but also
> nearly arbitrary input as far as I can tell.  (In cone-mode, it'll
> accept anything so long as it doesn't look like a relative path that
> tries to reach above the toplevel directory with '../' sequences.  In
> non-cone mode, I think it accepts completely arbitrary input).  If our
> guide is merely what the command swallows, then we should forgo
> completion for these subcommands, because it's not possible to
> enumerate all possible completions.  I don't think that's a useful
> guide or starting point, so we instead need to discuss what are
> reasonable completions.
> 
> cone-mode works exclusively on directories.  So, in that mode,
> directories are what we want to complete on.  (And if a file is
> specified, cone-mode will treat it as a directory and add expressions
> for including all the files under that "directory", which might be
> confusing.  sparse-checkout doesn't verify it is a diretory, because
> it *might* name a directory in a different branch, including one not
> yet downloaded.  But "might name a directory on another branch" is no
> reason to suggest picking that pathname with completion.)
> 
> In non-cone mode, arbitrary expressions are valid and will be treated
> as gitignore-style expressions.  That again leaves us with either not
> providing completions, or choosing a subset of possible inputs that
> are reasonable suggestions for users.  I prefer the latter, and in
> particular I feel that directories are reasonable suggestions.  In
> contrast, I don't think providing files is helpful, because it
> reinforces the design flaw of non-cone mode.  Non-cone mode has
> quadratic performance baked into its design, and since
> sparse-checkouts are about performance, non-cone mode kind of defeats
> the purpose of the command.

Or about disk space.  Which, because of the potentially significantly
reduced number of files in the work tree can bring along significant
performance benefits, even with quadratic behavior.

>  (In addition to other problems[2].)  So,
> I think non-cone mode should be deprecated and excised.  Patches
> elsewhere are moving in the direction of deprecation already[3], and
> we've already discussed multiple steps we'll likely take soon
> continuing in that direction.  In the meantime, providing just
> directories for completion seems like a good direction to me.
> 
> [1] https://lore.kernel.org/git/CABPp-BG=wr81CPtW1M12xFN_0dyS8mAZjM6o=77LA20Zge8Xng@mail.gmail.com/
> [2] https://lore.kernel.org/git/CABPp-BF=-1aZd=nFHF6spo7Ksa7f7Wb7ervCt0QvtNitMY=ZBA@mail.gmail.com/
> [3] https://lore.kernel.org/git/0af00779128e594aff0ee4ec5378addeac8e88a2.1642175983.git.gitgitgadget@gmail.com/
> ("This mode is harder to use and less performant, and is thus not
> recommended.")
> 
> > and I think 'git sparse-checkout set README.md' is a
> > perfectly reasonable command.
> 
> Reasonable in what sense?  That it makes it (vastly) easier to
> implement the completion and sparse-checkout set|add will swallow it,
> or that it's something that should actually be recommended for users
> doing sparse-checkouts?  While the former certainly holds, I don't
> think the latter does.

I used the following command to create a sparse-checkout from
linux.git to build and play with 'perf':

  git sparse-checkout set tools/perf/ tools/scripts/ tools/build/ tools/include/ tools/arch/x86/ tools/lib/ /.gitignore /.gitattributes

Including the top-level '.gitignore' and '.gitattributes' was
important, becase those ignore object files and specify userdiff.
Now, I wouldn't mind having other files present in the top-level
directory, because there are only a handful of files there.  However,
being able to specify just those two files to 'git sparse-checkout'
was great, because I didn't even have to think about what wildcard
pattern to use, and what negative pattern to use to exclude anything
that might have been included recursively.

I don't remember having any performance issues with it, on the
contrary, I do remember that Git suddenly became much faster that in
the full worktree.

So I'm fairly convinced that specifying files to sparse-checkout is a
feature that can make users' life easier.  It certainly made my life
easier.


On a related note: I just noticed the leading slashes in '/.gitignore'
and '/.gitattributes'.  __git_complete_index_file() is not ready for
that, I'm afraid; but I don't think the proposed patches could deal
with that, either (but I didn't actually try).

It would be great if completion could cope with patterns starting with
'/' and/or '!'.


