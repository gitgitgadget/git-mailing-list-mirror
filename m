From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: problem with git-cvsserver
Date: Thu, 31 Aug 2006 11:03:33 +0200
Message-ID: <20060831090333.GA28445@fiberbit.xs4all.nl>
References: <44F5B2A7.8070501@gmail.com> <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net> <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <junkio@cox.net>, aonghus <thecolourblue@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 31 11:03:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIiSa-0000PT-4O
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 11:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWHaJDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 05:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHaJDh
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 05:03:37 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:15280 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750864AbWHaJDg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 05:03:36 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GIiST-0007bG-Qu; Thu, 31 Aug 2006 11:03:33 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26246>

On Thursday August 31st 2006 at 08:29 uur Martin Langhoff wrote:

> [git-cvsserver and trouble with Perl DBI and SQLite]
> 
> Actually, just looking at my etch dev box, libdbd-sqlite-perl is
> 0.29-1 and sqlite is 2.8.16-1. Not sure if the difference is
> significant. Perhaps SQLite v3 has a different invocation / driver
> name?

Yes, SQLite v2 and SQLite v3 are different and binary incompatible.

However, on Debian 'etch' you can install packages for both versions
concurrently; most packages for SQLite have either a '2' or a '3' in the
name. Packages without the number use the "best current choice" which is
"3" in 'etch' at the moment but was "2" not too long ago.

So at this moment in Debian 'etch' SQLite3 is the default version and
calling

        my $dsn = 'dbi:SQLite:dbname=foo';

will use the SQLite3 driver internally, for which you must have
installed the "libdbd-sqlite3-perl" package. Just for the record, if
you'd wanted the older SQLite2 version you would install the
"libdbd-sqlite2-perl" package and from Perl call "my $dsn =
'dbi:SQLite2:dbname=foo';".

I'd guess that you were unfortunate enough to just install some packages
during the transition and now some parts look for the "2" version
and other parts for the "3" version. Probably just installing the
"libdbd-sqlite3-perl" package and upgrading the other sqlite packages
(from synaptic say to easily find them!) will probably cure your situation.

Incidentally I'd guess that in itself SQLite2 (so version 2) would also
function perfectly well for git-cvsserver (as would PostgreSQL or
MySQL), it's probably in this case just a slight version skew between
packages!
-- 
Marco Roeland
