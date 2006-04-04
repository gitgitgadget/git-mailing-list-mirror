From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 04 Apr 2006 02:08:31 -0700
Message-ID: <7vfykt908g.fsf@assigned-by-dhcp.cox.net>
References: <20060403221841.25097.18242.stgit@dv.roinet.com>
	<20060404082002.GJ4663@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 11:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQhWo-0008Hn-Lc
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 11:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWDDJIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 05:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDDJIe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 05:08:34 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43991 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932356AbWDDJId (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 05:08:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404090832.RHQN6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 05:08:32 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060404082002.GJ4663@admingilde.org> (Martin Waitz's message of
	"Tue, 4 Apr 2006 10:20:02 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18379>

Martin Waitz <tali@admingilde.org> writes:

>> +-x::
>> +	Don't use the ignore rules.  This allows removing all untracked
>> +	files, including build products.  This can be used (possibly in
>> +	conjunction with gitlink:git-reset[1]) to create a pristine
>> +	working directory to test a clean build.
>
> as ignored files are generally generated files, doesn't it make sense
> to clean up the "ignored" files, and leave other untracked files
> alone?  That way you don't loose files which you forgot to add to git.

Sounds like a sane suggestion, but my previous comment about
"make clean" broken for people who want this "git clean" feature
applies here as well.

One justification I can think of for "git clean" without -x flag
is to make a clean tree that has only the source and build
products, removing editor backup files, throwaway test output
files and friends, but as you pointed out, this risks losing
newly created source files that you forgot to add, so I would
need a bit of convincing before I use such a command myself.

Compared to that, removing only ignored files sounds like a much
safer operation -- they are explicitly listed as expendable, so
it is a lot less likely to lose anything important.  But again,
that is what "make clean" is there for...
