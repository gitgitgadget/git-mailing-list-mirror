From: Robert Smith <wolf1boy79@yahoo.com>
Subject: Re: Newbie using git -- need a little help
Date: Sun, 17 Jun 2007 13:06:05 -0700 (PDT)
Message-ID: <2218.85747.qm@web57401.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 22:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I010o-0000Lv-Co
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 22:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759503AbXFQUGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759791AbXFQUGJ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 16:06:09 -0400
Received: from n8.bullet.re3.yahoo.com ([68.142.237.93]:33205 "HELO
	n8.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759173AbXFQUGG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 16:06:06 -0400
Received: from [68.142.230.29] by n8.bullet.re3.yahoo.com with NNFMP; 17 Jun 2007 20:06:06 -0000
Received: from [66.196.101.131] by t2.bullet.re2.yahoo.com with NNFMP; 17 Jun 2007 20:06:06 -0000
Received: from [127.0.0.1] by rrr2.mail.re1.yahoo.com with NNFMP; 17 Jun 2007 20:06:06 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 123283.27151.bm@rrr2.mail.re1.yahoo.com
Received: (qmail 86711 invoked by uid 60001); 17 Jun 2007 20:06:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Message-ID;
  b=oneQ9xrQMnjW9ddMIHI0YGB9neIYNxuQgpslYeynhcRwSqamSO4E17quWeiR+Srxzr6iz6ZNQGmbdKs8mRv4DNWfi82KDH3XzQNmD5RvCV0VMIwuB23WTs2vPWR/+YOrckAQCJ6I+YYL5Racu+IPXZJSqP7ecFbt6FfIBrWNgBA=;
X-YMail-OSG: LQHexlIVM1lFkOYp_WnBYu5v_mRJhpLFBLcO1pNLivN.r0nRojQKcqLF2.oD_SOKahuZj7Wel8uRm_cGA.NxUabCENPfRQO7754l86xxU0SZOhZrWH2OB27Yr6g_Dtbj0cNKdkngF4L2E44IdEftVSF6rvhMXSg-
Received: from [216.252.108.190] by web57401.mail.re1.yahoo.com via HTTP; Sun, 17 Jun 2007 13:06:06 PDT
X-Mailer: YahooMailRC/651.29 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50371>

Thanks for the quick reply.  I have a few questions regarding the infrastructure you described...

> When you push to your server, the repository is updated (that is the
> thing that is in .git) but your working tree isn't.

> So when you push to a repository that also has a working tree attached
> to it, you have to do a "git checkout" on the working tree. Or pull from
> the repository and not push to it.

Ahhh, that makes sense... :)

> Than I publish my project to the server without giving the repository at
> the server a working directory attached to it. A working directory is
> where you can edit files and commit changes locally, just in case I
> didn't introduce the term yet.

>         # This creates the repository _without_ the working tree on the server.
>         ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db

The /home/cip/adm/sithglan/work/repositories/private/astro.git is simply a .git directory located on the "server", and it doesn't actually contain any working code (yet), right?

>         # This adds the remote origin to the config so that I don't have to
>         # type in the long repository path each time I am going to push or pull
>         # something.
>         git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git

So what this command is doing is telling git where the "origin" is -- on the remote server, correct?  Also, is the default protocol (since all you typed was 131.188.30.102:/.../astro.git) is SSH correct?
 
>         # Now I publish my stuff to the central repository. You need at least
>         # one commit in order to be able to do that.
>         git push origin master:master
> 
>         # I add a few lines to my config so that when I type in "git pull" it
>         #fetches the stuff and merges it with my local repositories master branch.
> 
>         "vim .git/config" and add the following lines:
> 
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
> EOF

I'm a little lost on what 'origin' refers to precisely.  Is origin considered the "root" of all the changes (the workspace as it was originally before any patches)?  Or is it a location for the working files?  You give a definition below in your e-mail but I'm still not completely sure what it is referring to.

>         # Now I can fetch back to see if everything works
>         git pull

Makes sense...let me give this a try.  :)
 
> Now I am fine the infrastructure is all set up. The next time I am going
> to access the project from a different machine I simply do:
> 
>        git pull 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git
> 
> And that's it. The origin and where it is going to merge stuff is set
> automatically up by git. Note: I use ssh (attached to a ssh-agent so that I
> don't have to passwords all the time I am doing a push or pull). I hope that
> helps you and didn't miss your original question. I just fly over your e-Mail
> and picked a few keywords to comment on.


Awesome...thanks, Thomas.  I'll tinker around with this a little more and see if I can get this working as wanted.

Thanks again.

- robert -




       
____________________________________________________________________________________
Yahoo! oneSearch: Finally, mobile search 
that gives answers, not web links. 
http://mobile.yahoo.com/mobileweb/onesearch?refer=1ONXIC
