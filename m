From: Tom Prince <tom.prince@ualberta.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 23:02:36 -0600
Message-ID: <8764snyufn.fsf@ualberta.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz> <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
 <20050926222944.GG26340@pasky.or.cz> <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 07:05:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK7cv-0000GF-Vr
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 07:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVI0FDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 01:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbVI0FDH
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 01:03:07 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54987 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964806AbVI0FDF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 01:03:05 -0400
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0ING00ECAM0BBKB0@l-daemon> for git@vger.kernel.org; Mon,
 26 Sep 2005 23:02:35 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
 by pd3mr5so.prod.shaw.ca (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar
 15 2004)) with ESMTP id <0ING008STM0BUA20@pd3mr5so.prod.shaw.ca> for
 git@vger.kernel.org; Mon, 26 Sep 2005 23:02:35 -0600 (MDT)
Received: from socrates (S0106000fea73ae52.ed.shawcable.net [68.148.44.80])
 by l-daemon (iPlanet Messaging Server 5.2 HotFix 1.18 (built Jul 28 2003))
 with ESMTP id <0ING0037EM0AA5@l-daemon> for git@vger.kernel.org; Mon,
 26 Sep 2005 23:02:35 -0600 (MDT)
Received: from socrates (localhost [127.0.0.1])	by socrates (8.13.4/8.13.4)
 with ESMTP id j8R52a2n031069; Mon, 26 Sep 2005 23:02:36 -0600
Received: (from cougar@localhost)	by socrates (8.13.4/8.13.4/Submit)
 id j8R52aUl031068; Mon, 26 Sep 2005 23:02:36 -0600
In-reply-to: <7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Authentication-warning: socrates: cougar set sender to
 tom.prince@ualberta.net using -f
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9368>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> Yes - so you can't save the tag objects either, but then
>> you'll re-slurp them again and again, which is kind of
>> silly. Alternatively, you could actually make git-fsck-object
>> silent about the case when an unreachable (not referenced in
>> refs/) tag object references a non-existing object - perhaps
>> unless --strict is passed to it. If you think the rest of my
>> logic is ok, I think this change to facilitate this "tags
>> caching" is not unreasonable.
>
> Now you completely lost me.  I really do not understand what you
> mean by tags caching and re-slurping.
>

I think Petr is interested in the case where the user hasn't asked for a
particular tag. He wants to automatically grab all the tags in a repository,
or at least those that refer to a branch being downloaded.

Of course, if somebody asks for a specific tag, then everything necessary
should be downloaded. Somebody is fetching your maint branch, Petr want to
automatically download all the tags v0.99.7[a-d], without the user specifying
them explicitly. Or more complex, somebody is tracking your master but NOT
maint. Then Petr wants to download tags v0.99.[0-9] but not v0.99.7[a-d]. 

  Tom
