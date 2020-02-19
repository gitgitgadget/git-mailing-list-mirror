Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A5C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC9824654
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crTV8Gec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgBSTcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:32:15 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34616 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBSTcP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:32:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so1321024otl.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nghqI7m2uJXnAX0tPzIiPiQeGy43uGQjUecjRnWEnWI=;
        b=crTV8Gec04VwTmVw3vBP7a7GKTWZH39S+1haI28eDKw2HqewDgfjywRZgeJBNW5f3U
         ILkAdQIFYT27kvKv5OfXCr4gALBiXjKsgxtnkWj1han2gg6d1HREbC21iP7M1OSUwJBP
         Gw9aj9fhTYEdmZXNQPyBMwPRuvuEHEwmoG9wQ79WQtL1J0rc7yA4kqHvqHpVo0go0dMq
         F0U+uSbP2IZfQvG3xjjRHXWPT1uJAn9SRm0djV6Ym4lu6szofc7kO4qYQ0CIJh5jVytc
         vqFTzcWky1ZwIqNK4zA1/fay5Xjm/QLo31XbJ3aVRB0OyUNgG5ed/gbrNfA1iQxgyg11
         4lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nghqI7m2uJXnAX0tPzIiPiQeGy43uGQjUecjRnWEnWI=;
        b=F54XPD0AzfZoaiaAwBzekpiPADdt0tH9L0f6Qg+Hq8Vv9YaOALhLdCHC5AknmLS4HF
         xBDbNPl9JScUUSqTiGx8RfOm9n0jtemsx+MxM4r2ULafGZlwv7x/QjJw8mEkT/ntAhm8
         KTkuXM7XK2/QaEWmpuYykGMuGuJ/O7BrSd5J0Fd9D9e8GsAzno70PibwdFloEdI4LlKQ
         et43iFEXmxshULjTSfrIHC65CsK6xiMqgjuH1OVCCuaNCoVlniAspCPHvKzrKe1k800e
         MkwCzcfftxsEVtQZIuBOnoysSOSFhv1Ts/DKz2HJScFxGgy+EcGrqv4m1oVDIdID1HPo
         x4jA==
X-Gm-Message-State: APjAAAXfftEt4vU8RAx0GxuVpJ12V6HLC7p0jaI3oknepGMsvWDpUJtQ
        6mMG81SWGAw4ph7uTjF6dwY4kZK71Qhq0G9W0KY=
X-Google-Smtp-Source: APXvYqwMfLyCsa+r+8TMQvq6QPsIKF7FZVQEZAdcoZ8wc5BUzNrVF9R9MYoH2Kz4Q1aCHemUdOREjFD5jISGiZQ3kpY=
X-Received: by 2002:a05:6830:13ca:: with SMTP id e10mr21060049otq.267.1582140734021;
 Wed, 19 Feb 2020 11:32:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.v3.git.git.1582064105813.gitgitgadget@gmail.com>
 <pull.712.v4.git.git.1582131847.gitgitgadget@gmail.com> <ba297fd67bb98bd06408241030cf42f410d5d366.1582131847.git.gitgitgadget@gmail.com>
 <xmqq4kvmfmjy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4kvmfmjy.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 Feb 2020 11:32:03 -0800
Message-ID: <CABPp-BFH2qgM2oR-6g-3RgPegpq4yZujizxCb=_Ax0g2WFOYYw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] merge-recursive: fix the refresh logic in update_file_flags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 10:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > If we need to delete a higher stage entry in the index to place the file
> > at stage 0, then we'll lose that file's stat information.  In such
> > situations we may still be able to detect that the file on disk is the
> > version we want (as noted by our comment in the code:
> >   /* do not overwrite file if already present */
> > ), but we do still need to update the mtime since we are creating a new
> > cache_entry for that file.  Update the logic used to determine whether
> > we refresh a file's mtime.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-recursive.c                    | 7 +++++--
> >  t/t3433-rebase-across-mode-change.sh | 2 +-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index aee1769a7ac..e6f943c5ccc 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -998,10 +998,13 @@ static int update_file_flags(struct merge_options *opt,
> >               free(buf);
> >       }
> >  update_index:
> > -     if (!ret && update_cache)
> > -             if (add_cacheinfo(opt, contents, path, 0, update_wd,
> > +     if (!ret && update_cache) {
> > +             int refresh = (!opt->priv->call_depth &&
> > +                            contents->mode != S_IFGITLINK);
> > +             if (add_cacheinfo(opt, contents, path, 0, refresh,
> >                                 ADD_CACHE_OK_TO_ADD))
> >                       return -1;
>
> Hmph, !.call_depth would avoid resetting update_wd to 0, so the only
> difference this patch makes is when the caller of this helper passed
> (update_wd == 0) during the outermost merge.  We did not tell
> add_cacheinfo() to refresh, and refresh_cache_entry() was not
> called.  But the new code forces refresh to happen for normal
> entries.  The proposed log message explains that a refresh is needed
> for a new cache entry, but if I am reading the code correctly, this
> function is called with !update_wd from two places, one of which is
> the "Adding %s" /* do not overwrite ... */ the log message mentions.
>
> But the other one?  When both sides added identically, we do have an
> up-to-date result on our side already, so shouldn't we avoid forcing
> update_wd in that case?

This change doesn't force update_wd (write out a new file, also
implies refreshing is needed), this only forces refreshing (check
stat-related fields of existing file).

> I do not think passing refresh==1 in that case will produce an
> incorrect result, but doesn't it force an unnecessary refreshing?
>
> Puzzled.

It does force a refreshing, and it is a necessary one based on
merge-recursive's design.  You can verify by putting an "exit 1" right
after "git merge side" in t6022.37 ("avoid unnecessary update,
rename/add-dest").  If you do that, then cd into the test results
directory, you'll see the following:

$ git diff-index --name-only HEAD
newfile
$ git update-index --refresh
$ git diff-index --name-only HEAD
$

After my patch, newfile won't be stat dirty.


As for why it's needed, let's dig into the code case you are
highlighting; it's code for a rename/add conflict case:

            } else if ((dst_other.mode == ren1->pair->two->mode) &&
                   oideq(&dst_other.oid, &ren1->pair->two->oid)) {
                /*
                 * Added file on the other side identical to
                 * the file being renamed: clean merge.
                 * Also, there is no need to overwrite the
                 * file already in the working copy, so call
                 * update_file_flags() instead of
                 * update_file().
                 */
                if (update_file_flags(opt,
                              ren1->pair->two,
                              ren1_dst,
                              1, /* update_cache */
                              0  /* update_wd    */))
                    clean_merge = -1;


Note that the fact that this was a rename/add conflict means that
unpack_trees() will create an index with two unstaged entries for the
given file, while leaving the file alone on disk.  When this section
of code calls update_file_flags, it skips over the bits about updating
the working tree (since update_wd is 0), then calls add_cacheinfo with
refresh=1 (was refresh=0 before my patch).  add_cacheinfo() will then
call make_cache_entry() and add_index_entry(), which will end up
replacing the two unstaged entries in the index with the new stage 0
entry, but the new stage 0 entry will not have all 0 ce_stat_data.
Only if refresh=1 will it then call refresh_cache_entry().

So, this was a bug all along for BOTH cases, we just didn't notice before.


(And if you are complaining that we had stat information that we could
have used if it hadn't been lost based on the design of
merge-recursive, then yes you are correct.  If my current design for
merge-ort works out, then it'll avoid this extra unnecessary stat.
But that's not easy to achieve with the
call-unpack-trees-then-fix-it-up design.)


Elijah
