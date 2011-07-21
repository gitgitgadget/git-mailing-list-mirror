From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: git fetch --all --depth
Date: Thu, 21 Jul 2011 22:04:55 +0200
Message-ID: <20110721200455.GC11520@camk.edu.pl>
References: <20110720223902.GA6675@camk.edu.pl>
 <7v1uxj4ml4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Alex Neronskiy <zakmagnus@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 22:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjzUb-0002iH-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 22:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180Ab1GUUFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 16:05:04 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:40097 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753118Ab1GUUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 16:05:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id D428C5F0049;
	Thu, 21 Jul 2011 22:05:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qhRJAsnv27-3; Thu, 21 Jul 2011 22:04:56 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id DF3525F0047;
	Thu, 21 Jul 2011 22:04:55 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id CF648809A9; Thu, 21 Jul 2011 22:04:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1uxj4ml4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177617>

On Thu, Jul 21, 2011 at 09:36:55AM -0700, Junio C Hamano wrote:
> Kacper Kornet <kornet@camk.edu.pl> writes:

> > I have just discovered that when I use:

> > git fetch --all --depth=<n> 

> > the history is not deepened. Is the any specific reason for it or is it
> > a bug?

> The above is not specific enough to judge if you found a bug or if it is a
> user error.

To be more specific, the steps to reproduce:

$ git clone --depth=1 git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git fetch --depth 2 --all

and the last command does nothing, while

$ git fetch --depth 2 

deepens the clone by 2 repos, as expected.

> IIRC, --depth=<n> is not "deepen by <n>", but "make sure I have at least
> <n> from the updated tip(s)".  The shallow-clone hack gives you quite
> useless (even though it may be internally consistent) semantics if you
> shallow-cloned way in the past and fetched with --depth after the other
> side added many more commits than <n>, as you cannot guess what the right
> value of <n> should be without actually fetching without --depth.

That is true. Also, from esthetic point of view, sometimes I miss the
functionality to deepen the full repository. For example git fetch
--depth 0 could do it. Now I have to do git fetch --depth
<very_large_number>

-- 
  Kacper Kornet
