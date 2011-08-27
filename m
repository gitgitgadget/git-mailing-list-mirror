From: rupert THURNER <rupert.thurner@gmail.com>
Subject: "git submodule foreach" very slow ...
Date: Sat, 27 Aug 2011 21:07:23 +0200
Message-ID: <CAJs9aZ8Bbaji-Did9gYzUQ85VRkp=ZpRq=Pej6M-9fkKK5BurA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 21:07:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxOEO-0000b8-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab1H0THo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 15:07:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60759 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1H0THo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 15:07:44 -0400
Received: by gxk21 with SMTP id 21so3758325gxk.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=gSIeVK75OmAkqVIyFevQFb5zsNMIF1k0uwKFfcjJRCI=;
        b=Zr/tCwpCQ8SswmCQYIjkyR1+evlgkefHJHj/2OgndoMuNBegL3C89RcnRprRiQkfxg
         JW1feVFNnlzDZuBwYAxCOQwhzaBBcbH0dTEhcTIXNpQit5uXfSI93MO5A8Eu3cI4JDeH
         g6QBnmL/9EacSG4pzMcRkP7I0XNITLRlKZtC4=
Received: by 10.42.131.9 with SMTP id x9mr2803274ics.255.1314472063059; Sat,
 27 Aug 2011 12:07:43 -0700 (PDT)
Received: by 10.42.180.70 with HTTP; Sat, 27 Aug 2011 12:07:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180241>

git usually is lightning fast, it even knows how many processor
threads are available and uses them. for a test i converted
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg into a git
repository with one subrepository for every directory. rebasing takes
now 3 hours, while git without subrepositories takes 10 minutes.

$ ls -1 | wc
   1162    1162    9527
$ time git submodule foreach git svn rebase
....
real    199m29.626s
user    60m49.631s
sys     70m51.888s

contrary, if one creates one git repository for all these little
directories, rebasing is twenty times faster:
$ time git svn rebase
...
real    10m1.032s
user    5m33.632s
sys     2m53.955s

rupert
