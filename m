From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/2] run_diff_{files,index}(): update calling convention.
Date: Sat, 10 Feb 2007 09:02:15 +0100
Message-ID: <e5bfff550702100002y3929c50mfb99b8da44c9c82b@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
	 <7vr6szt71j.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550702091235x74e44362gad5b9b6076a5ea53@mail.gmail.com>
	 <Pine.LNX.4.64.0702091253120.8424@woody.linux-foundation.org>
	 <7vmz3mq394.fsf@assigned-by-dhcp.cox.net>
	 <7vejoyq330.fsf@assigned-by-dhcp.cox.net>
	 <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"GIT list" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 09:02:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFnBf-000342-7F
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 09:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbXBJICR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 03:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbXBJICR
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 03:02:17 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:4686 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbXBJICQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 03:02:16 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1170386wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 00:02:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n7pkJiax3l3OOlTgM7qES0L8mu/beeNM1rcugTj7PnUEmEfxXrLQohn1bqwlkvmHaDFLZJ5b4MJiCtvO53Nua4OdHmVAIg/bM6PxoYpzpLhjIsel6ptJALZLbip4xoeTRnYuIMtPGVThgUTm8g7bhZfI/MIryLUpkDThmwu9P2A=
Received: by 10.114.193.1 with SMTP id q1mr5378936waf.1171094535726;
        Sat, 10 Feb 2007 00:02:15 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 00:02:15 -0800 (PST)
In-Reply-To: <7vy7n6ohc3.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39208>

On 2/10/07, Junio C Hamano <junkio@cox.net> wrote:
> They used to open and read index themselves, but they now expect
> their callers to do so.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---

Thanks this works for me, while the other workaround seems to have issues:

bash-3.1$ git status
fatal: unable to create '.git/index.lock': Read-only file system
bash-3.1$ git update-index --refresh
fatal: unable to create '.git/index.lock': Read-only file system
bash-3.1$ git runstatus
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   .gitignore
#       modified:   README
#       modified:   exception_manager.txt

  ------ cut -------

#       src/object_script.qgit.Release
#       src/object_script.qgit_bin.Debug
#       src/object_script.qgit_bin.Release
#       start_qgit.bat
no changes added to commit (use "git add" and/or "git commit -a")


bash-3.1$  git-runstatus --refresh
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       AAA_convert.xls.lnk
#       Cygwin.lnk
#       Qt 4.2.2 Command Prompt.lnk
#       bld.bat
#       cmd.txt
#       explore2fs.exe.lnk
#       qgit.lnk
#       src/object_script.qgit.Debug
#       src/object_script.qgit.Release
#       src/object_script.qgit_bin.Debug
#       src/object_script.qgit_bin.Release
#       start_qgit.bat
nothing added to commit but untracked files present (use "git add" to track)
bash-3.1$

Running 'git runstatus' alone shows _all_ the repo files, although are
not modified and not touched. With 'git runstatus' --refresh'
everything seems ok.

Please could you apply your patch before 1.5 so that I can update qgit
and change prerequisite git version to 1.5.

Thanks
Marco
