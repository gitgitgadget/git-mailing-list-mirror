From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Using git-p4 on project with branches
Date: Mon, 18 Aug 2008 17:44:12 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808181732180.19665@iabervon.org>
References: <1a6be5fa0808180226h79eebf46yad9174b1518d4eed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 23:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVCXW-0002wR-Lz
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYHRVoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 17:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYHRVoO
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:44:14 -0400
Received: from iabervon.org ([66.92.72.58]:59186 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbYHRVoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:44:13 -0400
Received: (qmail 24689 invoked by uid 1000); 18 Aug 2008 21:44:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2008 21:44:12 -0000
In-Reply-To: <1a6be5fa0808180226h79eebf46yad9174b1518d4eed@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92744>

On Mon, 18 Aug 2008, Tor Arvid Lund wrote:

> Hi!
> 
> I really appreciate the work that is done with allowing us poor souls
> stuck with perforce at work to use git via git-p4. But I'm wondering
> how to make it work when there are several branches on the perforce
> server.
> 
> Say, for instance, that I have this setup:
> 
> //depot/old/path/to/projectX
> //depot/new/path/to/projectX_Devel_Branch
> //depot/new/path/to/projectX_Release_1.2_Branch
> //depot/new/path/to/projectOther
> 
> It would be really nice, if I were able to make a projectX.git
> repository with the 'old', 'devel' and '1.2' branches. It seems that
> the --detect-branches argument to P4Sync wants me to enter
> //depot/new/path/to as the root path, and detect p4 branchspecs from
> there. That works poorly for me, since it would also include
> projectOther, which I don't want. It would also not include the 'old'
> branch.
> 
> I have looked briefly at the git-p4 code, but don't know it very well
> yet. Anyway, I suspect this functionality is not implemented... I
> might try to do this myself, and if anybody has ideas on how to get
> started, it would be much appreciated.

You might want to also look at git-p4raw, which does extremely clever 
branch tracking, but acts on the perforce server database directly. If you 
figured out how to supply its engine with information through the client, 
it would be really great (but likely slow on the order of "leave it 
importing over the weekend").

> To support submitting changelists back to perforce, it would probably
> need some configuration (to determine which path to submit to in
> perforce)... Like:
> 
> [git-p4 "branches"]
>         old = //depot/old/path/to/projectX
>         devel = //depot/new/path/to/projectX_Devel_Branch
>         1.2 = //depot/new/path/to/projectX_Release_1.2_Branch

You'd get "master = //depot/new/path/to/projectX_Devel_Branch", probably, 
by default, and then could add "old" and "1.2".

> Well, I guess I'm just wondering if this is something anybody but me
> would like to have? Or if there is another/better way to go about
> doing it...

I'd certainly like it. (But it's likely to be really tricky.)

	-Daniel
*This .sig left intentionally blank*
