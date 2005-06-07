From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [PATCH 0/4] Writing refs in git-ssh-push
Date: Mon, 06 Jun 2005 23:54:42 -0600
Message-ID: <42A536A2.3040809@tuxrocks.com>
References: <Pine.LNX.4.21.0506070032410.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:54:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfX2Z-0006mh-VD
	for gcvg-git@gmane.org; Tue, 07 Jun 2005 07:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVFGF5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Jun 2005 01:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVFGF4M
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jun 2005 01:56:12 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:36623 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261793AbVFGFzH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2005 01:55:07 -0400
Received: from [10.0.0.10] (byu-gw.customer.csolutions.net [216.190.206.130])
	(authenticated bits=0)
	by tuxrocks.com (8.13.1/8.13.1) with ESMTP id j575shCl021171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Jun 2005 23:54:45 -0600
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506070032410.30848-100000@iabervon.org>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Barkalow wrote:
> On Mon, 6 Jun 2005, Linus Torvalds wrote:
> 
> 
>>Two comments on git-ssh-push from a quick try-to-use-it-but-fail..
>>
>> - hardcoding the name of the command on the other side kind of sucks. 
>>   Especially when the user may end up having to install his own version
>>   under his own subdirectory. You really want to have some way of saying 
>>   "execute /home/user/bin/git-ssh-pull", and since it will depend on the 
>>   site you're pushing to, it should probably be available as a cmd line 
>>   option.
>>
>>   I have a
>>
>>	PATH=$PATH:~/bin
>>
>>   in my .bashrc, but sshd at the other end doesn't end up caring..
> 
> 
> sshd is pretty odd that way; I think ~/.ssh/environment might get you your
> local path. I thought it was just my sshd that was strange like that, but
> it's probably common if yours does it too. I'm not sure if there's a
> standard way to pick up a per-user version of the remote program. It seems
> like cvs doesn't do anything clever, and sftp makes it a compile-time
> option.
> 
> I think an environment variable for the directory to find
> git-ssh-(other) in would be easiest to script when needed and would also
> reduce the chances of specifying the wrong program on the remote side
> (which would generate really confusing errors).

- From the ssh(1) manpage (openssh):
Additionally, ssh reads $HOME/.ssh/environment, and adds lines of the
format "VARNAME=value" to the environment if the file exists and if
users are allowed to change their environment.  For more information,
see the PermitUserEnvironment option in sshd_config(5).

The default given in sshd_config(5) is not to allow the user-specified
environment, because "Enabling environment processing may enable users
to bypass access restrictions in some configurations using mechanisms
such as LD_PRELOAD."

It looks like something we probably can't count on for sure.

Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpTaiaI0dwg4A47wRAhoJAJ9h4MUqGZWsT7+22FHaavd2N4ETqQCfTYR3
4qibBinO4TUgsdTNMrtgaxk=
=Uutj
-----END PGP SIGNATURE-----
