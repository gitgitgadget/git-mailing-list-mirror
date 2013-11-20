From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Check out doesn't set x-flag on CIFS
Date: Wed, 20 Nov 2013 11:51:44 +0100
Message-ID: <CABPQNSZDSRf9LSeBHBJ46pbBGsDwybTPkyJ2esqvoc0UHPifKA@mail.gmail.com>
References: <loom.20130529T161408-317@post.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Andre Esser <andre.esser@geneity.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 20 11:52:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj5OY-0000Bv-Qc
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 11:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab3KTKw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 05:52:26 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41881 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab3KTKwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 05:52:25 -0500
Received: by mail-ie0-f174.google.com with SMTP id at1so7278038iec.19
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 02:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=j3vCrBIupmXUxcu/MxSbKGoymO1VF7GQ1vGKGbca+Zk=;
        b=04E+BZ0qfZl99WVU8UIIEUZ+IAWRGMF8ASNKw2HzDl+NiBnYMiBnL075pnrgG6vYxA
         OAhnXow9wiOaTcpRGf28zkIEwhgbL+wnQwyFhTcX4LLCR/po9bYWHml2qs9nO1cn5Twx
         iISbak06v7JUfGd68cQfM4gV4ft80Zlo/vy1myRWHQFq1NWQs5tlYy2j7P0tuKP1K3xf
         mkjLwMaZWiIUnqilpSt7gcZc71RnxoJ8e3wCDXcxF96c+QRiTlpRhobHQNuByrPElsly
         94F72MvaW3/toT0p2JssUUtHRYMomDWfoS1ky4/uAplZjjcCyzMY5XM7Zidh8Rvyy7Pl
         gmqQ==
X-Received: by 10.50.17.9 with SMTP id k9mr464282igd.3.1384944744919; Wed, 20
 Nov 2013 02:52:24 -0800 (PST)
Received: by 10.64.249.33 with HTTP; Wed, 20 Nov 2013 02:51:44 -0800 (PST)
In-Reply-To: <loom.20130529T161408-317@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238070>

On Wed, May 29, 2013 at 4:16 PM, Andre Esser <andre.esser@geneity.co.uk> wrote:
> Hello,
>
> When on a CIFS filesystem a git checkout does not replicate the executable
> flag from the repository:
>
>   $ git clone git://git/abettersqlplus
>   Cloning into 'abettersqlplus'...
>   remote: Counting objects: 522, done.
>   remote: Compressing objects: 100% (342/342), done.
>   remote: Total 522 (delta 166), reused 522 (delta 166)
>   Receiving objects: 100% (522/522), 82.40 KiB, done.
>   Resolving deltas: 100% (166/166), done.
>   $ ls -l abettersqlplus/absp.py
>   -rw-rw-r-- 1 aesser geneity 45860 May 29 14:46 abettersqlplus/absp.py
>
>
> Subsequently git status reports the file as changed:
>
>   $ cd abettersqlplus/
>   $ git status
>   # On branch master
>   # Changes not staged for commit:
>   #   (use "git add <file>..." to update what will be committed)
>   #   (use "git checkout -- <file>..." to discard changes in working
>   directory)
>   #
>   #    modified:   absp.py
>   #
>   no changes added to commit (use "git add" and/or "git commit -a")
>
>
> If I set the x-flag manually, all is well:
>
>   $ chmod +x absp.py
>   $ git status
>   # On branch master
>   nothing to commit (working directory clean)
>
>
> This problem doesn't occur on ext3 or NFS file systems. Client is Ubuntu
> 12.04 with git version 1.7.9.5. CIFS is exported from Ubuntu 12.04 with
> Samba version 3.6.3.
>
> Since git recognises the x-flag on this CIFS file system, shouldn't it also
> be able to set it on checkout?
>

You might want to check out the core.filemode configuration variable.
