From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: [PATCH] Add custom memory allocator to MinGW and MacOS builds
Date: Sat, 4 Apr 2009 08:35:24 +0200
Message-ID: <200904040835.24377.j6t@kdbg.org>
References: <1238766761-3576-1-git-send-email-marius@trolltech.com> <a5b261830904031412o60b7eb4fv7e25a2ca4f89fe60@mail.gmail.com> <49D6ED32.4000706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, patthoyts@googlemail.com,
	marius@trolltech.com, git@vger.kernel.org
To: mstormo@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 04 08:37:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpzV1-0005Kp-JH
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 08:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbZDDGfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 02:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbZDDGfa
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 02:35:30 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:38097 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbZDDGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 02:35:30 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5E5822C4002;
	Sat,  4 Apr 2009 08:35:25 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CDC503FFB5;
	Sat,  4 Apr 2009 08:35:24 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49D6ED32.4000706@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115572>

On Samstag, 4. April 2009, Marius Storm-Olsen wrote:
> Pat Thoyts said the following on 03.04.2009 23:12:
> > The difference on Windows Vista is that the low fragmentation heap
> > is the default memory allocator. On Windows XP you need to enable
> > it specifically for an application. So a possible alternative to
> > this is just to enable the low fragmentation heap. (done via
> > GetProcessHeaps and HeapSetInformation Win32 API calls).
>
> I know about the low-fragmentation heap, but given that it was only
> supported on XP and up (and given that I also had MacOSX in mind when
> considering a custom allocator; see MacOSX got 12% itself ;-), I
> didn't even consider it.
> Thanks for clearing up the differences on the Vista and XP benchmarks
> though! Makes sense.

Wouldn't a GetProcessHeaps/HeapSetInformation solution add much less code, 
even with a runtime check whether the feature is supported?

The improvement that you observed is in a rather special area (repack). How is 
the improvment in day-to-day tools:

- procelains used on command line: git-status, git-add, git-commit, git-diff, 
git-log, perhaps even local git-fetch.

- plumbing used by guis: git-diff-files, git-diff-tree, git-log, git-rev-parse

- I'm not even mentioning git-am, git-rebase, because here the time sink is 
the fork emulation.

I doubt that the improvement is equally great, and it will perhaps vanish in 
the noise. 7000+ LOC is a bit much in this case, don't you think so?

BTW, I assume that the Boost license is compatible with GPL. But did you check 
that?

-- Hannes
