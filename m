From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: svn repository URL and git
Date: Wed, 27 Oct 2010 17:31:58 +0200
Message-ID: <4CC845EE.5040602@debugon.org>
References: <loom.20101027T170254-268@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: H Krishnan <hetchkay@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7z4-00055N-5B
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab0J0PcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:32:08 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:52629 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0J0PcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:32:07 -0400
Received: from [172.20.2.23] (p578D1A1A.dip.t-dialin.net [87.141.26.26])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MLA1p-1PBOxm0Euv-0004I6; Wed, 27 Oct 2010 17:32:03 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <loom.20101027T170254-268@post.gmane.org>
X-Provags-ID: V02:K0:su9Fa+7hlnWplXpsV1hUuAU6rImRywE49EaKQ07y4d8
 Kd45fHjQ0B4Dg2W8yfwyz8QvEDjiHnEPLB4jmFHVmx9VdLWtRR
 ufV9dqL/YYjHeiJv1FyzvHxwdT0cdGPRQ5vx3CETUzXfeXWZX5
 8QfwKAbR8zJKHwzADsCJq81ByPILN7viDnsJr04Lvw63KbGstw
 rpf/DBwJGVuSnRhzesVJJzq3tZhLmmnq/2audls8OI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160091>

H Krishnan wrote:
> Hi, 
> We have started using git and git-svn. 
> I was thrilled to see that two people cloning using "git svn clone" 
> from the same repository got the same sha1 IDs for the commits which 
> meant that each of us could sync with svn independently while still 
> being able to share code among ourselves. 
> But my excitement was shortlived as the sha1 IDs were different if we 
> refer to the svn server using an alias. For example, using 
> http://mysvnserver.mydomain.com/repos/myproject/trunk gave different 
> sha1 IDs from using http://mysvnserver/repos/myproject/trunk even 
> though both refer to the same repository. This also disallowed using 
> mirrors of the repository for cloning. 
> Apparently the sha1 ID is generated from the full path of the URL. 
> Instead of this, could git-svn init be made to accept an optional 
> "prefix" argument as well which is filtered out of the URL before 
> building the sha1 ID. This will allow easy support for the oft 
> requested support for "svn switch --relocate". How much of an effort 
> is this? I don't know perl or git internals well enough for me to take 
> a stab at it but I am willing to learn if someone can give me some 
> pointers. 
> Krishnan

The problem is the "git-svn-id" which is automatically appended to each
commit done with git-svn. This ID consists of the URL and the UUID of
the corresponding SVN repository. A different git-svn-id value results
in a different commit SHA1 (i.e. a different commit to git).

I guess git-svn's --rewrite-root option might help here. Also, you have
to make sure that your SVN repos have the same UUID (with svnadmin
setuuid), of course.

-Mathias
