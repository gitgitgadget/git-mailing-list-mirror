From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: updating only changed files source directory?
Date: Tue, 24 Oct 2006 12:13:38 +0200
Message-ID: <200610241213.38558.jnareb@gmail.com>
References: <ehjqgf$ggb$1@sea.gmane.org> <ehkgfs$af6$1@sea.gmane.org> <453DE1F5.5010803@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 12:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcJHa-0002Eu-7o
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 12:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWJXKNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 06:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWJXKNP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 06:13:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63465 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965127AbWJXKNO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 06:13:14 -0400
Received: by ug-out-1314.google.com with SMTP id 32so158270ugm
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 03:13:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=naytn/JoaZ1fKtfOoBtU/9pfYaJE2XUW2Tf/iL7m8zCNfX55DsBce4lCx2d0xGoQWi/OqYWITi/nqL0nlWc+VllW/kfiLB9FD1pUNjgDf7aB5+tDmhFVhgrw8Xj1zyb3lN8+CHbE7q37HfSFZl0l7ZRMLU7VbxxB9Vn6MvK5D/8=
Received: by 10.67.119.13 with SMTP id w13mr8567730ugm;
        Tue, 24 Oct 2006 03:13:13 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id c1sm369041ugf.2006.10.24.03.13.12;
        Tue, 24 Oct 2006 03:13:13 -0700 (PDT)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
User-Agent: KMail/1.9.3
In-Reply-To: <453DE1F5.5010803@xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29960>

Han-Wen Nienhuys wrote:
> Jakub Narebski escreveu:
>> Han-Wen Nienhuys wrote:
>> 
>> I see that you are using fairly low level commands (plumbing commands)
>>  
>>>    git-http-fetch -a <branch>  <url>
>>>    wget <url>/refs/head/<branch>    ## dump to <myrepo>/refs/head/<branch>
>> 
>> instead of setting $GIT_DIR/remotes/origin file and using "git fetch".
>> BTW. "git fetch" will not update branch you are on, unless --update-head-ok
>> option is used.
> 
> I tried fetch, but was put off by the warnings because I didn't have 
> --update-head-ok. Using lowlevel commands is my way of making sure that 
> Git doesn't assume it needs to do anything intelligent.

You can either have additional branch which is not tracking branch
(you don't fetch into this branch), and on which you are always on,
called for example 'check-out' (and which can be used for git-reset
solution to checking out files to external directory), and use
git-fetch without --update-head-ok, or (if the repository is bare
repository, without working area) use --update-head-ok.
 
>>>    git --git-dir <myrepo> read-tree <committish>
>>>
>>>    cd <srcdir>
>>>    git --git-dir <myrepo> checkout-index -a -f
>> 
>> instead of 
>>      git --git-dir=<myrepo> checkout <branch>
>> (-f is Force a re-read of everything)

git-checkout-index(1):

       -f|--force
              forces overwrite of existing files

So probably you would get what you want if you lose '-f'.

> Yes, however,
> 
>    git checkout
> 
> changes the state of the repository, which is something I want to prevent.

Well, git-reset also changes state of repository, but it changes only
the branch we have created exactly for this purpose.
-- 
Jakub Narebski
Poland
