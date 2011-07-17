From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Sun, 17 Jul 2011 09:24:51 -0400
Message-ID: <1310909091.21563.23.camel@drew-northup.unet.maine.edu>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu>
	 <4E200611.9010005@alum.mit.edu> <7vlivz1inu.fsf@alter.siamese.dyndns.org>
	 <20110715212059.GA2117@sigill.intra.peff.net>
	 <4E212113.6000906@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 17 15:28:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiROq-0001Qd-K0
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 15:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab1GQN01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 09:26:27 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:57284 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab1GQN00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 09:26:26 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p6HDOvlm024827
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Jul 2011 09:24:57 -0400
In-Reply-To: <4E212113.6000906@alum.mit.edu>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-x.dcc-servers-Metrics: beryl.its.maine.edu 104; Body=4 Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p6HDOvlm024827
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1311513922.35078@6E7WarPKsUJhw5axOWPRAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177299>


On Sat, 2011-07-16 at 07:26 +0200, Michael Haggerty wrote:

> Currently, the loose ref cache is stored as a single linked list, so
> there is no easy way to populate part of it now and part of it later.
> So with the current data structure, the loose refs cache is
> all-or-nothing.  It would be possible to avoid filling it if there are
> not replace references, but if there is even one loose replace reference
> then the whole refs tree would have to be crawled.  Implementing this
> variation is alternative 4 from the early email.
> 
> More flexible would be to change the way the loose ref cache is stored
> from a linked list into a tree (probably mirroring the directory tree).

Given the potential for high performance inherent with trees, why mix
metaphors like this? What would the gain be?

>  If this were done, then it would be possible to populate the cache
> lazily, only crawling the part of the refs tree that is needed for a
> particular call of for_each_ref() and reusing any part of the cache that
> is already in memory.  

Is this the argument for directory structure mirroring?

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
