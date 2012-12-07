From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Weird problem with git-submodule.sh
Date: Fri, 07 Dec 2012 15:44:41 -0500
Message-ID: <50C25539.9010206@xiplink.com>
References: <50C22B15.1030607@xiplink.com> <7vvccdhhod.fsf@alter.siamese.dyndns.org> <50C22F72.6010701@xiplink.com> <7vwqwtfzis.fsf@alter.siamese.dyndns.org> <50C24ED7.90000@xiplink.com> <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 21:45:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Th4nC-0006O4-FB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 21:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424337Ab2LGUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 15:44:50 -0500
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:59642 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424123Ab2LGUou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 15:44:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 2D9E41980E0;
	Fri,  7 Dec 2012 15:44:32 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C45CC198093;
	Fri,  7 Dec 2012 15:44:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vsj7hfw6q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211192>

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
> 
> So setting it to SP HT LF should not make a difference, or your
> shell is buggy.
> 
> This is exactly why I asked you about the /bin/sh on your
> problematic box.

Fair 'nuf.

It's FreeBSD 7.2, which I know is an obsolete version but I'm not able to
upgrade the machine.  I believe FreeBSD's sh is, or is derived from, dash.

Anyway, given that there is at least one buggy version of sh, wouldn't it be
better for git to explicitly set IFS?

		M.
