From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: Check for differents trees
Date: Sun, 6 Nov 2005 11:02:49 -0800 (PST)
Message-ID: <20051106190249.39384.qmail@web26314.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 20:04:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYpnu-0002Ql-1X
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 20:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKFTCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKFTCw
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 14:02:52 -0500
Received: from web26314.mail.ukl.yahoo.com ([217.146.177.51]:47961 "HELO
	web26314.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932202AbVKFTCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 14:02:51 -0500
Received: (qmail 39386 invoked by uid 60001); 6 Nov 2005 19:02:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YKsUFJNZJU+O/IbRd/Z2mjYWBrCNaT80roJViFkIKpLxKNEDsfZCoWCKmIUBYLJCYVgrmp09Mw2iCGWOgpg+St3Kqm+Y3A8OqDbS9N3e4SBv3gGzkxF3iHljrkxLj/0Fl0nPydbM8Y7oSjK4XsC777wsK60XutSOkfyC/CLdJxw=  ;
Received: from [151.44.24.164] by web26314.mail.ukl.yahoo.com via HTTP; Sun, 06 Nov 2005 11:02:49 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11222>

Junio C Hamano wrote:

>>The problem is that if sha1 and sha2 correspond to very
>>"distant" revision the output of git-diff-tree can be very
>>long and also usless as long as I stop searching at first
>>match.
>
>
>Perhaps
>
>	$ git-diff-tree -r --name-status --diff-filter=AD sha1 sha2
>
>would help you somewhat?  This would not make the diff
>generation part quicker, but at least you do not have to parse
>other types of changes.
>

Thanks Junio,

   as you said, the speed is almost the same but your way is clearly better.

I have pushed the change.

P.S.: Could be interesting something like?:
     
          git-diff-tree -r --name-status --diff-filter=^M sha1 sha2


                          -------------------

>Dscho says:
>
>if you want to know if tree1 and tree2 have *exactly* the same files, you 
>only have to compare the sha1 of the two trees. If they are equal you are 
>virtually guaranteed that the two trees contain the same files.


I have impemented a tree viewer inside qgit. Tree view is updated when user browses through
revisions.

Loading the file names of a given tree, altough only for the open directories, is an expensive
operation. So I added a little "same files" test to skip tree reloading.

With "same files" I mean that the file list is the same bewteen tree1 and tree1, _not_ that the
files content are the same. As example, if tree1 is parent of tree2 (and tree2 is not a merge) and
the revision between the two only modified files (git-diff-tree status is M), in my test tree1 and
tree2 have the same files, also if sha's are, of course, different.

Put in other way, two trees have the "same files" if I don't have to repaint the tree view window.

  Marco
 


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
