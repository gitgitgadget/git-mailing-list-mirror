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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4401D1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 12:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGJMno (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 08:43:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:45291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfGJMno (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 08:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562762617;
        bh=bZ9b76H+jUvMOVW6sthQOhwoSFEw+rYKnkVZ+b8R78s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FRPNwFpbUrKPkaOv9H+y/vLIIoHum67bGK2kcqvDhTwBiRBRilCYwj6n8vHsf1iCx
         K7x14g7+8IOsFzM2S3zcLlhtOb3PyjsEB/+kZad3DdFYO3WIJN8g0NClyNnSFGmzwE
         MwGptDiMF+xYHFF7g1YNPO5Z+iEZvULuMaNJmNC0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBdv-1hfys22vcl-00FCOS; Wed, 10
 Jul 2019 14:43:37 +0200
Date:   Wed, 10 Jul 2019 14:43:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] diff: munmap() file contents before running external
 diff
In-Reply-To: <xmqq8st8xkdg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907101424300.46@tvgsbejvaqbjf.bet>
References: <pull.213.git.gitgitgadget@gmail.com> <bef83fc20b9e2048872316e3f396da0cb6775086.1562231781.git.gitgitgadget@gmail.com> <xmqq8st8xkdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DOfENlY8bjbzwlCpJSN6KcPUtIedZiaDy7xNak4kDzUC32VCTg9
 flZpa+a5lsbr/ppphjrpmbOGtYSojFF85KUmVBdArpIIT0homuJ00kP0fmbqaD6xg8WiBxg
 BYeO4Upqc+8SZMTfbLTgUQ0LMwl+GmRpiOO4s9iFSvLxEEe8UlbgahGSE0AlMnGZ7XkB5k4
 fTl22LzNywmJG1LxRKmJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yFcmZBdOL8E=:AtmAyN1M/xI1vPTVWr0Sdp
 FUhjxH1o71R0rSGyz7wWkkH+6RWuKtf8U1VAneQbgTKQVx+hHR7ddyeG+P7molyqtiML3/vRJ
 lhb4zzaEkPZVlGf4FMjUxIW4PktTqOz3ua6YyfAWXg5kElf1FxQz1HLveUVQKgs/3myl5ssC8
 dDMH/a+p7WN9uaBtOxOWlE8PTEVd+B+F682x5/3f+I2RcRk/zsq5OgmkDJo6109LTtKS/T2i6
 la2FUr0k8hjjuclE5zHoVGQuF0qntMSlMWPA+4RuiAlrE5bLUKMYquOcfqhH7g1byHVYAyhYd
 0gGmgFE9dgvjAjE8VYRrKzA/LVUT/wpIjyJniEwDcgUI3vqssfqvE/zxdZn6zzCVuiC5OTNzX
 OAWYB121/H29sMAN1GpWkiuppSkW8aW42JBKjxU7doeElM6UIR9F1sp/8OLzwYcbqrrZCibha
 NW/O8jsVsOA/rHkZDyfdj1SdvF9GHVYpE8i1R8oWw8oI44At/mGSRa+m7Tho+3DHVkdCdddV8
 KCLwtN2GR8lO2yiFkB1/3QwrTh4ElwvJsTluTaYlOkSGIbYHcTRqpm1jjx3dxReDLULT65X+X
 pWPrk+u5DVCMe/36JBHIxhN04Wyn+LBAZlNvVHG3gls/FG0hFx3i/++Zw/D5ZRnZTFngPlbR/
 Dq7XtSQKfK1W3jksgsl+7pZY+Z7UPVw5wFpKRV4m0YzQHTvPcvyzQd5L92Q+m+oErw9o+BlH4
 p5kltXh2LEOBTKe/LSAGemhdbIGhay2M5tWHidvVVF49iyXsrrf/o1mBe8RKTN9078mwVHGtW
 lAEjFmnpSnrK0uL5q6Jw3fqL2JyzQt9su8qbb/m9aquthcqhmugHHC7w3GtyLU/eht5DQ+mLD
 Umfm9KUB4gK3NqVzVmGQ8uzB9vPxHvfZWwFAY+3IKSYYiEAt9i+0hmapuwLdU5UVtP0bxsJb7
 exQ6AzasI2AKjXfMPl8sJQquq605gZ/aNuTYoOrZsakJ3bsNn4T/KlU0biWmSaNYPdm3ZFN7q
 5QEbW5aZu316EZShyQQEXAu3pO3OcjjGZd9BKp5Z4Xu2AsmXm6Trm9lavoJ1c6eCMVu25MGFY
 LbiJHfivr3mPDObKXiKZKuKBsB2CjDhsCw6
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 8 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When running an external diff from, say, a diff tool, it is safe to
> > assume that we want to write the files in question. On Windows, that
> > means that there cannot be any other process holding an open handle to
> > said files.
>
> Please add "It is not enough to close the file descriptor; having a
> region that is still mmapped keeps the file busy" or something like
> that at the end.

Good call.

> > So let's make sure that `git diff` itself is not holding any open hand=
le
> > to the files in question.
> >
> > This fixes https://github.com/git-for-windows/git/issues/1315
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  diff.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/diff.c b/diff.c
> > index 4d3cf83a27..0afb76bbca 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -4206,6 +4206,10 @@ static void run_external_diff(const char *pgm,
> >  	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=3D%d", ++o->diff_path_=
counter);
> >  	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=3D%d", q->nr);
> >
> > +	if (one && one->should_munmap)
> > +		diff_free_filespec_data(one);
> > +	if (two && two->should_munmap)
> > +		diff_free_filespec_data(two);
>
> I wondered if a single diff_filespec instance can be used in two
> diff_filepair instances (e.g. file A is in-place modified and also
> used to create file C), and if so after showing the diff for file A,
> we have problems with showing file C.  But I do not think it should
> pose a problem, as "free data after comparing a pair" is what we do
> for the in-core codepath in builtin_diff().

Precisely.

> We can lose the NULL-ness test for one and two if these "free the
> resource once we no longer need it" is done inside "if (one && two)".
> After all, once add_external_diff_name()[*1*] does its thing, we do
> not need the data for these diff_filespec instances, right?

Yes, but we still need the `should_munmap` test, I believe. So we have
that `if` anyway.

> Also, just like builtin_diff() unconditionally frees the resources
> held by diff_filespec instances, shouldn't this function do so, even
> the ones that are not marked with should_munmap?

I have not inspected the code path vigorously, nor am I confident that
this wouldn't be broken easily. At least when regions are mapped, I am
fairly certain that my patch does not break anything.

But if you are confident that this won't break anything, I'll certainly
be happy with that assessment.

I'll make that change and trust the CI build to fail if your assumption
was incorrect.

Ciao,
Dscho

>
>
> >  	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.a=
rgv))
> >  		die(_("external diff died, stopping at %s"), name);
>
