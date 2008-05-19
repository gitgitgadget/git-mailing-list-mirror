From: Seth Falcon <seth@userprimary.net>
Subject: Re: git and peer review
Date: Mon, 19 May 2008 07:10:36 -0700
Message-ID: <20080519141036.GV396@ziti.local>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com> <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com> <20080517213039.GR396@ziti.local> <20080519033736.GZ29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Toby Allsopp <Toby.Allsopp@navman.co.nz>,
	Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 19 16:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy67H-0007BX-Tt
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 16:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512AbYESOMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 10:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbYESOMl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 10:12:41 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:57328 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660AbYESOMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 10:12:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1354728wfd.4
        for <git@vger.kernel.org>; Mon, 19 May 2008 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=NlNTaMzTbju60Zc8P2ifbna9jNFzWDI24QJ1fClkgNA=;
        b=HyRPTuu/+1aoFBkTR7UtxvhSsiZj6GB6Pr0syZB1MmAgiQOxmGdo6iv4dzqvRMPFoaVFz+V+aedHrias+QoszfI3J6/iD3ac9GWhC8+Vt8Xf1VVxFNfczrFlfoNwMWqqZ6/wKdxU892TG/Do5HoaK0LEXzft/R4S80LS1iFtHeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tvwU60FZ0eMrmLsLQrMf62JbWO1eyEVWrNzYSqu1r3Zw244mDyOJ9EHUXJ7qVdSYz4KDOBjQSBMe7aLt4PAQrfymHNYXOvAWu2jGfbYPMf55z6BQJNduTyIzKe5YY7vtCMgOSHhlVtx4zNm1/oFUuJjlpE0+QDgibzFZLXcnnsA=
Received: by 10.142.89.13 with SMTP id m13mr2849361wfb.338.1211206359466;
        Mon, 19 May 2008 07:12:39 -0700 (PDT)
Received: from localhost ( [71.197.245.84])
        by mx.google.com with ESMTPS id 20sm8831399wfi.11.2008.05.19.07.12.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 May 2008 07:12:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080519033736.GZ29038@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82430>

* On 2008-05-18 at 23:37 -0400 Shawn O. Pearce wrote:
> Something like this, but its uh, ugly due to the use of a network
> connection:
> 
> 	branch=$(git symbolic-ref HEAD)
> 	branch=${branch##refs/heads/}
> 
> 	remote=$(git config branch.$branch.remote)
> 	merge=$(git config branch.$branch.merge)
> 
> 	rb=$(git ls-remote $remote $merge | awk '{print $1}')

Hrm.  My use case is with an upstream svn repository and git-svn.
With my .git/config, remote and merge as above are empty (I guess that
is what one would use with a pure git setup).

For the git-svn case, I think what is needed is the ability to ask
git-svn about the local upstream tracking branch associated with HEAD.
Since this is information already available to git-svn rebase, I tried
adding a --dry-run option that prints out what I want.  In the patch
that follows I'm not sure if I've chosen the right terminology...

-- 
Seth Falcon | http://userprimary.net/user/
