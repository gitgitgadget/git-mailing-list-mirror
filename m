From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 14:59:20 -0800
Message-ID: <4B032AC8.4@eaglescrag.net>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com> <7vhbssewm7.fsf@alter.siamese.dyndns.org> <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com> <7vd43gerak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 23:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAX1T-00078h-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 23:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbZKQW7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbZKQW7a
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 17:59:30 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:59378 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704AbZKQW7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 17:59:30 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nAHMxMsn008787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 14:59:28 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <7vd43gerak.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10030/Mon Nov 16 18:38:41 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Tue, 17 Nov 2009 14:59:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133108>

Junio C Hamano wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
> 
>>> Wouldn't it be a good idea to somehow make this work well together with
>>> the --user-path feature of git-daemon?
>>>
>>> Perhaps the recommended name given in the example shouldn't be ~/gitweb,
>>> but more like ~/public_git, as this is like ~/public_html but for git
>>> repositories.  Then the end users will browse
>> As I said, it's configuration :)
> 
> Wrong answer.
> 
> Exactly because it is configurable, the document that outlines the
> recommended practice should suggest the best convention.  My point was
> that it is likely to be tied to "git"-ness of the specified directory
> under $HOME/, not limited to "gitweb"-ness, and it is wrong to recommend a
> name tied to "gitweb"-ness in this document.

For starters I think overriding the /~<user> (specifically the ~ here) 
is going to be a bad idea no matter what you do and gives the wrong 
impression about what / how the request is being responded to.  You 
might want to try and pick a different delimiter or re-work the rule so 
that you could have something like:

	http://git.kernel.org/<gitweb urls>
	http://git.kernel.org/user/<gitweb urls>

Your also, likely, going to need to take into account things like 
index.cgi and gitweb.cgi in the url as things like:

http://git.kernel.org/?p=bluetooth/bluez-gnome.git;a=summary
http://git.kernel.org/gitweb.cgi?p=bluetooth/bluez-gnome.git;a=summary

are likely to be correct for almost all installations.

I would agree with Junio on this, if your suggesting a possible practice 
you should focus on the best convention.  Making it depend on something 
like ~/gitweb doesn't make it clear or obvious enough to a user, or an 
administrator, that the directory is being exported for the world to 
see.  There is a reason it's called ~/public_html.

Keep in mind most people are going to read the documentation and 
copy/paste what they need and not change anything.



- John 'Warthog9' Hawley
