From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: Git and git-svn question.
Date: Fri, 28 Mar 2008 12:27:59 +0100
Message-ID: <ae63f8b50803280427m55f6b957r12745c8e4178588b@mail.gmail.com>
References: <47ECA3DC.8010901@sezampro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: ivanisev@sezampro.com
X-From: git-owner@vger.kernel.org Fri Mar 28 12:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfClX-0000kM-PX
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 12:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbYC1L2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 07:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYC1L2R
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 07:28:17 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:25058 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbYC1L2P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 07:28:15 -0400
Received: by mu-out-0910.google.com with SMTP id i10so342695mue.5
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=+Ji1pUDLGOrlKOtuzez0xrq7Z9Defdd884dCpyA4Dxk=;
        b=coQbrPVfO8RZowLCEJiOYTHZJ+Yy3n3+2xLyFVhI5KhwPJfkfAcCejqDw0+ZM33DO9Yg1nXkIgR1aa5lD5tgh7GX9J+h4p1QhIin3Rr4N8oyX/ITVDlROVx+ps8ybLIeIcdZY4JeXbpJGcblfNykzTzl+/WmvCzKG2UqgXjclXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kX8ZHbBHXeKEt9uPviC9kNDrWViyK60dkmjqEvObWaOCCZrTjBcAwKQRjvvH6Q8B7qwblAnLbHcNDKkJFx9Sy7/lgwhidCPdHRN+VY2ZNSIr1ibvY87XZSAb4FeXHeizWaKqQUT4pvG802KUUSCPzotO2CqZWMtPnFM7+miooP4=
Received: by 10.78.186.9 with SMTP id j9mr9572574huf.3.1206703679455;
        Fri, 28 Mar 2008 04:27:59 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Fri, 28 Mar 2008 04:27:59 -0700 (PDT)
In-Reply-To: <47ECA3DC.8010901@sezampro.com>
Content-Disposition: inline
X-Google-Sender-Auth: b2f3d7d6e1768c90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78395>

Hi Bosko,

2008/3/28, Bosko Ivanisevic <ivanisev@sezampro.com>:
> My company uses SVN and I have to work on the code from two offices.
>  Since SVN is far away from git in branching I've decided to set up git
>  repository as a mirror of company's SVN repo, which I would use as
>  intermediate repository for my code:
>
>  git svn clone -t tags -b branches -T trunk
>  svn+ssh://company_server/path_to_svn_repo --prefix=company/

-t tags -b branches -T trunk == -s

>  Since I just started to use git I wonder if anyone can give me any hint
>  what is the best way to accomplish following tasks with git:
>
>  - In office 1 and office 2 I clone git repository that is a mirror of SVN:
>    git clone ssh://company_server/path_to_git_repo

You can't do that as SVN information is not cloned.  You have to call
git-svn clone on every working copy.

>  - I start new feature in office 1 based on the trunk version of SVN:
>    git checkout -b new-feature company/trunk
>
>  - Work on this feature is not finished and, after few commits to the
>  local 'new-feature' branch, I have to move to office 2.
>
>  - From office 1 I push local branch 'new-feature' to the git repository
>  on company server.
>
>  - In office 2 pull changes and continue to work on 'new-feature' branch
>  created from office 1.
>
>  - Commit everything in the git repository on company's server.


Yes you'll need also a central Git repository to work with plain Git
branches between the offices.

>  - Finally commit everything to the SVN repository.

I suggest to use cherry-pick to propagate the changes from the feature
branch to the SVN-aware branch.

All the best,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/
