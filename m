From: Patrick Doyle <wpdster@gmail.com>
Subject: Howto request: going home in the middle of something? v2009
Date: Tue, 21 Apr 2009 09:39:53 -0400
Message-ID: <e2a1d0aa0904210639t2ca73364pff26c85a0224182e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 15:42:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwGEs-0007FS-2v
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 15:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbZDUNj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbZDUNj4
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 09:39:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:5343 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZDUNjz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 09:39:55 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1634620ywb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=L0prnbwc9206MXdXldreHiOegm5wuSd6eYXAEuggw90=;
        b=DWAscMnL65HHVMzl0+7HgFUF8Bii1voEQRbECnsgtATtkTg7v33upluoM5gv0i1CF1
         Cib/xiq1NY9saTcfJpSOWM2j/m9x65ZW8IadFpidNuwjLtBXUXsTAWeB5Ce386FLGBV5
         fzKH12LXa0mo8KgcShKGoCyUy80p+1+op9a6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Xqn0jG2fl5cE5qKwysacetFrEgMt0RZDuSPecIH2tAAW+JGXbDBYUb9bq/RHt/1lmC
         zHlq/YSIShAUwreQ3G5TsDl0N1ie6gT+C2FldR8DTvNc+ZfKwGFylnrkeEodvKA3hcHG
         X/0IaWu6kcbMxp9/dURDwTKUxG0EHc9cjAkdM=
Received: by 10.231.19.72 with SMTP id z8mr3666409iba.6.1240321193848; Tue, 21 
	Apr 2009 06:39:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117131>

Hello,
I've developed a work habit of keeping my source code repository on a
USB stick and carrying that back and forth with me between work and
home.  (I typically have small, branchless, single-developer
projects.)  When I arrive at the other machine, I do

$ git pull
(code, commit, code, commit, etc...)
$ git push

Occasionally at the end of the day (if I'm at work) or at the end of
the night (if I'm at home), I'm in the middle of something that I want
to continue, and I end up making a "work-in-progress" commit

$ git commit -a "WIP"

just so I can pull that in the next day/evening and continue where I
left off.  But that leaves a bunch of "WIP" commits in my history.  I
started looking around for a better way to do this, and came across a
2007 discussion (at
http://kerneltrap.org/index.php?q=mailarchive/git/2007/10/18/347020/thread)
where the OP really wanted (as do I) do be able to do something like
this:

$ git stash
$ git push
$ git stash-push
(travel to other site)
$ git pull
$ git stash-pull
$ git stash apply
(continue coding and committing as before)

There were a number of different suggestions, such as:

$ git commit -b temp -a -m "Hold for transport home"

Then when I get home I do this:

$ git fetch work
$ git merge work/temp
$ git reset HEAD^
 # code code code
$ git commit -b temp -a -m "Hold for transport to work"

When I'm finished at home and want to carry on at work:

$ git fetch --force home
$ git merge home/temp
$ git reset HEAD^
 # start coding for the day

... or using git-bundle

That discussion dates back to 2007.  Is there a new, improved, 2009
way of accomplishing this?

--wpd
