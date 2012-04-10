From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Migrating SVN to Git, and preserve merge information
Date: Tue, 10 Apr 2012 23:57:38 +0100
Message-ID: <4F84BAE2.5090803@pileofstuff.org>
References: <4F844F33.5000004@nekoconeko.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Douma <n.douma@nekoconeko.nl>
X-From: git-owner@vger.kernel.org Wed Apr 11 00:57:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHk0T-00074e-CW
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 00:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600Ab2DJW5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 18:57:45 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:60196 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753125Ab2DJW5o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 18:57:44 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120410225741.HNBH21612.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Tue, 10 Apr 2012 23:57:41 +0100
Received: from [192.168.0.3] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120410225741.RKGV13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.3]>;
          Tue, 10 Apr 2012 23:57:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <4F844F33.5000004@nekoconeko.nl>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=5phNfFoJZtEA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=1zXWHiOROls77X4DgrIA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195136>

Hi Nick,

Would I be right in thinking that a commit like "Merged r100,r101,r102
from trunk" will create three grafts?  If so, that might be the problem.

Git differentiates between "merges" (which include every commit up to
and including the specified one) and "cherry-picks" (which just include
the specified commit), whereas SVN calls both of these "merges".  Grafts
are a way of creating "merges" rather than "cherry-picks" (which git
doesn't have any metadata for), and it's not at all easy to get "merge"
data out of SVN in the general case.  Having said that, it's often a
good enough heuristic to pick the highest revision number mentioned in
the commit message and pretend it's a merge.

Incidentally, I'm planning to work on this area of SVN->git conversion
in the coming months.  I don't have anything you could use yet, but I
don't suppose the scripts you used are available somewhere?  Getting
revision information out of log files is particularly tricky, and
everyone stumbles over a different set of issues.  I'd be really
interested to pick any nuggets of wisdom out of the approach you took.

	- Andrew
