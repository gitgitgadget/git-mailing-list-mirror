From: David Copeland <davetron5000@gmail.com>
Subject: Re: How does git store branchpoints?
Date: Mon, 9 Jun 2008 17:15:33 -0400
Message-ID: <1A180CD1-50C7-4CB5-A339-7C6725FEE8D4@gmail.com>
References: <beffea8c-fd2a-44d0-a566-3ded5d09a3d2@l42g2000hsc.googlegroups.com> <m3hcc2wso1.fsf@localhost.localdomain> <fd42f577-60ba-4d26-85a3-7ca4ea8295db@a1g2000hsb.googlegroups.com> <m38wxewcno.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 23:16:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5ojC-0000r2-97
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 23:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928AbYFIVPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 17:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbYFIVPi
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 17:15:38 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:33058 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759765AbYFIVPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 17:15:37 -0400
Received: by rv-out-0506.google.com with SMTP id k40so524437rvb.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=BynBB3Znj3eIpEG8jVMtTptokORiTixku6kEgMeVB7M=;
        b=gAlFqrHovEn7NTTbQip9w0P9crBlAiVnw/jNC9xbDj1ybIEB0OhFJdiDKQYmdUkdKE
         WiB4Ihi4QGsqRpFgfSyJRIeso9h4WE+YP4ZUW4vz+XhnKWo3BbjzMMaGHWOaglcCXCEs
         ZIWeoNCDNmDjh1dMBq/egDuQymTvUI/Serf1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=F6i0E5hRVIFRb5vfj0DSvp86AF8esbpplCWFk9AkOU4piKwBGEAbcxA4gS6fRfSNqj
         FUmPrepnznD/kPb6d048Q//+6BTkney37Lly9UoKcWIWOjw7RjTx6aJPHHqjV5DorOOq
         6mpUOMLx/5i6p6/8RnR0xuIry/rEwDtYpUIEU=
Received: by 10.114.159.5 with SMTP id h5mr4018292wae.222.1213046136558;
        Mon, 09 Jun 2008 14:15:36 -0700 (PDT)
Received: from ?10.0.1.2? ( [98.218.223.189])
        by mx.google.com with ESMTPS id 9sm9941158yxs.5.2008.06.09.14.15.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 14:15:35 -0700 (PDT)
In-Reply-To: <m38wxewcno.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84430>

OK, I think this captures it (branches replaced with real names so the  
images below make sense)


1---2---3---4---5---6---7---8---9  <- trunk
      \           \
       \           \-a---c---c---d  <- GLIFFY_ONLINE_REST_API (where  
I'm working)
        \
         \-I                        <- GLIFFY_ONLINE_SSO, no commits,  
just a branch in SVN

[ I is branched off of 2 and a is branched off of 5 ]

Changes at 3 and 4 show up as conflicts when I merge  
GLIFFY_ONLINE_REST_API and trunk

The situation you describe could be it.  It's hard to tell from gitk  
just what is going on.

In gitk, when I find the commit in SVN that created  
GLIFFY_ONLINE_REST_API, I see this:

http://www.naildrivin5.com/images/git_top.jpg  (The commit message i  
"Rest API Branch" and "GLIFFY_WEBSITE_MAR" is NOT the name in SVN)

When I find where that yellow arrow goes, I see this:

http://www.naildrivin5.com/images/git_bottom.jpg

I will look into the graft solution....

Dave

On Jun 9, 2008, at 4:53 PM, Jakub Narebski wrote:

> davetron5000 <davetron5000@gmail.com> writes:
>
>>>
>>> You can ask git to find branch point using "git merge-base trunk  
>>> FOO",
>>> which should return 'c' (actually, sha-1 of this commit).
>>
>> OK, this revealed interesting results.  The commit it gave me was a
>> commit right before ANOTHER SVN branch that I was originally to work
>> on, but never did.  The files git-merge showed conflicts for were
>> files modified since THAT branch (call it BAR) was created and before
>> my branch (FOO) was created.
>
> Could you write some ascii-art diagram showing the situation? It is
> hard to grasp the situation fully only from above description.
>
>> So, any ideas why git thinks that my two branches are rooted at BAR
>> and not FOO?  git-svn dcommit on local-FOO commits to FOO and not  
>> BAR.
>
> Note that the situation described below might be not related to your
> problem; please view history carefully using some (graphical) history
> browser like gitk.
>
> It could happen that commits which should be identical aren't,
> e.g. because of different timestamp, or different author, or lack of
> svn-id: line, or something like that.  This isn't helped by the fact
> that Subversion doesn't store information about merges; and even if it
> does (SVK or svnmerge extensions) I'm not sure if git-svn can use it.
>
> So the situation might be like following:
>
>   1---2---3---4---A---B---C   <-- branch 1
>
>   1'--2'--3'--4'--a---b---c   <-- branch 2
>
> while you want it to be
>
>   1---2---3---4---A---B---C   <-- branch 1
>                \
>                 \-a---b---c   <-- branch 2
>
> Usually working with grafts, examining result in gitk, then commiting
> grafts using git-filter-branch is the solution for such history
> rewriting.
>
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
