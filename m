From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-svn and branches
Date: Fri, 28 Sep 2007 13:19:59 -0400
Message-ID: <20070928171959.GA21816@dervierte>
References: <20070927021252.GA23777@dervierte> <20070927072404.GB1782@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stevenrwalter@gmail.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 19:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbJVz-0002FG-FB
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 19:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbXI1RUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 13:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbXI1RUY
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 13:20:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:43487 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbXI1RUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 13:20:23 -0400
Received: by py-out-1112.google.com with SMTP id u77so5371074pyb
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=hceKeHbpr68VXA7tHOoPVNDLyieuSrR4LHAXVvavkw4=;
        b=II/+h/UFEEBaEkSuaiEjvhfJbfnaGlIgFIRMx4viSGG2sFIJ656VSbCd1DLk/Ncyw9e3aFlZJlm3h902fxeI8QfszmixcAUKWjwAfiafuamOuO3jPc2ihj/2nkjUIWuraT85J2ZdzOWShDZuwintL1+CFm00FMSzYPmxv864IOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=ATFNHL+te3W2ePP2pdEURrG6HGFh0QOHNo6b8JfsI+a9dlL6cbTRtUlV2NMoBlYZxxHj2wjmek6zO35XIkSAEFzSqSwE3sH5Q4PkBPdDDitsSiosl1yUiztp2gB2Ho+5oKYatHDUDQJX6W4sjgy9wmjyD8dNZMnzuFT1Zs/34Sw=
Received: by 10.64.10.2 with SMTP id 2mr7501972qbj.1191000021372;
        Fri, 28 Sep 2007 10:20:21 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.36.23])
        by mx.google.com with ESMTPS id 24sm4384348nzn.2007.09.28.10.20.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 10:20:18 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 19ADBCDD091; Fri, 28 Sep 2007 13:20:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070927072404.GB1782@hand.yhbt.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59411>

On Thu, Sep 27, 2007 at 12:24:04AM -0700, Eric Wong wrote:
> I believe your case handles where a branch is created directly from a
> trunk copy with no file modifications in the branch, but not when a
> branch is created and files are modified in the trunk (or branch) within
> the same revision.  Is this what's happening?
> 
> Additionally, I think this breaks when an entire trunk or branch is
> moved around because the original directory has moved or gone away:
> 
>   /trunk => /project-a/trunk
> 
> Anyways, as Sam said, newer SVN (1.4.4+) has a working do_switch()
> function and that code path will never be hit at all.

I think you're right that my code would only handle a verbatim copy.  I
made a few changes and I think I have something that is more generally
useful.  Using a newer version of subversion isn't practical for me, as
this is a work situation where I don't have control of the workstations.

One criticism of the patch: the trees_match function probably needs to
be re-written.  My SVN::Perl-foo is weak.

Patch to follow
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
