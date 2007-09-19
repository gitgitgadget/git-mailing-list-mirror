From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/5] Yet another builtin-fetch round
Date: Wed, 19 Sep 2007 00:49:23 -0400
Message-ID: <20070919044923.GP3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 06:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXrVE-0006zk-To
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 06:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXISEt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 00:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXISEt2
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 00:49:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38734 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbXISEt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 00:49:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXrV4-0006wk-Ks; Wed, 19 Sep 2007 00:49:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B99320FBAE; Wed, 19 Sep 2007 00:49:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58674>

Another short series for db/fetch-pack, still in pu.  Aside from
optimizing the pipeline on the native transport (so we only invoke
the remote process we need once vs. twice) I'm actually now quite
comfortable with this whole series and think it is ready for next.

I'm certainly running it in production, and will be until it is
merged.  The performance difference is too big for me (and at least
some of my coworkers) to not be doing so.  If there are any specific
reasons why this topic is not ready for next or is unsuitable for
merging please let me know so I can take the time to correct it.

1/5  Rename remote.uri to remote.url within remote handling internals
2/5  Refactor struct transport_ops inlined into struct transport
3/5  Always obtain fetch-pack arguments from struct fetch_pack_args

  These three are basic code cleanups for small issues that
  bothered me about the original implementation of builtin-fetch.
  Now is just as good of a time as any to cleanup the code and make
  it more maintainable.  I think the overall total line count is
  reduced by these three patches.

* Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
* Fix memory leaks when disconnecting transport instances

  Fixes two known (but minor) outstanding bugs.  At this point
  I do not know of any other bugs in builtin-fetch so I would
  really appreciate testing reports from other people, especially
  those whose uses cases might stray outside of my workflow.  Hah,
  I did not tell you my workflow.  ;-)

-- 
Shawn.
