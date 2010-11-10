From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Wed, 10 Nov 2010 08:32:09 +0100
Organization: Bertin Technologies
Message-ID: <20101110083209.6a1252ef@chalon.bertin.fr>
References: <20101109083023.783fad9b@chalon.bertin.fr>
 <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
 <20101109102428.5ba8dc13@chalon.bertin.fr>
 <7vlj52jakh.fsf@alter.siamese.dyndns.org>
 <050F42EE-34FE-499F-B632-471597EB4881@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 08:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG5KX-0007bE-VF
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0KJHmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:42:49 -0500
Received: from blois.bertin.fr ([195.68.26.9]:35586 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740Ab0KJHms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:42:48 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id BD089542BE
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:42:46 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 7BB7A542CE
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 08:42:46 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBN003JTS3AZM70@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Wed, 10 Nov 2010 08:42:46 +0100 (CET)
In-reply-to: <050F42EE-34FE-499F-B632-471597EB4881@sb.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17756.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161134>

On Tue, 09 Nov 2010 16:33:31 -0800
Kevin Ballard <kevin@sb.org> wrote:

> On Nov 9, 2010, at 4:18 PM, Junio C Hamano wrote:
> 
> > Yann Dirson <dirson@bertin.fr> writes:
> > 
> >>>> Syntax like origin/pu^{/Merge 'kb/blame-author-email'}2 would be
> >> ...
> >> Another idea: origin/pu^{:2/Merge 'kb/blame-author-email'}
> > 
> > What are these "2"s?
> > 
> > You need to question how you figured out the commit you want is the
> > second one reachable (in whatever traversal order) from something
> > in the first place.  Didn't you use "git log --oneline" or
> > something to find that out? At that point, you have the object name
> > already, so I doubt such a "counting" feature is of much practical
> > use.

I usually always have a gitk displaying history.  Whereas it shows the
commit summary, it does not show the sha1 for each commit - and even if
it did, my brain is still more comfortable dealing with words than
hashes (though that may arguably be an effect of aging ;)

> The particular case that prompted this for me was I knew I had
> created two commits called "WIP", scheduled for renaming later, and I
> wanted to quickly look at the contents of the first one. I would have
> loved to be able to type something like `git show :/WIP/2`. I suppose
> this situation may be rare enough not to bother supporting it in the
> new syntax. With the new syntax it will be possible to do something
> like `git show HEAD^{:/WIP}^^{:/WIP}`, but that looks awfully awkward.

Another use for counting would be for reflog, to lookup things like
"2nd to last of yesterday's commits" - that could be spelled like
"master^{:2:yesterday}" or similar.  Not sure it's worth it (I hardly
use the @{anything vague} syntax myself, especially because it is so
vague), but that looked similar enough to be mentionned here.

> Another thing to consider - the current :/foo syntax searches for the
> newest commit reachable from any ref. Using the ^{} syntax will
> require specifying a ref first. I'm not sure this is a problem
> though, as I'm not really sure why :/foo searches from all refs to
> begin with.

The syntax could be extended so that ^{whatever} starts looking at
current commit (ie. HEAD), somewhat like @{whatever} looks at reflog for
current branch.

-- 
Yann Dirson - Bertin Technologies
