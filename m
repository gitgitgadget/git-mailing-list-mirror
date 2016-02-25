From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Rebase performance
Date: Thu, 25 Feb 2016 18:30:18 +0100
Message-ID: <vpq37sg4s0l.fsf@anie.imag.fr>
References: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
	<CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:30:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzkR-00075i-JI
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933335AbcBYRac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 12:30:32 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52000 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933238AbcBYRa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:30:28 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHUGOs026613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 18:30:16 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHUILd023747;
	Thu, 25 Feb 2016 18:30:18 +0100
In-Reply-To: <CACBZZX7rVAdzfCm=0FdrCXSx8a2=a8n7pjq1ZSW-V3fzmaSGWw@mail.gmail.com>
	(=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Thu, 25
 Feb 2016 17:31:04
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Feb 2016 18:30:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1PHUGOs026613
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457026218.96249@Zd2eOgpUwkByrwr4bwuo/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287402>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> At the risk of derailing this thread, a thing that would make rebase
> even faster I think would be to change it so that instead of applying
> a patch at a time to the working tree the whole operation takes place
> on temporary trees & commits and then we'll eventually move the branc=
h
> pointer to that once it's finished.
>
> I.e. there's no reason for why a sequence of 1000 patches where a
> FOO.txt is changed from "hi1", "hi2", "hi3", ... would be noticeably
> slower than applying the same changes with git-fast-import.

Also, not touching the worktree during rebase would have the advantage
that if the final result doesn't change a file, we wouldn't need to
touch this file at all, hence the next "make" (or whatever
timestamp-using build system the user runs) would consider this file
unchanged.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
