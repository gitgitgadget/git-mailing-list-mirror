From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 21:19:20 +0400
Message-ID: <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
References: <20080702143519.GA8391@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 19:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE60J-000264-E6
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 19:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYGBRTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYGBRTa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:19:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:49520 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbYGBRTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:19:30 -0400
Received: by yw-out-2324.google.com with SMTP id 9so200348ywe.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=u6qaJDV0dlL4jlsR1q9odF7rkbb/BVxGKnH1/d0NjIM=;
        b=Dto321oOaZrDW+F//O/XEfKTKlE/eZKBwNih5sGY3Z8ZOz3Yed5CcVt7RZ3gcEYhN7
         /pI445mYJ/eSgysVjSLHmjFlLrnQlecr9EyaZl8AirBA1JN57g2duvv4O5RV/rxYESaE
         IvWBulp6FHiE2qo3kH0ikXUl0T192ZsxeglPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qTOhn5pxZ9iWu1aiIinN5kt2MNPU0TCnzNLNmN1giI+pIJLG01DZspUDRKjVlNaYIM
         GmkN0bgQSEK0CGPPBzdJY7T4KggvWiIwcIEIeAseKB7FWQFdsxikkZU4/ACXDjaZTt/i
         HOGdvcNwdJnTNvm3DFm+egBps/LohKqNzWmcc=
Received: by 10.143.33.12 with SMTP id l12mr3141696wfj.272.1215019160464;
        Wed, 02 Jul 2008 10:19:20 -0700 (PDT)
Received: by 10.143.32.3 with HTTP; Wed, 2 Jul 2008 10:19:20 -0700 (PDT)
In-Reply-To: <20080702143519.GA8391@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87164>

On Wed, Jul 02, 2008 at 04:35:19PM +0200, Stephen R. van den Berg wrote:
>_
> - Extend the grafts file format to support something like the following syntax:
>_
> commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
> Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28
> Merge: 3b3da24960a82a479b9ad64affab50226df02abe 13b8f53e8ccec3b08eeb6515e6a10a2a
> Merge: ac719ed37270558f21d89676fce97eab4469b0f1
> Tree: 32fc99814b97322174dbe97ec320cf32314959e2
> Author: Foo Bar (FooBar) <foo@bar>
> AuthorDate: Sat Jun 6 13:50:44 1998 +0000
> Commit: Foo Bar (FooBar) <foo@bar>
> CommitDate: Sat Jun 7 13:50:44 1998 +0000
> Logmessage: First line of logmessage override
> Logmessage: Second line of logmessage override
> Logmessage: Etc.

I don't think that the grafts file is the right place for this kind of
information. Perhaps, it would be better to have a separate file or
even a directory with files where commit-id identifies a text file with
a new commit object, which should be placed instead of an old one.  So,
it will be easy to tell git filter-branch to use this new information.

However, if you want more than just ability to edit commits in a text
file but also inspect changes using normal git commands and gitk (as it
is possible with grafts), it will require changes to the git core, which,
perhaps, not difficult to implement using pretend_sha1_file(), but I am
not sure that everyone will welcome that...

Dmitry
