From: Matthieu Poullet <matthieu.poullet@gmail.com>
Subject: Wrong, misleading error message when "branch.<name>.merge" is invalid
Date: Wed, 11 Mar 2009 13:27:47 +0100
Message-ID: <80a0c20d0903110527s1fed1f36wf33446220f6628ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 13:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhNYn-0002t7-Rd
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 13:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511AbZCKM1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 08:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbZCKM1u
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 08:27:50 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:38284 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754285AbZCKM1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 08:27:50 -0400
Received: by fxm24 with SMTP id 24so1953230fxm.37
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=aNYlLG6CXemG5AVOaU62hN1BoExjHV76s92tMtUbZ8s=;
        b=ewDmgd7/tXozJPU8sSzYEtppj+jVy1YKeZaM3ckanoImOiBrTHdvSihQD7lEztacol
         8P8r4021Lorwm4s4WwTKE4H1RCWBOJxPbxtu21UcqAUmtn4/CmXcWMeJ6bzBUTEYARTu
         944aKhZeExBdwcJUSnxagmV+Mn+980WAcr6Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=fux+cnRA1AxiMstYiCrjgV6F1m8b8SRjHx0t54FuykKc5sB2VJCcy5bPkiObmkiV7q
         QnMhuZY00qYOPeALIiwdzsk3J5wVW+hdU+Or7TuSWZiiWROcHj9PCkwkkPrvLetvFVHp
         Ui60/LxlVFN/aX6LJE0Fn14uOvxs2I680Iocs=
Received: by 10.223.113.200 with SMTP id b8mr6314606faq.84.1236774467323; Wed, 
	11 Mar 2009 05:27:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112920>

Hi,

today I've tried to update a repo I haven't used for a while (see
complete log below).
When trying to pull changes for my remote tracking branch, I've got an
error message suggesting that my config was wrong instead of
suggesting that this branch was gone on the remote.

As people (thanks to them) explain me on #git, fetch doesn't remove
stale tracking branches, and so in this case the error message is
pretty misleading.
Maybe "Error: ref 'refs/heads/omap3' does not exist in remote repo
'origin'" (suggested by Ilari on #git) would be more appropriate?

Regards,
Matthieu.

mpoullet@LU84-mpoullet:~/src/u-boot-arm$ git branch -a
* master
  omap3
  origin/20070326_ene
  origin/HEAD
  origin/master
  origin/mm
  origin/next
  origin/old-next
  origin/omap3
  origin/testing
mpoullet@LU84-mpoullet:~/src/u-boot-arm$ git pull
Already up-to-date.
mpoullet@LU84-mpoullet:~/src/u-boot-arm$ git checkout omap3
Switched to branch "omap3"
mpoullet@LU84-mpoullet:~/src/u-boot-arm$ git pull
You asked me to pull without telling me which branch you
want to merge with, and 'branch.omap3.merge' in
your configuration file does not tell me either. Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.omap3.remote = <nickname>
    branch.omap3.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details.
mpoullet@LU84-mpoullet:~/src/u-boot-arm$ cat .git/config
[core]
  repositoryformatversion = 0
  filemode = true
  bare = false
  logallrefupdates = true
[remote "origin"]
  url = git://git.denx.de/u-boot-arm.git
  fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
  remote = origin
  merge = refs/heads/master
[branch "omap3"]
  remote = origin
  merge = refs/heads/omap3
