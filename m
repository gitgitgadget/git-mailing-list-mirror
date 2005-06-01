From: Junio C Hamano <junkio@cox.net>
Subject: Re: I want to release a "git-1.0"
Date: Wed, 01 Jun 2005 16:03:58 -0700
Message-ID: <7vfyw1isrl.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
	<972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
	<Pine.LNX.4.58.0505301801520.1876@ppc970.osdl.org>
	<7vu0kiu8pm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505311923240.19864@qynat.qvtvafvgr.pbz>
	<7vhdgismo0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0506011304001.21267@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 01:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdcDO-0005eT-8P
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 01:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVFAXEU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 19:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFAXEU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 19:04:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31221 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261445AbVFAXEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 19:04:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601230359.UCIY26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 19:03:59 -0400
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0506011304001.21267@qynat.qvtvafvgr.pbz> (David
 Lang's message of "Wed, 1 Jun 2005 13:06:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DL" == David Lang <david.lang@digitalinsight.com> writes:

>> Internally, git-diff-cache -B -C is used which does use the
>> deltify to locate complete rewrites, renames and copies (that's
>> why the script is so slow).  For passing on and assigning blames
>> line by line, parsing "diff --unified=0" output was a lot easier
>> for this script and that was what I did in this quick-and-dirty
>> version.

DL> I was under the impressin that the deltafy stuff was significantly
DL> faster then you are suggeting that it is here

I perhaps phrased it poorly.

The slow part is not a single delta operation, but having to run
many delta operations between all combinations of rename/copy
candidates, which is O(n * m) where n is the number of newly
created files (counting "broken" ones created by -B flag) and m
is the number of (deleted, modified and unmodified) files in the
original tree.


