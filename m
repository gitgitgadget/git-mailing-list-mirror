From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 8 Feb 2009 17:51:16 -0500
Message-ID: <76718490902081451xd953e84y33de64cc82c1da42@mail.gmail.com>
References: <20090208042910.19079.qmail@science.horizon.com>
	 <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
	 <76718490902080950r798ca02es4e560da35e499046@mail.gmail.com>
	 <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 23:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWIW5-0003z3-Dz
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 23:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZBHWvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 17:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZBHWvS
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 17:51:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:25949 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZBHWvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 17:51:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1536743rvb.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 14:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OefwZxl82RY3DadR6I4BOouhH9T2LY8/KADGb/FWS30=;
        b=ITYoLnzflASsjANyfaKOhSgr2FW88QuXW0I1x61jFL7/i8xJUiCdrgG4pYvSuWZnYy
         zSt6oMFkbGdQBxZRtROl1D37gXxuvi3VFOkJMbm8JzRb1eF7XR+hgrihnX7X4VCEtE+E
         182tc3IWFYJyklh14AspjzOC5jdY3SltmD+5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TLdgUaBpOjfQndQRCVPnAQ+laQjtX4bEO4RW3kmGLR8RUBx49XMpi8xrbVDzklzPfU
         MDH1XjPYG50f/CY5eH7bxUp8huGrmQNK0BabXwIdRE44NaGx1o8gzYfoCzMgno+HIIfj
         mAzO6hpWl7xBrBBLCg50VerUkDPpYfYCJVuac=
Received: by 10.141.37.8 with SMTP id p8mr1720373rvj.18.1234133476744; Sun, 08 
	Feb 2009 14:51:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902082149380.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109023>

On Sun, Feb 8, 2009 at 3:54 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Just to make it clear: if you have merge conflicts on the remote end, you
> will get into trouble.
>
> I do not know how Mercurial handles this (I am sure you will send a
> page-long mail illustrating it), but in my humble opinion, there is _no_
> way to handle this except if you have shell access to the remote
> repository/working directory.

I apologize for my prior reply. I understand you find any mention of
Mercurial offensive. But if you had paid attention, you would have
noticed that Mercurial did not attempt to merge. Rather, it created a
new branch head in the remote repository.

The equivalent in git would be for the user to do something like this:

satellite:~/repo (master)$ git push origin
! [remote rejected] master -> master (branch is currently checked out)
satellite:~/repo (master)$ git push origin master:satellite-master
 * [new branch]      master -> satellite-master
satellite:~/repo (master)$ ssh origin
origin$ cd repo
origin:~/repo (master)$ git merge satellite-master

> No matter if you suggest leaving merge conflict, a detached HEAD, or
> "read-tree -u -m HEAD" (i.e. trying a simple merge with the working
> directory): _all_ of them are unsafe.

I'm not suggesting any of those things. I was just illustrating what
another DVCS does to see if there was anything that might be learned
from it.

Clearly users are confused about pushing into a checked-out branch.
Maybe making that impossible by default will be enough.

j.
