From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 11:58:03 +0100
Message-ID: <200705021158.04481.andyparkins@gmail.com>
References: <200705012346.14997.jnareb@gmail.com> <200705020955.04582.andyparkins@gmail.com> <Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 12:58:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjCXP-0007PN-Rv
	for gcvg-git@gmane.org; Wed, 02 May 2007 12:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993039AbXEBK6T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 06:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993044AbXEBK6T
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 06:58:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:21616 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993039AbXEBK6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 06:58:17 -0400
Received: by ug-out-1314.google.com with SMTP id 44so222910uga
        for <git@vger.kernel.org>; Wed, 02 May 2007 03:58:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UGV1tiy5WO/reYWvUFuUmSf3WDjep6toQ8/bQes+UeyXkdumTTjP4T4fd5CvmRUo+RbBAP99h2vlmLn/iUqC1j2c504d25H39g2sJizoQJ0dGF3R+aJpnzQsAK3IaQf3Xf5AOq2CQyJldhl513t/Tkn0zz0yZJcNbkUEuzYlOpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=F1+IDtBT6zEDMRc/qAv+LSxKBTHbujvoLzmXqg585nofwaoogIKPApCkclVVHUj0iuqdN1Jd59J29fz5vhlILLxPCTg8ksC7bHH7iG23sx/IxEm38fzpieJR2QbYMObfGHPoilFJDla5puOFqlDCpixc0eHzcMxpuR+98OEJcCk=
Received: by 10.82.147.6 with SMTP id u6mr1177243bud.1178103496482;
        Wed, 02 May 2007 03:58:16 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y37sm123925iky.2007.05.02.03.58.09;
        Wed, 02 May 2007 03:58:13 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705021046230.2425@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46012>

On Wednesday 2007 May 02, Julian Phillips wrote:

> A fully packed clone of the OOo git repo was indeed 1.3G, and the entrire
> checkout + repo was indeed 8.5G (using git 1.5.1.2).

I'm more confused now then.  I assumed the figures were accurate, but they 
cannot be:

                               CVS      git      SVN
Size of data on the server     8.5G     1.3G     n/a
Size of checkout               1.4G     2.8G     1.5G

I don't doubt the 1.3G on the server - and assume that is fully packed.  The 
checkout sizes are suspicious though.  Is that 2.8G packed?
 - If it is, then we can deduce that this is a repo+source size, since the
   server is packed size+0 therefore the size of the source tree is
    2.8G - 1.3G = 1.5G
   In which case the other figures are wrong:
    - CVS checkout is 1.4G - impossible, the source tree is 1.5G. And where is
      the overhead of the CVS directories which would make it more than 1.5G?
    - SVN checkout overhead is always _at least_ the size of the source tree 
      because it keeps a pristine copy of HEAD.  If the source tree is 1.5G,
      then this figure should be at least 3G.
 - If it is not, then we're back to "I don't believe that git was packed"

Something smells fishy here - either the source tree size is included in some, 
but not in others or the git repository wasn't packed.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
