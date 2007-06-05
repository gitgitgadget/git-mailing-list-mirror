From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 05 Jun 2007 12:26:08 +0200
Message-ID: <868xayofy7.fsf@lola.quinscape.zz>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org> <Pine.LNX.4.64.0706030147520.4046@racer.site> <20070605101845.GA16160@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 12:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvWFB-0005O0-Ao
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763276AbXFEK0Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763774AbXFEK0X
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:26:23 -0400
Received: from main.gmane.org ([80.91.229.2]:42380 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762389AbXFEK0X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:26:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HvWEy-0007wr-DQ
	for git@vger.kernel.org; Tue, 05 Jun 2007 12:26:16 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:26:16 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 12:26:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:SxoDvYVSGgdyxubEMNB9PDc388o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49184>

Jonas Fonseca <fonseca@diku.dk> writes:

> A possible fix that makes the test pass for me.
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 0c8a7df..5cf9d3c 100644
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -339,7 +339,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
>  
>  i=0
>  while read commit; do
> -	i=$((i+1))
> +	i=$(echo i+1 | bc)

Would not work.  You need $i instead.

>  	printf "$commit ($i/$commits) "
>  
>  	git-read-tree -i -m $commit

More portable would be

        i=`expr $i + 1`

since not everything has bc installed.  Is $(...) available generally?
I thought it was a bashism, too.


-- 
David Kastrup
