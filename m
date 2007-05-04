From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: repack: handling of .keep files
Date: Fri, 4 May 2007 19:24:50 +0200
Message-ID: <81b0412b0705041024i43d7fc5ah1967d6a6192dc6ee@mail.gmail.com>
References: <81b0412b0705040225p26679dbib6a1261a1a43ee67@mail.gmail.com>
	 <7vy7k4ud3d.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040342p4fed3a4bnee92cce6b5fb6b9@mail.gmail.com>
	 <7vslacttij.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 19:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk1X4-0002DB-9b
	for gcvg-git@gmane.org; Fri, 04 May 2007 19:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbXEDRY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161306AbXEDRY6
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 13:24:58 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:8326 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161280AbXEDRYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 13:24:51 -0400
Received: by an-out-0708.google.com with SMTP id b33so902076ana
        for <git@vger.kernel.org>; Fri, 04 May 2007 10:24:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NpHQQWYdgv0pIkzl9vactiikA0R9TEvi290PG/D+KRP8jPs4JX0XZresMaP5EyQ4FKzfVztZ/Ee30JAnWSIrfeiDoBrBvaSjVrITr+nYgwciA7h5eUEU9SpwzGhxZbYwz1ukFop7XroRpN95jptxsh/NjVjRvyOT7dfTdO5NWK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P07QgpfLAmRry2JqUh0CwPmbTafWUCCJmDnfCTfoLRQ80ixppx8mMMRIdWG+cAYoWiGitjQB+jtp6M8T01NpP92ifpTgniAx1Fu1ttwQW4XPAMzV2V1LWSoEGn3qQ+T1DWq5aq5Z7YJne76IEKCEF9v+mCxRu8Al0ZLE7W58S0I=
Received: by 10.100.107.2 with SMTP id f2mr2961988anc.1178299490559;
        Fri, 04 May 2007 10:24:50 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Fri, 4 May 2007 10:24:50 -0700 (PDT)
In-Reply-To: <7vslacttij.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46195>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> > Still, git-log shouldn't crash (nothing should, of course).
>
> Honestly, I think that's borderline.  If you "dd if=/dev/random
> of=/dev/hda", should the kernel keep going, perhaps gracefully
> declining access to the filesystem on that drive?

e2fsck has a test somewhere which randomly corrupts a partition
and then lets the program fix it.
All kind of corruptions happen, we will have to deal with them.
Especially if this crash is so simple to reproduce.

> case of temporary pack I do not think there would be a risk of
> filename collisions, I think it makes sense to use either
> GIT_DIR or GIT_OBJECT_DIRECTORY instead of the working tree.
>
> I do not know pros-and-cons between .git/ and .git/objects/;

These are settable separately, so theoretically you can end
up with .git and .git/objects being on different filesystems.
Atomic rename wont be possible than.
