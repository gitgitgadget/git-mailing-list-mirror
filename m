From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 22:49:55 +0100
Message-ID: <200704262249.57238.andyparkins@gmail.com>
References: <200704261238.51234.andyparkins@gmail.com> <200704262228.46864.andyparkins@gmail.com> <7vfy6mstsd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 23:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBr5-0002qm-NV
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbXDZVuS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbXDZVuR
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:50:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13602 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228AbXDZVuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:50:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so704520uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 14:50:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=deecqTmBBBNdaA1uWQyWh/YF1pOPVXM9Zu9VcUEuACpEv7Rd0tgbrpZvVTaty4+6IQ9Agc9ddyVSBm93CP5k0ZGzNPkeC1AGhDDNgQmxGpez8nS5BCXuitYOleTaotHRkowusd5vY13Igsfm3safjJ59ts7KVbHKM08aXe2IbNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XePR1SvL8ih8xGAn3DJ/8CAHLeWI1LRu4U/nVij6w9tmPluKsbq6gRXg7KW8SKGqooFW2lpQJIPwySX8twgU0SbcroerdDVTy6Xw3yMv4sPMedE78LB3yXqBcUvvf90DEBBRCLAP2vuZK8yUiJ0FO63VYwWg9D1I6/18vnNtIws=
Received: by 10.67.27.15 with SMTP id e15mr2481881ugj.1177624211884;
        Thu, 26 Apr 2007 14:50:11 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id k1sm26402ugf.2007.04.26.14.50.10;
        Thu, 26 Apr 2007 14:50:10 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vfy6mstsd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45667>

On Thursday 2007, April 26, Junio C Hamano wrote:

> I think older tools do not expect to find anything but tree or
> blob in a tree object to begin with.  Now your experimental
> repository has a commit, which they do not expect to see and I
> think they will be unhappy.
>
> If you replace the commit objects in your trees with a new type
> of object 'gitlink', your older tools will have exactly the same
> problem, won't they?

I'm not sure, what I imagined was at the moment we have

160000 commit 0fbbf28b0eefb1546d02aabb43fa2de9b9f6d5f2  submodule

The hash here is a commit hash in another repository so obviously all 
the git tools from older versions instantly bomb out saying they can't 
find that object.

If, on the other hand we had

160000 blob b1819880ec7ead7354c6d1c650ea5faf9c6d629b  submodule

$ git-cat-file -p b1819880ec7ead7354c6d1c650ea5faf9c6d629b
0fbbf28b0eefb1546d02aabb43fa2de9b9f6d5f2

Obviously the current gitlink stuff would need rewriting to use this 
extra layer of indirection, but all the old tools would just see this 
as a blob and simply treat it as a file containing that hash.

I'm kind of hoping that older versions of git would fail gracefully on a 
160000 file type.  If that isn't the case, then this is no solution and 
there'd be no point going to any effort.




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
