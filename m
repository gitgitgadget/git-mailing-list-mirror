From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 18:49:19 -0300
Message-ID: <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com>
	 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com>
	 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com>
	 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
	 <20071010213925.GB2963@fieldses.org>
	 <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjSn-0004mC-QJ
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481AbXJJVtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbXJJVtX
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:49:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:1602 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054AbXJJVtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:49:21 -0400
Received: by nz-out-0506.google.com with SMTP id s18so275191nze
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XBSMZ9cW3RZax4fKNHbNrZiLdLJzCQDVozWoAGJMNVc=;
        b=D1o81OWrqQkM1MFN33isN7ScSoyW5XX5RmMmLHdBsZhs3aYIs1s6IRmt3EbuX+R6f0ZSEejH6e+uQkkW2DbzoqFxdy/4RsyHoVN7EJjKWPydGtVRmeFexzJ6XAThtqJRImLz+/RHrWeot4Ah7ndz2d7oVFONboZXCuwGotWJvb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ThDEmUC5eHAHYKz/329pYNYOHzoWcYGoKoizjLKZ+Lld+TGuwt4BW5q2LLG4j9pLrEd//ZGUFW01f+Brvh7fa5MSwyqMbBNcsHERnk1xe1NwjL64e0z6pvFewLhl+iNDPIRxMON/Twc6qgs3YdyEQfg9//Jvx8J2ESFcX5FQir0=
Received: by 10.65.20.18 with SMTP id x18mr2458315qbi.1192052959615;
        Wed, 10 Oct 2007 14:49:19 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Wed, 10 Oct 2007 14:49:19 -0700 (PDT)
In-Reply-To: <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60554>

2007/10/10, Lars Hjemli <hjemli@gmail.com>:
> On 10/10/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> > On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
> > > could it be that GC does not handle cyclic alternates correctly?
> >
> > Does it handle alternates at all?  If you run git-gc on a repository
> > which other repositories get objects from, then my impression was that
> > bad things happen.
> >
>
> AFAIK 'git gc' is safe, while 'git gc --prune' will remove loose
> (unreferenced) objects.

Yes, I think that in this case, gc --prune was run accidentally, but
given that the history of the program invoking git just died, I'm not
sure how to figure that out.

Maybe gc --prune could follow the alternates and abort if a cycle was detected?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
