From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in
 case of non-fast forward
Date: Sat, 08 Aug 2009 09:25:07 -0700
Message-ID: <7vy6pujmsc.fsf@alter.siamese.dyndns.org>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
 <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
 <87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Aug 08 18:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZojU-0001Ul-H0
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 18:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZHHQZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 12:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbZHHQZP
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 12:25:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZHHQZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 12:25:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE8792276B;
	Sat,  8 Aug 2009 12:25:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8417F2276A; Sat,  8 Aug 2009
 12:25:09 -0400 (EDT)
In-Reply-To: <vpqab2aqqia.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat\, 08 Aug 2009 17\:22\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CFF6380-8438-11DE-8E2A-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125287>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Teemu Likonen <tlikonen@iki.fi> writes:
>
>> On 2009-08-08 09:51 (+0200), Matthieu Moy wrote:
>>> 'git push' failing because of non-fast forward is a very common situation,
>>> and a beginner does not necessarily understand "fast forward" immediately.
>>
>>> +		if (nonfastforward) {
>>> +			printf("Push was rejected because it would not result in a fast forward:\n"
>>> +			       "Merge in the remote changes (using git pull) before pushing yours,\n"
>>> +			       "or use git push --force to discard the remote changes.\n"
>>> +			       "See 'non-fast forward' section of 'git push --help' for details.\n");
>>> +		}
>>
>> I'd like to add that some projects that use Git in (partially)
>> centralized manner prefer "git pull --rebase" before "git push".
>
> Right, but I don't think this error message is the place to discuss
> that. Anything involving rebasing should be taken with care, and
> pointing the user to it in a short sentence sounds like "try shooting
> yourself in the foot, and read the man page if it hurts" ;-).

Instead of saying "Merge in", we could say "Integrate" to cover both
practices.  I also happen to think that the mention of --force falls into
the same category as "try shooting and then study if it hurgs".

So how about phrasing it like this?

    Non-fast forward pushes were rejected because you would discard remote
    changes you have not seen.  Integrate them with your changes and then
    push again. See 'non-fast forward' section of 'git push --help'.

I think you can throw in a discussion on --force to the manual page, too.
