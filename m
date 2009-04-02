From: Charles Bailey <charles@hashpling.org>
Subject: Re: git-{diff,merge} refactor round 2
Date: Thu, 2 Apr 2009 20:59:18 +0100
Message-ID: <20090402195918.GA13817@hashpling.org>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:01:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpT6E-0005We-1u
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756492AbZDBT7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 15:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbZDBT7W
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 15:59:22 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:8688 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753718AbZDBT7W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 15:59:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAKi11EnUnw6S/2dsb2JhbADPb4N8Bg
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.ptn-ipout02.plus.net with ESMTP; 02 Apr 2009 20:59:19 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1LpT4J-0003Ze-H5; Thu, 02 Apr 2009 20:59:19 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n32JxJE6014451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Apr 2009 20:59:19 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n32JxIiR014450;
	Thu, 2 Apr 2009 20:59:18 +0100
Content-Disposition: inline
In-Reply-To: <1238590514-41893-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 885f0ec2c04bd47c84352676160ff7b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115490>

On Wed, Apr 01, 2009 at 05:55:04AM -0700, David Aguilar wrote:
> Here's the 2nd round of refactoring.
 
Again, I reply in summary form...

[02/10] - I ack this.

[03-07 / 10] - fine. I'm not sure, but should they be one commit?
They're really about consolidating blocks from one place to another
and the change might be more 'obvious' as a single commit.

[08/10] Now that we've isolated the run_mergetool, can we get it to
return the value of '$status' (either the result of the tool or of
check_unchanged) as its exit code so that we know whether the merge
succeeded?

[10/10] Then this chunk:

+    run_mergetool "$merge_tool" "$present"
+    status=$?
     if test "$status" -ne 0; then

can validly become:

     if ! run_mergtool "$merge_tool" "$present"; then

which seems clearer to me.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
