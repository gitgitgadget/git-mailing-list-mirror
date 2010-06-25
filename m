From: Carlos S <neubyr@gmail.com>
Subject: git config over http and ssh went wrong
Date: Fri, 25 Jun 2010 11:28:27 -0500
Message-ID: <AANLkTimc_T6qS5zVo92F8lw7hNPFp-9BhLP_g4ojntlZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 25 18:40:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSBxD-0006zW-Uo
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 18:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514Ab0FYQgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 12:36:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59043 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab0FYQgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 12:36:21 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2010 12:36:21 EDT
Received: by qwi4 with SMTP id 4so635365qwi.19
        for <git@vger.kernel.org>; Fri, 25 Jun 2010 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ZOv2gkRK4PuYCxq3hH95H6c4LK4y8rNnzdNt2Qf0mHk=;
        b=llOvraez71SImUDV3SKIfs26UX/kmzONHFMrB9qO+Lh0cZriPgmWsmJgEUHR07GGsu
         vBKXOnxW7IKp9CcfFzGpmBAv6sPqgqjJV7ahU7P6fVHHL09St89JvNJJoqDYAFVCET2L
         ViLtY7ccglPbimozy0RCffbihfPgQl3P8SMfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=U4qt6kIPNxpJV6vD1XkY0Cl40tGFCMK5zyNcZMRlogAHvmyxFfEZGXg0Mb66i2hFUc
         UlZ9VDYkp5y4CXcBKoGuay6miiBBJX6OV25K0+x2LPfzuW4HQFNaLuKy3Ig9p6Nf2eol
         Za2U0jeMkUsjQwflSM9h9J4BmU3nuV9Xt/cos=
Received: by 10.224.24.203 with SMTP id w11mr710508qab.296.1277483307898; Fri, 
	25 Jun 2010 09:28:27 -0700 (PDT)
Received: by 10.229.231.85 with HTTP; Fri, 25 Jun 2010 09:28:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149696>

Hi,

I need some help in setting up Git repository to be shared over ssh
and http. I was able to share my server/public bare repository over
ssh and http, but now client/private repositories are unable to push
their changes. Would really appreciate any help on configuring both
SSH and HTTP. And not sure why my SSH is not updating/pushing changes
to server, as it did before. Any pointers on where I went wrong?

Here is what I did:

[server - public]
* On CentOS5 - Git 1.7.1 server:
  -- Initialize bare git repo

[client - private SSH]
 * From another Debian VM:
  -- Create git repo
  --  Add remote origin ssh://user@centos5/var/gitpubrepos/test
  -- git push origin master

[server - public]
 * Then I changed HTTP conf to enable DAV for this directory.

[client - private HTTP] - May be I should have cloned the repo here
rather than pull?
 * git init
   Initialized empty Git repository in /ncs/tempgit-http/.git/
 *  git remote add origin http://centos5/git/fifa
 *  git pull
     fatal: http://centos5/git/fifa/info/refs not found: did you run
git update-server-info on the server?

[server - public]
  * git update-server-info


[client - private HTTP]
  * git pull origin master
    From http://centos5/git/fifa
    branch            master     -> FETCH_HEAD
    (Got all files)


[client-private HTTP]
  * Make some changes and try to push: git push
  * git push
    Fetching remote heads...
    refs/
    refs/tags/
    refs/heads/
    'refs/heads/master': up-to-date

 [client-private SSH]
  * git push
     = [up to date]      master -> master
     updating local tracking ref 'refs/remotes/origin/master'
     Everything up-to-date

-----

Thanks,
CS.
