From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 13:23:35 -0700
Message-ID: <7vodywxago.fsf@assigned-by-dhcp.cox.net>
References: <20060419053640.GA16334@tumblerings.org>
	<20060419094916.GD27689@pasky.or.cz>
	<20060419142131.GD4104@tumblerings.org>
	<20060419144827.GX27631@pasky.or.cz>
	<20060420164908.GA540@tumblerings.org>
	<7vejzsywrq.fsf@assigned-by-dhcp.cox.net>
	<20060420200849.GA3653@tumblerings.org>
	<7vslo8xaql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 22:24:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWfgi-0001al-IE
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 22:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWDTUXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDTUXi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 16:23:38 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62712 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751257AbWDTUXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 16:23:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420202336.HKYL8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 16:23:36 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <7vslo8xaql.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 20 Apr 2006 13:17:38 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18994>

Junio C Hamano <junkio@cox.net> writes:

> Zack Brown <zbrown@tumblerings.org> writes:
>
>> Not true. I went into the git source directory, and ran "make". Nothing more.
>
> Ah, I misunderstood.  You are trying to run it _without_
> installing it.
>
> Well, then probably you do not have templates installed
> anywhere, especially not where git-init-db expects them to be
> found.

(sorry for the short message sent unfinished by mistake).

Running things without installing is somewhat tricky, but test
framework needs to do that, so there are some things you would
need to do.

 - "git init-db" takes --template argument; in the source area
   before installing, they are built in templates/blt/.

 - "git" and programs that need to invoke other git programs
   (e.g. git-send-pack) expects things to be found in gitexecdir
   you set when you build.  If you are not installing, you need
   to override that with GIT_EXEC_PATH environment variable.

There might be other things, but you should be able to find them
from what t/Makefile and t/test-lib.sh do.

Having said that, honestly I would not recommend "runnning
without installing" unless you know what you are doing ;-).
