From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Fri, 22 Oct 2010 00:49:32 +0200
Message-ID: <201010220049.33344.jnareb@gmail.com>
References: <20420115.537598.1287696462845.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:49:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93xF-0003EO-J8
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0JUWto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 18:49:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60142 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0JUWtn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:49:43 -0400
Received: by bwz11 with SMTP id 11so62526bwz.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 15:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lWu7HHWaJQ4eSfR8kAaoFoagYGsXb1XTbfxtVm6OiV8=;
        b=Qk5QB9QDFLubBgv+yM0pabUMhKDs2ou2P7w5hORLPCKcSV3i6Eq6FOGGm0PhqgIAnk
         zS7IcinYfGINGnL0gUu5+rw9MkjkCnP8E1mK4F0tJIGFS8rAVAeHRNDCQ7/c5wVT2la2
         PTGAS/MHJzOF6VI0Ly8U/hRQUkeBBhUvbciOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=iFb6bqc+VWfLlZD5uEYi6AlGwpPz0VxEG2IbfysVwkv6jzVBioObXoSVkAJhoGPxnU
         QFrCb5T06B0jiXav0uujhyplAVoxSgV4WFCWrsRG3+Bhyw/kN5CZXAAselLMFcnZNFeK
         hiZ5BFzBFQ54sTUcxnpm0T1pGnl81Z4+7TqKA=
Received: by 10.204.115.133 with SMTP id i5mr381543bkq.27.1287701379724;
        Thu, 21 Oct 2010 15:49:39 -0700 (PDT)
Received: from [192.168.1.13] (abvl250.neoplus.adsl.tpnet.pl [83.8.209.250])
        by mx.google.com with ESMTPS id u4sm1602563bkz.5.2010.10.21.15.49.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 15:49:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20420115.537598.1287696462845.JavaMail.root@mail.hq.genarts.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159583>

On Thu, 21 Oct 2010, Stephen Bash wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:


> > But because Subversion doesn't impose strict separation between branch
> > namespace and in-repository paths, somebody somewhere would certainly
> > at some time screw this up. And only then we would have to rely on
> > subtree merge / git-subtree split similarity detection.
> 
> I don't have much experience with subtree merge...  It's possible
> that will improve the situation. 

I mean here the method used by "subtree" merge strategy, not by subtree
merge itself, i.e. the mechanism which make git apply changes to subtree
merged subproject at correct place.
 
> > BTW. Subversion doesn't have "svn cherry-pick", nor equivalent to
> > "git reset" == "git cherry-pick -R"... well, at least I don't think it
> > has.
> 
> See below...

Ah, I understand now that 'svn merge' (which is rather like 'cvs update')
can be used for cherry picking.

Sidenote: in Git cherry picking picks up change and applies it on top
of current branch as one would apply a patch.  This is quite different
from merge, where you find comon ancestor and then perform 3-way merge
(ours, theirs, ancestor).  Is merging in Subversion using 3-way merge
(like 'cvs update -j ... -j ...' is), or re-applying changes?


> > I have read some documentation about svn:mergeinfo property:
> > http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html
> 
> I guess this the first time I've read the 1.5 version of the SVN Book.
> This has consequences below... 

Errr... what consequences?  a:b vs a-b being closed (inclusive) or open
(exclusive) from one or other end?

> > ---1---B---2---3---M1--4---5---M2 <-- foo
> >         \         /           /
> >          \-a---b-/-----c---d-/ <-- bar
> > 
> > B is branching point, M1 and M2 are merge commits.
> > 
> > In Git, and I assume that also in Subversion, when doing merge M1, the
> > VCS notices that from revision B branches 'foo' and 'bar' have common
> > commits (in git we say that merge base of 'foo' and 'bar' at the point
> > of doing merge M1 is commit B). 
> 
> I'm going to take a little liberty with SVN revisions because I've
> always thought of SVN revisions as before and after the change, so a:b
> in SVN is the change introduced in b, but since we're on the Git list,
> in the following examples I will use a:b to mean the changes
> introduced in both a and b.  (Since it was introduced, I've always
> read "svn diff -c rev" as "svn diff -r rev-1:rev")
 
"git show rev" always show changes to parent, i.e. the same as 
"git diff rev^ rev" (rev^ ~= rev-1, if rev is not merge commit).
 
> Back to the task at hand... having read the 1.5 SVN docs, I have no
> idea how this works now (big caveat!!!), but prior to 1.5 M1 would
> have been  
> 
>   svn switch svn://path/to/foo
>   svn merge -ra:b svn://path/to/bar destination-path
> 
> which is "Take the changes introduced in revisions a through b, and
> apply them to the destination-path".  This is why I think of SVN
> merges as cherry-picks -- I was allowed to specify exactly what
> changesets I wanted merge to work on.

On one hand side you "were allowed to specify exactly what changesets
you wanted to merge to work on", on the other hand side you *had* to
specify what changesets etc.

So it was "make branching easy and O(1)"... and they forgot that
branching standalone doesn't make much sense, and that easy *merging*
is also required.  Merging in pre 1.5 times is as bad as in CVS.

> To truly illustrate this, consider a' is in between a and b:    
> 
> ---1---B---2---3-------M1--4---5---M2 <-- foo
>         \              /           /
>          \-a---a'---b-/-----c---d-/ <-- bar
> 
> I could
> 
>   svn switch svn://path/to/foo
>   svn merge -ra':b svn://path/to/bar destination-path
> 
> and "a" would never be merged back to foo.

Such merge would be hard to represent in Git, I think.

> The concept of *not* specifying revision numbers to merge is new
> in 1.5. See  
> 
>   http://svnbook.red-bean.com/en/1.4/svn.branchmerge.copychanges.html
> 
> This is what scares me about mapping SVN merges to Git merges.  It
> seems post-1.5 merges have a lot more in common with Git than pre-1.5
> (though mergeinfo is still brain damaged -- easy branching and merging
> is why I switched!), but I think we still need to support pre-1.5.   

-- 
Jakub Narebski
Poland
