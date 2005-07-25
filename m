From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Mon, 25 Jul 2005 00:32:41 -0700
Message-ID: <7vek9ns5ly.fsf@assigned-by-dhcp.cox.net>
References: <20050725064140.95259.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 09:33:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwxSR-0001G5-03
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 09:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVGYHc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 03:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGYHc4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 03:32:56 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6368 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261655AbVGYHcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 03:32:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050725073237.WMPG3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 03:32:37 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050725064140.95259.qmail@web26304.mail.ukl.yahoo.com> (Marco Costalba's message of "Sun, 24 Jul 2005 23:41:40 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba <mcostalba@yahoo.it> writes:

> Are really necessary to have both --exclude-from=<file> and 
> --exclude-per-directory=<name> ?
>
> Peraphs, if the file name of excluded list is the same for each directory, 
> e.g. .gitignore or something similar, instead of --exclude-per-directory
> we can use a concept of file validity 'scope' and just use --exclude-from=<file>.
> If entering in a directory <file> is found its contents are appended and 
> removed when leaving directory. A bad analogy can be with the use of 
> recursive Makefile.

Pasky wants to have one of the files in ~/.git-something if I
understand correctly.  I did not want to remove --exclude-from
for that reason.

> If we use the 'scope' logic we can just prepend path when
> adding entries and serach with with FNM_PATHNAME flag.

And I wanted for people's script and existing ignore files to
continue to work.

> Same comment as above, if prepending path when adding per 
> directory contents we can simplify to always use FNM_PATHNAME flag.

Yes, but that means you need to always prepend the current
directory being looked at to get the original behaviour.  The
way it was originally done without FNM_PATHNAME was far easier
to read, at least for me.
