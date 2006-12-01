X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Fri, 1 Dec 2006 06:23:02 -0500
Message-ID: <20061201112302.GA1910@coredump.intra.peff.net>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org> <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de> <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net> <20061128131139.GA10874@coredump.intra.peff.net> <7v1wnnysrn.fsf@assigned-by-dhcp.cox.net> <20061201081117.GA20025@coredump.intra.peff.net> <7vlklranrt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 1 Dec 2006 11:56:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vlklranrt.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32904>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq70G-000785-2L for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030722AbWLAL4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936487AbWLAL4Y
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:56:24 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:15277
 "HELO peff.net") by vger.kernel.org with SMTP id S936486AbWLAL4Y (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:56:24 -0500
Received: (qmail 4121 invoked from network); 1 Dec 2006 06:23:02 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 1 Dec 2006 06:23:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Dec
 2006 06:23:02 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Dec 01, 2006 at 02:55:34AM -0800, Junio C Hamano wrote:

> [PATCH] git-blame: mark lines blamed on boundary commits.

Excellent. This is exactly what I had in mind, and it seems to produce
sensible results out of the box:

git-diff --raw -r --diff-filter=AM $1 | cut -f2 |
  while read f; do
    git-blame -l $1 -- $f | grep -v ^- | cut -d' ' -f1
  done |
  sort | uniq -c | sort -rn |
  while read count hash; do
    echo "$count `git-rev-list --max-count=1 --pretty=oneline $hash`"
  done

Thanks!

