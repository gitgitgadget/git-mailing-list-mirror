From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Fri, 06 Sep 2013 19:28:43 +0200
Message-ID: <vpq38phsvuc.fsf@anie.imag.fr>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
	<vpqioyfukkw.fsf@anie.imag.fr>
	<20130905232322.GB29351@sigill.intra.peff.net>
	<20130906165330.GA6462@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHzqc-0002c1-EU
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799Ab3IFR3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:29:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43880 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab3IFR3W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:29:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r86HSfrH029999
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 Sep 2013 19:28:41 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VHzpr-0000WY-GL; Fri, 06 Sep 2013 19:28:43 +0200
In-Reply-To: <20130906165330.GA6462@google.com> (Jonathan Nieder's message of
	"Fri, 6 Sep 2013 09:53:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 06 Sep 2013 19:28:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r86HSfrH029999
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1379093326.58342@fP85srWjnKQfhwHmqAqanw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234067>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>> On Thu, Sep 05, 2013 at 09:36:47PM +0200, Matthieu Moy wrote:
>
>>> I'm fine with any name actually (since it is enabled by default, people
>>> don't need to know the name to benefit from the new output). Maybe
>>> status.displayCommentPrefix was the best name after all.
>>
>> FWIW, I had the same thought as Junio. I much prefer something like
>> status.displayCommentPrefix for clarity and future-proofing.
>
> Sounds fine, but I don't understand why we'd want this to be an option
> with a future in the first place.  Why not just fix the remaining bugs
> before merging to master and make it unconditional?

I think some old-time users may appreciate to have a
backward-compatibility option. It doesn't cost much for us, as we need
the variable internally (to use the prefix in COMMIT_EDITMSG, and not on
stdout), and it actually makes it easier to test.

>>                                               and the bottom "nothing
>> added" line butts against the untracked list more obviously, because
>> they now all have the same comment indentation.
>>
>> I wonder if it would look a little nicer as:
>>
>>   On branch private
>>   Your branch and 'origin/next' have diverged,
>>   and have 472 and 59 different commits each, respectively.
>>
>>   Untracked files:
>>           t/foo
>>           test-obj-pool
>>           test-string-pool
>>           test-treap
>>           test-url-normalize
>>
>>   nothing added to commit but untracked files present
>
> The added blank line before "nothing added" sounds like a good idea.

I won't change the header part in this topic (no time, sorry), but the
missing newline before "nothing added" actually sounds like a bug, as
there is normally a newline after each list of file in `git status`,
except untracked and ignored.

I'll fix it as a separate patch in the next round.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
