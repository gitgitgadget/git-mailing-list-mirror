From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: git remote branches oddies
Date: Mon, 23 Jun 2008 19:50:13 +0400
Message-ID: <20080623155013.GD7094@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 17:51:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAoKR-0007Us-Pj
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbYFWPun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbYFWPun
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:50:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:61449 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271AbYFWPum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:50:42 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1841726wri.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=/znWNDEiEAO59HqcK2X8c/9gJISZ+GACvRbFjDZp5Go=;
        b=C1Tt6HzkNjKe4nyRH+rt312tT1a07akMH8k682bCUjlvCCKh5fX8VI0KbkMBpJcIsk
         GJtTTijBUXrB3Jamk5xcgBl8KtMHYkzljMW8hiplAFgeGmoeKV0AxEcdlD+x//cTb7/X
         572RijGbq7kjidsTCMud9PlHUvhGaOqsjfvj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=mAgwEPbNwyfZk4Clbp3OPgf588bQQw/uavmeGacPvi7AU3iTeEL8lw4ecyV/SOGHA2
         cLiVTC5MITs9ZJxA9r6BCBpgq45elgF/t0vdaa0sEVMG1FFZMfxRYEdSESZaiG44lP/U
         P+4hS1YvLtfYOli+Ypbabu65Sb3LNXcpEfHuo=
Received: by 10.90.36.16 with SMTP id j16mr1498493agj.52.1214236239087;
        Mon, 23 Jun 2008 08:50:39 -0700 (PDT)
Received: from gorcunov ( [91.122.50.248])
        by mx.google.com with ESMTPS id s30sm4791273elf.15.2008.06.23.08.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Jun 2008 08:50:38 -0700 (PDT)
Received: by gorcunov (Postfix, from userid 1000)
	id 44036B9F; Mon, 23 Jun 2008 19:50:13 +0400 (MSD)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85875>

Hi git list,

could someone take a look please since I'm not
sure if that is right thing I'm doing with git ;)

I'm tracking a few linux kernel repos. Here is my git config:

--- git config ---
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
[remote "x86"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git
        fetch = +refs/heads/*:refs/remotes/x86/*
[remote "tip"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
        fetch = +refs/heads/*:refs/remotes/tip/*
[gui]
        geometry = 1037x445+260+116 207 192
[remote "udf"]
        url = git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-udf-2.6.git
        fetch = +refs/heads/*:refs/remotes/udf/*
------------------

By typing 'git remote update' I've got the following today

--- git remote update log ---
cyrill@cvg linux-2.6.git $ git remote update
Updating origin
Updating x86
From git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86
 * [new branch]      core/futexes -> x86/core/futexes
error: 'refs/remotes/x86/mm' exists; cannot create 'refs/remotes/x86/mm/xen'
 * [new branch]      mm/xen     -> x86/mm/xen
   d4abc23..ea71a54  sched-fixes-for-linus -> x86/sched-fixes-for-linus
error: unable to resolve reference refs/remotes/x86/sched/devel: Not a directory
 * [new branch]      sched/devel -> x86/sched/devel
error: unable to resolve reference refs/remotes/x86/sched/new-API-sched_setscheduler: Not a directory
 * [new branch]      sched/new-API-sched_setscheduler -> x86/sched/new-API-sched_setscheduler
error: unable to resolve reference refs/remotes/x86/sched/urgent: Not a directory
 * [new branch]      sched/urgent -> x86/sched/urgent
   ffe6e1d..ebb9cfe  x86-fixes-for-linus -> x86/x86-fixes-for-linus
error: Could not fetch x86
Updating tip
From git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
 * [new branch]      core/futexes -> tip/core/futexes
   d4abc23..ea71a54  sched-fixes-for-linus -> tip/sched-fixes-for-linus
error: unable to resolve reference refs/remotes/tip/sched/devel: Not a directory
 * [new branch]      sched/devel -> tip/sched/devel
error: unable to resolve reference refs/remotes/tip/sched/new-API-sched_setscheduler: Not a directory
 * [new branch]      sched/new-API-sched_setscheduler -> tip/sched/new-API-sched_setscheduler
error: unable to resolve reference refs/remotes/tip/sched/urgent: Not a directory
 * [new branch]      sched/urgent -> tip/sched/urgent
   ffe6e1d..ebb9cfe  x86-fixes-for-linus -> tip/x86-fixes-for-linus
error: Could not fetch tip
Updating udf
-----------------------------

I've asked Ingo what is happend with -tip tree. He answered:

| hm, this is due to a new 'sched/urgent' and 'sched/devel' branches being
| introduced, while the old ones were still around.

If I've recreated git repo from scratch - messages are gone. Not sure
how to react on this. Is that normal? (I would _not_ say that such
error messages annoying me but somehow a _bit_ unpleasant :-)

Please CC me since I'm not subscribed.
Btw the git I'm using is - git version 1.5.6.6.gd3e97.

		- Cyrill -
