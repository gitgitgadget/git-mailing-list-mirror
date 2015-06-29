From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 09:34:15 +0200
Message-ID: <vpq1tgvnf2g.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 09:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9TaL-0002Vh-0B
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 09:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbbF2He3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 03:34:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60838 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbbF2He1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 03:34:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5T7YEGP002988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 09:34:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5T7YFoP019867;
	Mon, 29 Jun 2015 09:34:15 +0200
In-Reply-To: <CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 29 Jun 2015 07:08:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 09:34:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5T7YEGP002988
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436168056.24886@viHwPUJyGbqYjd8EE5kQ6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272942>

Christian Couder <christian.couder@gmail.com> writes:

> On Sun, Jun 28, 2015 at 8:46 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> I understand that the user might make a mistake when marking the initial
>> commits, but as soon as bisect says
>>
>>     Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
>>     will look for the commit that caused the transition from
>>     "xyzzy" to "plugh".
>>
>> then I hope the user will notice and correct her/his mistake.
>
> This looks fragile to me. Unfortunately many users will probably not
> read it and continue, and then spend a lot of time later trying to
> understand what went wrong,

I don't understand what you mean by "went wrong". As a user, when I
discovered "git bisect", I was actually surprised that it expected one
particular order between good and bad. I would have expected to be able
to say "this is good, this is bad, tell me where it changed" without
having an idea of who's good and who's bad. In particular when bisecting
from two branches, the user knows that branch A is good, and branch B is
bad, but does not necessarily know whether it's a regression in B or a
fix in A. The fact that bisect can find out should be just "normal" from
the user point of view. There's no mistake involved, nothing to fix, and
nothing that went wrong.

> By the way we could use "mark" or "term" instead of "name" in the
> option name (like --mark-old or --term-old) and in the code too if it
> looks clearer.

I prefer "term" to "mark" because "mark" is both a verb and a noun, so
--mark-old=foo could mean both "mark foo as old" or "the name of the
marks for old commits is foo".

I think I prefer "term" to "name".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
