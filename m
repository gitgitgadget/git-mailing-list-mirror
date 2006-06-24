From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 01/12] Introduce Git.pm (v4)
Date: Sat, 24 Jun 2006 13:16:57 +0200
Message-ID: <20060624111657.GR21864@pasky.or.cz>
References: <20060624023429.32751.80619.stgit@machine.or.cz> <7vr71f5kzs.fsf@assigned-by-dhcp.cox.net> <7vu06bymtr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu68N-0001e0-VV
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbWFXLRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbWFXLRA
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:17:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40611 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1752203AbWFXLQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 07:16:59 -0400
Received: (qmail 24443 invoked by uid 2001); 24 Jun 2006 13:16:57 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu06bymtr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22503>

Dear diary, on Sat, Jun 24, 2006 at 10:33:52AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> The reason it failed?  Well, it could not find Git.pm because
> the changes to fmt-merge-msg was done for distros not for people
> who install under their home directories.

I don't understand what are you trying to say here...

> Now, I am quite unhappy about the situation (and it is not your
> fault).  "git pull" is something almost everybody uses, and
> having the series means they would need to make sure whereever
> Git.pm is installed is on their PERL5LIB as things currently
> stand.

...because well, they do:

$(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
	rm -f $@ $@+
	sed -e '1s|#!.*perl\(.*\)|#!$(PERL_PATH_SQ)\1 -I'"$$(make -s -C perl instlibdir)"'|' \
	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
	    $@.perl >$@+
	chmod +x $@+
	mv $@+ $@

(This is also why I was a bit confused by your make test patch - it does
not "fix" anything per se since no tests directly use Git.pm.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
