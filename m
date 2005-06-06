From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 07:43:56 +0200
Message-ID: <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 07:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfALm-0000lo-8K
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 07:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVFFFoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 01:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFFFoK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 01:44:10 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:37007 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261180AbVFFFoG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 01:44:06 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j565huS8010922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Jun 2005 05:43:57 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j565huaR010921;
	Mon, 6 Jun 2005 07:43:56 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> >  - "What happens when a merge goes wrong" helper script Jeff
> >    wanted to have in *4*.

> Does anybody have any suggestions? Preferably with a reasonable 
> test-case, so that people can try it out.. Maybe just leaving the merge 
> failures where they are?

I think the simplest and effectivies way to handle this is the
following: Add a flag to the current merge script which indicates that
on conflicts the user will be dropped to a shell per conflict to solve:

	- Checkout filename.LOCAL, filename.REMOTE, filename.GCA (with
	  sanitychecks of course (eg not overwriting existing files)
	- Run merga -A on them and maybe wiggle and write the product in
	  filename
	- If the user resolves the conflict drop him a note to
	  'update-cache' the resolved conflict and exit the subshell.

I also have at the moment a very nice perl merge script which works with
multiple heads, duplicates and stuff. Maybe I should write this down in
bash.

The above approach worked out very good at least for me. I often had to
resolve 'simple' conflicts when pulling in upstream changes from Linus
repo.

	Thomas
