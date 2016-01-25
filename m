From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/1] Let merge-file write out conflict markers with
 correct EOLs
Date: Mon, 25 Jan 2016 08:25:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601250802240.2964@virtualbox>
References: <cover.1453482052.git.johannes.schindelin@gmx.de> <cover.1453632296.git.johannes.schindelin@gmx.de> <xmqq4me2d402.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Beat Bolli <dev+git@drbeat.li>,
	Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 08:26:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNbXM-0007Fz-JQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 08:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbcAYH0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 02:26:04 -0500
Received: from mout.gmx.net ([212.227.15.15]:53758 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbcAYH0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 02:26:02 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LnOve-1ZuKBN1fGY-00hbui; Mon, 25 Jan 2016 08:25:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq4me2d402.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ONTG8QpqnNSJMGL6kqM2h72LQGmjewySLNo1x45s9KFgoATevXN
 2j3XiIfmdL6CXHIo7BKUnWFWy0AMGvc+Ilxpk2FrEc0ujtWYNYTvdzvcbxw9gubIhoh3b6b
 ammbYi8kAWP6HWV1ACed3N+rypbpDxHfIHzexDWHiI0Uw1uPrJq69KIMyUIdDWGwOka9LdL
 2HWkWhJOyNy+Ix/B9IdQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hyIYT4ueJ2Q=:WF+6A2hpA3EniS1CK6Raro
 1Na+4DKiOMnD4uJbh942Aks6XyV5xjro/VTRo9hyYbAsbqcsWBH9QKcVLoJj5VXLWfxy+X8gF
 VxapuZRacKXaHzx5GnjnQO895Lio8PeP+4rjimky8h3OQlOnr3SaVdAbmbfpHukkUqoc4VEaT
 9Sm9GiE28aMLk76yf+ILkfP+mqXP60+GctDGO10ajy2Qj8qIa+6DfQwUxwfPpMBsDlJzs5KNT
 YKpqRlva6jLO2JtECyKjTQGqtI1SQ+J6BHpWBn72FJs3/XkYodWXNlXlltCs+edqwlb9d6hDK
 aCvVP8PORbnIHkGRA8XM7jyKodtC1gwDb/dbhPE9E3s0NrHMvYbCVDkYuECvEsWdqI4m0ou6x
 B77rBqNOgUlp6mZqRQQ/rO2mdI5Ma2AYBvAXafGVTvebHg0D0hn9XkvjYpYsWvM4eGj7AHwV9
 mubU588z8kJwvkdUsB7EVtxxWMhEX8mP2DvwpHUurf4sMgolaRakq+8ysqJ7IjbH7RSc4gzaw
 9cpyVY0uRBKdcvnJiQWK/5KiNpO0dY9Rlevpq8VogZrzy5d+u+wBJmvR2fwnqWFMezpkVrszx
 oXqFNQ/TMVncMPv33GlYBMSaQrMFjnarQ2Z+4w3m/PAhCEizFFHqGeqEyRUtVlvsLyGzWqVlY
 O1B365AVjdMi88ZIguE8/9iWh+WpQC10FR7wX+UF2SVjt/R8B8yRlLnOtKshI5dJnfjL2ifAs
 vDcjKeGj734K1O3te/1c4E65Kqsh4Nx44LY3lBfiwOG/2XAjLaQBbgNhzRC8wq4ayzbYHAxo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284722>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > The crucial idea hit me yesterday when I took a step back: all
> > we need to do is to ensure that the end-of-line style is matched
> > when *all* input files are LF-only, or when they are all CR/LF.
> > In all other cases, we have mixed line endings anyway.
> >
> > And to do that, it is sufficient to look at *one single line
> > ending* in the context. Technically, it does not even have to be
> > the context, but the first line endings of the first file would
> > be enough, however it is so much more pleasant if the conflict
> > marker's eol matches the one of the preceding line.
> 
> I like that approach.  My understanding of the xdiff/xmerge code is
> very rusty and I have some time to re-learn it before I can judge
> that the change implements that approach correctly, though X-<.

I hear ya. The xmerge code is my fault, too, and it did not help that I
imitated the lack of documentation of the surrounding code.

But it all came back to me when I looked at the code. Hopefully these
hints are helpful:

- xe1 and xe2 refer to "xdfenv_t" types that essentially hold pointers to
  one pre-image and one post-image, each

- The pre-images of xe1 and xe2 are identical, of course, because we are
  looking at a three-way merge

- The xdfenv_t type refers to the pre-image as xdf1 and to the post-image
  as xdf2, both of the type "xdfile_t"

- The xdfile_t structure contains the pointers to a parsed file. The lines
  are called "recs" (record) here

- Each record has a pointed to the start of the line and a size that
  includes the newline byte, if any

- The record parsing hard-codes 0x0a as newline (NEWLINEBYTES), which is
  used in the xdl_hash_record() function that is called from the
  xdl_prepare_ctx() function that parses each input file, and which in
  turn is called from the xdl_prepare_env() function that prepares a
  pair of files for diff'ing by the xdl_do_diff() function that in turn
  is called twice from xdl_merge() to diff orig->a and orig->b

- Imitating libdiff's existing code, "i" is used to refer to a specific
  line; it is the line number decremented by one, i.e. 0 <= i < nrec
  (where "nrec" is the field of the xdfile_t structure indicating the
  line count)

You know, cobbling these notes together had an unexpected side effect: I
realized that another patch is needed to properly support CR/LF files:
when the conflict hunk is at the end of one file and said file has no
trailing line ending, we add \n always, but we should add \r before that
when appropriate.

I'm on it.

Ciao,
Dscho
