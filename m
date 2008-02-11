From: Paul Gardiner <osronline@glidos.net>
Subject: Re: Best way to specify all local branches and all remote branches.
Date: Mon, 11 Feb 2008 19:40:38 +0000
Message-ID: <47B0A4B6.2090408@glidos.net>
References: <47B09921.2070109@glidos.net> <m3ir0ve2c1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 20:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOeWn-00068x-KC
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbYBKTkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbYBKTkq
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:40:46 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:21021
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754548AbYBKTkp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 14:40:45 -0500
X-Trace: 38684123/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CACMzsEc+8aIg/2dsb2JhbACqJw
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Feb 2008 19:40:42 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by ranger.systems.pipex.net (Postfix) with ESMTP id 6AB34E000096
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 19:40:38 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <m3ir0ve2c1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73571>

Jakub Narebski wrote:
> Paul Gardiner <osronline@glidos.net> writes:
> 
>> New to git, and often finding it hard to specify the correct
>> refs for a command. Here's an example where I was converting
>> all the files in all the commits from unix line endings to
>> DOS line endings. You can see I've ended up using cd and ls.
>> I'm sure there must be a better way.
> 
> git-for-each-ref, git-show-ref, git-ls-remote / git-peek-remote.

Ah right, those look hellishly useful, thanks.

>> $ cd /home/public/tmp/git/
>> $ yes |rm -r vdos32
>> $ git clone /export/git/vdos32.git vdos32
>> $ cd vdos32/
>> $ for f in `(cd /export/git/vdos32.git/refs/heads; ls)|sed -e
>>     '/master/d' -e '/origin/d'`; do git fetch origin $f:$f; done
>> $ git-filter-branch --tag-name-filter cat --tree-filter 'find . -type f
>>     ! -name \*.gif ! -name \*.ico|xargs unix2dos -q' `(cd
>>     .git/refs/heads;ls)`
> 
> If you want to fetch all branches, you can specify globbing refspec;
> of course if you use separate remotes layout, or mirror layout.

I think I tried that with my line 5 above. I tried 
refs/heads/*:refs/heads/* as the ref spec. Should something like that
work?

> If you want to pass all branches to git command, usually --all would
> be enough (sometimes --heads).
>  
>> With git-filter-branch, I'm surprised I can't use --all.
> 
> git-filter-branch is about single branch; I'm not sure if it should
> support --all.

It seems to work with multiple branches, and I think it's important
that it does, because as far as I can tell, that's the only way
to filter a whole repository without visiting some commits more
than once. Certainly my command, using cd/ls, worked and visited
each commit exactly once.

Cheers,
	Paul.
