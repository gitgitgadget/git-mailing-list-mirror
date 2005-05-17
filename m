From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] Janitor projects around core GIT
Date: Mon, 16 May 2005 21:48:14 -0700
Message-ID: <7vpsvqihkh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 17 06:48:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXu04-0007jx-St
	for gcvg-git@gmane.org; Tue, 17 May 2005 06:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVEQEs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 00:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEQEs2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 00:48:28 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:743 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261233AbVEQEsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 00:48:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517044814.FDYK19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 00:48:14 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a list of things I would like to see done by people who
want to get their hands dirty ;-).

 * Rewrite command line parsing code, probably using GNU getopt.
   I have three gripes about option parsing in the current code:

   - Some pretend to take long options, but allow only --long
     without allowing --lon or --lo.  Some say "--flag=argument"
     while others say "--flag argument", which is inconsistent
     and confusing.

   - For some commands the order of options matter for no
     apparently good reason.  The most prominent example is
     "checkout-cache -a -f" vs "checkout-cache -f -a"; yes I
     know about the comment Linus wrote, but it is more a
     warning for people not to get confused by this behaviour;
     not a justification for that confusing behaviour.

   - Related to the second point, many commands perform actions
     as they go parsing and processing the options.  It would be
     cleaner and easier to add new options later if the option
     processing loop is reorganized so that optionss are done
     first and after all options are collected, real processing
     begins.  The current way lets you make "update-cache foo
     --add bar" to refuse to add foo but to allow adding bar,
     but I do not think being able to do that kind of thing is
     buying us much.

 * Extend coverage of tests to more commands in the t/ directory.

 * const-ness cleanups.

 * Use correct types for sizes of things, as HPA suggested the
   other day.

 * It would be nice if somebody who is handy with checker/sparse
   type tools to run them on core GIT part and/or run core GIT
   part under purify.


