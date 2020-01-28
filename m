Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD18C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0E24681
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/Peaobn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA1P4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:56:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51475 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgA1P4n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 10:56:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id t23so3099788wmi.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nO33lYn3rnEUq1+EchJjzDglc7VnZfYYpS9rSYEflq0=;
        b=Y/Peaobnhw3DYcunDHqSm3sb7dSJojqlZaZ2aq3dDVI1xqXQGc1sH2tw/JTWSIPCWK
         mrGoC/xxVT+6Vjc9SHUSmNe4Xo9UzZQA8TM3xMlyXPs0d+1VW18Eo8Cb9ef1CbYL7cOm
         cxmRDj4IYEEInKZVp9c9JGzb6qj461yONbH+mnD925+J3x0SGDn5bGFe/DM0RgjZPsp/
         Rj7xrvg6F52G01t7sdAxF8ZtUW3n1qqD7FboWTBT/d3rXLr9WBtwzzrfBggqtge1zWNO
         MRq8/Hv+1utkF36M4eJNkbATyR8G0Q7vY//t1Z/ZruOc+7HdIhgT/a+qvFKS713F+vlQ
         h5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nO33lYn3rnEUq1+EchJjzDglc7VnZfYYpS9rSYEflq0=;
        b=oT6shvrUDK6N1tO9mdmksTKV2rRJRc/zxkoWTATHbPL2HVqJ10CbOIaV7Q6a/M3Aea
         3k8mPoxqqPU4cW6RKo0/YJDYuDeOINsIP87VBi0QRn1wOO7gaxFlkehUXVPbH+o4Aa8L
         R7JlMkKFNuqDJ5WKFRbKv3b5u+DaQboa6CN+HuoVj6o9GG+r/QRi3Ym5JjtaSNTsTAOb
         4t/X7le19IVTi8pVd9MNd/TXuPo4hn6pNwoVjlP+hVJ0+L3J0bP2OEcDjk0Oeiqjd3v/
         9Q3yIbsGNelRtxw5Pt53kp0ngmWYX38WzrBo1ZNIuW3oMlpEeUpR6Xg3G3U2h7J6nFjH
         ssoA==
X-Gm-Message-State: APjAAAXLI390pYuRpdnDdQeecooaR1RLVJpOqpDt6Txaly0ThdsOl3El
        t5JYbjFKlC+97XQP8NOavSyIJMnBIzHLz21BPWKUGg==
X-Google-Smtp-Source: APXvYqwWD5aYQh3YPLtap18Ww5fhc7LkM4cHMNzsDW1DnmBPi05vm4S0Xmakr9NveVmUpRL1ZA2ZU1Q86JoTXBnRgjo=
X-Received: by 2002:a05:600c:2c0b:: with SMTP id q11mr5707279wmg.2.1580226999701;
 Tue, 28 Jan 2020 07:56:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com> <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
In-Reply-To: <20200128073100.GA563058@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Jan 2020 16:56:26 +0100
Message-ID: <CAFQ2z_MXDODBmsCVPdvNQzhFSYchq77mJCxw9P0kPSmSnsTZqQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 8:31 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 27, 2020 at 02:22:24PM +0000, Han-Wen Nienhuys via GitGitGadg=
et wrote:
>
> > [...]
>
> I'll try to add my 2 cents to all of the XXX spots you flagged.
>

thanks! that was really helpful.

>
> Some thoughts on compatibility:
>
> The idea of the config changes is that older versions of Git will either
> complain about repositoryformatversion (if very old), or will complain
> that they don't know about extensions.refFormat. But the changes you
> made in patch 1 indicate that existing versions of Git won't consider it
> to be a Git repository at all!
>
> I think this is slightly non-ideal, in that we'd continue walking up the
> tree looking for a Git repo. And either:
>
>   - we'd find one, which would be confusing and possibly wrong
>
>   - we wouldn't, in which case the error would be something like "no git
>     repository", and not "your git repository is too new"
>
> So it would be really nice if we continued to have a HEAD file (just
> with some sentinel value in it) and a refs/ directory, so that existing
> versions of Git realize "there's a repository here, but it's too new for
> me".

You have good points.

JGit currently implements what we have here, as this is what's spelled
out in the spec that Shawn posted  back in the day. It's probably
acceptable to this, though, as the reftable support has only landed in
JGit very recently and will probably appear very experimental to
folks.

How would the layout be then? We'll have

  HEAD - dummy file
  reftable/ - the tables
  refs/ - dummy dir

where shall we store the reftable list? maybe in a file called

  reftable-list

If we have both HEAD/refs + (refable/reftable-list), what should we
put there to ensure that no git version actually manages to use the
repository? (what happens if someone deletes the version setting from
the .git/config file)

> > +/* XXX which ordering are these? Newest or oldest first? */
> >  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, vo=
id *cb_data);
> >  int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_f=
n fn, void *cb_data);
>
> The top one is chronological order (i.e., reading the file from start to
> finish), and the latter is reverse-chronological (seeking backwards in
> the file).

thanks, I put in a commit to clarify this.

> > +     err =3D merged_table_seek_ref(mt, &ri->iter, prefix);
> > +     /* XXX what to do with err? */
>
> Hmm, I don't think you can return an error from iterator_begin(). It
> would probably be OK to record the error in your local struct, and then
> later return ITER_ERROR from iterator_advance().

good point. I did that.

> > +     /* XXX - are we allowed to mutate the input data? */
> > +     qsort(transaction->updates, transaction->nr,
> > +           sizeof(struct ref_update *), ref_update_cmp);
>
> I don't offhand know of anything that would break, but it's probably a
> bad idea to do so. If you need a sorted view, can you make an auxiliary
> array-of-pointers? Also, the QSORT() macro is a little shorter and has
> some extra checks.

Done.

> In the "unsafe" version, the memory belongs to a static buffer inside
> the function. You shouldn't need to free it.


OK.

> > +static int
> > +reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator=
)
> > [...]
> > +             /* XXX const? */
> > +             memcpy(&ri->oid.hash, ri->log.new_hash, GIT_SHA1_RAWSZ);
>
> You'd want probably want to use hashcpy() here (or better yet, use
> "struct object_id" in ri->log, too, and then use oidcpy()).

It's more practical in the library to use pointers rather than fixed
size arrays, so it'll be hashcpy.

> But that raises a question: how ready are reftables to handle non-sha1
> object ids? I see a lot of GIT_SHA1_RAWSZ, and I think the on-disk
> format actually has binary sha1s, right? In theory if those all become
> the_hash_algo->rawsz, then it might "Just Work" to read and write
> slightly larger entries.

The format fixes the reftable at 20 bytes, and there is not enough
framing information to just write more data. We'll have to encode the
hash size in the version number somehow, eg. we could use the  higher
order bit of the version byte to encode it, for example.

But it needs a new version of the spec. I think it's premature to do
this while v1 of reftable isn't in git-core yet.


> The committer entry we pass back to each_reflog_ent_fn should be the
> full "Human Name <email@host>".

thx, done.

> I agree that we'd generally want to expire and compact all entries at
> once. Unfortunately I think this per-ref interface is exposed by
> git-reflog. I.e., you can do "git reflog expire refs/heads/foo".
>
> Could we add an extra API call for "expire everything", and then:

I took note of your remarks, and added a BUG() for now.

I'll focus on getting the CI on gitgitgadget to build this code first.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
