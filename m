Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E59C34022
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F68246A0
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 15:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH8EJdmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgB0Pe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:34:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34979 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbgB0Pe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 10:34:58 -0500
Received: by mail-io1-f66.google.com with SMTP id h8so3668467iob.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGYS2++rQrvLqry/ZnI056QPHt3JS75tP2w9U9xF/us=;
        b=JH8EJdmh84Tbhvj9S8W47k+UlebL3HwbUGoCzEa85zxYyePhwc0PZznMaWaFRNMfup
         yyyI6etkMd163rHvwJ0PGR3a0Zq27ZYjctubS3N/wYj5gOhK3GUtuk20/teGCdkH9hLI
         tRVq5UZk3VJwUwFAuo3+2VPL3bfzGtLAfSdvo0FcAEK/Zl2m44vpsiievgGaTmBZJzHv
         ZiyU1nFoGnE/oSXbpIjyNBixTwr0qAm0leNLkSltQ/IEobjE93XGvaX5EVkrKzZpCewl
         lYzOvMrDJ0Sm25o9OXV/+JbYuqgEfortgfvW5jR4JkLwKPMCbQVq9mmY6mpMesE1ghFb
         xA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGYS2++rQrvLqry/ZnI056QPHt3JS75tP2w9U9xF/us=;
        b=qvw7Lve61hTm36BQTgaaxk/RSKirvDxUXAVMwS+ANByBIYZahjohUyTqCi2MRziKrk
         n/zMWX1eIHFke6R+s9f2kQTsxlIRU7PVcc1lj1bk3f3o4mCRsmWXHCpvvAMMNTD6EOWk
         YO6NS1FD45Bs50v72gUwj9l8LXvwleKo2RmrMAuwYN702Fqv31KqsFuHeU/c87N8PMgT
         koS7t9aiLJdkhGRpDe/s9F25uOl+J4tO7d+Sv+z+gG5dktQpSJ8iIJb0rLgw+4D+FSHM
         DVrRCNfTlmxDIl5j8UYgHwA2qW6J3Ww66viEJTnM8w3dAWInhldJvBOjZco63PXyMQaf
         xo+g==
X-Gm-Message-State: APjAAAVcJRVSEwBub9HgWBaDNcpfs3a4l4+C1yohk70pDlZaPEjw5vP9
        HBfV3qLu1xzd4LbU1ZhQ5xwFfUFIeD3p5RlxTCg=
X-Google-Smtp-Source: APXvYqyqe4DgXHztWV+8Nwqtw7+u1Tqy4Hwzx40mj/qw84aT6Z4wB/XiYgjwRU3s1TRopnz6Ua3a3l8CzZbsntdTixE=
X-Received: by 2002:a05:6602:2113:: with SMTP id x19mr5214895iox.227.1582817697496;
 Thu, 27 Feb 2020 07:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20200226101429.81327-1-mirucam@gmail.com> <20200226101429.81327-3-mirucam@gmail.com>
 <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhd5i1na.fsf@gitster-ct.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 27 Feb 2020 16:34:46 +0100
Message-ID: <CAN7CjDDwgR=y8gyYmDzmuTW3AKvb1N=EdCtH-8Tr7T=b6cG5gQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El mi=C3=A9., 26 feb. 2020 a las 20:34, Junio C Hamano
(<gitster@pobox.com>) escribi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > +static int register_good_ref(const char *refname,
> > +                          const struct object_id *oid, int flags,
> > +                          void *cb_data)
> > +{
> > +     struct string_list *good_refs =3D cb_data;
> > +
> > +     string_list_append(good_refs, oid_to_hex(oid));
> > +     return 0;
> > +}
> > +
> > +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_a=
rray *rev_argv)
> > +{
> > +     struct string_list good_revs =3D STRING_LIST_INIT_DUP;
> > +     char *term_good =3D xstrfmt("%s-*", terms->term_good);
> > +
> > +     for_each_glob_ref_in(register_good_ref, term_good,
> > +                          "refs/bisect/", &good_revs);
> > +
> > +     argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", =
"--not", NULL);
> > +     for (int i =3D 0; i < good_revs.nr; i++)
> > +             argv_array_push(rev_argv, good_revs.items[i].string);
> > +
> > +     string_list_clear(&good_revs, 0);
> > +     free(term_good);
>
> Why do you need good_revs string_list in the first place?  Wouldn't
> it be simpler and easier to understand to pass in the argv as part
> of the callback data and push the good refs in the callback function?
>
Ok, I will do it that way.

