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
	by dcvr.yhbt.net (Postfix) with ESMTP id 669A71F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 12:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfJ2MjQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 08:39:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:44849 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731583AbfJ2MjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 08:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572352745;
        bh=fX/GYkNP2u/YZPOrthni4e1SAJ/yjNSfK3M2GldAy6M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F1l3AI6cD3W30ExEiGoC1TXs9N3fLt5EEwy7zOzwWlb+/pePQ+y4O34GV5rdHcPGT
         jJ6lxvz6RlG09m6BzeOyZ4U0N40GtTY9I/ZWaU/dVIK7HVNH7d64gxYjFzOKxhRknj
         cxWVXgU3OZd8KqBe7jmRGpWN8hIu9pzMEL52M6sc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1hwAPd263p-015biD; Tue, 29
 Oct 2019 13:39:04 +0100
Date:   Tue, 29 Oct 2019 13:38:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] vreportf(): avoid buffered write in favor of unbuffered
 one
In-Reply-To: <20191029103842.GV4348@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1910291334210.46@tvgsbejvaqbjf.bet>
References: <pull.428.git.1572274859.gitgitgadget@gmail.com> <455026ce3ef2b2d7cfecfc4b4bf5b588eebddcfe.1572274859.git.gitgitgadget@gmail.com> <20191029103842.GV4348@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1064914085-1572352746=:46"
X-Provags-ID: V03:K1:6Qi0kD58UJzOim94JbWWogQuYCAk9/SCfJ/5MslHDk5ALbTWfzT
 MLLR/ifZSpLPRCJ8oXt67/Z3RVMx+dlW+XtpZtvKpYIOKFv9cFIs4iI/K0hRfSEvF+qetcj
 +n47KS3dlZqmwiLOkeiiWjQv/f8Lfs0D5BMDEMh5ldLvEwOzQ8ijUG071l4aFy/4VsetyCF
 3Q3UkzQ0ah3pL8Qn+kDaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S70aqG2Kwro=:dy/Ugh5rr28KUOAoCAw/UI
 WFMWu6il+VDSDCigUgY5Mq0nwLdcB4kR/rbHMOQbSKGcqasX2+sOCWAypq19oYg1z3fKQfO4E
 INRsy+dMgPHnn70i8dcPTDWBJ8BQIpyrQYzn1ik2x/ovVrkUXDMVLQJ1td6kpxGjQ3BUDuAif
 +ClXkFxX5C5O1V4ptYQ2r7YgUX02m/DUTpe7u/fpekRLSl6XBSjk3jzQeXjG/Drgiwmj3oDdk
 19EOLOhig3BHIiVcC+NWJeW059WhaQw3WOvc8VzPMiE0zmTcwz/SXrB8Gf/da/UlkisOFUCF5
 Nf1J4K3BsdrCOMd+A+g2PPUuul6fAmSOM/TlWoRO53FKj4DeMsQSMidSbLvtymCX4Pj1odfke
 eAGd//48bvUf1F8Pkx89DYaUosBXjSBpbzV+4Ti2U7WQZbgRSWl52kgENWfOR8O60VKjbeVW5
 9LgxlVtOIWuRnPTdAvCsPXiIFD/dOqSii5XrFZzGnShwkRo8EAlqBuYR1Uh8swssQ+YsE4ZLl
 8lkOD/ebdWl++20JV+3GsdlvR2chtvhDa54yQb+mOMr+k7DL1SrJ8z7g7AvBX7OAFvowMTnzs
 xQaCEwNZ1R5u2wDpqqBcUPIXUNOI0K3TpOpmabXVpDucd0Dau8Sew6JLtFcxZEsa3VxLqku/z
 zTa7AR1LwlU1M7rwzldV7AZm1xeZNjZK1PIkgRFuqTQMdrRLZyxzrvWGEpOO4Fd1gQbLYZL3F
 sP8MG4uTPZhSD2UzB5Qdt+bMhLsFopGsI3lfv7iHwZH9YTn3bNeWFUnqirf1JKszy4CXsCoOj
 OexYCqkOixOjyER1v+TyTe1H0jrHUb1MHR4hIjMPMyIxKCzC4gxZ2RwL4A+l4J/6LEqPFUcg0
 0LKyvPMEUBxoH+XHhl/BPVtwoV/brl8qLGO4o+T3ovrwzEkVc+HdBGY+K2GeLHiXtxYecNlF+
 6RRGpiyWqaybCiT5TZuJ2Tb4Mtrq1k0wOIe+lggAtqGheeXOMCeYqqcJtAp2bUH7rDG/7lK17
 zxWTDoJjmbM0hovPFnWwS0xkghy3bFyco3XrB9HfTlElAKfw6XJYZqOO0o9InX6H5Cqw9bkQH
 vh0D0dfyI2pQm3bZOMR1+SQeDxDf9JyoR2YejNsILrDmhehW40RNNo5yo8bm4i+5kAcA4om6G
 o38ywLwAlHA5a67e/6oN6fycg29fjX8m+lOAtggCDMDFwyVk15z6jOa5AWbNaj9WsSYlaZRV2
 5bh6xDPxhKx0vZDsDEpxDlqof01MLIUAbhe55QY+hpuY95dlWUkvyAcNwvNg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1064914085-1572352746=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Tue, 29 Oct 2019, SZEDER G=C3=A1bor wrote:

