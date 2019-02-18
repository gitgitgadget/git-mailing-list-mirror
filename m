Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FEA01F453
	for <e@80x24.org>; Mon, 18 Feb 2019 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfBRXfr (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 18:35:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37421 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBRXfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 18:35:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so716992wmg.2
        for <git@vger.kernel.org>; Mon, 18 Feb 2019 15:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ddVyOIQ3tHleq0vdmSvSMTNTw1Ww1/hbhx+jjCrWzs=;
        b=GaMN/eKqFnzaWxem7p81rjMDFEP/KWA9GOuUG1NcweNjrLqHfE2vnfYYSkoQ+fp9Qf
         p4qaXWbS55Fv/f7AWEPGQu+Csi1L2uOuFa34ToJ30dsgM56Snh1EaBxISw94nCOdmNzF
         C8a3ktRA3cKVbbrQOZDw8DZ/niX+oXrArDlJvj/PJX9Nag3ZuDb6L+ADPjNdGet4N0PG
         Jd9c5DKGiB7wbgx1Fqvmmys++Kt0SF0JdR8TNJu5qxL94PlnRnQIMRzqbLZg1ruGbnEG
         eY9Y2YqYvtjQ7IgVzx9auoSFTApudcMjo8wpHoHssWmmr/VmexZoeU0fK2GOc25Xeft3
         k96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ddVyOIQ3tHleq0vdmSvSMTNTw1Ww1/hbhx+jjCrWzs=;
        b=eOrumAHUGkS7g8IZwPBGqfGb3VHKPfVHMZnwxTdKiM8eha1Bj9dc6XAa1N+0USP/+x
         0IJ3l+6GqCuTjYl7BlmdxehJYlEjE77nxN/0UhhFImoV2BxefACFrT7v1Eqj4SmQuUj8
         m9j2dj5kGaszt6Ew8b/BPj++2CTLmbULl8JgxGuaLuDuvQTSfTt9UqtSjwS5PKYoLKSg
         i/dD7iKklpTmds83IelMRKHqBc67LyCoJSBpanvcePd/UBX4jO3+FMZaAKY4werEfHdp
         o3U+CwcgAU+TMIvzn9JEF/aOCqzcJsturWdCDSLhDlCsrBdyBUeBQn4Caslpi8yxxqKV
         mC8A==
X-Gm-Message-State: AHQUAub/Lmc3E2fD6gmlTvVvxxM53fjp2MH33RH+N/pNPAuH2a60k6b4
        Bsvd5CggC3Qya3qa0aM0YDU=
X-Google-Smtp-Source: AHgI3IbNinpZ8kN3LXoJ0V+ZBbD83lo2bdk3Ci43NApH5qkKXxdG8Exv668kJEEZYdbvtl0AhCOaXw==
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr772327wmf.32.1550532944465;
        Mon, 18 Feb 2019 15:35:44 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id 62sm32172223wra.46.2019.02.18.15.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 15:35:42 -0800 (PST)
Date:   Mon, 18 Feb 2019 23:35:41 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH 2/2] clone: use dir-iterator to avoid explicit dir
 traversal
Message-ID: <20190218233541.GK6085@hank.intra.tgummerer.com>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
 <20190215154913.18800-3-matheus.bernardino@usp.br>
 <20190216143824.GJ6085@hank.intra.tgummerer.com>
 <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW60a+zz9J+u0HiRuTy-FKYN4s95fCcR3mgJz0hUokhTCQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/18, Matheus Tavares Bernardino wrote:
