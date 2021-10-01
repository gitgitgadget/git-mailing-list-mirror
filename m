Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EEAC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 03:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA1496187D
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 03:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351844AbhJAD5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 23:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhJAD5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 23:57:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C5C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 20:56:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ba1so29797731edb.4
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 20:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9dJNsM4wAo4P531U8S5zUKrXMPdvbGpR82nrpn7UPM=;
        b=BnjowW0juUYkZxR1JXhedLdcTM/VbgaBRq9j6C5tGHxxErT3Bj2uekualOUZwJ3SC5
         J0HTnJsB5vfL5Nq5OZURL4cBqtyDpPDCl4ghYYwnWytayT1TCmCq2t+zh79YOb9NKcbB
         4mjFNfRskfVMDIekIXzRM3DWWDzxOnzGb9GJGEz97MNQdJRLnbnXY6e8FD1av8OaE7T4
         FV15SPN1IOq4CrZ1QtyalpTU/eBjgCtoIS3Gbw0JytnB0EtmNM6TFqSUQf9YSEztGwTI
         rImUpC9FH02yX6PsUIdAtYAi+AlZL067JWNnZNmndpP4cS1GbKjoBcAR8zX1Vi+BkNzU
         iK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9dJNsM4wAo4P531U8S5zUKrXMPdvbGpR82nrpn7UPM=;
        b=cyhgVgBOXYxNlnwKJwNcWBo73EWWLtnme/wGvZiZ/EqGzL9SlCLpdEJzi36kecTV8Y
         1OXcKkp9vKKs1ZYmUKNsa0zIB+vMYY5iGd9W2RMdZ6B5wnoQPbCy9CyoGTcHMmzsj5br
         Klexo3vWbXHSfll84fWkQkWJYS4qKffgxVAxQLqi451nCgc+8ooMT/35KPliISrYLuFF
         Jxz9y4fEwUxZlw/k77h5k0XgGEKkLceLGHm4fkOJwXUh/jFJYnou0g87ih4RyLAx4tL+
         ghhfJpgJKekyVNFsW+jU8SXOBbYEHU9VCA2rXb5bChpdeGhEaJtWNbEzUcDLT4gvkdaS
         mEew==
X-Gm-Message-State: AOAM533dxJ31i9oZOB0u2+R1UfMe4yiowh8tZoM1InASIJVBwVV0ZXH/
        SWOUL6lIpUYEmaiJQHKbENtuNVoQvTjAosCFpow=
X-Google-Smtp-Source: ABdhPJx9dckREfTHPlWtl44Uk+2XYmcwsQJaliJK2XsXkw32YWrP9wWaDI5u+aEjG/or7Sg3SQZ6mEe2FXUPPeLLJjc=
X-Received: by 2002:a05:6402:2682:: with SMTP id w2mr11741027edd.62.1633060567670;
 Thu, 30 Sep 2021 20:56:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
 <67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com>
 <87r1d9xh71.fsf@evledraar.gmail.com> <CABPp-BG_qigBoirMGR-Yk9Niyxt0UmYCEqojsYxbSEarLAmraA@mail.gmail.com>
 <87h7e2t9fh.fsf@evledraar.gmail.com>
In-Reply-To: <87h7e2t9fh.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 20:55:54 -0700
Message-ID: <CABPp-BF_KqEUXB8H7Xsjjk10sb1hB8Qt3AzAeURAdDSxHYDo9w@mail.gmail.com>
Subject: Re: [PATCH 5/7] tmp-objdir: new API for creating and removing primary
 object dirs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 7:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Sep 28 2021, Elijah Newren wrote:
