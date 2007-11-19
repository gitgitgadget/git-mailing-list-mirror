From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 22:04:25 +0100
Message-ID: <200711192204.26772.jnareb@gmail.com>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <fhrrbt$lvk$1@ger.gmane.org> <7vy7cum2k1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuDnf-0003Il-CH
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 22:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXKSVEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXKSVEm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 16:04:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:22490 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbXKSVEl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 16:04:41 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1540780nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=+VGjm+bvnXDfO5h/99LEqEzyhPAa0BcHOAHkJRzkw1k=;
        b=HMnuNWjbJSIufiuFE9s0Mw4BS0/4ijVZ9vlGDyN4WSUAU16YjO4HyLppfmLeccRa2JsimsrEk2Gag7e7pUXKQDVtCV6ZD8RmvkvO99rw8iwky4g9IShefmF+YOanRREvMrjykZfe7YCc3ikXfpdmQkzJ08CxWeLkZscLKFy8zvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g4FtQXvPqv7rO9CgiGMYgdzdk9fFryQeiU+fIsVpCbttDtwB5U+tStvN0FiXmIsTCHBfVv8VFuy3/yT78lEvwaW476v50Qbm3NH880GOFc9A9qdajhhfGEd7v/TKv3Pddr3Nbl5ml7+fkiKTrebInxf2EAvN8MOUlvzIJLPZ6ss=
Received: by 10.86.84.5 with SMTP id h5mr5438004fgb.1195506277534;
        Mon, 19 Nov 2007 13:04:37 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.246])
        by mx.google.com with ESMTPS id d4sm3694602fga.2007.11.19.13.04.32
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 13:04:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy7cum2k1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65500>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Brief recap, to check if I understand things correctly:
>>
>> 1. If you use "matching" more often, then it should be enough
>>    to provide remote.<remotename>.push with refspec or wildcard
>>    refspec. 
> 
> Eh, excuse me, what refspec would you write there?  "matching"
> is defined to push the intersection of what we have and what
> they have when "git-push" is run.  I do not think there is any
> way to write that in remote.$there.push and cast in stone.
[...]
>>    Question: what to do if there is no remote.<remotename>.push?
>>    Assume 1-1 matching?
> 
> One-to-one is what 'matching' does, and the way to trigger it is
> not to have a remote.$there.push.

I'm sorry, I had to have "stupid" moment. Thanks a lot for complete 
explanation of git-push, anyway.


>>    ... If one wants to push only current branch, one
>>    would use "git push --current" or "git push <remotename> HEAD".
> 
> I think that is the proposal by Steffen (added back CC).
> 
> I am wondering if an alternative approach could be simpler.  If
> we teach "git-push" to notice when only the refspecs are given
> without remotename, and default to branch.$current.remote in
> such a case, 

Including default remote when branch.<branchname>.remote is not set?

> IOW, make these: 
> 
> 	$ git push HEAD
>       $ git push next
> 
> push the obvious thing to the default remote, I _think_ we can
> achieve the same effect as --current and a bit more.

The only problem would be when there is conflict between remote name and 
branch name (for example default "origin" remote, and old git 
no-separate-remotes "origin" branch, or origin = origin/HEAD).
Perhaps we can reuse '--' as separator between remote(s) and refspecs 
(branch names); other command use it to separate refname / commit-ish 
from pathspec (file name).

So for scripts it would be "git push -- HEAD"; still shorter than
"git push --current".


BTW. what would happen for "git push branch1 branch2" if branch1 has 
different remote than branch2?

> The latter could be run after I made the 'next' integration
> branch into a good shape, switched to 'pu' to merge up other
> bits but before finishing that merging yet (it would not help me
> personally as I do not work that way --- I push things out only
> after I am done with all the public branches --- but it may help
> the others). 

-- 
Jakub Narebski
Poland
