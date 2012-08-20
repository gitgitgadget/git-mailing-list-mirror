From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Mon, 20 Aug 2012 18:09:14 +0200
Message-ID: <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com> <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> <7v628epzia.fsf@alter.siamese.dyndns.org> <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de> <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3UXh-0003EX-61
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab2HTQJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:09:23 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57086 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab2HTQJW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:09:22 -0400
Received: from DualCore (dsdf-4db55923.pool.mediaWays.net [77.181.89.35])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lp8j6-1TZY6b1TD2-00fMzy; Mon, 20 Aug 2012 18:09:17 +0200
In-Reply-To: <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KAKVWWsnAm8TuDMCb+a+7QMjYLRhlZv4e7A=
Content-Language: de
X-Provags-ID: V02:K0:zwKWvdovhy7bI1FX1YJUKhjORVd+KcxY9FlE6yIe+na
 W/PtzA1BdSwNJeuhUC+yVeQaVaMQn5+KmY2fH/6L3HvmMnrO0H
 34sziSRPmTESfsGBb3gKAM1wVWIyN9qe0aNUsc5R2GtTZfH8wx
 65svOass8e2x+dd7t+kz5C05l2B0T4nT0QnI9w5CVZcLlK/zjU
 D1dqmFRXu9kj1pXivr3E6NtLajcpXBwQHAKe/RqTN7hzj7OuBk
 Yq6ZHEoB6dy+O49woWSTUFTG/kk8Sb1ewDVGJu+EAtIcDnyF+M
 0hHLn2m6LDDC4gXQ5sZ/TZtST0kb0zkFM6iMgIq1tHJKK1xD1Y
 UQp3Sqoe/cvctMsf8g1BhwaQiWeZWNAOAPJxHFcKygkI2oKSwn
 bOBbY5IliJMpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203848>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, August 20, 2012 4:42 PM
> To: Joachim Schmitz
> Cc: 'Shawn Pearce'; git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > OK, I'll go for a compat/mkdir.c though.
> 
> No.  See below.
> 
> > We shouldn't call it tandem.c as Tandem, the Company, doesn't exist
> > anymore and since more than a decade (bough by Compaq, then HP), only
> > the __TANDEM survived in our compiler and headers/libraries. Could
> > call it NonStop.c, but I don't really like that idea either, I'd
> > rather keep it more generic, just in case someone else might need it
> > too, or that issue someday gets fixed for NonStop.
> 
> compat/hp_nonstop.c is also fine, but I think matching "#ifdef __TANDEM"
is
> the most sensible.
> 
> And I wouldn't call it just "mkdir", as it is more likely than not that we
will find
> other incompatibilities that needs to be absorbed in the compat/ layer,
and we
> can add it to compat/tandem.c, but not to compat/mkdir.c, as that will be
> another nonstop specific tweak.

I haven't found any other to be needed. Well, poll, maybe, but with only
minor tweaks for the win32 one works for me (and those tweaks are compatible
with win32

> A separate file, compat/tandem/mkdir.c, is fine, though.
> 
> > I'll go for git_mkdir(), similar to other git wrappers, (like for
> > mmap, pread, fopen, snprintf, vsnprintf, qsort).
> 
> Again, no.  Your breakage is that having underlying system mkdir that does
not
> understand trailing slash, which may not be specific to __TANDEM, but
still is
> _not_ the only possible mode of breakage.

Well, it is the only one GNUlib's mkdir caters for and I'd regard that an
authoritative source...

> Squatting on a generic "git_mkdir()" name makes it harder for other people
to
> name their compat mkdir functions to tweak for the breakage on their
> platforms.  The examples you listed are all "the platform does not offer
it, so
> we implement the whole thing" kind, so it is in a different genre.

Nope, git_fopen() definitly is a wrapper for fopen(), as is git_vsnprintf()
for vsnprintf().

Bye, Jojo
