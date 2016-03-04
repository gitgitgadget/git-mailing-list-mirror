From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/3] Documentation/git-pull: document --[no-]autostash option
Date: Fri, 04 Mar 2016 08:00:09 +0100
Message-ID: <vpqegbqg22u.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-3-git-send-email-mehul.jain2029@gmail.com>
	<xmqqbn6v32ms.fsf@gitster.mtv.corp.google.com>
	<CA+DCAeS90-mbyPVqpJJ6LwRwgN2rWycDtuENsCKuu6ktGpDC_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 08:00:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abjir-0004dh-Jk
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 08:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcCDHAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 02:00:21 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55947 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbcCDHAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 02:00:20 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u24708lm030073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 4 Mar 2016 08:00:08 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u24709bK008137;
	Fri, 4 Mar 2016 08:00:09 +0100
In-Reply-To: <CA+DCAeS90-mbyPVqpJJ6LwRwgN2rWycDtuENsCKuu6ktGpDC_A@mail.gmail.com>
	(Mehul Jain's message of "Fri, 4 Mar 2016 10:34:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Mar 2016 08:00:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u24708lm030073
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457679609.41963@tk+nrPiW58B2cuJR61xleQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288237>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Thu, Mar 3, 2016 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Should this entry this verbose?
>>
>>  - Is there a non-temporary stash?
>>
>>  - I think "This means that ..." is totally unnecessary.
>>
>>  - It probably makes sense to have "This option is only valid..." as
>>    a separate second paragraph as you did.
>>
>>  - "The default is..." is misleading.  Even if rebase.autostash is
>>    set to false, we won't autostash, but that is different from the
>>    default being "--no-autostash".
>>
>>    Think of "--[no-]autostash" option as *ONE* way to affect the
>>    auto-stashing behaviour, and treat "options" and "behaviours" two
>>    different things.
>>
>> There is no default "option" for this.  It is that "autostash"
>> behaviour defaults to what is given to rebase.autostash if
>> exists, and can be explicitly set by --[no-]autostash if given.
>>
>> But that is the norm for any configuration and option that overrides
>> the configuration, so it probably is a better use of the ink to say
>> something like this perhaps?
>>
>>         --autostash::
>>         --no-autostash::
>>                 Before starting "pull --rebase", create a stash to save
>>                 local modifications, and apply the stash when done (this
>>                 option is only valid when "--rebase" is used).
>
> OK, but according to the definition of --[no-]autostash given in
> git-rebase documentation (https://git-scm.com/docs/git-rebase),
> temporary stash is created.

You shouldn't justify your change by copy-paste from another place. If
the other place is wrong, then replicating it is the worse thing to do
because this would mean we end up with two suboptimal pieces of
documentation instead of one (keep in mind: maintaining stuff is usually
harder than writing it in the first place).

I agree with Junio that "temporary stash" is pleonasm. OTOH, for someone
not familiar with "git stash", the explanation makes no sense anyway.
So, I'd drop the "temporary", and instead add a link to the doc of git
stash. Also, this is not really before starting "pull --rebase" but
after the user calls "pull" and before the actual rebase starst. I'd
write something like this:

	Before starting rebase, stash local modifications away (see
	linkgit:git-stash.txt[1]) if needed, and apply the stash when
	done

(I added "if needed" which makes sense technically since we don't create
an empty stash if not needed)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
