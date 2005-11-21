From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Make grafts versionable
Date: Mon, 21 Nov 2005 13:41:10 -0800
Message-ID: <43823EF6.6010302@zytor.com>
References: <Pine.LNX.4.63.0511212152110.4611@wbgn013.biozentrum.uni-wuerzburg.de> <43823654.2060904@zytor.com> <Pine.LNX.4.64.0511211326110.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 22:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeJPu-0001Hi-DL
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 22:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVKUVlb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbVKUVlb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 16:41:31 -0500
Received: from terminus.zytor.com ([192.83.249.54]:63679 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751051AbVKUVla
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 16:41:30 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jALLfFvK030984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Nov 2005 13:41:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211326110.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12491>

Linus Torvalds wrote:
> 
> However, there's one fundamental reason:
> 
>  - if you have a file in ".git", that implies that even a "raw git repo" 
>    would have versions matter, since technically such a file would be 
>    inside the "raw" part. And that I find to be confusing. One of the 
>    whole points of a raw git repo is that because it doesn't have anything 
>    that is version-controlled and checked out, none of the branches or 
>    tags are special, and nothing needs to be updated when you push to such 
>    a repo.
> 
>    Now, if you have files in .git, suddenly that fundamental nature of a 
>    raw repository is no longer clear.
> 

Note that I didn't actually mean that they should necessarily represent 
files in .git/.  The point was more that if we wanted to have 
version-controlled metadata, using .git/ as a namespace would be suitable.

In particular, I believe that if we ever do that, git should obtain this 
metadata from the repository/object database.

> In general, making any internal git data versionable is very confusing. So 
> you make the grafts file versionable - that suddenly means that different 
> branches may have different parents for the same commit. And that 
> depending on which branch you have checked out, git-fsck-cache may result 
> in an error, or it may not. That's _nasty_, in my opinion.
> 
> So I much prefer to say: everything under ".git" is not versionable, for 
> the fundamental reason that the files under .git are "global" to that git 
> repository. 
> 
> And I think .git/grafts in particular makes no sense to version.
> 
> If you want to track a git "grafts" file, you can do it as another git 
> repository and a symlink.

I fully concur with this (as I pointed out in my post, although perhaps 
fuzzily.)

	-hpa
