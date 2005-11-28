From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 05:45:24 -0800
Message-ID: <86zmno6g3v.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<20051128104831.GN22159@pasky.or.cz>
	<86d5kk7wbv.fsf@blue.stonehenge.com>
	<20051128134111.GP22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 14:52:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgjKK-0006bd-CE
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVK1Np1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVK1Np1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:45:27 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:55415 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932098AbVK1Np0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 08:45:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 9B5FE8F6B8;
	Mon, 28 Nov 2005 05:45:25 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 15092-02-84; Mon, 28 Nov 2005 05:45:25 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0C3308F6BE; Mon, 28 Nov 2005 05:45:25 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <20051128134111.GP22159@pasky.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12879>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> It would sure be bad if this was the case. However I'm really sorry, but
Petr> I still can't reproduce it.

Reproduce by this:

    localhost:~/Projects/Git/Play % cg-admin-setuprepo remote.git
    localhost:~/Projects/Git/Play % mkdir local.git
    localhost:~/Projects/Git/Play % cd local.git
    localhost:..Git/Play/local.git % cg-init -minitial
    defaulting to local storage area
    Committing initial tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
    Committed as 958ed484382609786ca9ae611cc54802cb7697a9.
    localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"           
    localhost:..Git/Play/local.git % cg-push
    WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
    WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
    ssh: \033]2;[zsh] localhost: No address associated with nodename
    fatal: unexpected EOF

I did this with current-of-the-moment git and cogito:

localhost:~ % cd MIRROR/git-GIT 
localhost:~/MIRROR/git-GIT % cg-status
Heads:
   >master      f1f909e3185b5ee366e198042447afe749bfc813
  R origin      f1f909e3185b5ee366e198042447afe749bfc813

localhost:~ % cd MIRROR/cogito-GIT 
localhost:~/MIRROR/cogito-GIT % cg-status
Heads:
   >master      cec6c5564c6dcc30361f164dce9ac5dc635d202f
  R origin      cec6c5564c6dcc30361f164dce9ac5dc635d202f

If this indeed works on your machine, then we have a Darwin dependency
somewhere in cg-push or something it calls.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
