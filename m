From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 16:01:40 -0500
Message-ID: <50C25934.4080409@xiplink.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 22:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th53K-00014C-4D
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 22:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424505Ab2LGVBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 16:01:30 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:44594 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424420Ab2LGVB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 16:01:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 62F85198150;
	Fri,  7 Dec 2012 16:01:31 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A1434198110;
	Fri,  7 Dec 2012 16:01:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211193>

On 12-12-07 03:23 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>>     sh-setup: protect from exported IFS
>>
>>     Many scripted Porcelains rely on being able to split words at the
>>     default $IFS characters, i.e. SP, HT and LF.  If the user exports a
>>     non-default IFS to the environment, what they read from plumbing
>>     commands such as ls-files that use HT to delimit fields may not be
>>     split in the way we expect.
>>
>>     Protect ourselves by resetting it, just like we do so against CDPATH
>>     exported to the environment.
>>
>>     Noticed by Andrew Dranse <adranse@oanda.com>.
>>
>>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> Perhaps IFS should be set to " \t\n" (which I believe is sh's default)
>> instead of just unsetting it altogether?
> 
> POSIX.1 says this:
> 
>     IFS - A string treated as a list of characters that is used for
>     field splitting and to split lines into fields with the read
>     command.  If IFS is not set, it shall behave as normal for an
>     unset variable, except that field splitting by the shell and
>     line splitting by the read command shall be performed as if the
>     value of IFS is <space> <tab> <newline>; see Field Splitting.
> 
>     Implementations may ignore the value of IFS in the environment, or
>     the absence of IFS from the environment, at the time the shell is
>     invoked, in which case the shell shall set IFS to <space> <tab>
>     <newline> when it is invoked.

Not to defend anyone, but I can understand how an implementer might think
they're complying with the above while still deciding that an explicit "unset
IFS" means IFS=''.

		M.
