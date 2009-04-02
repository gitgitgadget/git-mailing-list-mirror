From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 10/10] mergetool: use run_mergetool from
	git-mergetool-lib
Date: Thu, 2 Apr 2009 21:02:35 +0100
Message-ID: <20090402200235.GB13817@hashpling.org>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <1238590514-41893-10-git-send-email-davvid@gmail.com> <1238590514-41893-11-git-send-email-davvid@gmail.com> <200904020054.23147.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:04:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpT92-0006Ha-RR
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761276AbZDBUCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760975AbZDBUCk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:02:40 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:60599 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755772AbZDBUCj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 16:02:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFu21EnUnw6R/2dsb2JhbADPdYN8Bg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.pcl-ipout02.plus.net with ESMTP; 02 Apr 2009 21:02:36 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1LpT7U-00058W-1G; Thu, 02 Apr 2009 21:02:36 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n32K2Z5i014516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Apr 2009 21:02:35 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n32K2Zgc014515;
	Thu, 2 Apr 2009 21:02:35 +0100
Content-Disposition: inline
In-Reply-To: <200904020054.23147.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 27c6b773151c5855a410e31435ae7a51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115491>

On Thu, Apr 02, 2009 at 12:54:22AM +0200, Markus Heidelberg wrote:
> David Aguilar, 01.04.2009:
> > +    present=false
> > +    base_present &&
> > +    present=true
> > +
> > +    run_mergetool "$merge_tool" "$present"
> > +    status=$?
> 
> This last line has to be deleted, because the variable 'status' set in
> run_mergetool would be overwritten then. In this case the merge will
> succeed even if it didn't and the file will be staged.

I think that it would be better if $status stayed as local as
possible. If run_mergetool returned the value of $status as its exit
code then the function will properly return whether the merge
succeeded or not.

This way run_mergetool's clients can just use its exit code, without
having to know about a magic $status global variable.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