> On Sat, Feb 16, 2019 at 12:38 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/15, Matheus Tavares wrote:
> > > -     struct dirent *de;
> > > -     struct stat buf;
> > >       int src_len, dest_len;
> > > -     DIR *dir;
> > > -
> > > -     dir = opendir(src->buf);
> > > -     if (!dir)
> > > -             die_errno(_("failed to open '%s'"), src->buf);
> > > +     struct dir_iterator *iter;
> > > +     int iter_status;
> > >
> > >       mkdir_if_missing(dest->buf, 0777);
> > >
> > > +     iter = dir_iterator_begin(src->buf);
> > > +
> > >       strbuf_addch(src, '/');
> > >       src_len = src->len;
> > >       strbuf_addch(dest, '/');
> > >       dest_len = dest->len;
> > >
> > > -     while ((de = readdir(dir)) != NULL) {
> > > +     while ((iter_status = dir_iterator_advance(iter)) == ITER_OK) {
> > >               strbuf_setlen(src, src_len);
> > > -             strbuf_addstr(src, de->d_name);
> > > +             strbuf_addstr(src, iter->relative_path);
> > >               strbuf_setlen(dest, dest_len);
> > > -             strbuf_addstr(dest, de->d_name);
> > > -             if (stat(src->buf, &buf)) {
> > > -                     warning (_("failed to stat %s\n"), src->buf);
> > > -                     continue;
> > > -             }
> >
> > Why was this warning removed?  I don't see a corresponding warning in
> > the iterator API.  The one thing the iterator API is doing is that it
> > does an lstat on the path to check if it exists.  However that does
> > not follow symlinks, and ignores possible other errors such as
> > permission errors.
> >
> 
> You are right. I didn't know the differences from lstat and stat. And
> reflecting on this now, I realize that the problem is even deeper:
> copy_or_link_directory follows symlinks but dir-iterator don't, so I
> cannot use dir-iterator without falling back to recursion on
> copy_or_link_directory. Because of that, I thought off adding an
> option for dir-iterator to follow symlinks. Does this seem like a good
> idea?

Hmm looking at how this function is actually called, I don't think we
need to worry about symlinks too much.  It only copies the
.git/objects directory, which normally shouldn't contain any
symlinks.  I think it's still good to preserve the warning, in case
someone gave some object directories bad permissions, but following
symlinks in there may be overly paranoid, dunno.

Adding an option to dir-iterator to follow symlinks may be a good
idea, but it raises a few questions I think, e.g. how are we going to
deal with symlinks that point to a parent directory.  The answer for
this function is that we currently don't and just keep recursing,
until 'stat()' fails, but that is probably not the behaviour we'd want
if we were to add this functionality to dir-iterator.

At this point I'm almost convinced that not following symlinks may be
the better solution here.  That is a change in behaviour though, and
it should be described in the commit message why that change is a good
change.

> Also, I just noticed that dir-iterator follows hidden paths while
> copy_or_link_directory don't. Maybe another option to add for
> dir-iterator?

That feels like quite a special case in 'copy_or_link_directory()'.  I
don't think it's worth adding a feature like that for now, at least
not until we find another use case for it.  It's easy enough to skip
over hidden directories here.

> > If there is a good reason to remove the warning, that would be useful
> > to describe in the commit message.
> >
> > > -             if (S_ISDIR(buf.st_mode)) {
> > > -                     if (de->d_name[0] != '.')
> > > -                             copy_or_link_directory(src, dest,
> > > -                                                    src_repo, src_baselen);
> > > +             strbuf_addstr(dest, iter->relative_path);
> > > +
> > > +             if (S_ISDIR(iter->st.st_mode)) {
> > > +                     if (iter->basename[0] != '.')
> > > +                             mkdir_if_missing(dest->buf, 0777);
> > >                       continue;
> > >               }
> > >
> > >               /* Files that cannot be copied bit-for-bit... */
> > > -             if (!strcmp(src->buf + src_baselen, "/info/alternates")) {
> > > +             if (!strcmp(iter->relative_path, "info/alternates")) {
> > >                       copy_alternates(src, dest, src_repo);
> > >                       continue;
> > >               }
> > > @@ -463,7 +458,11 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
> > >               if (copy_file_with_time(dest->buf, src->buf, 0666))
> > >                       die_errno(_("failed to copy file to '%s'"), dest->buf);
> > >       }
> > > -     closedir(dir);
> > > +
> > > +     if (iter_status != ITER_DONE) {
> > > +             strbuf_setlen(src, src_len);
> > > +             die(_("failed to iterate over '%s'"), src->buf);
> > > +     }
> >
> > Interestingly enough, this is not something that can currently
> > happen if I read the dir-iterator code correctly.  Even though the
> > dir_iterator_advance function says it can return ITER_ERROR, it never
> > actually does.  The only way the iter_status can be not ITER_DONE at
> > this point is if we would 'break' out of the loop.
> >
> > I don't think it hurts to be defensive here in case someone decides to
> > break out of the loop in the future, just something odd I noticed
> > while reviewing the code.
> >
> 
> Yes, I also noticed that. But I thought it would be nice to make this
> check so that this code stays consistent to the documentation at
> dir-iterator.h (although implementation is different).

Yeah, I'm not opposed to keep this check to be more defensive against
future changes of the API and the code here.

> Something I just noticed now is that copy_or_link_directory dies upon
> an opendir error, but dir-iterator just prints a warning and keeps
> going (looking for another file/dir to return for the caller). Is this
> ok? Or should I, perhaps, add a "pedantic" option to dir-iterator so
> that, when enabled, it immediately returns ITER_ERROR when an error
> occurs instead of keep going?

Good point, I failed to notice that during my earlier review.  I do
think a "pedantic" option would be a good idea here, to preserve the
previous behaviour.

> I'm proposing some new options to dir-iterator because as the patch
> that adds it says "There are obviously a lot of features that could
> easily be added to this class", and maybe those would be useful for
> other dir-iterator users. But I don't know if that would be the best
> way of doing it, so any feedback on this will be much appreciated.
> Also, I saw on public-inbox[1] a patchset from 2017 proposing new
> features/options for dir-iterator, but I don't really know if (and
> why) it was rejected. (I couldn't find the patches on master/pu log)

I don't think we should necessarily add new options because the
original patch said we should do so.  Instead the best way to
introduce new options is to introduce them when they are actually
going to be needed in subsequent patches.  So it would be nice to
implement features that are actually needed by your patches, but I
don't think it's worth trying to introduce new features that could
potentially be useful in the future, but where we don't know yet
whether they really will be or not.

I can't recall those patches, and from a quick look at the history I
can't tell why they were never merged.  The what's cooking emails from
Junio around that time may have a bit more background, but I don't
have time to dig them up now.

> [1] https://public-inbox.org/git/1493226219-33423-1-git-send-email-bnmvco@gmail.com/
> 
> Thanks,
> Matheus Tavares
> 
> 
> > >  }
> > >
> > >  static void clone_local(const char *src_repo, const char *dest_repo)
> > > --
> > > 2.20.1
> > >
