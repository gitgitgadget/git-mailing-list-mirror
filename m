From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Wed, 26 Jan 2011 13:40:09 -0800 (PST)
Message-ID: <m3y6679wfy.fsf@localhost.localdomain>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
	<AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
	<20110121222440.GA1837@sigill.intra.peff.net>
	<20110123141417.GA6133@mew.padd.com>
	<AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>,
	Eric Montellese <emontellese@gmail.com>,
	Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiD69-0003Z4-1I
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754229Ab1AZVkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:40:14 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38824 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab1AZVkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:40:12 -0500
Received: by wyb28 with SMTP id 28so1413204wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=6HRFYEL9QZnxWqlkWfw+UzTec0OoCNgiyNTqmfZjlO8=;
        b=fB4lCKdqblibFIg6mqR0gMT1q1WZznjLp7pvcH/Yb7zN8iekccUuBOxuQM3LFeJ2lo
         IXuKuhwPWEeahhXHcVXuB2ZJsPJfdKev5vQxoP2V1SHh0GrEoNih01J4WkLL4JOKGDrM
         pPRBVq/ilTXX9bAP7aMq1CrWFAkI1kd7VIBjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=X1mhjo/muo1isaYc4pidLd4I3eLKnq7QhkNDCKQvwic3ghCmfCvPzqHWNP+iCnF6bn
         b69zH8mPHqoMu3uafg8W9nIZdCuHvxtKrJAnAp/LRnaidJZ18LO3XDbvLeWYHN9b9oTs
         rVQ0Ts+DYlXeCuwWK2J9F/9BTQEXa6WiXe6MQ=
Received: by 10.227.72.199 with SMTP id n7mr130383wbj.61.1296078011365;
        Wed, 26 Jan 2011 13:40:11 -0800 (PST)
Received: from localhost.localdomain (abve138.neoplus.adsl.tpnet.pl [83.8.202.138])
        by mx.google.com with ESMTPS id f27sm408136wbf.1.2011.01.26.13.40.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:40:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0QLdbRb009528;
	Wed, 26 Jan 2011 22:39:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0QLdEeW009523;
	Wed, 26 Jan 2011 22:39:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimE+s81Xbj4snNX0WWxG8x=qSwaQWfK+08+1Zy+@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165554>

Scott Chacon <schacon@gmail.com> writes:

> Sorry to come in a bit late to this, but in addition to git-annex, I
> wrote something called 'git-media' a long time ago that works in a
> similar manner to what you both are discussing.
> 
> Much like what peff was talking about, it uses the smudge and clean
> filters to automatically redirect content into a .git/media directory
> instead of into Git itself while keeping the SHA in Git.  One of the
> cool thing is that it can use S3, scp or a local directory to transfer
> the big files to and from.
> 
> Check it out if interested:
> 
> https://github.com/schacon/git-media

Could you please add short information about this project to the
https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
page, in the "Backups, metadata, and large files" subsection?
git-annex is there...

Thanks in advance.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
