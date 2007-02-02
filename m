From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Fri, 2 Feb 2007 13:02:07 +0000
Message-ID: <200702021302.10567.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home> <Pine.LNX.4.63.0702021140340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Lars Hjemli" <hjemli@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 14:02:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCy3b-0005L7-98
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 14:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423026AbXBBNCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 08:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423031AbXBBNCU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 08:02:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423026AbXBBNCT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 08:02:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so752086uga
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 05:02:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=A3vaO6C8A1Ad3/DrLGo8yyL8BMSbIw8jRma4e6O7ZaV+vWnzH/k+b//g5qOkQpJja89zoU/BMdjI6V29ZFOp/r2hNmbMxDmMxK+FUylZP1wrXCOQ1e+0/vlHdWiPumIMthEXDDTg+2+d8iXaE/ekzXAH1zc3Q6b+53RDIiGJ/LI=
Received: by 10.67.121.15 with SMTP id y15mr4372653ugm.1170421337320;
        Fri, 02 Feb 2007 05:02:17 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 53sm5281524ugn.2007.02.02.05.02.14;
        Fri, 02 Feb 2007 05:02:14 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <8c5c35580702020302g46f71fe3o24d7dc9490192cab@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38494>

On Friday 2007 February 02 11:02, Lars Hjemli wrote:

>   "HEAD@{yesterday}" = current branch, yesterday
>   "@{yesterday}"     = detached head (no branch), yesterday

I'd vote for this too.  It's the only logically consistent view.

HEAD is a symbolic reference, it's a way of referring to a real branch by 
another name.  HEAD@{} should be the same as branch@{} to be consistent.

Forgetting about detached heads for the moment, imagine that yesterday I did 
lots of bouncing around on branches, around 1300 (although I wouldn't 
remember the exact time).  Oh look, it's about 1300 now.  What then is
HEAD@{yesterday} going to tell me?  What will it tell me one minute from now?  
It would be the most confusing operation in the world; I'd have to remember 
which branch I had checked out and what time I checked it out.

I really don't want to be able to answer the question what branch did I have 
checked out 15 minutes ago.  I do want to ask where was my current branch 15 
minutes ago.

Then of course, it's perfectly reasonable to treat the detached HEAD as 
meaning that the symref HEAD was pointing at a kind of virtual branch - this 
is a branch that isn't in the refs directory but is reflogged.  Other than 
that it's no different from any other branch.

Any notation would do I think, @{} is as good as any other.  In fact, if we 
used the name "unnamed branch" instead of "detached head", the notation @{} 
is perfect.  (Actually I think unnamed branch is a much better term than 
detached HEAD, because HEAD is never detached - it must point at something)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
