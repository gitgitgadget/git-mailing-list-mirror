From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 07/10] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date: Sun, 11 Oct 2015 20:10:17 +0200
Message-ID: <vpqvbadz37a.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-8-git-send-email-Karthik.188@gmail.com>
	<vpqa8rtnqzp.fsf@grenoble-inp.fr>
	<CAOLa=ZTvD5cXduPH3G0bGDba_hevLQsuwYsoZFtmfTd2SS4Prw@mail.gmail.com>
	<vpqa8rp2xku.fsf@grenoble-inp.fr>
	<CAOLa=ZRvTUpz2Ey9ZLwe_iqVGPaFZGJ2_HiASpn=txAgV57otg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlL4o-0003v5-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Oct 2015 20:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbbJKSK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 14:10:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54931 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbbJKSKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 14:10:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BIAFje007583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 11 Oct 2015 20:10:15 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9BIAHXM024875;
	Sun, 11 Oct 2015 20:10:17 +0200
In-Reply-To: <CAOLa=ZRvTUpz2Ey9ZLwe_iqVGPaFZGJ2_HiASpn=txAgV57otg@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 11 Oct 2015 23:16:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 11 Oct 2015 20:10:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9BIAFje007583
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445191818.40158@7H28JgGrgVFt0jF7gKvePA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279351>

Karthik Nayak <karthik.188@gmail.com> writes:

> A little blurry on how this works, as in how translation takes place,
> probably need to look at some code.

What you really need to understand is: _("foo") is translated, "foo" is
not and will always be "foo". Technically, _ is a macro, it could be
called get_the_translated_string_for(...) but that would be too long.

In git, _("foo") should be used when talking to a user (porcelain), and
"foo" when talking to a program (plumbing). This way a user running

git <plumbing-command> | grep "some-plumbing-message"

will always get the same result regardless of the current locale.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
