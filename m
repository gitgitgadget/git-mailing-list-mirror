From: Stephen Bash <bash@genarts.com>
Subject: Re: Speeding up the initial git-svn fetch
Date: Wed, 13 Oct 2010 12:02:06 -0400 (EDT)
Message-ID: <4305143.485826.1286985726762.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTinOQd4xo6VsDXQxShhrRFM28cJfKHjnVPpRuY-q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Stump <mstump@goatyak.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 18:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P63mW-0000gJ-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 18:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611Ab0JMQCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 12:02:14 -0400
Received: from hq.genarts.com ([173.9.65.1]:14555 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751448Ab0JMQCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 12:02:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 0617F1E2692D;
	Wed, 13 Oct 2010 12:02:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oGYh4lm8yIAN; Wed, 13 Oct 2010 12:02:06 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id D3E701E26931;
	Wed, 13 Oct 2010 12:02:06 -0400 (EDT)
In-Reply-To: <AANLkTinOQd4xo6VsDXQxShhrRFM28cJfKHjnVPpRuY-q@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158941>

> What have other people done in similar circumstances?

Based on suggestions from this list, I sidestepped git-svn and used svn-fe [1] and git-fast-import.  It imports the entire Subversion tree in a single git branch, but using git's tools that's workable.  At an extremely high level I used git-filter-branch to split up into branches and git grafts to stitch the various branches together to represent the SVN history.

The real devil is in extrating the SVN history, but there are a few gotchas in the filtering/recombining.  I haven't written up a complete summary for the list because I thought the GSoC project would supersede my process rather quickly...  If there's interest I can transpose my internal documentation for public use.

As a benchmark, our SVN repository was about 20k commits, ~400 tags, ~100 branches, HEAD contained ~7k files.  git-svn took several weeks (and never finished), svn-fe and git-fast-import took ~20 minutes (my entire process takes about 4 hours).

[1] http://github.com/barrbrain/svn-dump-fast-export

HTH,
Stephen
