From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH 1/1] Guilt: Fixed guilt-patchbomb temporary mbox deletion bug
Date: Tue, 6 Mar 2007 02:53:16 -0500
Message-ID: <20070306075316.GC26626@filer.fsl.cs.sunysb.edu>
References: <1173164506.4877.19.camel@gandalf.dcc.usm.my> <20070306074740.GB26626@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nur Hussein <hussein@cs.usm.my>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOUUN-0000ct-Nv
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933991AbXCFHxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933993AbXCFHxh
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:53:37 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44357 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933991AbXCFHxg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:53:36 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l267rGdP027547;
	Tue, 6 Mar 2007 02:53:16 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l267rGOJ027545;
	Tue, 6 Mar 2007 02:53:16 -0500
Content-Disposition: inline
In-Reply-To: <20070306074740.GB26626@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41557>

On Tue, Mar 06, 2007 at 02:47:41AM -0500, Josef Sipek wrote:
> On Tue, Mar 06, 2007 at 03:01:46PM +0800, Nur Hussein wrote:
> > A bug occurred where the temporary mbox is deleted even when 'N' or 'n' was selected
> > because of the incorrect use of the -a operator when testing user input. Fixed now to
> > use -o instead.
> > 
> > Signed-off-by: Nur Hussein <hussein@cs.usm.my>
> > ---
> >  guilt-patchbomb |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/guilt-patchbomb b/guilt-patchbomb
> > index 6f51b4b..ad80fb1 100755
> > --- a/guilt-patchbomb
> > +++ b/guilt-patchbomb
> > @@ -88,5 +88,5 @@ fi
> >  echo -n "Delete temporary directory? [Y/n] "
> >  read n
> >  
> > -[ "$n" != "n" -a "$n" != "N" ] && exit 0
> > +[ "$n" != "n" -o "$n" != "N" ] && exit 0
> >  rm -rf $dir
> 
> Would this actually work?
> 
> input		$n != n		$n != N		action (-a)	action (-o)
> ---------------------------------------------------------------------------
> <not N>		true		true		exit		exit
> n		false		true		rm		exit
> N		true		false		rm		exit
> 
> 
> The new statement seems wrong. The fact that the original statement had the
> logic inverted still remains. It should be exit if ($n==n || $n==N).

I fixed it up and commited it.

Thanks,

Josef "Jeff" Sipek.

-- 
It used to be said [...] that AIX looks like one space alien discovered
Unix, and described it to another different space alien who then implemented
AIX. But their universal translators were broken and they'd had to gesture a
lot.
		- Paul Tomblin 
