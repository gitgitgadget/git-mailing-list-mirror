From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] GIT_SSH alternate ssh name or helper
Date: Wed, 03 Aug 2005 12:29:55 -0700
Message-ID: <7v4qa6akek.fsf@assigned-by-dhcp.cox.net>
References: <20050803151542.GA6655@medusa>
	<7viryndjvu.fsf@assigned-by-dhcp.cox.net>
	<20050803185621.GA20645@medusa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 21:31:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0OwS-0008Cl-7i
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 21:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbVHCT37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 15:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbVHCT37
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 15:29:59 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7557 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262402AbVHCT36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 15:29:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803192957.YASP8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 15:29:57 -0400
To: Martin Sivak <mars@nomi.cz>
In-Reply-To: <20050803185621.GA20645@medusa> (Martin Sivak's message of "Wed,
	3 Aug 2005 20:56:21 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Sivak <mars@nomi.cz> writes:

> I mean, how would you setup different identities for more user
> accounts on the same server (it doesn't happen often, but..)?

I do not claim the way I do is the best way, but I do that all
the time.

I just use different "name" to connect, by setting up the ssh
client configuration file to give me the protocol parameters I
want depending on the name I use.  The wildcard support handles
permutations quite nicely.  Something like this:

    $ cat .ssh/config
    Host *-1-*
      Protocol 1
    Host *-2-*
      Protocol 2
    Host lucia-*
      Hostname lucia.example.xz
    Host myriam-*
      Hostname myriam.example.xz
    Host *-junio
      IdentityFile ~/.ssh/identity-junio
      IdentityFile ~/.ssh/id_dsa-junio
    Host *-junkio
      IdentityFile ~/.ssh/identity-junkio
      IdentityFile ~/.ssh/id_dsa-junkio

    $ ssh lucia-2-junio ;# go to lucia over protocol 2, use id_dsa-junio
    $ ssh myriam-1-junkio ;# to myriam over protocol 1, use identity-junkio
