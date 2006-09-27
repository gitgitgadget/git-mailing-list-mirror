From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 07:55:05 +0800
Message-ID: <451B0F59.6070901@dawes.za.net>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <Pine.LNX.4.63.0609271152270.14200@wbgn013.biozentrum.uni-wuerzburg.de> <451AB122.9020600@gmail.com> <Pine.LNX.4.63.0609280113490.14200@wbgn013.biozentrum.uni-wuerzburg.de> <20060927233639.GE21839@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 01:55:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSjF6-0007FY-Ug
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 01:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031262AbWI0XzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 19:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031265AbWI0XzE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 19:55:04 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:65239 "EHLO
	spunkymail-a10.dreamhost.com") by vger.kernel.org with ESMTP
	id S1031262AbWI0XzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 19:55:02 -0400
Received: from [0.0.0.0] (lucas.dreamhost.com [64.111.99.14])
	by spunkymail-a10.dreamhost.com (Postfix) with ESMTP id E505A1615F3;
	Wed, 27 Sep 2006 16:54:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060927233639.GE21839@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27948>

Shawn Pearce wrote:

> 
>  - Higher level projects should drive subprojects.
> 
>    Higher level projects tend to be composed of specific revisions or
>    specific generations of subprojects.
> 
>    Part of the content of the higher level project is just what
>    those subproject specifications are and how those subprojects
>    should appear in a working directory.
> 

> 
> I used the term "generation of subprojects" as not everyone wants
> to bind their root project to a specific revision of a subproject.
> Indeed that may not be entirely practical.  Instead just a particular
> lineage of development (e.g. "Version 1.0" vs. "Version 1.2")
> may be all that is needed.
> 

Does it not make sense that a commit of the higher level project should 
include the contents of its subprojects at that particular moment in time?

e.g. using the previous example of a kernel, apache, glibc, etc

You may track the subprojects using whatever scm applies to THAT 
subproject. But when you want to record the state of the entire project, 
you want to include the state of the subprojects. So, your super-project 
commit would actually recurse down into the working directories of the 
subprojects and record the state/contents of each file that makes up 
each of the subprojects.

So, if someone is tracking the overall project, and they do a pull of 
v1.1 (tag), they will see exactly what v1.1 looked like in your repo.

What this makes me think is that it might be useful to have a mechanism 
for recalculating the tree-ish of a subdirectory and finding an 
associated commit, for the case where a subproject is also managed by git.

i.e. given a super-project in this state, and knowing that this 
subproject is managed by git, which revision of the subproject are we 
talking about, and can we find a commit that matches this tree-ish? 
(assuming we have the history of the subproject available, of course)

Regards,

Rogan
