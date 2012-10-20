From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Report a bug, about track remote repository.
Date: Sun, 21 Oct 2012 00:46:20 +0100
Organization: OPDS
Message-ID: <F15116C3B49A439AB06C8068F79E4C0F@PhilipOakley>
References: <5082F255.9060600@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: "Cheeray Huang" <cheeray.huang@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 01:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPik2-0004jg-Rw
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 01:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393Ab2JTXpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 19:45:49 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:8356 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982Ab2JTXps (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2012 19:45:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuIKABYzg1BZ8rGT/2dsb2JhbABEi1O0LwQBA4EDgQmCGwUBAQQBCAEBLh4BASwCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYdhAwkKsQ4NiVSKdoEkRBEchGNgA4glhUeGMIx+hRCCcA
X-IronPort-AV: E=Sophos;i="4.80,622,1344207600"; 
   d="scan'208";a="388217841"
Received: from host-89-242-177-147.as13285.net (HELO PhilipOakley) ([89.242.177.147])
  by out1.ip04ir2.opaltelecom.net with SMTP; 21 Oct 2012 00:45:45 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208096>

From: "Cheeray Huang" <cheeray.huang@gmail.com>
> Hi,
>
> I think I found a bug, when I used local branches to track remote 
> branch. But I'm not very sure, can anyone double check this?  I'd like 
> to finger this out. I think you can reproduce this bug as below steps:
>
> precondition:
>
> Suppose that you have a remote branch in repository, named 
> origin/work. And then you want to track it with a local branch.
>
> Steps:
>
> 1. So you can do this:
>
> git checkout -t origin/work
>
> now, you have a local branch also named "work" to track "origin/work".
> It works nicely, you can use "push/pull" command without any detail 
> parameters to sync anything with the remote branch.
>
> 2. Create another branch, ex. named "work2", to track "origin/work" 
> again, though maybe there are not so many people that will do like 
> this.

At this point you have created the 'conflict' - You can't have two 
different branches that both track the same identical remote branch and 
expect that they can be both different and identical at the same time.

>
> You will find that local branch "work2" can't "push" to "origin/work".
> ex. After you committed something in work2, you typed "git status", 
> git would tell you:
>
> Your branch is ahead of 'origin/work' by x commit.
>
> And then you used "git push", git can't display the information about 
> changing hash value in remote branch, just printed "everything is up 
> to date".

Only one push (from two branches trying) can suceed. You either force 
the remote to match the current branch, and loose any information that 
it had about the other branch, or the remote stays with one branch. 
Simply don't do it [that way]. If the local branches are different, then 
you need distinct remote branches.

>
> Actually, you can use some exact parameters to solve this,  such as:
>
> git push origin work2:work
>
> But, I still think it is a bug.
>
> BTW, I found this bug when I used github. I don't know whether it is 
> related to github.
>
>
> -- 
> B&R,
> Cheeray
