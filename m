Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F85D1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161629AbeBNSIS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:08:18 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37726 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161585AbeBNSIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:08:17 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so8968224plb.4
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qNdkpZ5kOvE6BK/sRUo3HgQJ4CMEwhyg/KnuxvjFpHU=;
        b=RMhcqrLrge6L6J+FWJ8L0TY8hgbj5pXmo2tHpYZvvL3RYPh5oeRh202HjhPSx70HRf
         oh+hA7j59/kREzD1M1Ni5HiXcz/ANW2XXnzEylNSwOtI+63im1zbx07BqlnTL2Rrgl39
         f00VgW4N6/Bk7vsiamYnDKGJBTL7qF4w/IopHA5ekBCK1gGsN+cUD0XS9ndPaHFOVy/H
         3o/U++dc9VsHMA0TnQwVtyF0QhRs7/zQYGWZN4lKqb/LPM5DG1YFstdSnFdmwXCflkcb
         EdS3ynD14qMxoev9zCjTnwUDdAit7w9jOUzVScaTwxQYURiIiR9mt9CTZvN649hnqBrY
         5t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qNdkpZ5kOvE6BK/sRUo3HgQJ4CMEwhyg/KnuxvjFpHU=;
        b=hT3EaXjBNCgrfmGziXko0W1J2/Te797R9QNVyrhwtc0Gvi5rY6nJyX6ri8K2vKiXO2
         Ko6ugX7cJaChcNUfwj6LFfzaP4pmhAyt1fE6LyKQ/7JtBX1yLoAoXmK1bAKgf3gLwATm
         54vdcv//uhhHspiGai5ZKGidHsaRI09rbThO0LTC8G+7O5C7VFxpjAe7B8riN0QVCk09
         zC4+scou6P3oJFUToXi9Es+LGFELwvgn6V5tQk4ih5maG0yiwxDu56Hh1k5QELrXNvS3
         e803eIiYZXMn4x1/Zw0/BiGnI27U2GPJaAxy5MS2UTi2GyXHOuXPVcal0ExyIDcbS93j
         +cvw==
X-Gm-Message-State: APf1xPBU6gVNTE4uPDUTLkYttZ3X1aNaKhrVH0QY49g3dw+soxoigICy
        DcYzRHbGPGrMMrOeCkOGPJ11bg==
X-Google-Smtp-Source: AH8x227/jssASfKQJ6CU0ca6A5kwUmmAtHcEgqSV4GdoZlWQ7wZUS8TmoVu+SWKmTvOFTqkMeuMl5w==
X-Received: by 2002:a17:902:6e8c:: with SMTP id v12-v6mr4983plk.424.1518631696816;
        Wed, 14 Feb 2018 10:08:16 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id b67sm10317985pfm.56.2018.02.14.10.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 10:08:15 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:08:14 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 14/26] sha1_file: allow prepare_alt_odb to handle
 arbitrary repositories
Message-ID: <20180214180814.GA139458@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
 <20180213012241.187007-15-sbeller@google.com>
 <CACsJy8DmXrO9bxv10DsDpSWxm2BiZwwfhso4=ZRQs_xhrpAgfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DmXrO9bxv10DsDpSWxm2BiZwwfhso4=ZRQs_xhrpAgfg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Duy Nguyen wrote:
> On Tue, Feb 13, 2018 at 8:22 AM, Stefan Beller <sbeller@google.com> wrote:
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  object-store.h |  3 +--
> >  sha1_file.c    | 21 +++++++++++----------
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/object-store.h b/object-store.h
> > index d96a16edd1..add1d4e27c 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -61,7 +61,6 @@ struct packed_git {
> >         char pack_name[FLEX_ARRAY]; /* more */
> >  };
> >
> > -#define prepare_alt_odb(r) prepare_alt_odb_##r()
> > -extern void prepare_alt_odb_the_repository(void);
> > +void prepare_alt_odb(struct repository *r);
> >
> >  #endif /* OBJECT_STORE_H */
> > diff --git a/sha1_file.c b/sha1_file.c
> > index d18ce3aeba..f046d560f8 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -677,21 +677,22 @@ int foreach_alt_odb(alt_odb_fn fn, void *cb)
> >         return r;
> >  }
> >
> > -void prepare_alt_odb_the_repository(void)
> > +void prepare_alt_odb(struct repository *r)
> >  {
> > -       const char *alt;
> > -
> > -       if (the_repository->objects.alt_odb_tail)
> > +       if (r->objects.alt_odb_tail)
> >                 return;
> >
> > -       alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> > +       r->objects.alt_odb_tail = &r->objects.alt_odb_list;
> > +
> > +       if (!r->ignore_env) {
> > +               const char *alt = getenv(ALTERNATE_DB_ENVIRONMENT);
> 
> If one day the majority of git moves to use 'struct repository', then
> ALTERNATE_DB_ENVIRONMENT is always ignored because ignore_env is
> always true. I think if you ignore_env, then you still need to get
> this "alt" from  'struct raw_object_store' (or 'struct repository').
> 
> Since you get lots of getenv() in repo_setup_env(), I think this
> getenv(ALTERNATE_DB_ENVIRONMENT) belongs there too. Then here, if
> ignore_env is true, you read r->objects.alt or something instead of
> doing getenv().
> 
> I really want to kill this getenv() in this code, which is basically
> delayed initialization because we haven't done proper init on
> the_repo. I realize that it cannot be done earlier, when
> prepare_alt_odb() does not even have a  'struct repository *' to work
> with. Would it be ok if I contributed a patch on top of your series to
> basically do repo_init(&the_repo) for all builtin/external commands
> (and fix all the bugs that come with it)? Then we would not need
> ignore_env here anymore.

At some point yes we would definitely want the setup code to fully
initialize a repository object (in this case the_repository).  And I
would even like to change the function signatures of all the builtin
commands to take a repository object so that they don't implicitly rely
on the_repository at all.

When I introduced struct repository I seem to remember there being a
couple things which were different about setup that made it difficult to
simply call repo_init() on the_repository.  If you can fix whatever
those issues with setup were (I can't remember all of them) then that
would be great :)

> 
> > +               if (!alt)
> > +                       alt = "";
> >
> > -       the_repository->objects.alt_odb_tail =
> > -                       &the_repository->objects.alt_odb_list;
> > -       link_alt_odb_entries(the_repository, alt,
> > -                            PATH_SEP, NULL, 0);
> > +               link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);
> > +       }
> >
> > -       read_info_alternates(the_repository, get_object_directory(), 0);
> > +       read_info_alternates(r, r->objects.objectdir, 0);
> >  }
> >
> >  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
> > --
> > 2.16.1.73.ga2c3e9663f.dirty
> >
> 
> 
> 
> -- 
> Duy

-- 
Brandon Williams
