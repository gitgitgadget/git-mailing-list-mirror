From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] init-db: Store current value of autocrlf
Date: Mon, 24 Mar 2008 03:16:34 +0300
Message-ID: <20080324001634.GC25381@dpotapov.dyndns.org>
References: <alpine.LSU.1.00.0803101327390.3975@racer.site> <bdca99240803100611s3c8b3b9djb1b993c9fbad712@mail.gmail.com> <alpine.LSU.1.00.0803101448430.3975@racer.site> <cb8f4255-2bf8-4489-aeb0-c18d6e932342@s13g2000prd.googlegroups.com> <ab311292-809f-4e45-a19d-a600c2333ab6@a23g2000hsc.googlegroups.com> <alpine.OSX.1.00.0803221036230.7618@cougar> <7vzlsqfe2h.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.OSX.1.00.0803231032180.7541@cougar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdaNL-0005hT-TZ
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500AbYCXAQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757479AbYCXAQm
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:16:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:25831 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500AbYCXAQj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 20:16:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2687034fgb.17
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=8sOaYgZCNtmMnDaTLbROe40+MQPUp7orKp8EwFzRMDU=;
        b=gdXsW2iOL5ZZYrW9O9fMpOm9rXhZX7GUc1ZsOBLD/YH9yrm+iQeRwPkBK/X/771xPFaEa9lvotg6HxB5SSB6jj5X5czqFrR1YA6kuf2YCO/rOxLH18N2oLjd5sPyIRI/Ccwpxh+VwUVPKMlxDuD1Wq1syw3Mo4x0sYMr7y6N6Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oeki72HVmYPFSgVoiX1b1RbAvBxgj7FCaAj7zhTB38YPhOcVDyy6/SwamaFW1QPbdLblA2pdSC3PU1o+MAS3dgJIjThR2E6p1IFVUUtILxIdEwkoRIBcakQipJSgSl1wau+s4K/btEku+nMpt6FX+Hal24MLiYuA7+PJqrGM19k=
Received: by 10.82.170.2 with SMTP id s2mr15553108bue.30.1206317798236;
        Sun, 23 Mar 2008 17:16:38 -0700 (PDT)
Received: from localhost ( [85.140.170.114])
        by mx.google.com with ESMTPS id b17sm9755217fka.4.2008.03.23.17.16.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Mar 2008 17:16:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.OSX.1.00.0803231032180.7541@cougar>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77979>

On Sun, Mar 23, 2008 at 10:34:13AM +0100, Steffen Prohaska wrote:
> Storing the current value of autocrlf to preserve it for this repository
> even if the global setup changes is a good idea.  Changing autocrlf
> later is tricky because the work tree's line endings depend on the
> settings during checkout.  Therefore, it makes sense to preserve the
> value of autocrlf that exists during the first checkout.  In this
> regards autocrlf is different from, for example, author, because author
> can be easily changed later without requiring any conversion of existing
> files in the work tree.
> 
> This commit modifies the initialization of a new repository to store the
> current value of autocrlf.

NAK

While I agree that preserving autocrlf may be a good idea, I don't like
that the idea of making an exception for autocrlf and treating the global
settings for it differently than for other variables -- as something that
should be copied on init. We have templates for that, so autocrlf should
be placed into templates/config and then it will be automatically copied
when a new repository is created. I have tested that now, and it works.


Dmitry
