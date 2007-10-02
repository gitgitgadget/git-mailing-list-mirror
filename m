From: Dan Zwell <dzwell@gmail.com>
Subject: git-diff not showing changes (corrupt repo?)
Date: Tue, 02 Oct 2007 13:55:16 -0500
Message-ID: <47029414.3080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 20:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcmuU-000450-PL
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 20:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbXJBSzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 14:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbXJBSzt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 14:55:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:57962 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbXJBSzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 14:55:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so3016109nze
        for <git@vger.kernel.org>; Tue, 02 Oct 2007 11:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=TLQTj50fBpS5nt+HK6+DCbcVROuAegjm/VnIEEHFDGE=;
        b=Td5wv+BqtHfhMjSXaHgNsrE6B5gZJUUHhTLy33gLkHNpxa5pOpIA1cW8QKYLaUGNfk1Vc+Q87+oJevZx+N6VxpSwK0JhKLzE6NPXPkcu6kXtBeFeN2W+n4Ms8aDaRBps8ghIea2etxrGlG+8G4Efn1ilvaFntieU28l8oPTzk1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=er3HhJTQ/5vPKHkv81TU2fAS9LYg+mg2x+R0ivBAgGcnG0k2rnM7Ez+9XsrQXi/ggN9v+TSTkRfs9gBDyj+T1mz9Vlc65Ui7zVPHgWBLa8H11LoGY6coXyiL9vmTXZVIgS1VqvQBRT1ZGYQdzw9fJ8NUhir+f3RhtdUe0LeGAnU=
Received: by 10.65.133.8 with SMTP id k8mr5623798qbn.1191351347500;
        Tue, 02 Oct 2007 11:55:47 -0700 (PDT)
Received: from ?143.44.70.185? ( [143.44.70.185])
        by mx.google.com with ESMTPS id 19sm2855354nzp.2007.10.02.11.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Oct 2007 11:55:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070922)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59710>

Hi,
A small personal git repository has started lying to me about changed 
files. git-diff sometimes tells me that the index has no changes from 
HEAD, while other commands (git-status, at least) seem to tell the 
truth. It is the same after I commit the new changes--at that point, 
"git-diff-tree HEAD^ HEAD -p" spits out a nice patch, but "git-diff 
HEAD^ HEAD" gives nothing.

I have tried git versions 1.5.1.6-1.5.3.3, and they all act the same, so 
I think the repository is corrupt. Does sound familiar to anybody? If 
this is user error (for example, "git-reset --hard HEAD^" on a branch 
that had already been pulled into another branch), I can restore from a 
recent backup and redo some changes, but I would like to help 
troubleshoot this behavior if it is a git bug. Is this a known behavior? 
git-fsck doesn't reveal anything amiss, besides dangling objects. Does 
anybody know anything about this situation or what can cause it?


Example of behavior:

$ git status
# On branch bak_linear-checks3
nothing to commit (working directory clean)
$ echo "test" >> Makefile
$ git status
# On branch bak_linear-checks3
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   Makefile
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git diff
$

Thanks,
Dan