> > +static int prepare_revs(struct bisect_terms *terms, struct rev_info *r=
evs)
> > +{
> > +     int res =3D 0;
> > +     struct argv_array rev_argv =3D ARGV_ARRAY_INIT;
> > +
> > +     prepare_rev_argv(terms, &rev_argv);
> > +
> > +     /*
> > +      * It is important to reset the flags used by revision walks
> > +      * as the previous call to bisect_next_all() in turn
> > +      * setups a revision walk.
>
> "setup" is not a verb X-<.  "... in turn sets up a ..." would be OK.
>
Noted.
> > +static int process_skipped_commits(FILE *fp, struct bisect_terms *term=
s, struct rev_info *revs)
> > +{
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +
> > +     if (fprintf(fp, "# only skipped commits left to test\n") < 1)
> > +             return -1;
> > +
> > +     while ((commit =3D get_revision(revs)) !=3D NULL) {
> > +             struct strbuf commit_name =3D STRBUF_INIT;
> > +             format_commit_message(commit, "%s",
> > +                                   &commit_name, &pp);
> > +             fprintf(fp, "# possible first %s commit: [%s] %s\n",
> > +                     terms->term_bad, oid_to_hex(&commit->object.oid),
> > +                     commit_name.buf);
> > +             strbuf_release(&commit_name);
> > +             clear_commit_marks(commit, ALL_REV_FLAGS);
>
> clear_commit_marks() is to clear the given flag bits from the named
> commit *AND* all of its ancestors (recursively) as long as they have
> these bits on, and it typically is used in order to clean up the
> state bits left on objects _after_ a revision walk is _done_.
>
> Calling it, especially to clear ALL_REV_FLAGS that contains crucial
> flag bits necessary to drive get_revision(), inside a loop that is
> still walking commits one by one by calling get_revision(), is
> extremely unusual.
>
> It would be surprising if this code were correct.  It may be that it
> happens to (appear to) work because parents of the commit hasn't
> been painted and calling the helper only clears the mark from the
> commit (so we won't see repeated "painting down to the root commit")
> in which case this might be an extremely expensive looking variant
> of
>
>         commit->object.flags &=3D ~ALL_REV_FLAGS;
>
> that only confuses the readers.
>
> Even then, I think by clearing bits like SEEN from commit, it breaks
> the revision traversal machinery---for example, doesn't this mean
> that the commit we just processed can be re-visited by
> get_revision() without deduping in a history with forks and merges?
>
> Has this been shown to any of your mentors before sending it to the
> list?

Adding clear_commit_marks() was a suggestion of a previous review of this p=
atch:
https://public-inbox.org/git/nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqb=
jf.bet/

And of course, my mentor always reviews my patch series before sending.

>
> > +static int bisect_successful(struct bisect_terms *terms)
> > +{
> > +     struct object_id oid;
> > +     struct commit *commit;
> > +     struct pretty_print_context pp =3D {0};
> > +     struct strbuf commit_name =3D STRBUF_INIT;
> > +     char *bad_ref =3D xstrfmt("refs/bisect/%s",
> > +                             terms->term_bad);
> > +     char *content;
> > +     int res;
> > +
> > +     read_ref(bad_ref, &oid);
> > +     printf("%s\n", bad_ref);
> > +     commit =3D lookup_commit_reference(the_repository, &oid);
> > +     format_commit_message(commit, "%s", &commit_name, &pp);
> > +
> > +     content =3D xstrfmt("# first %s commit: [%s] %s",
> > +     terms->term_bad, oid_to_hex(&oid),
> > +     commit_name.buf);
>
> Strange indentation.
Noted.
>
> > +     res =3D write_in_file(git_path_bisect_log(), content, 1);
>
> So this is a new use of the helper introduced in [01/10].  It is
> true that use of it lets this caller not to worry about opening,
> writing and closing, but it needs an extra allocation to prepare
> "content".
>
> If the calling convention were more like this:
>
>         res =3D write_to_file(git_path_bisect_log(), "a",
>                             "# first %s commit: [%s] %s",
>                             terms->term_bad, oid_to_hex(&oid), commit_nam=
e.buf,
>                             NULL);
>
> this callsite and the callsite in [01/10] wouldn't have had to make
> an unnecessary allocation, perhaps?
>
Aha. I will change it.

This helper function was also a suggestion of the previous reviewer:
https://public-inbox.org/git/nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqb=
jf.bet/

Thank you very much for reviewing!.

Best,
Miriam
