From: Christopher Faylor <me@cgf.cx>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 12:15:46 -0400
Message-ID: <20051005161546.GB30303@trixie.casa.cgf.cx>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <Pine.LNX.4.63.0510050902430.28854@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 18:17:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBw1-0000pr-JV
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbVJEQPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVJEQPs
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:15:48 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:41151 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030210AbVJEQPr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 12:15:47 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 457FE13C101; Wed,  5 Oct 2005 16:15:46 +0000 (UTC)
To: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510050902430.28854@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9717>

On Wed, Oct 05, 2005 at 09:09:49AM -0700, Davide Libenzi wrote:
>On 10/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
>>Still does not work for me.  I cannot isolate the problem out of git,
>>but at the moment the only way for me to make commit_index_file to work
>>is to put unlink(indexfile) before rename(cf->lockfile, indexfile).
>
>I don't know how Cygwin implemented rename(), but if they used
>MoveFile() they broke the POSIX rename() since MoveFile() fails if
>destination already exists.  They should have used
>MoveFileEx(MOVEFILE_REPLACE_EXISTING) instead, to guarantee POSIX
>semantics.  The symptoms you're experiencing make me think this might
>be the case (even if it is strange, since other Unix software would
>fail the same way).

Cygwin's rename is much more than just a simple wrapper around MoveFile
or MoveFileEx.  It tries hard to guarantee POSIX semantics within the
strictures imposed by Windows.
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
