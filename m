From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 17:14:07 +0100
Message-ID: <4ECBCA4F.5090505@ira.uka.de>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com> <4ECB8917.8010305@ira.uka.de> <4ECBAFB7.9040505@obry.net> <4ECBBAD4.6080206@ira.uka.de> <4ECBBDE3.3010904@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Nov 22 17:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSsyW-0000py-4R
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 17:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab1KVQNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 11:13:31 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57789 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757255Ab1KVQNa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 11:13:30 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RSsyH-0008St-BD; Tue, 22 Nov 2011 17:13:29 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RSsyG-0002U8-Vg; Tue, 22 Nov 2011 17:13:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4ECBBDE3.3010904@obry.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1321978409.928081000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185799>

On 22.11.2011 16:21, Pascal Obry wrote:
> In fact I want to do that in a branch (say work) and keep master as-is
> as this branch is used to pull changes from origin. And in this case,
> doing 'git diff master' still shows the files under src2. See script to
> reproduce:
[...]
> # let's replace src2 by sd in branch work
>
> git checkout -b work
> git rm src2/*
> git ci -m "no more src2"
> # ln -s ../sd src2
> cp -r ../sd src2
>
> # make sure src2 is excluded
>
> echo 'src2'>>  .git/info/exclude
>
> # the following output should be clean
>
> echo '============== Status'
> git status
>
> echo '============== Diff'
> git diff
>
> echo '============== Diff master'
> git diff master
>>>
>
> Is that possible?
>

In my not-really-expert opinion no. At least git diff master has to show 
something because there obviously is a difference between what is in 
master (that you can't gitignore) and your branch (whether you ignore it 
or not).

I would

a) use a different directory name for src2 and adapt the Makefile to 
cope with that

or

b) remove the src2 link from .git/info/exclude and commit it into the 
branch. That way whenever you switch branch and master, the correct dir 
or link will be present and still because of the link none of the files 
in the svn will be handled by git in any way
