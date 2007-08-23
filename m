From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 21:48:09 +0100
Message-ID: <b0943d9e0708231348o28d870fem656330f89f248578@mail.gmail.com>
References: <20070823092254.GA5976@kroah.com>
	 <20070823180633.GA24530@filer.fsl.cs.sunysb.edu>
	 <20070823184758.GB17601@kroah.com>
	 <20070823185608.GC1608@filer.fsl.cs.sunysb.edu>
	 <b0943d9e0708231336h3a92de22oc025c69b9209da9a@mail.gmail.com>
	 <20070823204202.GA10644@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Greg KH" <greg@kroah.com>, git@vger.kernel.org
To: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJbZ-0000Lz-EI
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759969AbXHWUsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759793AbXHWUsM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:48:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:36210 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757650AbXHWUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:48:11 -0400
Received: by nf-out-0910.google.com with SMTP id g13so466638nfb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 13:48:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M8ysHUxGiNtRq1ogd/A2Cdgr6brHiDA1V9DSb2VwNnwHSKajSdtsJ/q5KzANpYkuKIaY9f3vy4ToEYt82hmsvhs2s2gkgVIomba8S6nkUR5THoOylj23Zw1ojbW5J3uFZ1aZ7SrWZMj8/vkpPtKW83UpgQ3GgS0ebIKXMn6UYRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N1TuIMwgaK1PB801Y/tcZp/ijmfvoA0flEdUMJac6jUr4rygn/2P/pUbgKc6Ix7L2jW34qC53BDA68U8Zs68f2N4JfzU8iyyTSz4TCfo6TS3vACMb8tHzXcu/QOl2U8Oug+SnAjN/lywTMv81ICpT2INuGccbjk4YHaOrSkiPr8=
Received: by 10.78.37.7 with SMTP id k7mr1468235huk.1187902089211;
        Thu, 23 Aug 2007 13:48:09 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 13:48:09 -0700 (PDT)
In-Reply-To: <20070823204202.GA10644@filer.fsl.cs.sunysb.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56530>

On 23/08/07, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> On Thu, Aug 23, 2007 at 09:36:05PM +0100, Catalin Marinas wrote:
> > On 23/08/07, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> > > Yep. Two different projects taking different approaches to storing the
> > > patches. I go with the plaintext diff approach ala quilt, while stgit uses
> > > git objects to store the data.
> >
> > But guilt also generates a commit object when pushing a patch. Or am I wrong?
>
> That's correct. But the git commit/tree/blob objects are a mere cache. For
> example, a refresh consists of:
>
> git-update-index ...
> git-diff HEAD^ > patchfile
> git-reset --hard HEAD^
> <internal push patch function - uses git-apply, git-{write,commit}-tree>

StGIT does a "git-diff | git-apply" during push as an optimisation.
Guilt moved the diff to the 'refresh' command. It might be a good idea
as the delay during 'push' is much more visible.

As I said in the past, the difference I see is that StGIT performs
three-way merging if simple git-apply fails, with the possibility
(configurable) of automatically starting a three-way merge tool like
xxdiff or emacs. Guilt could probably be modified but this information
needed for the three-way merge might be lost with text-only patches.

The rest is some extra functionality, StGIT being around for longer
(actually I think two months younger than the first official GIT
announcement).

-- 
Catalin
