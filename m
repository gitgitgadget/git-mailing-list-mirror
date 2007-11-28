From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 19:11:07 +0100
Message-ID: <200711281911.07522.jnareb@gmail.com>
References: <993937.9873.qm@web55013.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:12:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxROR-0001LQ-UZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbXK1SLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbXK1SLN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:11:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:42861 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbXK1SLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 13:11:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1493465nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 10:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=FV4PRdJq5UnvV3Z9ps0K+YdhGTr08xTWoMpp5uJeIR4=;
        b=XW7eKXBie1w0mQ5O+BBWe34aWWHXZP5vzA+1DPTiTfD+E7FG6u/42xlr33dfsSAYJJmfzmoERdQkh6TOZWHEv8c2M164QC56S/5pqwDQ98MV3diIIBwnenej9m0dMaEqxqh6I05viuyVO5TbBYKYSkZ4ffJlNnax5DpRhI/tthI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sGvEVuaPhdH6k0wH3Q7cJCxmy3w9StqWHNYNdBbzsImq30uUBpaB+08o1L2crm/Lvkf5lkTk/Sp37peZZJpGIiTRqakVCMHx2I1pBQzSIE5MGtFYrsqBNDde3CdIctvfjHaJ4pEs1Fmz3nqAR1h/LKGvR1S387eqJARwO+Z8uMs=
Received: by 10.86.95.20 with SMTP id s20mr5227173fgb.1196273470031;
        Wed, 28 Nov 2007 10:11:10 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.156])
        by mx.google.com with ESMTPS id e20sm5648264fga.2007.11.28.10.11.07
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 10:11:08 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <993937.9873.qm@web55013.mail.re4.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66394>

Bill Priest wrote:

> I understand what git is doing in terms of trying to
> merge.  But it sounds like it is enforcing policy on
> the merge by not allowing me to check in files as I
> resolve them.  I have two separate branches w/ a
> similar but not identical hardware platform where I
> will always get conflicts when I merge back and forth.
>  Usually I cherry-pick between the two branches and
> this works until there are massive changes on one
> branch w/o time to move the changes to the other.  In
> the latter case I do a merge and live w/ resolving
> conflicts.I guess w/ this workflow I have more
> conflicts than is "normal".  
> 
> It seems pretty heavy handed to force all merges to be
> complete before I can commit any files; git knows
> which files are unmerged.  Does git track which files
> have been merged w/ conflicts?  I'd like the option to
> be able to check in files that I have indicated have
> conflicts resolved (maybe w/ a flag to bypass the
> checking).

Yes, git does track which files have conflict, but I don't
think it does track which files were merged on file-level
without conflicts.

The problem is that git remember which files are yet not
resolved, and remembers that it is in the middle of the
merge by remembering parents of a merge. So I think if you
want to commit before doing merge, you would have to move
MERGE_HEAD away, and commit specifying paths using
"git commit <file1> <file2>". Or you can always resort
to low-level plumbing, for example creating temporary
staging area (index) etc.

But if you want to just make some commit to be cherry-picked
for example before merge, I think it would be easier to just
stash away merge, do a commit, then unstash it.

-- 
Jakub Narebski
Poland
