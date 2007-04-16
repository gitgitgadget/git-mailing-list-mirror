From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display the subject of the commit just made
Date: Mon, 16 Apr 2007 08:40:59 +0300
Message-ID: <20070416054059.GB23255@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416035325.GA20304@mellanox.co.il>
	<7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 07:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdJxV-0003fk-FH
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 07:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXDPFk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 01:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXDPFk6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 01:40:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:21072 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbXDPFk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 01:40:57 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1027448uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 22:40:56 -0700 (PDT)
Received: by 10.67.50.7 with SMTP id c7mr4078292ugk.1176702055780;
        Sun, 15 Apr 2007 22:40:55 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id x37sm5137766ugc.2007.04.15.22.40.54;
        Sun, 15 Apr 2007 22:40:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwt0cx5jr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44582>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display the subject of the commit just made
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> > Better?
> >
> > diff --git a/git-commit.sh b/git-commit.sh
> > index 9e0959a..32257b0 100755
> > --- a/git-commit.sh
> > +++ b/git-commit.sh
> > @@ -649,8 +649,9 @@ then
> >  	fi
> >  	if test -z "$quiet"
> >  	then
> > +		commit=`git-diff-tree --shortstat --pretty="format:%h: %s"\
> > +		       --summary --root HEAD --`
> >  		echo "Created${initial_commit:+ initial} commit $commit"
> > -		git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
> >  	fi
> >  fi
> 
> Close but no cigar.  You broke it for a merge commit, I think.

Yes, you are right.

> Perhaps
> 
> 	pretty="format:Created${initial_commit:+ initial} commit %h: %s%n"
> 	git-diff-tree --always --shortstart --summary --root --pretty="$pretty" HEAD

Aha, --always should do the trick. I'll check this.
BTW, a couple of questions:
1. do we really need the shortstat info?
2. why is there "--" at the end do in the original version?

-- 
MST
