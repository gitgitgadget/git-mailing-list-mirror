Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C41BD1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 19:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfJLTYR (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 15:24:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:35137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfJLTYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 15:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570908253;
        bh=BR+uld6pZvpjcQVGFL0PNCjWz2GPrrxe5QOOz0YjjO0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i1Okz6vyW8imuecRKNzhocsIEfqV8qrOqAvkM8WQMa8iNWEcCK2rgCMz1NulB8+Vb
         n23ZeRC/0zUU6+WdiTVnZs8IOhNYvTCeuJT9bR77WQGUzQXZfav7t6FjRIboLsFRKB
         K4+5ntWFQQtpLOiQiQ2JNCULDYDP5IwgTjR1igzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1iWcWr21lQ-00Uprq; Sat, 12
 Oct 2019 21:24:13 +0200
Date:   Sat, 12 Oct 2019 21:23:58 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v10 18/36] merge-recursive: add get_directory_renames()
In-Reply-To: <CABPp-BFrFrm1-MdttBDRHMmun++HxwV1tySoDb75f58ObwMwfg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910122122520.3272@tvgsbejvaqbjf.bet>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-19-newren@gmail.com> <nycvar.QRO.7.76.6.1910092044590.46@tvgsbejvaqbjf.bet> <CABPp-BFrFrm1-MdttBDRHMmun++HxwV1tySoDb75f58ObwMwfg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:98pPAsJRyToJY261ZkMeokOqkP2e47RNiEd6OQ09EI+XjCdrTd5
 RBKDlTOx78todR1Zlpo+b9PPdaBR0VMgjWjgzAcpm8cXn0/ZqNNtNkd8p9r2WX+0dXpzIVZ
 hfvthgsirWuN+1yNZTfM3xeZf+xnVUVEh9e+J0aPKBsdRqflGtiM6N52Qk8UAUNu76pE2BE
 2J5QGF7ftUdvJNGoJfsaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHjtpbJuT4k=:EWlSbnqBILTWbk0cdbvYwF
 N8nGHFPmD+4If6qmFHxosOe3g+38xZO0JDBKvllzprTZnXWI24oD0H1o5ptkazstVQvVdx+Yo
 ZnhBLbS6gyRrIYwqo/kpipv3xMbCbLLrpXAYzWg2oDXDB5wATvKwaO9W1yJB5J+ztOY0WkvLM
 G6kWAZB/x03jAPCnBVbbaYlH2AWjmNYkBq+IgtzpL0Sl6+D66svwcrAxpFjL9ZSqpFnFR2Nod
 s3CSXxSUJNDCp4ICa3N///6+/e4XgrcEtzeq6gCUYi08RrVkZ0F0JXxw5Od76O7+N10pMQTCd
 rB96p92b6Cx8llqgVaF/EWFeM5/Fhn1m70g+56585lElyscPE581SuLfv5t/3/el7t8i3G4er
 8ANHxyhdmdePmnl1lrKKtN9vfdRgjQuzo8wdsr2mQH0lmZ+6nc0ryBnoR15j0plCsVKEALwix
 jE1vXCeaXN7+5XdvCzCjf4hvHggR2zw/JpP3KlsxI+EFVBkqKvXk2jPHvIjTR9Owr3shmJ4bm
 Bx7S8JJTiZ1JzHCqIKbWdLriw7//BKKxQfcunC/doDvChl5CKuMONeP6zyGWpetvJIt8kkpOl
 R1yrN0/+0wYykaRTsIHXju+XcKZU0nQ+mbl6tkY0mXmXAwBCx3KH9Dfw0dzNfhoYq3IRmlA13
 ZG2fAWQB5bfCxeuhgg6OY25Mw0BbkYOasnGfFiBCWSkAYhTAqbQytvkWwPiR9DGYrQp+F7pLz
 ItjPqeVNch4ZFgPpmId7hkJPtPihkDbk2uht/XBuSRNVtUtmS5BHaboL0LnRdQZAp6pTHnp1Y
 AEhq1fcaEuScobvvM0T51b2Nj1YWoFbv9fAMEbW4ugUAE2/o8R9Wr7UL6kH/g18uiwvIVjhiL
 GrZCLWJXjh/ISlEo3IiL3dLv1G/HP+llZRTm4quOlavKKOLnvHjMXwCqHJzR3HjEA6Rd+iARG
 yqeNUPq2nWtGg5Y5kHGZTtbS7VJ64eJcBWU+Mu/MyHjpeorS4A2KbCGFDSsmTARcgVSCiJp0C
 xw7RtD8rCtjpFR+Es55+8j/0i4aki2E/SAfQiyntzBI3umZDD1g5obzkiFSB2yr8kPX37TdA0
 776U7kKNUabTGT09KDIBUu3xtrAP45YrW5IF2qftuUtF0b712O/mnsrG7D9uX1rh1FywsQofk
 BaVv0oC5DgPuBjxhRjwr4SMIrHQGfJaLq5ZEWjyqiA9BXcb1XxhxqB7TF8iQBLYHRE1Np+m97
 scdnbRtx414xSBELujzInxnn6r9IUJ9xEEKRmmjyK0bgDZ4w0CFNtXdxf9lY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 11 Oct 2019, Elijah Newren wrote:

