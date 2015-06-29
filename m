From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 17:19:21 +0200
Message-ID: <vpqlhf2czk6.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
	<vpq1tgvnf2g.fsf@anie.imag.fr>
	<CAP8UFD1gWXOZHfiELZYgvGP1dA-aeaxbyaokKCut9pfWghy9uQ@mail.gmail.com>
	<vpqsi9alv1l.fsf@anie.imag.fr>
	<CAP8UFD23RTCzrv8j8Jbcx5ajMUjgVsO3P5_Fiv3Vwx5uaPwXrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 17:19:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9aqO-0006b7-EW
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 17:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbF2PTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 11:19:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46029 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbbF2PTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 11:19:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFJKpo013440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 17:19:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5TFJLQ2031250;
	Mon, 29 Jun 2015 17:19:21 +0200
In-Reply-To: <CAP8UFD23RTCzrv8j8Jbcx5ajMUjgVsO3P5_Fiv3Vwx5uaPwXrw@mail.gmail.com>
	(Christian Couder's message of "Mon, 29 Jun 2015 12:55:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 17:19:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5TFJKpo013440
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436195963.85679@+NbmdYdoKbfU4elX9QXnkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272955>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jun 29, 2015 at 11:32 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> bisect is all about finding the commit where a property has changed,
>
> That is your interpretation of this command. On the man page there is:
>
>     git-bisect - Find by binary search the change that introduced a bug
>
> So its stated purpose is to find the first "bad" commit. Not to find a fix.

This is a limitation of the current bisect, but the discussion is
precisely about removing this limitation.

I still don't understand what "risk" we are taking by doing the
bisection anyway. I can't imagine a case where we would harm the user by
doing so.

I just tested with Mercurial, and looking for a fix instead of a
regression just works:

$ hg bisect --good 4        
$ hg bisect --bad 1         
Testing changeset 2:d75a2d042c99 (3 changesets remaining, ~1 tests)
1 files updated, 0 files merged, 0 files removed, 0 files unresolved
$ hg bisect --bad  
Testing changeset 3:9d27d9c02e28 (2 changesets remaining, ~1 tests)
1 files updated, 0 files merged, 0 files removed, 0 files unresolved
$ hg bisect --bad
The first good revision is:
changeset:   4:1dd9bb959eb6
tag:         tip
user:        Matthieu Moy <Matthieu.Moy@imag.fr>
date:        Mon Jun 29 17:07:51 2015 +0200
summary:     foo

I don't see anything wrong with this.

(OTOH, "hg bisect" does not accept revisions which aren't parent of each
other)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
