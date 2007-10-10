From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 17:39:25 -0400
Message-ID: <20071010213925.GB2963@fieldses.org>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Oct 10 23:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjHH-0002Ec-GJ
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXJJVja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbXJJVja
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:39:30 -0400
Received: from mail.fieldses.org ([66.93.2.214]:50195 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756509AbXJJVj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:39:29 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IfjH4-0006jt-0L; Wed, 10 Oct 2007 17:39:26 -0400
Content-Disposition: inline
In-Reply-To: <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60552>

On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
> 2007/10/10, Han-Wen Nienhuys <hanwenn@gmail.com>:
> > More to the point, I seemed to have lost my entire repository. This is
> > the type of surprise  I don't enjoy.
> >
> > Now, can someone explain why 'git branch' takes forever if there are
> > only two non-remote branches ?
> 
> So,
> 
> Here is a question:  I would like to share commitishes between two checkouts
> of a repository. The reason for this is that I want to easily cherry
> pick back and forth between the two. The files of in one of them
> should be continually available, since I am running out of that
> directory.
> 
> The way I solved that, was to have both repositories pointing to each
> other, using alternates.
> 
> Now, after a couple of gc and pack-refs iterations, I am greeted by
> 
> hanwen@lilypond:~/vc/git6$ git fsck
> missing tree 12b00ec3190f7b46a5fe0a3235445bead4c9645b
> broken link from    tree 1718d09e0394d113c162e4a3471e7a1f20914a94
>               to    blob 635e2802568b85017007698c0e6dd4d28dca496f
> broken link from    tree 926899798fce75038e24f8fa1838f6da8bcf105f
>               to    tree f1b852d270ebbaaf95d8ddc06c52763bad11ff25
> missing blob 99f0c0d63276fce444e3a200167b636236784c52
> missing tree f1b852d270ebbaaf95d8ddc06c52763bad11ff25
> missing blob 236962a87fafae8ca2dce2dc550d344aa7a8884a
> missing blob 7d69ca297f392a954c4cdcb62bb4c8a90ddb862b
> missing blob 9e39be8f5cb4eeff97fcfd6eb77fefeda02f0e71
> dangling blob f3a93f023080ce9fc6becb397e366cc4ceb192f5
> 
> 
> could it be that GC does not handle cyclic alternates correctly?

Does it handle alternates at all?  If you run git-gc on a repository
which other repositories get objects from, then my impression was that
bad things happen.

--b.