> On Wed, Oct 9, 2019 at 1:39 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > sorry about the blast from the past, but I just stumbled over somethin=
g
> > I could not even find any discussion about:
>
> I'm curious what brought you to this part of the codebase, but either
> way, thanks for sending an email with your findings.

Well, you know, it's a loooooong story.

> More comments below...

Thank you so much, they unpuzzled me quite a bit.

Ciao,
Dscho

>
> [...]
> > > @@ -1357,6 +1395,169 @@ static struct diff_queue_struct *get_diffpai=
rs(struct merge_options *o,
> > >       return ret;
> > >  }
> > >
> > > +static void get_renamed_dir_portion(const char *old_path, const cha=
r *new_path,
> > > +                                 char **old_dir, char **new_dir)
> > > +{
> > > +     char *end_of_old, *end_of_new;
> > > +     int old_len, new_len;
> > > +
> > > +     *old_dir =3D NULL;
> > > +     *new_dir =3D NULL;
> > > +
> > > +     /*
> > > +      * For
> > > +      *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
> > > +      * the "e/foo.c" part is the same, we just want to know that
> > > +      *    "a/b/c/d" was renamed to "a/b/some/thing/else"
> > > +      * so, for this example, this function returns "a/b/c/d" in
> > > +      * *old_dir and "a/b/some/thing/else" in *new_dir.
> > > +      *
> > > +      * Also, if the basename of the file changed, we don't care.  =
We
> > > +      * want to know which portion of the directory, if any, change=
d.
> > > +      */
> > > +     end_of_old =3D strrchr(old_path, '/');
> > > +     end_of_new =3D strrchr(new_path, '/');
> > > +
> > > +     if (end_of_old =3D=3D NULL || end_of_new =3D=3D NULL)
> > > +             return;
> > > +     while (*--end_of_new =3D=3D *--end_of_old &&
> > > +            end_of_old !=3D old_path &&
> > > +            end_of_new !=3D new_path)
> > > +             ; /* Do nothing; all in the while loop */
> > > +     /*
> > > +      * We've found the first non-matching character in the directo=
ry
> > > +      * paths.  That means the current directory we were comparing
> > > +      * represents the rename.  Move end_of_old and end_of_new back
> > > +      * to the full directory name.
> > > +      */
> > > +     if (*end_of_old =3D=3D '/')
> > > +             end_of_old++;
> > > +     if (*end_of_old !=3D '/')
> > > +             end_of_new++;
> >
> > Is this intentional? Even after thinking about it for fifteen minutes,=
 I
> > think it was probable meant to test for `*end_of_new =3D=3D '/'` inste=
ad of
> > `*end_of_old !=3D '/'`. And...
>
> Yeah, looks like a mess-up, and yes your suspicion is correct about
> what was intended.
>
> Hilariously, though, no bug results from this.  Since these are paths,
> as canonicalized by git (i.e. not as specified by the user where they
> might accidentally type multiple consecutive slashes), there will
> never be two slashes in a row (because we can't have directories with
> an empty name).  Thus, it is guaranteed at this point that *end_of_old
> !=3D '/', and end_of_new is thus unconditionally advanced.  Further,
> since we wanted to find the _next_ '/' character after end_of_new,
> then there were two cases: (1) end_of_new already pointed at a slash
> character in which case we needed it to be advanced, or (2) end_of_new
> didn't point to a slash character so it wouldn't hurt at all to
> advance it.
>
> > > +     end_of_old =3D strchr(end_of_old, '/');
> > > +     end_of_new =3D strchr(end_of_new, '/');
> >
> > ... while I satisfied myself that these calls cannot return `NULL` at
> > this point, it took quite a few minutes of reasoning.
> >
> > So I think we might want to rewrite these past 6 lines, to make
> > everything quite a bit more obvious, like this:
> >
> >         if (end_of_old !=3D old_path)
> >                 while (*(++end_of_old) !=3D '/')
> >                         ; /* keep looking */
> >         if (end_of_new !=3D new_path)
> >                 while (*(++end_of_new) !=3D '/')
> >                         ; /* keep looking */
>
> I think your if-checks here are not correct.  Let's say that old_path
> was "tar/foo.c" and new_path was "star/foo.c".  The initial strrchr
> will bring both end_of_* variables back to the slash.  The moving left
> while equal will move end_of_old back to old_path (i.e. pointing to
> the "t") and end_of_new back to pointing at "t" as well.  Here's where
> your six alternate lines would kick in, and would leave end_of_old at
> old_path, while moving end_of_new to the '/', making it look like we
> had a rename of "" (the empty string or root directory) to "star"
> instead of a rename of "tar" to "star".  If you dropped your if-checks
> (just having the while loops), then I think it does the right thing.
>
> > There is _still_ one thing that makes this harder than trivial to reas=
on
> > about: the case where one of `*end_of_old` and `*end_of_new` is a slas=
h.
> > At this point, we assume that `*end_of_old !=3D *end_of_new` (more abo=
ut
> > that assumption in the next paragraph), therefore only one of them can
> > be a slash, and we want to advance beyond it. But even if the pointer
> > does not point at a slash, we want to look for one, so we want to
> > advance beyond it.
>
> I should probably add a comment that we want to advance BOTH to the
> next slash.  I would have just used strchr() but it wouldn't advance
> the string if it already points to what I'm looking for.  Actually, I
> guess I could simplify the code by unconditionally advancing by one
> character, then calling strchr().  In other words, simplifying these
> six lines to just
>
>        end_of_old =3D strchr(++end_of_old, '/');
>        end_of_new =3D strchr(++end_of_new, '/');
>
> > I also think that we need an extra guard: we do not handle the case
> > `a/b/c` -> `a/b/d` well. As stated a few lines above, "if the basename
> > of the file changed, we don't care". So we start looking at the last
> > slash, then go backwards, and since everything matches, end up with
> > `end_of_old =3D=3D old_path` and `end_of_new =3D=3D new_path`. The cur=
rent code
> > will advance `end_of_new` (which I think is wrong) and then looks for
> > the next slash in both `end_of_new` and `end_of_old` (which is also
> > wrong).
>
> The current code is slightly convoluted, but I would say it's not
> wrong for this case.  If we renamed a/b/c -> a/b/d, then there isn't a
> directory rename; the leading directory (a/b/) is the same for both.
> You are right that the advancing of end_of_old and end_of_new to the
> next slash would result in what looks like a rename of "a" to "a", but
> the checks at the end checked for this case and only returned
> something for *old_dir and *new_dir if these didn't match; in fact,
> it's the part of the code at the end of your email that you didn't
> comment on, here:
>
> > > +
> > > +     /*
> > > +      * It may have been the case that old_path and new_path were t=
he same
> > > +      * directory all along.  Don't claim a rename if they're the s=
ame.
> > > +      */
> > > +     old_len =3D end_of_old - old_path;
> > > +     new_len =3D end_of_new - new_path;
> > > +
> > > +     if (old_len !=3D new_len || strncmp(old_path, new_path, old_le=
n)) {
> > > +             *old_dir =3D xstrndup(old_path, old_len);
> > > +             *new_dir =3D xstrndup(new_path, new_len);
> > > +     }
> > > +}
> > > [...]
>
> However, we could drop this late check by just doing a simpler earlier
> check to see if end_of_old =3D=3D old_path and end_of_new =3D=3D new_pat=
h
> after the "find first non-equal character" step and before advancing
> to the next '/', and if that condition is found, then return early
> with no match.
>
>
> However, since you highlighted this code, there are two other special
> cases that might be interesting:
>
> 1) What if we are renaming e.g. foo/bar/baz.c ->
> leading/dir/foo/bar/baz.c?  Then after trying to find the first
> non-matching char we'll have end_of_old =3D=3D old_path and *end_of_new =
=3D=3D
> 'f', and the advancing makes it look like "foo" being renamed to
> "leading/dir/foo".  Since the root directory cannot be renamed (it
> always exists on both sides of history), this probably makes sense as
> the right thing to return.
> 2) What if the renaming went the other way, from
> leading/dir/foo/bar/baz.c -> foo/bar/baz.c?  The whole advancing thing
> makes this look like "leading/dir/foo" being renamed to "foo", instead
> of "leading/dir" being renamed to "" (the root directory).  If we
> don't detect it as "leading/dir" being renamed (merged into) the root
> directory, then new files added directly within leading/dir/ on the
> other side of history won't be moved by directory rename detection
> into the root directory.
>
> > Is my reading correct?
>
> I'm not sure if I've answered your questions; let me know if not.  I
> have generated a couple patches to (1) make the code easier to follow,
> and (2) support the rename/merge of a subdirectory into the root
> directory.  They're waiting for the gitgitgadget CI checks right now,
> then I'll send them to the list.
>
