From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: combine git repo historically
Date: Fri, 09 Oct 2009 08:02:44 +0200
Message-ID: <4ACED204.3000907@viscovery.net>
References: <20091009012254.GA3980@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw8eZ-0006G9-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbZJIGD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754912AbZJIGD0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:03:26 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43746 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590AbZJIGDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:03:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Mw8Yu-0007gn-IT; Fri, 09 Oct 2009 08:02:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2B6A26D9; Fri,  9 Oct 2009 08:02:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091009012254.GA3980@debian.b2j>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129736>

bill lam schrieb:
> I have two git repos, no branches.
> 
> repo 1.
>   emptyrootcommit -- A ... M 
> 
> repo 2.
>   emptyrootcommit -- N ... Z
> 
> N was evolved from M but the time gap is large, how can I combine them
> into one repo
> 
> emptyrootcommit -- A ... M -- N ... Z
> 
> so that snapshots N .. Z will not be changed.

$ echo $(git rev-parse N) $(git rev-parse M) >> .git/info/grafts
$ git filter-branch --tag-name-filter cat -- --all --not M

i.e. you graft the older history right before the younger history, then
you use git filter-branch to rewrite the parentship of the younger commits.

-- Hannes
