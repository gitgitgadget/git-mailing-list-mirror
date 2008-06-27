From: John Locke <mail@freelock.com>
Subject: Re: git svn clone a non-standard repository
Date: Thu, 26 Jun 2008 18:06:16 -0700
Message-ID: <48643D08.1030904@freelock.com>
References: <48613DC5.2000506@freelock.com> <g3to0t$35n$1@ger.gmane.org> <4863E01E.9050108@freelock.com> <4863E261.8040508@freelock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Jun 27 03:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC2Qe-00014f-IX
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 03:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYF0BGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 21:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYF0BGL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 21:06:11 -0400
Received: from logan.freelock.com ([216.231.62.127]:33817 "EHLO
	logan.freelock.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbYF0BGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 21:06:09 -0400
Received: from localhost (foraker.freelock.com [127.0.0.1])
	by logan.freelock.com (Postfix) with ESMTP id DD0ECA0456;
	Thu, 26 Jun 2008 18:06:08 -0700 (PDT)
Received: from logan.freelock.com ([127.0.0.1])
 by localhost (foraker.freelock.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11055-09; Thu, 26 Jun 2008 18:06:08 -0700 (PDT)
Received: from [192.168.9.243] (router.freelock.lan [192.168.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by logan.freelock.com (Postfix) with ESMTP id B1A4EA0448;
	Thu, 26 Jun 2008 18:06:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <4863E261.8040508@freelock.com>
X-Virus-Scanned: by amavisd-new at freelock.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86512>

Okay. I think I've closed the loop, and have this updating successfully, 
if not necessarily easily.

John Locke wrote:
> Sorry to respond to my own post, but this section looks wrong:
>
> John Locke wrote:
>>
>>
>> Now the tricky part: I checked out a new "work" branch, and deleted 
>> everything in the working copy. Then, 4 steps out of the howto, 
>> adjusted to pull the particular branch from the current repository 
>> (instead of an outside one):
>>
>> git remote add -t dojo -f dojo ./
>> git merge -s ours --no-commit dojo-trunk
>> git read-tree --prefix=dojo/ -u dojo-trunk
>> git commit -m "merge dojo into subdirectory"
>
> ... since I added the remotes as svn-remote sections directly in 
> git-config, I skipped that first line.
>
>
To update, we need a local branch for each submodule:

git checkout -b dojo dojo-trunk <- create local branch and switch to it 
(only create it the first time through)

git svn rebase dojo-trunk  <- do this to update each local branch from 
the remote svn repository version--must have corresponding branch 
checked out.

... now that we've merged the remote changes to a local branch, we can 
update our work branch from each module's branch:

git checkout work
git pull -s subtree ./ dojo
git pull -s subtree ./ dijit
....




-- 
John Locke
"Open Source Solutions for Small Business Problems"
published by Charles River Media, June 2004
http://www.freelock.com
