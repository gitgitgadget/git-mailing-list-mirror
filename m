From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 17:37:38 -0400
Message-ID: <51DC82A2.8020203@xiplink.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 23:49:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwfmw-0002bX-57
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 23:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753722Ab3GIVta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 17:49:30 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:48569 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3GIVt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 17:49:28 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2013 17:49:28 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id DAFC28AA1
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 17:39:40 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp114.ord1c.emailsrvr.com (smtp114.ord1c.emailsrvr.com [108.166.43.114])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id BC9A98A9C
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 17:39:40 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp7.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 1EE091B8138;
	Tue,  9 Jul 2013 17:37:35 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp7.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C566D1B8116;
	Tue,  9 Jul 2013 17:37:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7vhag3v59o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230010>

On 13-07-09 04:37 PM, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Am 09.07.2013 21:53, schrieb Junio C Hamano:
>>> +--lockref::
>>> +--lockref=<refname>::
>>> +--lockref=<refname>:<expect>::
>>> ...
>>> +This is meant to make `--force` safer to use.
>>
>> This is a contradiction. "--force" means "I mean it, dude", and not "I
>> mean it sometimes". It would make sense if this sentence were "This is
>> meant to make `+refspec` safer to use."
> 
> No, this *IS* making --force safer by letting you to say in addition
> to --force alone which is blind, add --lockref to defeat it.
> 
> I do not see any good reason to change the samentics of "+refspec"
> for something like this.  "+refspec" and "--force refspec" have
> meant the same thing forever.  If --lockref adds safety to +refspec,
> the same safety should apply to "--force refspec".
> 
>> Do you intend to require users to opt in to safety by saying --lockref
>> until the end of time?
> 
> For normal users this is *NOT* necessary.  I do not know where
> people are getting the idea of making it default.
> 
> Rewinding a branch, needing to --force, is an exceptional case.

Yes, rewinding is exceptional.

However, when a rewind has to happen, I think most users would want to have
this feature most of the time.  I think anyone who rewinds a shared branch
would hate to inadvertently throw away someone else's work.  Rare is the
person who really won't care about that.

So I agree with those who say that this would be nice default behaviour.  I
also don't think we need to make --force different from +refspec, mainly
because if the rewound ref turns out to have moved a simple "git fetch" will
update it and likely allow the next rewind attempt to succeed.  A helpful
error message would make this plain.

I also appreciate the desire to let this stew a while before making it the
default.  However, I don't think that leaving it as an option of push will
give it enough exposure.  I myself want this feature, and I do rewind or
delete a branch every few months or so, but I'm almost certainly going to
forget to use this option the next time the need arises.

But if it was instead/also a configurable option I could just turn on, that
would be awesome.

<bikeshed>
For the option name, how about --match-baseref ?
</bikeshed>

		M.
