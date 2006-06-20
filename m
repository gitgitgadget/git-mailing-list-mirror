From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: packs and trees
Date: Tue, 20 Jun 2006 01:57:31 -0400
Message-ID: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jun 20 07:57:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsZF2-0002u9-6q
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 07:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbWFTF5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 01:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWFTF5d
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 01:57:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:28361 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965062AbWFTF5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 01:57:32 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1918873nze
        for <git@vger.kernel.org>; Mon, 19 Jun 2006 22:57:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qw5+gBzF60R00tWYTVmzekzFrYHGhbTBjU0qYsyABUDjBTPBnD1pGVvu0FhfdKkGeq298u/Q5WGNOpIGFs8tBi1ntrkfeJcRuyY0bAurJYOYBtAyfdgn3F8QOjDnL1YWqg/vSs3C7YBhVX+gMdzgIW5ocYiuU6wqSjMVyS9xBzQ=
Received: by 10.36.91.5 with SMTP id o5mr6642421nzb;
        Mon, 19 Jun 2006 22:57:31 -0700 (PDT)
Received: by 10.36.37.5 with HTTP; Mon, 19 Jun 2006 22:57:31 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22167>

Converting from CVS would be a lot more efficient if all of revisions
contained in a CVS file were written into git at the same time. So, if
I extract complete revisions from 100 source files into git objects
and then ask git to incremental pack, will git find all of the deltas
and do a good job packing? Some of these files have thousands (50MB)
of deltas. Also, note that I have not written any tree info into git
yet.

After all of the revisions are into git, I will follow up with the
tree info and then repack all. How will the pack end up grouped,
chronologically or will it still be sorted by file? It is not clear to
me how the tree info interacts with the magic packing sauce.

The plan is to modify rcs2git from parsecvs to create all of the git
objects for the tree. It would be called by the cvs2svn code which
would track the object IDs through the changeset generation process.
At the end it will write all of the trees connecting the objects
together.

cvs2svn seems to do a good job at generating the trees. I am not
exactly sure how the changeset detection algorithms in the three apps
compare, but cvs2svn is not having any trouble building changesets for
Mozilla. The other two apps have some issues, cvsps throws away some
of the branches and parsecvs can't complete the analysis.

-- 
Jon Smirl
jonsmirl@gmail.com
