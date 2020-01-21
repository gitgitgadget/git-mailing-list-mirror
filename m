Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D563C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0463024655
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 10:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwepRFE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUKAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:00:04 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45330 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAUKAE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 05:00:04 -0500
Received: by mail-io1-f67.google.com with SMTP id i11so2173419ioi.12
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 02:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cljS01yqbubG+LB3ql4BEOQmGJKkAlALo2NWLWp3ftQ=;
        b=MwepRFE+LovIeXH0XCPxKlOCklePohkL3gSRVrBya3uTWPlAuLa4IOKrSCJ0ovJyzn
         oacDRyP5ac3QnTvNDK7hsjKyscG/s9qHZnu8xtY0TKj+bf90IsratCv/OW16zsBTX8w1
         zFGWIT0YoBRbCc+9enZvIidt1u2crQoWjeMVch7DlpA4hHLWMVdk0D4VLK4M82LESoeh
         rThrVbW3ju2SBhIFDjEWKsCvX/zcrAQOoHkPlkYyQ/lTE+6rQUk7tNNOBAUzTI+/e/mo
         xFprTLNPdg/qhSHrW7XkRlg3Pk1wYCVBGM1ZPGJImenvN6kjVUfrArR23mIC+U2tZGBp
         cQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=cljS01yqbubG+LB3ql4BEOQmGJKkAlALo2NWLWp3ftQ=;
        b=Jx3ZmNPtf7eOBdXfOFRCtx4CSI5fUEz7UxuxsoUr2fyQcwyy14i/FvSnTabZUAVJM1
         nJR1TjsoZaqOYkpDv4y126d/eFuuyciTiGBb+uE1tqUkmwKvKrrutmB3COVdapeaaWE0
         VkM3rRzFm8d2fDXdbPMegrJv91hohLg76E5D6U3SbcToA1WishjNxnO4xPe3ytVJZX7u
         KWDf+RMCPCLiFKc9015eMf/citsTOWwWtaEhnolWHNZyV6aXHxB19veAB+wKe9R8sFZz
         XNmeAlysKpvjdUGwPEZU2kojVsRs3TCerr+IxApMi/Bv6lqD6FPJl+MzV4GvrfVvVSCX
         Z9Zg==
X-Gm-Message-State: APjAAAWe4fC6CyuZTvuBoEplXm1u4LaGRffjden5RR96e3EiLpfWsvqJ
        YPIKWwLCUVVd4eDLK//7p0miRUQHyZfzmBHIYNA=
X-Google-Smtp-Source: APXvYqyy2jate5weChPCggZhF7goyvzJoRoC9KRrsgQUAwtADAxQO8N5xc6t/AEesLGS7xT0VxxgJOmyBQmfqz4kh/U=
X-Received: by 2002:a6b:510c:: with SMTP id f12mr2527064iob.227.1579600803584;
 Tue, 21 Jan 2020 02:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-9-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001202308050.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202308050.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 21 Jan 2020 10:59:53 +0100
Message-ID: <CAN7CjDCmqvAkbeHnqLM6SUUyGWQu23hE=nbab6bYxZKZsXB1Qw@mail.gmail.com>
Subject: Re: [PATCH 08/29] bisect: libify `check_merge_bases` and its dependents
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El lun., 20 ene. 2020 a las 23:09, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi,
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > From: Pranit Bauva <pranit.bauva@gmail.com>
> >
> > Since we want to get rid of git-bisect.sh it would be necessary to
> > convert those exit() calls to return statements so that errors can be
> > reported.
> >
> > Emulate try catch in C by converting `exit(<positive-value>)` to
> > `return <negative-value>`. Follow POSIX conventions to return
> > <negative-value> to indicate error.
> >
> > Turn `exit()` to `return` calls in `check_merge_bases()`.
> >
> > In `check_merge_bases()` there is an early success special case,
> > so we have introduced special error code `-11` which indicates early
> > success. This `-11` is converted back to `0` in `check_good_are_ancesto=
rs_of_bad()`.
> >
> > Handle the return value in dependent function `check_good_are_ancestors=
_of_bad()`.
>
> This is a lot of repeated text from earlier commit messages. It might mak=
e
> sense to condense it a bit, and while at it, to remove sentences that
> essentially repeat what the diff says.
>
Ok. Noted!
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> > Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> > Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> > ---
> >  bisect.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/bisect.c b/bisect.c
> > index 385afaf875..367258b0dd 100644
> > --- a/bisect.c
> > +++ b/bisect.c
> > @@ -806,13 +806,16 @@ static void handle_skipped_merge_base(const struc=
t object_id *mb)
> >   * "check_merge_bases" checks that merge bases are not "bad" (or "new"=
).
> >   *
> >   * - If one is "bad" (or "new"), it means the user assumed something w=
rong
> > - * and we must exit with a non 0 error code.
> > + * and we must return error with a non 0 error code.
> >   * - If one is "good" (or "old"), that's good, we have nothing to do.
> >   * - If one is "skipped", we can't know but we should warn.
> >   * - If we don't know, we should check it out and ask the user to test=
.
> > + * - If a merge base must be tested, on success return -11 a special c=
ondition
> > + * for early success, this will be converted back to 0 in check_good_a=
re_ancestors_of_bad().
> >   */
> > -static void check_merge_bases(int rev_nr, struct commit **rev, int no_=
checkout)
> > +static int check_merge_bases(int rev_nr, struct commit **rev, int no_c=
heckout)
> >  {
> > +     int res =3D 0;
> >       struct commit_list *result;
> >
> >       result =3D get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
> > @@ -827,11 +830,16 @@ static void check_merge_bases(int rev_nr, struct =
commit **rev, int no_checkout)
> >                       handle_skipped_merge_base(mb);
> >               } else {
> >                       printf(_("Bisecting: a merge base must be tested\=
n"));
> > -                     exit(bisect_checkout(mb, no_checkout));
> > +                     res =3D bisect_checkout(mb, no_checkout);
> > +                     if (!res)
> > +                             /* indicate early success */
> > +                             res =3D -11;
>
> This is yet another good candidate for an `enum`.
>
> > +                     break;
> >               }
> >       }
> >
> >       free_commit_list(result);
> > +     return res;
> >  }
> >
> >  static int check_ancestors(struct repository *r, int rev_nr,
> > @@ -865,7 +873,7 @@ static void check_good_are_ancestors_of_bad(struct =
repository *r,
> >  {
> >       char *filename =3D git_pathdup("BISECT_ANCESTORS_OK");
> >       struct stat st;
> > -     int fd, rev_nr;
> > +     int fd, rev_nr, res =3D 0;
> >       struct commit **rev;
> >
> >       if (!current_bad_oid)
> > @@ -880,10 +888,13 @@ static void check_good_are_ancestors_of_bad(struc=
t repository *r,
> >               goto done;
> >
> >       /* Check if all good revs are ancestor of the bad rev. */
> > +
> >       rev =3D get_bad_and_good_commits(r, &rev_nr);
> >       if (check_ancestors(r, rev_nr, rev, prefix))
> > -             check_merge_bases(rev_nr, rev, no_checkout);
> > +             res =3D check_merge_bases(rev_nr, rev, no_checkout);
> >       free(rev);
> > +     if(res)
>
> Please put a space between the `if` keyword and the `(` following it.

Ok.


>
> Thanks,
> Johannes
>
> > +             exit(res =3D=3D -11 ? 0 : -res);
> >
> >       /* Create file BISECT_ANCESTORS_OK. */
> >       fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