> On Mon, Oct 28, 2019 at 03:00:59PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The MSVC runtime behavior differs from glibc's with respect to
> > `fprintf(stderr, ...)` in that the former writes out the message
> > character by character.
> >
> > In t5516, this leads to a funny problem where a `git fetch` process as
> > well as the `git upload-pack` process spawned by it _both_ call `die()=
`
> > at the same time. The output can look like this:
> >
> > 	fatal: git uploadfata-lp: raemcokte :error:  upload-pnot our arcef k6=
: n4ot our ea4cr1e3f 36d45ea94fca1398e86a771eda009872d63adb28598f6a9
> > 	8e86a771eda009872d6ab2886
>
> Heh.

Yes ;-)

> > Let's avoid this predicament altogether by rendering the entire messag=
e,
> > including the prefix and the trailing newline, into the buffer we
> > already have (and which is still fixed size) and then write it out via
> > `write_in_full()`.
>
> s/write_in_full/xwrite/ perhaps?  Both the cover letter and the patch
> below use xwrite().

Excellent eyes! I had originally used `write_in_full()` before realizing
that `xwrite()` would be more appropriate.

Fixed.

Thank you for helping me improve the patch!
Dscho

> > The history of `vreportf()` with regard to this issue includes the
> > following commits:
> >
> > d048a96e (2007-11-09) - 'char msg[256]' is introduced to avoid interle=
aving
> > 389d1767 (2009-03-25) - Buffer size increased to 1024 to avoid truncat=
ion
> > 625a860c (2009-11-22) - Buffer size increased to 4096 to avoid truncat=
ion
> > f4c3edc0 (2015-08-11) - Buffer removed to avoid truncation
> > b5a9e435 (2017-01-11) - Reverts f4c3edc0 to be able to replace control
> >                         chars before sending to stderr
> > 9ac13ec9 (2006-10-11) - Another attempt to solve interleaving.
> >                         This is seemingly related to d048a96e.
> > 137a0d0e (2007-11-19) - Addresses out-of-order for display()
> > 34df8aba (2009-03-10) - Switches xwrite() to fprintf() in recv_sideban=
d()
> >                         to support UTF-8 emulation
> > eac14f89 (2012-01-14) - Removes the need for fprintf() for UTF-8 emula=
tion,
> >                         so it's safe to use xwrite() again
> > 5e5be9e2 (2016-06-28) - recv_sideband() uses xwrite() again
> >
> > Note that we need to be careful to handle the return value of
> > `vsnprintf()` that indicates the _desired_ byte count.
> >
> > Also please note that we `fflush(stderr)` here to help when running in=
 a
> > Git Bash on Windows: in this case, `stderr` is not actually truly
> > unbuffered, and needs the extra help.
> >
> > Co-authored-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.c=
om>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  usage.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/usage.c b/usage.c
> > index 2fdb20086b..4328894dce 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -10,13 +10,19 @@ void vreportf(const char *prefix, const char *err,=
 va_list params)
> >  {
> >  	char msg[4096];
> >  	char *p;
> > -
> > -	vsnprintf(msg, sizeof(msg), err, params);
> > +	size_t off =3D strlcpy(msg, prefix, sizeof(msg));
> > +	int ret =3D vsnprintf(msg + off, sizeof(msg) - off, err, params);
> >  	for (p =3D msg; *p; p++) {
> >  		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
> >  			*p =3D '?';
> >  	}
> > -	fprintf(stderr, "%s%s\n", prefix, msg);
> > +	if (ret > 0) {
> > +		if (off + ret > sizeof(msg) - 1)
> > +			ret =3D sizeof(msg) - 1 - off;
> > +		msg[off + ret] =3D '\n'; /* we no longer need a NUL */
> > +		fflush(stderr);
> > +		xwrite(2, msg, off + ret + 1);
> > +	}
> >  }
> >
> >  static NORETURN void usage_builtin(const char *err, va_list params)
> > --
> > gitgitgadget
>

--8323328-1064914085-1572352746=:46--
