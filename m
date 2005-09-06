From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsimport-script: handling of tags
Date: Wed, 7 Sep 2005 10:59:26 +1200
Message-ID: <46a038f9050906155962d33869@mail.gmail.com>
References: <431DD381.4050709@zytor.com> <431DE640.8050901@zytor.com>
	 <431DFB04.5020701@zytor.com>
	 <46a038f905090614216eca87eb@mail.gmail.com>
	 <431E0B25.5000104@zytor.com>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 01:00:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECmPc-0006Tg-BN
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 00:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbVIFW73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 18:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVIFW73
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 18:59:29 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:60298 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751099AbVIFW72 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 18:59:28 -0400
Received: by rproxy.gmail.com with SMTP id i8so914036rne
        for <git@vger.kernel.org>; Tue, 06 Sep 2005 15:59:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FpoIxhWdsMPUWqCNzqe/gOHq5gvOBx+g7Vw+dLxC9S3/U2wyxYWFZxAX5+ZLTZ2SkvChRvAvxaShBZhIxppTfYeTej5/du2DpJL7qAl+kVr5ACA7hjodSAIMoFxopZQsOWRWl30fdhZTMH6jV/GOPI22GI3Nb2ErLduDlqUXAGo=
Received: by 10.39.3.51 with SMTP id f51mr768883rni;
        Tue, 06 Sep 2005 15:59:26 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Tue, 6 Sep 2005 15:59:26 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <431E0B25.5000104@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8154>

On 9/7/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Martin Langhoff wrote:
> >
> > Tell me more about how you are trying the 'recognize merge'. It is a
> > pretty unsophisticated thing, as it trusts the commit message in the
> > first place. But when it works, it works.
> >
> 
> Perhaps it would be good to know what it expects in the commit message?

>From the source, with line numbers:

80 our @mergerx = ();
81 if ($opt_m) {
82     @mergerx = ( qr/\W(?:from|of|merge|merging|merged) (\w+)/i );
83 }
84 if ($opt_M) {
85     push (@mergerx, qr/$opt_M/);
86 }

If your commit messages have a particular format, feed -M a regex that
captures the branchname/tagname in $1.

> My style has always be to use tags for merges; tag the origin branch as
> well as before and after on the receiving branch.

Do you move the tags with cvs tag -F? If that's the case, the data you
need to merge is lost... otherwise, you could hack an alternative
merge detection based on your tagnames.

cheers,



martin
