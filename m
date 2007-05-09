From: Sven Verdoolaege <skimo@kotnet.org>
Subject: failing test t9400 (Re: [PATCH] git-update-ref: add --no-deref option
 for overwriting/detaching ref)
Date: Wed, 09 May 2007 17:38:31 +0200
Message-ID: <20070509153831.GW942MdfPADPa@greensroom.kotnet.org>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
 <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 17:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HloFT-0006IA-CE
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbXEIPie (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbXEIPie
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:38:34 -0400
Received: from smtp17.wxs.nl ([195.121.247.8]:35925 "EHLO smtp17.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755860AbXEIPid (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:38:33 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp17.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JHS00579647HJ@smtp17.wxs.nl> for git@vger.kernel.org; Wed,
 09 May 2007 17:38:32 +0200 (CEST)
Received: (qmail 2383 invoked by uid 500); Wed, 09 May 2007 15:38:31 +0000
In-reply-to: <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46731>

On Wed, May 09, 2007 at 08:22:42AM -0700, Junio C Hamano wrote:
> Can you retry after installing libdbi and libdbd-sqlite-perl?

I'd rather spend my (limited) time on the submodules thing.
Shouldn't these tests be skipped if I don't have all that stuff installed?
There doesn't even seem to be an option to turn off these tests.

Your hunch was correct, btw:

bash-3.00$ sh t9400-git-cvsserver-server.sh --verbose --immediate
* expecting success: cvs -Q co -d cvswork master &&
   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"
install_driver(SQLite) failed: Can't locate DBD/SQLite.pm in @INC (@INC contains: /home/skimo/src/git/t/../perl/blib/lib /home/skimo/src/git/t/../perl/blib/arch/auto/Git /usr/lib/perl5/5.8.0/i686-linux-thread-multi /usr/lib/perl5/5.8.0 /usr/lib/perl5/site_perl/5.8.0/i686-linux-thread-multi /usr/lib/perl5/site_perl/5.8.0 /usr/lib/perl5/site_perl .) at (eval 2) line 3, <STDIN> line 16.
Perhaps the DBD::SQLite perl module hasn't been fully installed,
or perhaps the capitalisation of 'SQLite' isn't right.
Available drivers: ExampleP, Proxy.
 at /home/skimo/src/git/t/../git-cvsserver line 2212
cvs [checkout aborted]: end of file from server (consult above messages if any)
* FAIL 1: basic checkout
        cvs -Q co -d cvswork master &&
           test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5))" = "empty/1.1/"

skimo
