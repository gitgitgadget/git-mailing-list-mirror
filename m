From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Thu, 12 Apr 2007 23:23:16 +0200
Message-ID: <e7bda7770704121423i3a984c65g2d21436833b5f0a8@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
	 <200704101828.37453.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
	 <e7bda7770704111742i2ac12cbas50fd7a3ba5c21cd8@mail.gmail.com>
	 <20070412005654.GQ21701@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Martin Waitz" <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 23:23:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc6lI-0005Mk-SE
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 23:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbXDLVXS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 17:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbXDLVXS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 17:23:18 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:21213 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbXDLVXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 17:23:16 -0400
Received: by an-out-0708.google.com with SMTP id b33so712588ana
        for <git@vger.kernel.org>; Thu, 12 Apr 2007 14:23:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ob1Qre1JMLbZLFPbeIknB/K8zeItsNgraRgVftRtdo0B9Q8mhUnCRiLitcZ4aiitm8f0rkxBMwYsKzjUrCOko/2b6qYdVH+sBGiKIjbxv0owTawllXzx0eScBp716GiUxDvYr1XYwgAlBEXZP1QZdToDH//031uHQrACQ4bfMt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DucvStvAEjOhovn34PYYnJS5YDdm8gEc5YjG2T71v98ZbKm/9IJv4vpfh7CDYjPDxx4u9A7ftUZnuUEJLHuQSqh4zLmPYdU7LRFSkhlPcCDbsvCGaUS6j0V5y2yiRceKYuDo3dkc+YILISFePUaNJoClNcFs4iQHF4q2oYBpEwM=
Received: by 10.100.168.13 with SMTP id q13mr1910257ane.1176412996323;
        Thu, 12 Apr 2007 14:23:16 -0700 (PDT)
Received: by 10.100.189.8 with HTTP; Thu, 12 Apr 2007 14:23:16 -0700 (PDT)
In-Reply-To: <20070412005654.GQ21701@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44353>

On 4/12/07, Martin Waitz <tali@admingilde.org> wrote:

> On Thu, Apr 12, 2007 at 02:42:43AM +0200, Torgil Svensson wrote:
> > I guess this file could also cover the case where the superproject is
> > only interested in a small subset of the subproject. For example if I
> > only uses some header-files in a library and want
> > "/lib1/src/interface" in the subproject end up as "/includes/lib1" in
> > the superproject. Could single files be handled in a similar way?
>
> Conceptionally this information would have to be part of the
> supermodule tree (after all it changes how your tree is set up).

I agree. This could be included in the module config file which in
turn is version-controlled.


> I think it makes more sense to make users think about which part
> of their tree can be reused and make them choose submodule boundaries
> wisely so that the above partial-checkout is not needed.

Sometimes you can't control upstream projects the way you want it.
Also, splitting up projects for the potential need of future
superprojects has several obvious disadvantages (multiple changelogs,
versions etc). I don't see the subfolder checkout thing as a problem
since the core plumbing in Linus's implementation doesn't care what's
beneath the commit link. The subfolder checkout can "easily" be done
in a porcelain.

It's more problematic if you want to cherry-pick individual files in a
subproject. Here, I think the tight connection between links and
directories to be too restrictive. Why does a subproject commit-link
have to be represented as a folder?

//Torgil
