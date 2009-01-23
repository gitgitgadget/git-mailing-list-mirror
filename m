From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: lineups with GIT (or dealing with directory renames)
Date: Fri, 23 Jan 2009 09:25:30 -0800 (PST)
Message-ID: <m3mydix7bq.fsf@localhost.localdomain>
References: <1232610882661-2196604.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: outre <spoony.sob@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:27:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPo2-00052d-De
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbZAWRZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZAWRZe
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:25:34 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:36709 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZAWRZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:25:33 -0500
Received: by ewy13 with SMTP id 13so3802358ewy.13
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DmA9xSsIvE2rnL3xAAVWFPE9zILmS/L4kNRxye56bwA=;
        b=aVAxABYfxbYbjkKwE2b3HanQu3gFUnbz0fQHHBn+brfiSIGeIBP4sF6c8Az6OVfNbS
         GfKkbuK7sLeWdx9qyuHtghnKcuNtI0v1HiWriP23eoKjfcGC1wEfFQjQzkMW6zSNTOSw
         +2zc+wHhiNDVXXMLLBpMddtbkm4oA6yFFlMn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BV7txObEKyOjcDniVsNuwL6eQxXtvIstXwlG+9qKR6xuZKw46XYZ49bs00gncvAvQj
         860mpU51b/ALx4EDZ1BKF17iNsY77y328uU44aaq62BAwhUquLt1IvVBKyvpUck9GyS5
         Q6Ar4UFaqSVY6Ium4IyXFxQC5SWZBEJw5v9yc=
Received: by 10.86.92.9 with SMTP id p9mr2216369fgb.15.1232731531260;
        Fri, 23 Jan 2009 09:25:31 -0800 (PST)
Received: from localhost.localdomain (abwn47.neoplus.adsl.tpnet.pl [83.8.237.47])
        by mx.google.com with ESMTPS id l12sm4709667fgb.48.2009.01.23.09.25.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 09:25:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0NHQ25b018098;
	Fri, 23 Jan 2009 18:26:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0NHQ1q0018095;
	Fri, 23 Jan 2009 18:26:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1232610882661-2196604.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106892>

outre <spoony.sob@hotmail.com> writes:

[...]
> I tried using "git mv" command and it somewhat solved the problem. After I
> cloned the devel line-up, I used "git rm iWeb.local iWeb.test".
> And now if I edit a file in iWeb.local and do a pull to iWeb.test this file
> gets properly updated while preserving the difference between
> the folder names. But if I add a new file to iWeb.local, and then do a pull
> I get  iWeb.local folder added together with the 
> new file to the testing line-up.
> 
> I was wondering if it is intended behaviour for GIT. And if it is may be
> someone can point me to a better way to setup two line-ups using
> GIT.

I know nothing about line-ups, but the behaviour wrt. wholesame
directory renames is _known_ behavior of git. If one side renames
directory, and other side creates new files in old-name directory,
the old-name directory gets recreated during merging.

I wrote _known_ and not _intendend_ because this can be changed;
there were some patches on git mailing list (I don't know what
happened to them; I think the development stalled) that added
detecting wholesame rename of directories, based on heuristic
content and filename similarity based detection of renames for
individual files.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
