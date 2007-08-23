From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 21:57:42 +0100
Message-ID: <b0943d9e0708231357s1ceaa121qd56e3a9c71677c8d@mail.gmail.com>
References: <20070823092254.GA5976@kroah.com>
	 <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
	 <20070823164322.GC5528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Greg KH" <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 22:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOJkS-00041K-Om
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 22:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914AbXHWU5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 16:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760514AbXHWU5o
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 16:57:44 -0400
Received: from ik-out-1112.google.com ([66.249.90.177]:5208 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbXHWU5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 16:57:44 -0400
Received: by ik-out-1112.google.com with SMTP id b32so277585ika
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 13:57:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=esSrdJhUhvvtCHwNtk6Ky7teAStOmd1tIPjx6qkyh50Xq8bwmYgGLo0dYtnolA+Xo0FjQIBoG5zVTZqRqrQkcOs1Ekoen/djWYy2TmwguhiO4OqC1OWu4N8pbegoEnIX92bCY6ov6yB28yNDLEsQpUnEmeXgqRrWDN0gtV+xLkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OjiPE8Rbu2AA2Y/yqDN1+UnaHTj6Z1DiRRm4pKKjNKb1cPbIj4XAmwlmH/iqKbYNHN6fKo0Jtwzq8vjSRGQMG1gfr/O55q6FhhtaH+r2IE1hPAy63j5ToeXkaOLJbjGeQK/3kTKjSxuPnKe6Ih+7Xji5GesOluAVVkJj154EQb4=
Received: by 10.78.200.3 with SMTP id x3mr1501852huf.1187902662220;
        Thu, 23 Aug 2007 13:57:42 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 13:57:42 -0700 (PDT)
In-Reply-To: <20070823164322.GC5528@kroah.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56532>

On 23/08/07, Greg KH <greg@kroah.com> wrote:
> Also, it would import these patches, which are individually in mbox
> form, with the incorrect author information.  So I thought I would use
> the mbox form to make sure I wasn't just doing something stupid.

If the patches have a "From: ..." line after the subject (as described
in the submitting patches kernel docs), StGIT honours it.

Yet another way (might be even simpler for you) - use git-applymbox
(or git-quiltapply) and 'stg uncommit -n 177'. The former generates
GIT commits and the latter creates StGIT patches (without touching the
tree, HEAD remains the same and corresponds to the top patch). There
is also 'stg uncommit --to=commit-id'.

> > After an import failure, you can continue importing from the next
> > patch using the 'stg import --ignore' option.
>
> Ok, will try that, and your patch.

You can try the tonight snapshot which has this patch included (and
other fixes) - http://homepage.ntlworld.com/cmarinas/stgit/snapshots/stgit-20070823.tar.gz

> > One thing you'll notice is the speed difference as stgit has to
> > generate a git commit during a push operation.
>
> Oh yeah, I know that it would be slower, but I use git-quiltapply a lot
> for sending patches to Linus, and that seems quite fast (actually a lot
> faster than stgit for some reason...)

I should have a look at what git-quiltapply does as most of the StGIT
waiting time on external GIT invocation.

>         $ stg series -d
>         + add-my-version-to-the-kernel   | Add my version to the kernel.
>         + stupid-patch-for-my-laptop-whi | Stupid patch for my laptop which cant get sysrq-u
>         + gregs-test-driver-core-sysfs-s | Gregs test driver core / sysfs stress test module
>         > detect-atomic-counter-underflo | detect atomic counter underflows
>
> Are those spaces really the name of the patch?

No, the patch name is with the dashes, the rest is the patch subject line.

-- 
Catalin
