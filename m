From: Andreas Ericsson <exon@op5.com>
Subject: Re: problem with cherry picking
Date: Tue, 21 Apr 2009 00:20:41 +0200
Message-ID: <49ECF539.3030701@op5.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0021@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:23:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw1te-0003CY-Ny
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 00:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbZDTWUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 18:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758005AbZDTWUq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:20:46 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:41766 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbZDTWUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 18:20:45 -0400
Received: by ewy24 with SMTP id 24so1342107ewy.37
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 15:20:43 -0700 (PDT)
Received: by 10.210.87.14 with SMTP id k14mr4231046ebb.60.1240266043303;
        Mon, 20 Apr 2009 15:20:43 -0700 (PDT)
Received: from ?192.168.25.19? (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 24sm2706838eyx.3.2009.04.20.15.20.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 15:20:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70ACE0021@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117042>

John Dlugosz wrote:
> Someone at work here jumped the gun and committed something before
> fetching an amended branch.  Typical stuff -- now his work and the
> repo's work diverged.  His change was purely new files, no big deal.  In
> gitk, reset his dev to origin/remote/dev, then cherry-pick his new
> commit.
> 
> But it barfed all over the place.  One problem was read-only files.  But
> even after purging those, it had the same complaint, something about
> untracked file would be modified.  What's the deal here?
> 
> I talked him through accomplishing it another way -- reset hard back to
> his new commit, reset mixed to the proper ancestor, and re-doing the
> commit.
> 
> But I want to understand what the issue is here.
> 

When he first reset back to the pre-modified state, the newly created
files were not removed from the working directory (this happens on soft
or mixed resets, fe, or when a branch is moved).

The files were untracked by git as seen from the commit he reset to, and
so git rightly refuses to apply another patch that introduces them, as
that would mean overwriting files git knew nothing about (again, at the
time of the commit he reset back to).

/Andreas
