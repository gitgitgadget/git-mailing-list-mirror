From: "Mario Pareja" <mpareja.dev@gmail.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 10:14:07 -0400
Message-ID: <94c1db200809230714k6b007919yfd8ad1b86cbcd385@mail.gmail.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
	 <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
	 <48D8CFF1.8030403@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boaz Harrosh" <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:15:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki8fg-0000kN-7R
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYIWOOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbYIWOOK
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:14:10 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:59324 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbYIWOOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:14:09 -0400
Received: by gxk9 with SMTP id 9so4323208gxk.13
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dEIsc6y2qnDVQbcjeLsl2fOkf+aRR1UqafEeRcCUdaA=;
        b=o/p3UvJxufUk3RfIezs8m3ADehzZVqH+pze2GqJq7jYX5IML1KxU3KQqIf+hSt4Ncu
         HGa5m85Iv4DOiK3F6UPnO+bnpPpAhJYi5Rta+s8q+0wuENlmpj6OcpEOAlbDEvrdQsLa
         78ZGAfb5245MFT5wiunM4HD0oOkN5tW/p5crs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iL+5UKGtQLUdid4Mo+tUTwERaj7/rwgL10m7qwTfjdLQAjysyMuBTH55BR+ouX0LFr
         x0Z8FhnKCT49yJc2XbRAdwdSc+19zCxY7MD+bOduQ0bBCGxqh+w7V7kqNL9vLo6Zut8b
         ppFu73o8aWALbrpUIH+58rABAXq6T9ziDwsQQ=
Received: by 10.100.214.15 with SMTP id m15mr4381104ang.51.1222179247085;
        Tue, 23 Sep 2008 07:14:07 -0700 (PDT)
Received: by 10.100.207.17 with HTTP; Tue, 23 Sep 2008 07:14:07 -0700 (PDT)
In-Reply-To: <48D8CFF1.8030403@panasas.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96568>

> It should be easy for a company to set a policy where a couple of scripts
> must be run for particular type of files. Given that, the implementation
> of such scripts is easy:
>
> For every foo.bin there is possibly a foo.bin.lock file.
>
> Lock-script look for absence of the lock-file at upstream then git-add
> the file (With some info that tells users things like who has the file).
> If git-push fails, since I'm adding a file and someone already added
> it while I was pushing, then the lock is not granted.
>
> Unlock-script will git-rm the lock-file and push.
>
> In both scripts mod-bits of original file can be toggled for
> read-only/write signaling to the user. (At upstream the file is always
> read-only)
>
> This can also work in a distributed system with more then one tier of
> servers. (Locks pushed to the most upstream server)
>
> Combine that with git's mail notifications for commits and you have a
> system far more robust then svn will ever want to be
>
> My $0.017
> Boaz
>

This is a reasonable approach to obtaining the desired functionality.
Unfortunately, I have not seen any third-party packages implementing
such a feature.  It seems to me the problem is general enough to be
solved once rather than requiring organizations wishing to use git to
implement an in-house locking system. It simply creates more friction.
Perhaps, when I have the time, I will come up with something others
can use.  For now, unfortunately, it seems I am out of luck?

Mario
