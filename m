Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 470271F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbeKKRtq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 12:49:46 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:37362 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeKKRtq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 12:49:46 -0500
Received: by mail-vk1-f193.google.com with SMTP id 197so1329764vkf.4
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51I4E1qqqtiFSCz31AZxjZgcRL//goqjU+CPhBRu3Wg=;
        b=VeJCk81PHKeh9LlEkQgi1p8d36S7ynR5os/8hIlPrOHhkNS7tQ+3E34zzk71w2s0kH
         /gpvtGeN5eTyh77f3L2X8PP3Rh52GQv+tuYjmFAe0tWz9x2eB3G7vVNuBsegvizGdBgN
         ixJZYeZd8qBVoszDr6vfu9pJd0DNS6PutVF2CL8hyXNaT/4kxKtStyZBgs7fB3sHtOC5
         9cXVULbHFtSwTed69MNlvd4zQqYKL5jIU9KFsxGaWMdvmwWHz3YPrr3b9c+joZrSMLZG
         Kcve1J71/u0a/tAjTLcc6C5PJ90guMMlxftiZLrz2nuIn5ofUdefnH0EhdVingNR8hBW
         aXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51I4E1qqqtiFSCz31AZxjZgcRL//goqjU+CPhBRu3Wg=;
        b=Ghw55P1+LhknNQcVLbrD8catRvu9RMnRNafQh1UOKuMprSv8mSxqgZIt1hgI6i26dK
         T7qN6xIB2SJHJ3omvyKT7W7p+EEHoj8eFH91w4Z1aD1vkz4lNDLKE7fPx6jgyUc3xaYN
         PY9fJSF4gWVWFDYDgmJYpuWvORmYnQ/eEXpOlFf80D8lSt9P3CwT3r2KNyXZmSTBLdIJ
         RbjjXspTTRFUkqEr3e5JWkFP90EtqAH9b/xsWqUfT6weMQ4E6MawuGvI9wtSnCRErlPc
         fkBvOtBAJHTxFpRJnzuVvytrCkyjtUKo7SAe/KoD9WSbzluKo97KhLd9IESEcfLV8uey
         fGSA==
X-Gm-Message-State: AGRZ1gLDejACMvwpO+Bzzd4+TOMEo3ywupoH/rSenMLh5+o/A3bJkt9/
        AGbax6yFyUr2VZu1vh3lOOlPreEWS+1+FhnfF1k=
X-Google-Smtp-Source: AJdET5ckhwy1kJF9v0DYLIcT/SbSLOAyk2xRJ8PDh2tqFq4p/WdkgUSIPsl1gNC8y3H+lQ/oVUFfPRdux/UKStWdS1E=
X-Received: by 2002:a1f:97d1:: with SMTP id z200mr6533886vkd.15.1541923314625;
 Sun, 11 Nov 2018 00:01:54 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-7-newren@gmail.com>
 <20181111065338.GF30850@sigill.intra.peff.net>
In-Reply-To: <20181111065338.GF30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 11 Nov 2018 00:01:43 -0800
Message-ID: <CABPp-BGF8C5vhyVbAwpmXeii452fBgtvL4dPRLWdOPxLiCYR0A@mail.gmail.com>
Subject: Re: [PATCH 06/10] fast-export: when using paths, avoid corrupt stream
 with non-existent mark
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:53 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:08PM -0800, Elijah Newren wrote:
>
> > If file paths are specified to fast-export and multiple refs point to a
> > commit that does not touch any of the relevant file paths, then
> > fast-export can hit problems.  fast-export has a list of additional refs
> > that it needs to explicitly set after exporting all blobs and commits,
> > and when it tries to get_object_mark() on the relevant commit, it can
> > get a mark of 0, i.e. "not found", because the commit in question did
> > not touch the relevant paths and thus was not exported.  Trying to
> > import a stream with a mark corresponding to an unexported object will
> > cause fast-import to crash.
> >
> > Avoid this problem by taking the commit the ref points to and finding an
> > ancestor of it that was exported, and make the ref point to that commit
> > instead.
>
> As with the earlier tag commit, I wonder if this might depend on the
> context in which you're using fast-export. I suppose that if you did not
> feed the ref on the command line that we would not be dealing with it at
> all (and maybe that is the answer to my question about the tag thing,
> too).

