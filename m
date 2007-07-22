From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Test #7 in t9200-git-cvsexportcommit fails
Date: Sun, 22 Jul 2007 22:21:21 +0200
Message-ID: <20070722202121.GA3288@steel.home>
References: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 22:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChvl-0000gO-T2
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 22:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762782AbXGVUVZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 16:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762780AbXGVUVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 16:21:25 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:53725 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762731AbXGVUVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 16:21:24 -0400
Received: from tigra.home (Fc8c3.f.strato-dslnet.de [195.4.200.195])
	by post.webmailer.de (mrclete mo10) (RZmta 9.1)
	with ESMTP id 900c7bj6MHj9w0 ; Sun, 22 Jul 2007 22:21:22 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0F5CE277BD;
	Sun, 22 Jul 2007 22:21:22 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 96B00BDD0; Sun, 22 Jul 2007 22:21:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <31e9dd080707221241j5c00aaaaqa79c12d3e2a3345b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+WOJg=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53313>

Jason Sewall, Sun, Jul 22, 2007 21:41:53 +0200:
> This test fails for me on the current head (pulled just now) and where
> the test was introduced (e86ad71fe).

Aahh, the test where CVS failed to commit sub-second changes...
It never really succeeded.

> P.S. I don't use this part of git at all, so this is not a priority
> for me. I am using Fedora 7, which is definitely a mainstream distro,
> so I imagine others might have this problem too.

Just disable it:

    $ echo "export GIT_SKIP_TESTS = t9200" >>config.mak

It'll never work, cvs does not commit changes made during one second,
as they have the same timestamp.

If you feel interested, try investigating the test by running it with
"-d -v", like this:

    $ cd t
    $ ./t9200-git-cvsexportcommit.sh -d -v -i

You'll have to run it multiple times, probably: the problem is
sometimes timing dependent and changed output conditions may make it
go away for a while. Just continue trying.
