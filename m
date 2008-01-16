From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 05:13:47 -0800 (PST)
Message-ID: <m3bq7lncak.fsf@roke.D-201>
References: <478D79BD.7060006@talkingspider.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF860-0000im-OR
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 14:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYAPNNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbYAPNNv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:13:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:52021 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbYAPNNu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:13:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so209740ugc.16
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=PV8BVDDZKmera2PmZYsXJT/x9tx4LgqmL38PA3d6C/A=;
        b=KARAbNux6tJWtIpMdhHBtJPUY0OOK/xcaknsbYt7ciXQ+6lNZSMeHcC7YJpt+MIicifQBBsb49aIcvylQssxsKMWygGTRwOY45Oz6FAuv4T1FzdbqSX0xuERoH8fI6kz7yw/S6f+aqEk6G5AQTaHiwkc1ZicyxzomjEopzzKbEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=muGlNtY4Yy7VVKvsWvfsdiOJsMosmCxhn4Yp7SPkElg8x7Y5+MO+3z87QMkOn+k4DA7KIo8Nxbriu6aGOt2J0CUQUJkN9/ND4GBByzQH5GrRmWbVDEJmdlz6+W47GdPESlsyVLFlVmQ28qzBbKdjEXEN17IE3MlnXh0WkHTb1Mc=
Received: by 10.67.116.9 with SMTP id t9mr2054088ugm.77.1200489228583;
        Wed, 16 Jan 2008 05:13:48 -0800 (PST)
Received: from roke.D-201 ( [83.8.213.34])
        by mx.google.com with ESMTPS id h1sm1793189ugf.11.2008.01.16.05.13.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Jan 2008 05:13:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id m0GDDfcT019015;
	Wed, 16 Jan 2008 14:13:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0GDDdtT019012;
	Wed, 16 Jan 2008 14:13:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <478D79BD.7060006@talkingspider.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70664>

Mike <fromlists@talkingspider.com> writes:

> I'm learning git and I'm really annoyed that the .git directory lives
> in the same directory as my code.  I don't want it there for three
> reasons:
> 
> 1. My code lives on a development web server docroot, and I don't want
> the .git repository to end up getting published to the live site by
> accident. (I would imagine this would be a common need.)

Use git-archive (or, in older releases, git-tar-tree) and perhaps
post-update / post-recieve hook to publish latest version.

I think best layout would be: 
 (1) your private copy (clone) of repository, with working directory
 (2) bare (without working directory) publishing repository,
     with post-update hook
 (3) published last version of your files

You can check 'todo' branch of git.git repository for scripts which
Junio uses to automatically update git HTML documentation at
kernel.org
 
> 2. If I tar/gz my code and deliver it to a client, I don't want the
> .git dir slipping into the tarball, allowing my client to be able to
> peruse the history of what we did and when.

Use git-archive / git-tar-tree to tar.gz or zip code to send to client.
This has the advantage of not packing generated code, backup files,
etc., not only .git. Besides there is --exclude option to tar ;-)
 
(For RPM based distributions git-archive is usually in git-core;
I don't know what package you have to install on Debian based distro).

> 3. The .git respository will get big, especially with binary files in
> it, and I want it someplace with a lot of disk space. And I don't want
> it to get tarred up when we migrate the site to a different
> server. (And tar isn't aware of hard links is it? wonderful.)
> 
> How do I make the repository dir live somewhere else, the hell away
> from my code? Thanks

If you are inside repo, configuration variable core.worktree,
environmental variable GIT_WORK_DIR, or '--work-tree' command line
option (git --work-tree=/path/to/working/dir <cmd>) can be used to
point to working tree.

If you are in working area, environmental variable GIT_DIR, or
'--git-dir' command line option can be used to point to the
repository. You can also symlink .git in working directory.
There was an idea of '.gitlink' file, similar to CVS/Root file
in CVS, or core.gitdir configuration variable which points to
base GIT_DIR in unionfs / shadow like way, but neither got
implemented. You are welcome to it... of course after release :-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
