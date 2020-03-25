Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768EC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DFF20777
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 18:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gWBhQ6n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCYSAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:00:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:38519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgCYSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 14:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585159207;
        bh=pmQz+T6rC+GRdAI3wRxdku9G9mgEIQi9xiipZfNTnQc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gWBhQ6n1m9ZetlqRJKabrPbGg/kw9Zr7vT/EcunRxnsHE4VbRFw7eEnCVY6cqfCMm
         bkwhjbSUeRaOGrhQRP10u3jC21TS4YcB3YiuOA4OdYx9mKHZysry17Ht6CEDWpeN6K
         cXGR7u6Ov7AHXXpmyEV3LtB71Kq2EQ3hzZ4j8TOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.37]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mwfai-1jRWVZ0WYU-00yCpp; Wed, 25 Mar 2020 19:00:07 +0100
Date:   Wed, 25 Mar 2020 18:59:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] import-tars: ignore the global PAX header
In-Reply-To: <xmqqd0911n3b.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003251859070.46@tvgsbejvaqbjf.bet>
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com> <pull.577.v2.git.1585078545448.gitgitgadget@gmail.com> <xmqqd0911n3b.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WszlepIynhuuRaMSE3e81P2MMXjr/G/vf79bO66FVevH0VL5tVm
 kdoOWoh42KPIx4MAWZH2pmOqdatcmh5GV/QRPL63VM67nXkLrYza9rZgu9UEIfQ5yZaeNIF
 /iWE2t2BOHxj9ARjb+tl1fAjzWWcvluXG6leX/Hf6GcVj6IM78OoAthYrqubSEaprCVRJTL
 QCWKHGvjTn0nO8DFYszlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WqPvaaQgSUQ=:HhIDlLOCM0tWHVifJ2by8X
 iwikQg+08U/FNzgXWbT35tyTLIDO0DGu6FZydLM1N18rF59dAhcRGfX38ci1tbZLrYv9beKZy
 H7w//Ogy6UezmDxoqW42I/eyvZrIta9C8ZshhpdxWYrxFDOdyPjT5GYlOMAuIzY1ED70YATwb
 Z8F5MRP1q9RHRYbF0zX/KwIIRV3fPE9fV7mLVai9oORg+KH4H3THJzRFJ7rDXWNvAwW2ylu9A
 /5RCu8DgUlFcbLBG52joN5gQBiOk4Yc5YMG7uZbn8Pzso3gUmt5odTdj331pTp28cJBQREHHN
 S3XHQvPHNmqpdN/DUUeVxJ03dj+BZEjwQnwW85DFFCMukS2+1gin2xr/DUbfvhKlc3TkpGC7U
 bRQs18O8Ns4Wrcp5Klm2AumytJgVfY9WunLlMye0JU6A8EdP9gzQRId0E9PkanAbWscl8jeGg
 eVkoXOSvb+cCoUkso5EhQcQgMr3qtI9Ln28m2SjIiwQ78qqaTIPz/pcNKW2fXFMfCnUIcy9Tc
 nSQu293roZDzUYLtIKEIG4VhIRImliCtFnIIcXYSGEvBpDlu7gs+jvHA8FxL6QmrKZNBDUQzQ
 U20r/jje1hI9KE9nptTjFJH2HKap6BfL8lZW4UTBOBwXkc5R6SXA0hfocCQWJNAe1G8pUHH6F
 gX9Hqj092LlmLJubwK8e4+Xpk9GKAMlAawkYx/xGIT9Q5Tu1lOa0shV+Zbeq1ExHermc452NX
 TjaChDOm75PCEw6hLvO0akQa+v+zhYKpmmuzu7mw06a0Ppz+hSY25lgQ9a6SanRDV8On4P9uq
 KIq44Gs2/xFG1v4tMf1N71bC/fl3hmfzb8qxuwTnlEs+5iUYNurq76w8uzH7PJQPbOihw3qpd
 V0Ski/dZVlaiuGi3wX/MBY1yJUEhfYSXP1Xr4OR9xNbU6p7D2mpJJeYS5Kwxjxl89zIhvsyN/
 SSCswBynwBpssNjlmBQU/5pIKOKQykRhJh+UpEUuDlXucdvxj+zZoVARgCztIcB15SArirxUi
 b4L5eqbvW7SeHZC7vKWFNCsUwGaLruu7Sb8l5yo2lp3Pl05EQLVMdphIL4dxIVx74kEEHfh9a
 KCI5uQbxzPDJ9Ebw0XxzYMkdb95q/Hmtd5PtmsUej4VM0upYyzE3gtoObYKq7S0K7plhkJUZv
 tFhRykyTkIhOLQRo0Ty57EqmioqVYvZBZH5+ij19AHJ74Xhlkohps2J25Ws4ImNv+MnPHmCIP
 ijLC6qkQ02FcnX8mZ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Mar 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> >      +    Note: this global header might contain useful information. F=
or example,
> >      +    in the output of `git archive`, it lists the original commit=
, which _is_
> >      +    useful information. A future improvement to the `import-tars=
.perl`
> >      +    script might be to include that information in the commit me=
ssage, or do
> >      +    other things with the information (e.g. use `mtime` informat=
ion
> >      +    contained in the global header as date of the commit). This =
patch does
> >      +    not prevent any future patch from making that happen, it onl=
y prevents
> >      +    the header from being treated as if it was a regular file.
> >
> >           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.=
de>
> >
> >
> >
> >  contrib/fast-import/import-tars.perl | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-impor=
t/import-tars.perl
> > index e800d9f5c9c..d50ce26d5d9 100755
> > --- a/contrib/fast-import/import-tars.perl
> > +++ b/contrib/fast-import/import-tars.perl
> > @@ -139,6 +139,8 @@
> >  			print FI "\n";
> >  		}
> >
> > +		next if ($typeflag eq 'g'); # ignore global header
> > +
>
> Yeah, it is more like "don't create a phony file out of global
> header" which is exactly the point of this fix, rather than "ignore
> global header", and if the contents of the header is used for any
> other purpose (e.g. metadata that will be added to the log message
> or mode bits that is forced on all files), that can be handled
> before this line.  And the current code structure is already
> prepared for it: all that remains in the block after this point is
> to create a file at $path and store its contents.
>
> So, this makes sense.  I suspect that with an update to the comment
> in the direction, there probably is no need for the huge "Note" in
> the log message.

Too many of such in-code comments added by me became stale. I'd rather
keep this in the commit message where it explains the reasoning for the
current change.

Thanks,
Dscho

>
> Thanks.
>
> >  		my $path;
> >  		if ($prefix) {
> >  			$path =3D "$prefix/$name";
> >
> > base-commit: b4374e96c84ed9394fed363973eb540da308ed4f
>
