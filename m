From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 17:11:33 +0200
Message-ID: <81b0412b0704170811h510ce0afn1b2277b752bdf422@mail.gmail.com>
References: <4624CD58.90103@gmail.com>
	 <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
	 <F47212AE-B31D-4025-9859-6794E7405DF2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Herman" <rene.herman@gmail.com>, git@vger.kernel.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpLG-0000wK-OF
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbXDQPLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754454AbXDQPLf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:11:35 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:47395 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbXDQPLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:11:34 -0400
Received: by an-out-0708.google.com with SMTP id b33so2253608ana
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 08:11:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fYkA08UfUm3lk+rOZzr8CA8e3DrbF4J3HnIa2TGhP0hlrMSKke3dqJlOKc/PJylj0qZVxqPeWnyu53WYhXryjyACF3dxPjeI79Hz8LPRh+q8a8JNXr1Qn9JhR8P6S6a8QeBg/19IBkNmsOTt74JT4IXifHY6QF6qY1rBbnAZPvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lVPeeTAzzq5QTH1qdXxv5FIKJGOr9FUEvb8G+vJdtpyR2H4d/KkggncUS0V3W9qNOFW+U4Aro4yQGWXeKblOU/OQebojTjgV7Dofp6WULiuvOUcsZG+syXVlMZSkyAzx/ZBNxojstNm3PbUNA7wGvxC0lDNVAMegtd0X+eQEhz0=
Received: by 10.100.139.9 with SMTP id m9mr5527506and.1176822693427;
        Tue, 17 Apr 2007 08:11:33 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 17 Apr 2007 08:11:33 -0700 (PDT)
In-Reply-To: <F47212AE-B31D-4025-9859-6794E7405DF2@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44776>

On 4/17/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Apr 17, 2007, at 10:21 AM, Alex Riesen wrote:
>
> > Kind of. It can be done with git-read-tree. I.e.:
> >
> >  $ git-read-tree --index-output=.git/tmp-index <branch-name> && \
> >     mv tmp-index .git/index && \
> >     git update-ref HEAD <branch-name>
>
> This does not appear to do what you think it will.  git update-ref
> will write the SHA1 of <branch-name> into the current HEAD, not
> switch HEAD to a new branch.
>

ach, right. Dangerous: it can change the ref HEAD points to. Very sorry!
Better just:

 $ rm .git/HEAD && git symbolic-ref HEAD "refs/heads/<branch-name>"

In the end, you just have git-checkout minus git-checkout-index. Maybe
a "git-checkout -n" can be useful. Even though I can't imagine what for.
