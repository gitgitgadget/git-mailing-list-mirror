Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED2A1F461
	for <e@80x24.org>; Wed, 24 Jul 2019 10:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGXKu0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 06:50:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:35135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfGXKu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 06:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563965417;
        bh=jgM/wiROqUysBrQpYOP3eSCqdPf2uAmBQDwF2Snn4BQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=C4818zFJaaBzeqhvbOHNZHa1a1ESSzbvc4YPSjzNT4kPTDMGOq2espPMbUDJenLil
         tNP+EvM3aKx6DT6j3TLRqHZYyvDdcikfKf92DT9HgScywrkRUgWU5XTzSx+10/bqp4
         oBRodA/34j1s1zpm2G46G5SxRLNb6C2YzKCXRM4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7YF5-1iek0c2sCd-00xKPg; Wed, 24
 Jul 2019 12:50:17 +0200
Date:   Wed, 24 Jul 2019 12:50:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] grep: skip UTF8 checks explicitly
In-Reply-To: <xmqqa7d4rxm9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907241248000.21907@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet> <20190722144350.46458-1-carenas@gmail.com> <xmqqa7d4rxm9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2127279820-1563965418=:21907"
X-Provags-ID: V03:K1:WQzLTmIeNJO4pWNtuzhLAykidm8FRFI6RSCglMM/Rqf2GPc/7Y0
 yorrofS3CKC3NayWWCJJrm6yM/CYOrbisCfuHGB9ejo+4QcX+ZRkqsXdJZ4hSUog/yqhoO/
 KqRZGFd0hRKmqvhAzZlr2/kn0zbr2XoUAXwWfRnf46m/kf7jFRLZ2PVvIXBV1l2sKhsRZM2
 UB3CWbDD7Ks5veT+vBv4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EEPHbNJVMnw=:vcfvKkf94KkjnTF2wiI6QF
 lTPng6YaP1XpX4Ax0pvEgzbvpC71tpbgKZcHE32b+Twh+O/o5NnxWVXnuWEJjZKQByr8CARHw
 EmGUYEpG1j4DYMtYkRjqDoAy4gFf8rKDm9Q/MNSR4/GX9ntMAO+KnH+SFTrt7Qot///o73AT8
 By/1My+Gx1fhe/EWG4etv9bMtGDClXuf6kzRhbDaab5X97YwRUjEQfTc6cJAFmLmDCiT2c4Bt
 Hb5UoqViTwLnu8L+KKDMFJWVqeSPDYfi2e916MRkSWfZf8HaAVPqKIHl2+7tgJ0v+D19EiuF3
 c/Z3qxa7hUkJtW3tAEn46K7T9gdjwTWPhNxKFX9nCz6Se41/86iYFTtr+WQLAelypwxtUDh85
 RJhBS87WHs1o8Y47SPO54A/WKEyD2BQGLUyV20+FDHijp4h1KW+rcUZ6TCiOK8h+APatS87xn
 hOii2ihI7exUajQCeWNoitXBo5Z0eGMoM/Od1IYYh6QbXGxDi1ccHsoKRjUdCc25n9AQ4klWv
 0acFb2DEw4Hov5b3W3bvF7qa1MvDPmyn43RBN26aOnfxYcTkjXQU1F9mUefE8WlbpH9gD35lR
 S5JjII4+2FDw0g5WHb7JLytZ86L3NBFiVbg7ST0xdZxQYVxp3OjD06DBPWnjx735YWzYcamzh
 3WbTwWJ1Nfi+GFzutOLAw2yw+jg1QhV5XZu00brzmu9xRpk4eA1gSLTFYDIzIDyRiuBjyVgkl
 /uF9k8uA7h/qdnjAqLnk/hW7ASCOjhhrfnb5h5fZe3b5Eh99Ap5ngBD5C8frodp3j6RGX1KSV
 jnSrai1gUWCVzTUSsVex03hME3LU72hg6RUam+m36XX3GHQpW6rjULCUDJg6YvYe9o2BBwYkX
 VhST2k52Js9SIk00yTtcFIVs7srHhqQ4afTVl34yZSSobDqw3+9tncJcFHl3mezKnLyNSq2dp
 IuCp96C2rjkPTLmbya7aHKo7cv0x7njzEDxN7QCQP76tG0NK2mptU8LdN6Hj1Lpe8iBt1fuZI
 kmbtk0VRC84DrwxqkxHnXwyQRUCnuxELfbqw53EsuAwGkyiko8LsLXOOdOFu8HQh9k+hx2rW5
 YDtn7ZWr8bj9ZkB3cR0n+AHa/GOpqx6Qf68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2127279820-1563965418=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 23 Jul 2019, Junio C Hamano wrote:

> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > Usually PCRE is compiled with JIT support, and therefore the code
> > path used includes calling pcre2_jit_match (for PCRE2), that ignores
> > invalid UTF-8 in the corpus.
> >
> > Make that option explicit so it can be also used when JIT is not
> > enabled and pcre2_match is called instead, preventing `git grep`
> > to abort when hitting the first binary blob in a fixed match
> > after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)
> >
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> > ---
> > V2: spelling fixes from Eric Sunshine
>
> Good.  I was expecting fallouts like this from our recent push to
> aggressively use pcre and that was why I merged ab/no-kwset before
> I felt comfortable, so that we can have longer exposure.  It seems
> to be paying off.

I agree: it pays off quite nicely.

> So with JIT, PCRE_NO_UTF8_CHECK is on by default, but without, we
> need to give the option explicitly, and because it is on by default
> in the JIT case, it would not hurt to explicitly pass it?
>
> That makes perfect sense to me.

My reading of the situation is slightly different. I think
PCRE_NO_UTF8_CHECK is off by default, but it only makes a difference in
the non-JIT'ed code path. Since we use PCRE2's JIT when possible
(because it leads to a quite nice performance improvement), we usually
don't see those warnings. Carlo's patch makes the non-JIT'ed code path
behave the same as our preferred code path.

Thanks,
Dscho

>
> >  grep.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/grep.c b/grep.c
> > index fc0ed73ef3..146093f590 100644
> > --- a/grep.c
> > +++ b/grep.c
> > @@ -409,7 +409,7 @@ static void compile_pcre1_regexp(struct grep_pat *=
p, const struct grep_opt *opt)
> >  static int pcre1match(struct grep_pat *p, const char *line, const cha=
r *eol,
> >  		regmatch_t *match, int eflags)
> >  {
> > -	int ovector[30], ret, flags =3D 0;
> > +	int ovector[30], ret, flags =3D PCRE_NO_UTF8_CHECK;
> >
> >  	if (eflags & REG_NOTBOL)
> >  		flags |=3D PCRE_NOTBOL;
> > @@ -554,7 +554,7 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
> >  static int pcre2match(struct grep_pat *p, const char *line, const cha=
r *eol,
> >  		regmatch_t *match, int eflags)
> >  {
> > -	int ret, flags =3D 0;
> > +	int ret, flags =3D PCRE2_NO_UTF_CHECK;
> >  	PCRE2_SIZE *ovector;
> >  	PCRE2_UCHAR errbuf[256];
>

--8323328-2127279820-1563965418=:21907--
