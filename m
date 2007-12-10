From: Wink Saville <wink@saville.com>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 09 Dec 2007 22:36:35 -0800
Message-ID: <475CDE73.9010505@saville.com>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home> <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org> <475C7DD5.9040209@saville.com> <Pine.LNX.4.64.0712091942520.5349@iabervon.org> <475CA476.6070507@saville.com> <Pine.LNX.4.64.0712092130560.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 07:37:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1cGB-0002a4-Kk
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 07:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbXLJGgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 01:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbXLJGgi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 01:36:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:1772 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbXLJGgi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 01:36:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1512491rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 22:36:37 -0800 (PST)
Received: by 10.141.171.6 with SMTP id y6mr4017596rvo.1197268597429;
        Sun, 09 Dec 2007 22:36:37 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id f42sm5956665rvb.2007.12.09.22.36.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 22:36:37 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0712092130560.5349@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67684>

Daniel Barkalow wrote:
> On Sun, 9 Dec 2007, Wink Saville wrote:
>
>   
> Ah, okay. I was assuming that you wanted them to maintain their original 
> identities (so you'd send stuff off for each of them separately, for 
> example).
>
> I think you can do what you want by doing:
>
> # Set up the new line:
> $ mkdir x; cd x
> $ git init
> $ touch README
> $ git add README
> $ git commit
>
> # Add a project "foo"
> $ git fetch ../foo refs/heads/master:refs/heads/foo
> $ git merge --no-commit foo
> $ git read-tree --reset -u HEAD
> $ git read-tree -u --prefix=foo/ foo
> $ git commit
>
> And repeat for all of the other projects.
>
> What's going on here is that you're merging in each project, except that 
> you're moving all of the files from that project into a subdirectory as 
> you pull in the content. The resulting repository has one recent dull 
> initial commit, and then merges in each of the other projects with their 
> history, with only the slight oddity that they don't go back to the same 
> initial commit, and the merge renames all of the project's files.
>
> I think there may be a more obvious way of doing this (it's essentially 
> how gitweb and git-gui got into the git history), but I'm not sure what it 
> is, if there is one.
>
> 	-Daniel
> *This .sig left intentionally blank*
>   

Daniel,

Worked like a charm, someday maybe I'll understand why it works:)

Wink
