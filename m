Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF905C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiARM7y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiARM7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:59:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A32AC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 04:59:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c9so133772plg.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 04:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q77lQ78+4LucWwivlWw5fNxIXUrF4q9r6S204VF8YGU=;
        b=ENjaj5wBe4JopePoBCEWRiaGI+IXQ+5jJxeFf5gW+OUV6MR5dyG2F31nvPSCJHuRps
         wHgBQeits/GxfTzUWbEI9H+Mmo1D9cE6E/qxpziG5RwaZb52w5s4uZgeTfamGG/pM4v7
         jNwy0T5Q9mt2wQddUCg+w2S/NWKEHV6gYdxkH/Xzy0mCpJDZR67Yzx8dDYcpMn8IFJSy
         NvkOYSPsCuXWjm6yO2bO9kYXMf6sMOPp9oB4rLE9xWC7zDKsIFc4iTQgxYdY+Iett45e
         0Sp1Jrws5Pp7Lmaf4KQVFF/ZVIy3TXr7xmU3t3DodIALf+XPkiWTU408hMs16eXsHrje
         /RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q77lQ78+4LucWwivlWw5fNxIXUrF4q9r6S204VF8YGU=;
        b=hGcfeUqSSivz0jMe1CiS0Y2RNTEKpe0v+oTmADUSMKcqEmsCGxwBtlAlVB/owYkwRe
         WLo8wWh41VIjY42T94AcS8+LGN3VDdEk5Hxk31CFIP608F+y79cFzUKgRDZ04BMRElaj
         7ANr9beWLYBxvZBccfmgguq1Jm9AuIUkJggIvYY8ikmQFUGtCHGEQ7s0iTYcH8ucBjfw
         FWF7EDLYqogwkvac9KbVO2XqQanBE55XTJ3pRYWyjHWO9DWZNfye8/rgVMhbAG6OKi2/
         x5MouNFNISKrLiBjKQQS+DXnI8deJZczE7EfGkM4j+91uOU6LDT0o8MxcR7RnWOltQug
         4HkQ==
X-Gm-Message-State: AOAM530xZnI8u4FR9mXWavEn7wFMuvQy7BY2Jan9HYeL403cr4dXbZAV
        kwlDErUlEBporXYkHolKa6Y=
X-Google-Smtp-Source: ABdhPJykKsjuUSvPGCKtxreA7zmi6VlNidnSN9NbZG1BXzsSe2yKNFAxN/zzyLiZr2Zr8C/cp5D1Uw==
X-Received: by 2002:a17:90b:17cd:: with SMTP id me13mr16471445pjb.234.1642510793565;
        Tue, 18 Jan 2022 04:59:53 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.58])
        by smtp.gmail.com with ESMTPSA id i194sm11794510pfe.10.2022.01.18.04.59.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jan 2022 04:59:53 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        dyroneteng@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        johncai86@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 9/9] ls-tree.c: introduce "--format" option
Date:   Tue, 18 Jan 2022 20:59:39 +0800
Message-Id: <20220118125939.99956-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.401.gc7f2b5cad2
In-Reply-To: <220113.86o84gvwfd.gmgdl@evledraar.gmail.com>
References: <220113.86o84gvwfd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 5:04 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> > diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> > index 729370f235..ebdde6eae3 100644
> > --- a/Documentation/git-ls-tree.txt
> > +++ b/Documentation/git-ls-tree.txt
> > @@ -10,9 +10,9 @@ SYNOPSIS
> >  --------
> >  [verse]
> >  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> > -         [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]]
> > -         <tree-ish> [<path>...]
> > -
> > +         [--name-only] [--name-status] [--object-only]
> > +         [--full-name] [--full-tree] [--abbrev[=<n>]]
>
> Let's split up this re-flow only change into its own commit? I.e. the
> only non-whitespace change here is beginning with [--format].
>
> If it was the right thing to do to re-flow this then we didn't need
> [--format=<format>] to exist to do so...

Agree, especially if "--format" comes earlier as you mentioned in
another reply.

The doc change should only include the new "--format" here, so
we just:

diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index db02d6d79a..b02f028aca 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -10,5 +10,5 @@ SYNOPSIS
 --------
 [verse]
 'git ls-tree' [-d] [-r] [-t] [-l] [-z]
