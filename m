From: Johan Herland <johan@herland.net>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 11:27:18 +0200
Message-ID: <200804281127.18162.johan@herland.net>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: John Wiegley <johnw@newartisans.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:29:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqPfB-0007wB-2j
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 11:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759014AbYD1J14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 05:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756786AbYD1J14
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 05:27:56 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50711 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756269AbYD1J1z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 05:27:55 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K01006033MHWP00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 Apr 2008 11:27:53 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K01002403LI9620@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 28 Apr 2008 11:27:18 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K010010U3LIZ467@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 28 Apr 2008 11:27:18 +0200 (CEST)
In-reply-to: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80516>

On Monday 28 April 2008, John Wiegley wrote:
> I published another tutorial on Git today, this one describing the  
> system from a "bottom up" perspective.  I know it's been written about  
> this way before, but I was aiming at a bit more thoroughness, and a  
> paced introduction to the basics.
> 
> There's a link to the PDF is in the following blog post:
> 
>    http://www.newartisans.com/blog_files/git.from.bottom.up.php

Some comments after a quick read-through:

(in general) In you examples, you are using the "git foo" notation, while
you're using the "git-foo" notation when referring to git commands elsewhere
in the text. This is probably OK; just be aware that the dashed form of the
commands will disappear in a future git version.

(in general II) You mention "git prune" a couple of places. I think "git gc"
is the command we encourage new users to use, so you might want to use that
instead.

(p.2 (and p.19-20)) I think most people say "index" and not "index cache".
In the git codebase, "index" and "cache" are often confused (I think Linus
initially named it "cache"), but I think from a user perspective, we try to
use the term "index".

(p.3) In the simple diagram, you show the 'checkout' activity as an arrow
directly from 'Repository' to 'Working Tree'. What actually happens on
checkout is copying the appropriate tree object into the index, and then
applying the index onto the working tree. IOW if you want to be 100% correct
the checkout arrow should go through the index. But this is only a minor
issue; if you feel understanding is better conveyed by the existing diagram,
please don't change.

(p.9) "But if I pass the -f flag to git-checkout, it becomes identical to
git-reset --hard": In the context of the command above (resetting the
working tree to 5f1bc85) there are in fact no difference between the two
commands. However, in general, there is one crucial difference between "git
reset --hard" and "git checkout -f": "git reset --hard" will rewrite which
commit the current branch points at, whereas "git checkout -f" will not.
(I see you treat this later in "To reset, or not to reset", but I think it
should be fixed on p.9 as well.)

(p.10) In the diagram at the top, the arrow from the root tree object to
HEAD commit is labelled "parent". I think this label rather belongs on the
arrow from the HEAD commit to its parent.

(p.11) "name~10" Just to make things perfectly clear, I would state that
"name~10" is equivalent to "name^^^^^^^^^^".

(p.11-12) This entire list is prefixed with "nam[ing] commits - and ranges
of commits", so in a strict sense "name:file" and "name{tree}" does not
belong here. But you have to put them somewhere...

(p.15) "Even the transformation from X to W is changed": I think this should
be the other way around: "W to X".

(p.16) "For every commit this that involves conflicts": s/ this//?
Also, in the preceding sentence, I'd prefer "...to its (now rewritten)
parent commit" instead of the current "...to its (now) rewritten parent
commit".


Otherwise, I think it's informative and well-written. Nice work.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
