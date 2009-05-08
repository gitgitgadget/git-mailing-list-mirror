From: Dan Fairs <dan.fairs@gmail.com>
Subject: Problem with local branches and git svn rebase
Date: Fri, 8 May 2009 09:57:10 +0100
Message-ID: <08FCF5E0-A2AA-4F23-9C23-E8F823AF2546@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 10:57:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LtT-00084c-9Q
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZEHI5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZEHI5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:57:16 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:42474 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbZEHI5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 04:57:14 -0400
Received: by ewy24 with SMTP id 24so1667012ewy.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=oG7IAYtdeNTWhe7D3q1Amo+Am0zAbpk5DFB2cueVpB4=;
        b=Nfrx/n2niY5M6Tyic0lo65pkoKGAPRngktZBQDZBYmU2aWArnlAWiDytrldnwI/qlH
         XF+7Z1kNKLSBbzmR3nm0kiKIuuVBIxT7xiA1jRjel/sxyaGoE8WXljKjNPwyT1bLrIqU
         npogKcJ1RzkUjyw69hXB+bngxoVdtTCbzysSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=cvXPyA7TQKzRveIKWhj2GNHzCO5jNQev73zyUeH581xHuiSOBN9Mk8SmXE0iKL0UHJ
         VMVSihBTTYJg4m3C0uKXznhqvCLPJYDY9TifID06iT1VytXZ1z3ZRXrnTQ914bDT91AQ
         ohLOBtsuU5KvNSUj7YjG58nFx2hwiBRP0oh/k=
Received: by 10.216.0.83 with SMTP id 61mr1454253wea.170.1241773034135;
        Fri, 08 May 2009 01:57:14 -0700 (PDT)
Received: from ?192.168.87.36? (bristol.offices.netsight.co.uk [213.133.64.253])
        by mx.google.com with ESMTPS id j8sm1726889gvb.11.2009.05.08.01.57.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 01:57:12 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118591>

Hi,

I'm experiencing a problem with local branches and the git svn rebase  
command. I'm using git 1.5.5.1. Basically, I can no longer 'git svn  
rebase'.

I've been doing all my work on a local branch 'work' which I've been  
successfully using with a remote SVN repository successfully for  
weeks. I yesterday needed to do some disruptive work, so I committed  
everything on my 'work' branch, created a new branch 'onlinehacking',  
checked it out, did some work on that, and committed. I then tried to  
check out my original 'work' branch and run a git svn rebase to pull  
down my colleagues' work. Here's what happens:

bash-3.2$ git branch
   dan-bf-merge-lc
   master
* onlinehacking
   work
bash-3.2$ git status
# On branch onlinehacking
nothing to commit (working directory clean)
bash-3.2$ git checkout work
error: Entry 'online.cfg' not uptodate. Cannot merge.
bash-3.2$ git checkout -m work
Checking out files:   8% (169/2051)
   ... snip ...
Checking out files: 100% (2051/2051)
Checking out files: 100% (2051/2051), done.
M	online.cfg
M	products/online/Formulator/CREDITS.txt

    ... snip ...

M	products/online/Formulator/www/StringField.gif
M	products/online/Formulator/www/TextAreaField.gif
Switched to branch "work"
bash-3.2$ git svn rebase
Cannot rebase with uncommited changes:
# On branch work
nothing to commit (working directory clean)
status: command returned error: 1

bash-3.2$ git status
# On branch work
nothing to commit (working directory clean)
bash-3.2$ git diff
bash-3.2$ git diff --cached
bash-3.2$

I'm still pretty new to git, so I'm sure that I've done somthing  
stupid, not git. I tried adding the -m option to 'git checkout work'  
as advised by the git-checkout man page, but git diff doesn't show any  
changes afterwards.

What have I done wrong, and how can I pull latest changes from svn  
into my work branch?

Thanks,
Dan
--
Dan Fairs <dan.fairs@gmail.com> | http://www.fezconsulting.com/
