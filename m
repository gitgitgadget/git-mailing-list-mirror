From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: request for documentation about branch surgery
Date: Tue, 7 Jul 2009 14:28:57 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0907071400170.2147@iabervon.org>
References: <200907070105.12821.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 20:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOFPe-0003IP-VE
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 20:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbZGGS27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 14:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbZGGS27
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 14:28:59 -0400
Received: from iabervon.org ([66.92.72.58]:50971 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbZGGS26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 14:28:58 -0400
Received: (qmail 4804 invoked by uid 1000); 7 Jul 2009 18:28:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jul 2009 18:28:57 -0000
In-Reply-To: <200907070105.12821.bruno@clisp.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122857>

On Tue, 7 Jul 2009, Bruno Haible wrote:

> 6) Also, it would be good to have a section "Reconnecting branches after rebase".
>    If you want to reconnect a branch to a rebased master, here's how to do it:
> 
>                    /--C'--...---P'--Q'--...---Z'  new rebased master
>               A---B---C---...---P---Q---...---Z   old master
>                                  \
>                                   --BA---...---BZ  release-branch
> 
>   =>
>               A---B---C'--...---P'--Q'--...---Z'  new rebased master
>                                  \
>                                   --BA---...---BZ  release-branch

This is impossible; the parent of BA is P, not P'.

                   /--C'--...---P'--Q'--...---Z'  new rebased master
              A---B---C---...---P---Q---...---Z   old master
                                 \
                                  --BA---...---BZ  release-branch

  =>
                                  --BA'--...---BZ' release branch
                                 /
                   /--C'--...---P'--Q'--...---Z'  new rebased master
              A---B---C---...---P---Q---...---Z
                                 \
                                  --BA---...---BZ

In order to draw well-formed tree sequences, you can only add items to the 
trees, and only use each letter once in the whole thing. When you've got a 
complete history following those rules, you can elide parts of the history 
that aren't referenced any more, but you still can't reuse their letters.

You're drawing some of your trees as if it were possible to have commits 
that are not eq but are equal; in fact, all information about a commit, 
including its parentage, is immutable and contributes to the way it is 
referenced, so any equal commits are eq (and therefore only appear in one 
spot on the graph).

	-Daniel
*This .sig left intentionally blank*
