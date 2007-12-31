From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: v1.5.4 plans
Date: Sun, 30 Dec 2007 19:56:41 -0800 (PST)
Message-ID: <377939.62541.qm@web52402.mail.re2.yahoo.com>
References: <20071212184022.GB28377@untitled>
Reply-To: ddkilzer@kilzer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 04:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Bm8-0003R3-N7
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 04:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXLaD4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 22:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbXLaD4n
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 22:56:43 -0500
Received: from web52402.mail.re2.yahoo.com ([206.190.48.165]:39174 "HELO
	web52402.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752209AbXLaD4m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2007 22:56:42 -0500
Received: (qmail 63405 invoked by uid 60001); 31 Dec 2007 03:56:41 -0000
X-YMail-OSG: Rfua480VM1lrbvXFp6nOmcZnhIt6B4n3mjHV2.cQrhkHFoCtNkklFgFf0H0zbMEmGbwhow--
Received: from [24.7.124.164] by web52402.mail.re2.yahoo.com via HTTP; Sun, 30 Dec 2007 19:56:41 PST
X-RocketYMMF: ddkilzer
In-Reply-To: <20071212184022.GB28377@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69385>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> >  * I've seen t9119-git-svn-info.sh fail in my k.org private repository
> >    and have been skipping the test, but this needs to be diagnosed and
> >    fixed [*1*].  It could be just that the code is fine and the test is
> >    not rejecting SVN that is too-old. I dunno.
> 
> I wouldn't mind dropping this test for now.
> 
> 100% output compatibility with SVN is too difficult to achieve
> and IMHO not worth it for commands like `info' and `log'.
> 
> David:
> 
> I also noticed some race-conditions on this test when running this on my
> Centrino laptop (my fastest box, but I rarely use it for git
> development) and having git on my USB thumb drive.  I'm pretty sure
> these were caused by inconsistencies in handling timestamps on symlinks
> vs timestamps on the files they link to.

The problem is that 'svn info' is reading the mtime from its hidden backup file
(in the .svn directory) instead of the file in the working directory, so
setting the mtime (and atime) of the git working copy file using the svn
working copy doesn't always work.

I'm working on a solution now.

Dave
