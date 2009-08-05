From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 15:24:43 +0200
Message-ID: <200908051524.46502.trast@student.ethz.ch>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 15:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYgUN-0006wr-Lr
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 15:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934331AbZHENZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 09:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934322AbZHENZA
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 09:25:00 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:45431 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933912AbZHENY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 09:24:59 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 15:24:58 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 15:24:59 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124906>

Dan McGee wrote:
> 
> This is the first thing I have seen svn be able to do[1] that git
> can't. :)
> 
> [1] svn annotate http://path/to/repo/path/to/file@2345

The only thing broken is git-annotate's guessing code to see if you
use the 'git annotate <file> <revision>' (legacy) or 'git annotate
<revision> <file>' syntax.

I'd simply write the unambiguous

  git blame e19d7da4~1 -- "scripts/makepkg.in"

and similarly for other revisions.  And you'll immediately notice that
git *can* do this.

> OK, it did a move of a bunch of lines into functions that GIT couldn't
> quite track:

You can try

  git blame -C -C scripts/makepkg.sh.in

to let git try *really* hard to find out where the lines come from.
Note that it does find some lines from older commits, e.g.,

  2ef1c841 scripts/makepkg.in    (Dag Odenhall                2007-05-30 23:04:36 +0200  470)

in the body of download_sources, which was moved (but apparently not
changed) in e19d7da4 (Andrew Fyfe, 2007-06-01 22:10:27 +0100).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
