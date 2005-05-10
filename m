From: Paul Mackerras <paulus@samba.org>
Subject: Re: Prototype git commit viewer
Date: Tue, 10 May 2005 10:33:00 +1000
Message-ID: <17024.316.828536.230448@cargo.ozlabs.ibm.com>
References: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
	<m3fywwjktf.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 02:26:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIZR-00039N-Iq
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVEJAdG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVEJAdG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:33:06 -0400
Received: from ozlabs.org ([203.10.76.45]:60895 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261458AbVEJAdB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:33:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4BB6E679FA; Tue, 10 May 2005 10:33:00 +1000 (EST)
To: Krzysztof Halasa <khc@pm.waw.pl>
In-Reply-To: <m3fywwjktf.fsf@defiant.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Krzysztof Halasa writes:

> Nice. I wonder how well would it work with a longer history, say all
> linux-2.[56] data. It takes gitk ~ 10 seconds to read ~ 1000 Linux
> commits from cache now, on my system.

Any arguments you give to gitk (other than -b and -d) get passed to
git-rev-tree, so you can just look at a section of the tree.  (I just
fixed a bug where it would crash if a commit had a parent that wasn't
listed in the git-rev-tree output, so refetch if you want to try it.)
So you can do e.g.
	gitk 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5 \
		^a2755a80f40e5794ddc20e00f781af9d6320fafb

to see all the commits from v2.6.12-rc4 back to but not including
v2.6.12-rc3 (unfortunately git-rev-tree seems not to cope with being
given tags rather than commit ids).

Ultimately I want to add ways to select the range of commits you want
to look at, e.g. by tags or by dates.

So as long as git-rev-tree remains fast as the history grows, gitk
should remain usable for looking at reasonable-sized chunks of the
history.  There are various things I can do to make gitk faster, too,
up to and including tcl bindings for the core git library. :)  

> In fact I'm thinking about something working with WWW browser. I've
> written a very simple experimental show-tree tool in C and it seems
> reading current Linux tree (no HTTP output yet) takes 0.065s with it.
> 
> Now I'm thinking about output language. (X)HTML seems to be not
> capable (I'm not HTML expert, please correct me if I'm wrong).
> 
> Any idea of what can I use?

I think I am even less of an HTML expert than you. :)

Regards,
Paul.