-           [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
+           [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
            <tree-ish> [<path>...]

is OK.

> > +         [--format=<format>] <tree-ish> [<path>...]
> >  DESCRIPTION
>
> Removing this \n breaks the formatting in the file. See "make man && man
> ./Documentation/git-ls-tree.1". The ./Documentation/doc-diff utility is
> also handy for sanity checking the documentation formatting.

This is my mistake and will be corrected in the next patch.

> >  -----------
> >  Lists the contents of a given tree object, like what "/bin/ls -a" does
> > @@ -79,6 +79,16 @@ OPTION
> >       Do not limit the listing to the current working directory.
> >       Implies --full-name.
> >
> > +--format=<format>::
> > +     A string that interpolates `%(fieldname)` from the result
> > +     being shown. It also interpolates `%%` to `%`, and
> > +     `%xx` where `xx` are hex digits interpolates to character
> > +     with hex code `xx`; for example `%00` interpolates to
> > +     `\0` (NUL), `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> > +     When specified, `--format` cannot be combined with other
> > +     format-altering options, including `--long`, `--name-only`
> > +     and `--object-only`.
> > +
>
> These new docs make sense & seem to cover all the basis, thanks!

Actually, the content is not from me, I borrowed it from other
documents, but I'm glad if it's described and placed here correctly.

> Here because we've added --format discussing the previous pseudo-format
> as a "default" format becomes confusing. Let's instead say:
>
>         The output format of `ls-tree` is determined by either the `--format` option,
>         or other format-altering options such as `--name-long` etc. (see `--format` above).
>
>         The use of certain `--format` directives is equivalent to using those options,
>         but invoking the full formatting machinery can be slower than using an appropriate
>         formatting option.
>
>         In cases where the `--format` would exactly map to an existing option `ls-tree` will
>         use the appropriate faster path. Thus the default format is equivalent to:
>         ---
>         %(mode) %(type) %(object)%x09%(file)
>         ---

Make sense.

I will use this paragraph instead in next patch except a tiny
nit (s/--name-long/--name-only/).

> > +The output format changes to:
> > +
> > +        {"object":"<object>", "file":"<file>"}
>
> This one-liner is guaranteed to result in invalid JSON on some
> repositories, both because JSON is inherently a bad fit for git's data
> model (JSON needs to be in one Unicode encoding, Git's tree data might
> me in a mixture of encodings), and because it'll break if the file
> includes a '"'.

Correct and especially we use a "quote_c" style behind.

> I think it's better to just replace this with some example involving -z,
> or at least prominently note that this is broken in the general case,
> but can be used ad-hoc to quickly check things with "jq" or whatever.

Your suggestion is great, but personally I don't want to introduce more
complexity and other tools in here, and try to describe it in a simple way.
I think the below maybe is enough:

@@ -117,14 +127,10 @@ Customized format:
 
 It is possible to print in a custom format by using the `--format` option,
 which is able to interpolate different fields using a `%(fieldname)` notation.
-For example, if you want to only print the <object> and <file> fields with a
-JSON style, executing with a specific "--format" like
-
-        git ls-tree --format='{"object":"%(object)", "file":"%(file)"}' <tree-ish>
-
-The output format changes to:
+For example, if you only care about the <object> and <file> fields, you can
+execute with a specific "--format" like
 
-        {"object":"<object>", "file":"<file>"}
+        git ls-tree --format="%(object) %(file)" <tree-ish>
 
 FIELD NAMES
 -----------

> > +FIELD NAMES
> > +-----------
> > +
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputing line, the following
> > +names can be used:
> > +
> > +mode::
> > +     The mode of the object.
> > +type::
> > +     The type of the object (`blob` or `tree`).
> > +object::
> > +     The name of the object.
> > +size[:padded]::
> > +     The size of the object ("-" if it's a tree).
> > +     It also supports a padded format of size with "%(size:padded)".
> > +file::
> > +     The filename of the object.
>
> In
> https://lore.kernel.org/git/cover.1641043500.git.dyroneteng@gmail.com/
> you noted that you changed the field names of e.g. "objectname" to
> "object" etc. You're right that I picked these as-is from the
> git-for-each-ref formatting.
>
> 1/3 of your reasoning for doing so was to make it consistent with the
> documentation examples of e.g.:
>
>      <mode> SP <type> SP <object> TAB <file>
>
> I think in any case (as noted above) we should change those to use the
> --format), so that leaves just:
>
>  - "I prefer to make the name more simple to memorize and type"
>  - "I think the names with "object" prefix are [from git-for-each-ref
>    and the object* prefixes aren't redundant there, but would be here]".
>
> I think both of those still apply, but I think having these consistent
> with git-for-each-ref outweighs the slight benefit of shorter names.
>
> Right now only a handful of things support these sort of --format
> directives, but we've already got RFC/WIP patches to add that to
> git-cat-file, and are likely to add more in the future.

New and important input for me on this.

> I'd also like us to eventually be able to combine what are now separate
> built-ins with their own --format to expose more deeply some internal
> APIs via IPC. E.g. now you can do this:
>
>     git for-each-ref --format='%(refname) %(tree)'
>
> But to list each of those trees you'd need to pipe that output into this
> new 'git ls-tree --format. But imagine being able to do something like:
>
>     git for-each-ref --format='%(refname) %(git-ls-tree --format %%(objectname) %(tree))'

Make sense.

> Where we'd just invoke git-ls-tree for you without running a full
> sub-process. I think both for that hypothetical and working with the two
> --formats now having to use %(type) in some places but %(objecttype)
> etc. in others is just needlessly confusing. Let's just consistently use
> the same format names everywhere.
>
> Specifically for your s/path/file/ name change, that's just inaccurate, consider:
>
>     $ ./git ls-tree --format="%(mode) %(type) %(file)" -t HEAD -- t/README
>     040000 tree t
>     100644 blob t/README
>
> And:
>
>     $ $ (cd t && ../git ls-tree --format="%(mode) %(type) %(file)" -t -r HEAD -- README)
>     040000 tree ./
>     100644 blob README
>
> I.e. we talk about <path> in the existing SYNOPSIS for a reason. That we
> had a "<file>" in the existing format demo was a bug/shorthand that we
> shouldn't be propagating further.

Should use "path" instead of "file" in here.

Make sense.

> > [...]
> > +static const char *format;
> > +static const char *default_format = "%(mode) %(type) %(object)%x09%(file)";
> > +static const char *long_format = "%(mode) %(type) %(object) %(size:padded)%x09%(file)";
> > +static const char *name_only_format = "%(file)";
> > +static const char *object_only_format = "%(object)";
> > +
>
> One advantage of keeping the variable names I picked in
> https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/
> is that they align, so you can instantly see that the first two are
> equivalent until the "%x09".

Ha. Thanks.I think they not align in here is because my variables' names not align :)  

Actually, I was hesitating to use like "object" or follow the "objectname" like
rules. I would like git to have unified naming style on this, but I didn't have
that much input (other usage already on the way) at the time, so I chose to use
a shorter and probably more memorable name based on the document.

But now, I agree with you, to use the same naming conventions because on the whole,
especially multiple commands have the same appeal on format naming, uniformity is
more important than memorability of a single command, and I also think maybe we
might need to describe and maintain these rules of <fieldname> in a document
somewhere.

> It also makes it easier to review to avoid such churn, to see what you
> really changed I'm looking at a local version of a range-diff where I
> renamed these, the struct you renamed etc. back just to see what you
> /really/ changed. I.e. what are functional v.s. renaming changes.
>
> Here you changed my '"%"PRIuMAX' to '"%" PRIuMAX'. The former is the
> prevailing style in this codebase, and avoiding the formatting churn
> makes the inter-diff easier to read.

Will fix it in next patch.

> Ditto some harder to review interdiff due to renaming
> churn. I.e. s/line/sb/ in both this and expand_show_tree(). I really
> wouldn't care at all except because of all the manual work in reviewing
> the inter-diff between my original version & this derived version.
>
> In the case of "line" that's not even an improvement. With a --format
> we're not building a "line", the user is free to insert any arbitrary
> directives including \n's, so we might be working on multiple lines.

Make sense.

Will optimize in next patch.

> As I noted in my RFC CL (https://lore.kernel.org/git/RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com/):
>
>         "the tests for ls-tree are really
>         lacking. E.g. I seem to have a rather obvious bug in how -t and the
>         --format interact here, but no test catches it."
>
> So first, in my version of adding --format I was careful to make
> --name-only etc. imply a given --format, and then only at the last
> minute would we take the "fast path":
> https://lore.kernel.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/

I'm not sure I understand all the meanings above. I think I have forgot about the content here.
and I have to add some tests for other options like "-t" combined with "--format".

Please correct me if I misunderstood.

> You rewrote that in
> https://lore.kernel.org/git/e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com/
> and qremoved the limited "GIT_TEST_LS_TREE_FORMAT_BACKEND" testing I
> added, so now the internal --format machinery can't be run through the
> existing tests we do have.

I thought the "GIT_TEST_LS_TREE_FORMAT_BACKEND" is only used in your RFC for testing conveniently,
and should be removed in the end (non-RFC). So I removed it...

So should we add it back?

> Even with that re-added I really wouldn't trust that this code is doing
> the right thing (and as noted, I don't trust my own RFC version
> either). I think e.g. our "coverage" Makefile targets would be a good
> start as a first approximation, i.e. running the /ls-tree/ tests and
> seeing if we have full coverage.

Yeah. I haven't tried it yet, but I will try to run coverage detection when
the next patch is completed

> As I noted in 7/9 I think this patch is 9/9 still mostly something I
> wrote, so that the "author" and Signed-off-by should be preserved. The
> below is a range-diff of an amended version I've been looking at in
> trying to review this. It undoes several (but not all) of your
> formatting/renaming-only changes, just so that I could see what the
> non-formatting changes were:

Sorry for that. I misunderstand something here.
I will fix in the next patch.

Thanks.
