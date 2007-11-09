From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Fri, 9 Nov 2007 08:03:03 +0100
Message-ID: <B2BAA0E1-8DA7-417D-AE25-53D8690810ED@zib.de>
References: <20071109011214.GA5903@diku.dk> <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 08:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqNve-0007uI-Fc
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 08:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbXKIHFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 02:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbXKIHFB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 02:05:01 -0500
Received: from mailer.zib.de ([130.73.108.11]:64519 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968AbXKIHFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 02:05:00 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA971oTg006017;
	Fri, 9 Nov 2007 08:04:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1078e.pool.einsundeins.de [77.177.7.142])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA971jXd017306
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 9 Nov 2007 08:01:45 +0100 (MET)
In-Reply-To: <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64131>


On Nov 9, 2007, at 2:51 AM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> That's a known design limitation of applymbox/mailinfo.  Any
>> line that looks like a beginning of a patch in e-mail ("^--- ",
>> "^---$", "^diff -", and "^Index: ") terminates the commit log.
>
> Ok, so that explains the symptom.  What's the next step?
>
>  * The applymbox/mailinfo pair should continue to split the
>    commit log message at the first such line.  There is no point
>    breaking established workflow, and people in communities that
>    exchange patches via e-mail already know to avoid this issue
>    by indenting quoted diff snippet in the log message,
>    e.g. 5be507fc.

I wasn't aware of this.

Maybe git-commit should validate commit messages? If people
have a notion of a well-formed commit message this should be
verified. The message should not contain strings that indicate
termination of the commit message when sent by email. If commit
did this the evil strings would never enter a commit message
in the first place.

Actually I sometimes use '---' as a separator in text. I'm
sure I'll forget at some point that I must not use it in a
commit message. I'd be happy if git saved me from this.

If I understand correctly, the problem will remain when
sending patches by emails; even if git-rebase was changed
to use merge. Or does git-format-patch quote evil strings in
commit messages?

	Steffen