>
> > On Tue, Sep 28, 2021 at 1:00 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Tue, Aug 31 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> I commented just now on how this API is duplicated between here &
> >> another in-flight series in
> >> https://lore.kernel.org/git/87v92lxhh4.fsf@evledraar.gmail.com/; Just
> >> comments on this patch here:
> >>
> >> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> >> > index b8d880e3626..9f75a75d1c0 100644
> >> > --- a/tmp-objdir.c
> >> > +++ b/tmp-objdir.c
> >> > @@ -288,7 +288,36 @@ const char **tmp_objdir_env(const struct tmp_ob=
jdir *t)
> >> >       return t->env.v;
> >> >  }
> >> >
> >> > +const char *tmp_objdir_path(struct tmp_objdir *t)
> >> > +{
> >> > +     return t->path.buf;
> >> > +}
> >>
> >> Not your fault & this pre-dates your patch, but FWIW I prefer our APIs
> >> that don't have these "hidden struct" shenanigans (like say "struct
> >> string_list") so a caller could just access this, we can just declare =
it
> >> "const" appropriately.
> >>
> >> We're also all in-tree friends here, so having various accessors for n=
o
> >> reason other than to access struct members seems a bit too much.
> >
> > That's a fair point, but just to play counterpoint for a minute...
> >
> > FWIW, I dislike when our public facing APIs are polluted with all
> > kinds of internal details.  merge-recursive being a case in point.
> > When writing merge-ort, although I had a struct with public fields,
> > that struct also contained an opaque struct (pointer) within it to
> > hide several private fields.  (I would have liked to hide or remove a
> > few more fields, but couldn't do so while the merge_recursive_options
> > struct was shared between both merge-ort and merge-recursive.)
> >
> > That said, I agree it can certainly be overdone, and tmp_objdir is
> > pretty simple.  However, sometimes even in simple cases I like when
> > folks make use of an opaque struct because it means folks put some
> > effort into thinking more about the API that should be exposed.
> > That's something we as a project have often overlooked in the past, as
> > evidenced both by our one-shot usage mentality, and the existence of
> > external projects like libgit2 attempting to correct this design
> > shortcoming.  I'd like git to move more towards being structured as a
> > reusable library as well as a useful command-line tool.
>
> [This is somewhat of a continuation of
> https://lore.kernel.org/git/87lf3etaih.fsf@evledraar.gmail.com/].
>
> I like our APIs being usable, but right now we're not promising any
> maintenance of APIs that work the same as git v2.30.0 or whatever.
>
> I think some external users directly link to libgit.a, but they're
> tracking whatever churn we have from release to release, just like
> someone maintaining out-of-tree linux kernel drivers.
>
> For maintenance of git.git itself I think it's going to stay like that
> for any foreseeable future[1].
>
> And that's before we even get into the practicalities of git's license
> likely not winning over many (if any) libgit2 users. I think those users
> are if anything migrating from libgit2 to git's plumbing CLI, or in some
> cases folding what they needed into git.git itself (or just staying with
> libgit2).
>
> So assuming all of that I really don't see the point in general of
> having a "foo" field that has the equivalent of get_foo() and set_foo()
> accessors in the context of git.git.
>
> That's something that's really useful if you're maintaining API and ABI
> compatibility, but for us it's usually just verbosity. All the users are
> in-tree, so just add "const" as appropriate, or perhaps we should give
> the field a "priv" name or whatever.

It wasn't just a get or set accessors, and there was more involved
than just adding const:
  * There was a typechange from struct strbuf -> const char *; strbuf !=3D =
char *
  * Having an API that _enforces_ accesses to be const provides more
safety.  Relying on callers to remember to declare their variable
access as const provides virtually none.

But more importantly than either of the above, tmp_objdir was locked
down because it was too easy to make big mistakes with, as Peff
pointed out.  That meant that folks would only use it through the API,
and if folks tried to do unusual things, they'd do so by adding new
API, which is easier to flag in code reviews and make sure the right
people get cc'ed than if folks just reach into some internals from
some other file.  And the new API that I added resulted in a
discussion that pointed out I didn't need to access that field at all
and should instead create and delete the tmp_objdir after every merge.

> Obviously not everything should be done that way, e.g. being able to
> have trace2 start/end points for something you'd otherwise push/clear
> from a "struct string_list" or whatever directly *is* usable, so it's
> not black and white.
>
> I'm just saying thaht using convoluted patterns *just* to get in the way
> of some hypothetical code that's going to mess with your internals can
> make things harder in other areas. E.g. the init/release pattern via
> macros I mentioned in the linked E-Mail above.

Fair points, but I just don't think that's relevant to the context
here; i.e. these aren't convoluted patterns *just* to get in the way.

Further, I don't see how this would adversely affect the *_INIT macros
you mentioned at all.  tmp_objdir is an opaque struct so you can only
declare a pointer to it.  Pointers being initialized to NULL is
handled quite nicely by the *_INIT macros.

> > [...]
> >> In this particular case I hadn't understood on a previous reading of
> >> tmp-objdir.c why this "path" isn't a statically allocated "char
> >> path[PATH_MAX]", or a least we that hardcoded "1024" should be a
> >> PATH_MAX, as it is in some other cases.
> >
> > Actually, PATH_MAX shouldn't be used:
> >
> > https://lore.kernel.org/git/7d1237c7-5a83-d766-7d93-5f0d59166067@web.de=
/
> > https://lore.kernel.org/git/20180720180427.GE22486@sigill.intra.peff.ne=
t/
>
> Thanks. I didn't know about that. I've fixed (some of that) up in some
> semi-related WIP work I've got.
>
> 1. Aside: I *do* think it would be really useful for us to expose a
>    stable C API eventually, using some of the same license
>    workarounds/shenanigans (depending on your view) as the Linux kernel
>    did. I.e. to say that "we're GPLv2, but this small API is the
>    equivalent of our syscall interface".
>
>    Rather than that API being something that would look anything like
>    internal git.git users it would basically be a run_command() + Perl's
>    unpack/pack + output formatter on steroids.
>
>    I.e. we'd be able to invoke say a 'git cat-file --batch' in the same
>    process as the caller by essentially calling cmd_cat_file()
>    directly. Just with some callback replacements for "provide this on
>    stdin" and "this line accepts stdout" without actually involving
>    different processes or I/O.
>
>    You'd then have the equivalent of a --format output that would just
>    so happen to be in your OS's / C ABI's understood struct
>    format. Similar to "perldoc -f pack".
>
>    The maintenance burden of such an API would be trivial. It would
>    basically be a handful of functions just to setup input/output
>    callbacks.
>
>    Most of the interface would be a rather convoluted construction of
>    command-line parameters (like our own run_command() use), not ideal,
>    but most users are after structured data and eliminating process
>    overhead, and they'd get that.
>
>    We would need to replace fprintf() and the like with some structured
>    formatting mechanism, but that would be useful for non-API users as
>    new commands learning a shiny new --format parameter. You could even
>    use such a --format to have a non-C-API user get the same struct
>    output, perhaps for direct mapping into memory, say if you didn't
>    trust the built-in/command in question to not leak memory yet.
>
>    I don't know if this has been suggested before, just my 0.02. It's
>    also partially why I'm interested in making even-built-ins not leak
>    memory with some of my parallel SANITIZE=3Dleak work.
>
>    Once you've got that you can usually call the cmd_whatever() in a
>    loop without much effort, and once you've got that, well, see above
>    :)

This sounds really cool.