Right, if you didn't feed the ref on the command line, we're not
dealing with the ref at all, so the code here doesn't affect any such
ref.

> It does seem funny that the behavior for the earlier case (bounded
> commits) and this case (skipping some commits) are different. Would you
> ever want to keep walking backwards to find an ancestor in the earlier
> case? Or vice versa, would you ever want to simply delete a tag in a
> case like this one?
>
> I'm not sure sure, but I suspect you may have thought about it a lot
> harder than I have. :)

I'm not sure why you thought the behavior for the two cases was
different?  For both patches, my testcases used path limiting; it was
you who suggested employing a negative revision to bound the commits.

Anyway, for both patches assuming you haven't bounded the commits, you
can attempt to keep walking backwards to find an earlier ancestor, but
the fundamental fact is you aren't guaranteed that you can find one
(i.e. some tag or branch points to a commit that didn't modify any of
the specified paths, and nor did any of its ancestors back to any root
commits).  I hit that case lots of times.  If the user explicitly
requested a tag or branch for export (and requested tag rewriting),
and limited to certain paths that had never existed in the repository
as of the time of the tag or branch, then you hit the cases these
patches worry about.  Patch 4 was about (annotated and signed) tags,
this patch is about unannotated tags and branches and other refs.

If you think about using negative revisions, for both cases, then
again you can keep walking back history to try to find a commit that
your tag or branch or ref can point to, but if you get back to the
negative revisions, then you are in the range the user requested to be
omitted from the resulting repository.  Sounds like tag/ref deletion
to me.

>
> > diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> > index a3c044b0af..5648a8ce9c 100644
> > --- a/builtin/fast-export.c
> > +++ b/builtin/fast-export.c
> > @@ -900,7 +900,18 @@ static void handle_tags_and_duplicates(void)
> >                       if (anonymize)
> >                               name = anonymize_refname(name);
> >                       /* create refs pointing to already seen commits */
> > -                     commit = (struct commit *)object;
> > +                     commit = rewrite_commit((struct commit *)object);
> > +                     if (!commit) {
> > +                             /*
> > +                              * Neither this object nor any of its
> > +                              * ancestors touch any relevant paths, so
> > +                              * it has been filtered to nothing.  Delete
> > +                              * it.
> > +                              */
> > +                             printf("reset %s\nfrom %s\n\n",
> > +                                    name, sha1_to_hex(null_sha1));
> > +                             continue;
> > +                     }
>
> This hunk makes sense.

Cool, this was the entirety of the code...so does this mean that the
code makes more sense than my commit message summary did?  ...and
perhaps that my attempts to answer your questions in this email
weren't necessary anymore?

> > --- a/t/t9350-fast-export.sh
> > +++ b/t/t9350-fast-export.sh
> > @@ -386,6 +386,30 @@ test_expect_success 'path limiting with import-marks does not lose unmodified fi
> >       grep file0 actual
> >  '
> >
> > +test_expect_success 'avoid corrupt stream with non-existent mark' '
> > +     test_create_repo avoid_non_existent_mark &&
> > +     (
> > +             cd avoid_non_existent_mark &&
> > +
> > +             touch important-path &&
> > +             git add important-path &&
> > +             test_commit initial &&
> > +
> > +             touch ignored &&
> > +             git add ignored &&
> > +             test_commit whatever &&
> > +
> > +             git branch A &&
> > +             git branch B &&
> > +
> > +             echo foo >>important-path &&
> > +             git add important-path &&
> > +             test_commit more changes &&
> > +
> > +             git fast-export --all -- important-path | git fast-import --force
> > +     )
> > +'
>
> Similar comments apply about "touch" and "test_commit" to what I wrote
> for the earlier patch.

Thanks; will fix.
