Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830031F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 08:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfJIILj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 04:11:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:57099 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIILi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570608692;
        bh=TGk0+Qk5BZpBeiDZVDGCBIP8AQt7PKveTcY/fQM6WDU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HMIaHYtSaX7or4tWtkEiuoLSyO7f3BGhOfpx8BM4c+7anZDthQGkp947mFHfH1g34
         r2JCMB3e+N7G6F/uD2+Yo9yhli677PyNRJQXDKlx8QSykZNmxrKZbxpXEK2Pp1RQzy
         PsOrcASpC4BuKR3jnINV7GO1alVajFi4Fg5opyzc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnaof-1hqEYj2Uc9-00jdZo; Wed, 09
 Oct 2019 10:11:32 +0200
Date:   Wed, 9 Oct 2019 10:11:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
In-Reply-To: <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910091009370.46@tvgsbejvaqbjf.bet>
References: <pull.378.git.gitgitgadget@gmail.com> <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com> <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org> <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4W62s6OJoGVlxDldF/CnWy2jLmjwv+u64FmXLb8+8sMaOfRlrZG
 BdCAzXYXbut7krPvZG6QPeqqA4wZSHWqvbpGep0g4mu2WMvdPbX3fMA9kEvwKhsM+8pVPXq
 xP3wQ6i51wYGLpmC1xtvznOO63k4Phl2ETddcY+dHaMivE3M5ExCn2MRNTBZGoK/RoW7EeV
 jb9NOVR009SNwxx68gUzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9kRcfePl4hE=:PghNWqRKgr325j/F8At74b
 aSA4XuwPgW5a+s/zv8jtV9pX45WGtNyRjwKS4Pm/hnNBLawVLRm6IC7qgKah9rQp/dJfnhSX7
 6pKmW0PhGxFrEEITa4yq1juVspCztScDj9z/kFhvB5I9Uh7Y47GEQ4WGZwwpRnh9lO0KLZAbO
 pWD5w8+qpvif38JyPs9kqvQ3C0Lql95IsID8dzFm24FY9OCNk8Ra7ielAw+ZxBkFEdDAcHUbi
 0/oHSNytLxTo+JFHNmjuSKf6vSP5BDHnL+caNQh0ZYAsO4oXjWPwRnjPjLaPqQ8fAlawrAyHN
 WsFD+GQK+eFDuXFaUh8gwDUDx9AdxwR/8F6PwD2Rkeswmr/rwCEbR8Bvh6xxZRm93O9nnmCGV
 H+BetAOp3Ftd7tIEJch06iT4dYNa4MBm+iZBMJs1P1fWv3WR0Xkhs4dkJwfw8n0C4OO0zvj8q
 gFwDxqDYGYwjlgrZ/uuhtA/kRtoNqlipCd6e8O/hZ0rVkUbo8ss/JOYVI0sVVjYylZZWReJSX
 QHoRTzPG/2kbV9brUEkaHuoewADTD2iOl/d/HMmdTudZmkCx7bZcthaUy6rzDOFqBf9dZqpIG
 1lEdXY9T8Hh5v8hLdyZrX4MFAlJfPS0mZg6u4u3hIU/Ydx0NMZkn0xHCqbY7ARdenDeu72TsD
 iZzo0hwjrUZMMWchR+8IgMibAPc6/FLBPDmNhWDW3kH3lHGO4S2ldja3F7736HjXsbAv4UXV/
 qAQ2RS9if1o4inMKmBAK30fN6iDXTBri6+cLamqhB8pgp/NNXaClJr37pbDqND49N3rdOrZ3m
 j9PQu/ryZyXoVey86QadxXiItT7li89ikjIWV48Pq3zGn2o8G3dFARBxr5wQft0QHsW37OvY8
 MBGDFrMgQU0NuON3jQ5PjiA9Oi0nbXlKtZvHKR8IrCW4BZl3r0oARMUrXZmNcR5bAxoxk9yUu
 UnhW95ZwK2V/kd49TRs4VQDT2+DGpRkNqzgjPDwTGC3I4N5DRjfoE+gxJV9RqwmTNeYAg0zZj
 u222vaqvZe0OmCwCyAT7He4MWerwZd4Wk+RzOPH+4McqGbH8MZ4Ltt7jqWqwUeIbHSXwhZa6o
 FJPHy+RhxW9W9C9yBAWa/ojbdz8Lbo0Bg1GwbXsFNs8sUoFCC8NoypbQ0Pu+6lT/DucEKjnYx
 N+dw3zpm7Vh9ltkilKwWX9ZE1PMdOVtBm2RGtYYxIk3EBuLGd1yY/T6FrZiKHgS2tB35n96T9
 Ke5iPmzFwK0hOXL7HSPsZuP6r4dNk55anKIUjqJmMnFs3nmJC7VylAGvMSkw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Wed, 9 Oct 2019, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
>
> > We do not want to have it for *all* cases, where we return -1 - pos, b=
ut
> > only for those cases, where the result was actually encoded by
> > index_pos_to_insert_pos().
>
> Yup, I agree with you that decoder should be fed only the data
> emitted by the encoder.
>
> But shouldn't the code that yielded 'pos' that later gets decoded by
> computing "-1 -pos" without using the encoding helper be corrected
> to use the encoder instead?  After all, the primary purpose of
> inventing the encoder was to catch the arith overflow, wasn't it?

That was the primary purpose of the encoder. And it is used in those
places where we want to encode _unsigned_ positions.

All of the calls to `insert_pos_to_index_pos()` that I introduced in
this here patch pass _signed_ position values, though. They cannot
overflow nor underflow because `-1 - <int>` is just the one-complement,
i.e. all bits are flipped.

Ciao,
Dscho

>
> > That excludes all cases where the argument is
> > derived from index_name_pos(), and leaves just...
> >
> >> --- a/rerere.c
> >> +++ b/rerere.c
> >> @@ -154,7 +154,7 @@ static struct rerere_dir *find_rerere_dir(const c=
har *hex)
> >>  		rr_dir->status =3D NULL;
> >>  		rr_dir->status_nr =3D 0;
> >>  		rr_dir->status_alloc =3D 0;
> >> -		pos =3D -1 - pos;
> >> +		pos =3D insert_pos_to_index_pos(pos);
> >
> > ... this one...
> >
> >>
> >>  		/* Make sure the array is big enough ... */
> >>  		ALLOC_GROW(rerere_dir, rerere_dir_nr + 1, rerere_dir_alloc);
> >> diff --git a/sha1-name.c b/sha1-name.c
> >> index 49855ad24f..bee7ce39ee 100644
> >> --- a/sha1-name.c
> >> +++ b/sha1-name.c
> >> @@ -98,7 +98,7 @@ static void find_short_object_filename(struct disam=
biguate_state *ds)
> >>  		loose_objects =3D odb_loose_cache(odb, &ds->bin_pfx);
> >>  		pos =3D oid_array_lookup(loose_objects, &ds->bin_pfx);
> >>  		if (pos < 0)
> >> -			pos =3D -1 - pos;
> >> +			pos =3D insert_pos_to_index_pos(pos);
> >
> > ... and this one.
> >
> >>  		while (!ds->ambiguous && pos < loose_objects->nr) {
> >>  			const struct object_id *oid;
> >>  			oid =3D loose_objects->oid + pos;
> >
> > -- Hannes
>
