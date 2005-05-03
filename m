From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add exclude file support to cg-status
Date: Mon, 02 May 2005 21:15:43 -0700
Message-ID: <7v4qdlndw0.fsf@assigned-by-dhcp.cox.net>
References: <20050502171042.A24299@cox.net>
	<7vd5s9nmio.fsf@assigned-by-dhcp.cox.net>
	<20050502193343.A25462@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:10:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSoje-0003mI-GP
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVECEQR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVECEQR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:16:17 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48040 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261371AbVECEPv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 00:15:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503041543.GDVW22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 00:15:43 -0400
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050502193343.A25462@cox.net> (Matt Porter's message of "Mon,
 2 May 2005 19:33:43 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MP" == Matt Porter <mporter@kernel.crashing.org> writes:

MP> My reasoning for not doing something like this was that there is
MP> only ever one exclude file.  In other instances of cogito specific
MP> data in the .git directory, there is a subdir named for the class
MP> of data being stored there (i.e. branches, refs).  In this case,
MP> it didn't seem necessary.  On the other hand, this made me
MP> wonder whether there should just be a .git/cginfo subdir where
MP> exclude, branches, refs, etc. all live under since they are
MP> cogito specfic functionality. Something like:

MP> .git/cginfo/

MP> 	    exclude
MP> 	    branches/
MP> 	    refs/

MP> and so on...

You may want to check the past thread, like this one:

    From: Daniel Barkalow <barkalow@iabervon.org>
    To: Junio C Hamano <junkio@cox.net>
    cc: David Greaves <david@dgreaves.com>, 
        GIT Mailing Lists <git@vger.kernel.org>
    Subject: Re: [PATCh] jit-trackdown
    Message-ID: <Pine.LNX.4.21.0504291730000.30848-100000@iabervon.org>

    On Fri, 29 Apr 2005, Junio C Hamano wrote:

    > Have toilet side gitters reached a concensus (or semi-concensus)
    > on how things under .git/ should be organized?  Is there a
    > summary somewhere, something along the following lines?

    I've made a proposal like the following:

    .git/
      objects/    (traditional)
      refs/       Directories of hex SHA1 + newline files
        heads/    Commits which are heads of various sorts
        tags/     Tags, by the tag name (or some local renaming of it)
      info/       Other shared information
        remotes
      ...         Everything else isn't shared
      HEAD        Symlink to refs/heads/<something>

    The plumbing doesn't care what you name heads or tags, but expects things
    to be in heads to be commit objects and tags to be tag objects (which can
    tag whatever).

    AFAICT, there is general concensus that this is how things should be, but
    I haven't convinced Linus that the plumbing should know about anything
    other than objects/.

            -Daniel

