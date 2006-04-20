From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] colored diff.
Date: Thu, 20 Apr 2006 13:52:38 +0200
Message-ID: <20060420115238.GA4681@cip.informatik.uni-erlangen.de>
References: <7vpsjczh1k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 13:52:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWXiI-0004AY-5s
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 13:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDTLwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 07:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDTLwl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 07:52:41 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:250 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750729AbWDTLwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 07:52:40 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id DA26C3061B; Thu, 20 Apr 2006 13:52:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsjczh1k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18966>

Hello Junio,

* Junio C Hamano <junkio@cox.net> [060420 12:22]:
> With configuration option diff.usecolor, this colorizes the diff
> output.

I use a long time the following combination, which served me and a few
others very well:

        bourne shell function:

        BLACK="^[[0;30m"
        RED="^[[0;31m"
        GREEN="^[[0;32m"
        YELLO="^[[0;33m"
        BLUE="^[[0;34m"
        PURPLE="^[[0;35m"
        CYAN="^[[0;36m"
        WHITE="^[[0;37m"
        END="^[[0m"
        REVERSE="^[[7m"

        cdiff()
        {
                cat $1 | \
                sed -e " \
                        s/^\(diff-tree\)\(.*\)/\1${RED}\2${END}/; \
                        s/^+.*/$RED&$END/;  \
                        s/^-.*/$BLUE&$END/;  \
                        s/^@.*/$GREEN&$END/;  \
                        s/^Date.*/$RED&$END/;  \
                        s/^Author.*/$RED&$END/; \
                        " | less -R -i -p "^diff-tree"

                        # This would highlight manpages but the last line clashes with cdiff
                        # --tg 00:52 05-05-26
                        #s/^[A-Z]\+[A-Z ]\+$/$RED&$END/; \
                        #s/[A-Z]\+([0-9])/$RED&$END/g; \
                        # s/\W--\?[0-9a-zA-Z=-]\+/$BLUE&$END/g; \
        }

# with 'n' you simply jump to the next commit
# with 'N' to the previous

git-whatchanged -p | cdiff

screenshot: http://wwwcip.informatik.uni-erlangen.de/~sithglan/shot.png

Thanks for the enegery you put in git,
                                   Thomas
