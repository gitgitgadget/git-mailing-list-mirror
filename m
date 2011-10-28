From: Gelonida N <gelonida@gmail.com>
Subject: Re: git slow over https
Date: Fri, 28 Oct 2011 22:07:48 +0200
Message-ID: <j8f22l$b2h$1@dough.gmane.org>
References: <CAOs=hR+K_YZcjdAUq_jaz0wc9k8BRQ2-ny7A=GFaNL4R-W0UBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 22:08:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJsim-0000aR-CF
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156Ab1J1UID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 16:08:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:39812 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241Ab1J1UIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 16:08:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJsie-0000WY-Py
	for git@vger.kernel.org; Fri, 28 Oct 2011 22:08:00 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:08:00 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:08:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <CAOs=hR+K_YZcjdAUq_jaz0wc9k8BRQ2-ny7A=GFaNL4R-W0UBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184428>

On 10/28/2011 05:28 PM, Mika Fischer wrote:
> Hi,
> 
> I have an apache server that serves git repositories over https. I
> have the problem that git is very slow when accessing it, as in 3
> seconds for a "git pull" that does nothing.
> 
> I tracked the problem down to git sleeping for 50ms using select from
> time to time while downloading the response of the server. In my case
> this really hurts performance (see attached strace). However, with a
> different https server things work quite fine.
> 
> If I remove the select in http.c:673 (in run_active_slot), then things
> are fast also with my server.
> 
> So my questions are:
> 1) What's the purpose of the select in http.c:673? Can it be removed?
> 2) If it serves a useful purpose, what can be the reason that it hurts
> performance so much in my case?
> 

Do you edperience the same delay if you ssh to the server?

If yes, then try to add following line to the slow https server's config
file.

UseDNS no

The config file should have a name similair to
/etc/ssh/sshd_config



Is it getting any faster?
