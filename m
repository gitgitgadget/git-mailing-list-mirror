From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-ls-files -l
Date: Tue, 30 Dec 2008 22:47:39 +0100
Message-ID: <200812302247.40872.jnareb@gmail.com>
References: <87abae6hbn.fsf@jidanni.org> <m3wsdiaptg.fsf@localhost.localdomain> <alpine.LFD.2.00.0812301226110.3082@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 22:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHmRF-0002qn-GU
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 22:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbYL3VqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 16:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbYL3VqO
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 16:46:14 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:46208 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYL3VqM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 16:46:12 -0500
Received: by ewy10 with SMTP id 10so5716734ewy.13
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 13:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=syCErtkUhfvk2NgMBvpOAqnX+7FRS0qWsqzguAT5EXI=;
        b=HChmM7SgB6fvr388J0qH4cDI3fCL5iRhEWo9eYTgvpMwQOMEIVzIvQsa9SL6VVp3CJ
         HadVgCz+HamOulaJmhIzCqL5Ru2RjjhXoGFkqOebfQuHhrlEM4Qiqj9WRR42UR289MtK
         FQwyyqIXato+cS6m8UEyTzgWWV0Y2LchwTqoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mO81FZP5HV4GZ6WgWGrJzArSfc/rIx24iTMbEp7ZAFDl1LGAK05vwakkxq6GMGe9VK
         s5rqW/1zAL6sFduOH/K+KkCY4iF0nNzMpxADw864yHTzAUlKTdJnPbNu8baimB4DhSov
         l9/sqzuahjl82SM0fmqGP1wHhG69LV13cYf9g=
Received: by 10.210.45.17 with SMTP id s17mr17894077ebs.69.1230673570165;
        Tue, 30 Dec 2008 13:46:10 -0800 (PST)
Received: from ?192.168.1.11? (abwv44.neoplus.adsl.tpnet.pl [83.8.245.44])
        by mx.google.com with ESMTPS id i7sm52101134nfh.53.2008.12.30.13.46.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Dec 2008 13:46:09 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0812301226110.3082@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104211>

On Tue, 30 Dec 2008, Linus Torvalds wrote:
> On Tue, 30 Dec 2008, Jakub Narebski wrote:
> > 
> > I think it would be easy to add '-l' also to git-ls-files. Please
> > remember to provide size only for blobs, as provoding size for trees
> > would make it harder to change to future packv4, where tree objects
> > would be stored deconstructed.
> 
> Personally, more than "git ls-files -l", I've occasionally wanted a real 
> "git ls" that really looks more like "ls". That includes:
> 
>  - turning a list of files in a subdirectory into a "directory" entry 
>    (which is not very natural for "git ls-files" as an index operation, 
>    since the index is fundamentally flat).
> 
>  - yes, adding "-l" as an option, but really showing the stat information. 
>    Right now, you can do "git ls-files --stage", and it will show a kind 
>    of extended information, but while it shows the mode, it doesn't show 
>    the owner/timestamp/etc parts of the index, and those are sometimes 
>    interesting.

Good idea.

I guess we could put shortened sha-1 of object in place of owner and
group info which is not present in index, and perhaps stage number
instead of number of hard links. I wonder a bit about formatting
timestamps, if to follow "ls -l" format there...

> Btw, the "ls-tree -l" format is not nice. Don't use it as a basis 
> to pattern "ls -l" (or if you want to just extend ls-tree, whatever).

Well, "ls-tree -l" is just "ls-tree" with size added. You would
probably want to use "git ls-tree -l --abbrev" instead for human
consumption.

-- 
Jakub Narebski
Poland
