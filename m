From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] disallow providing multiple upstream branches to rebase,
  pull --rebase
Date: Wed, 18 Feb 2009 14:36:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902181436380.6274@intel-tinevez-2-302>
References: <1234932262-63469-1-git-send-email-jaysoffian@gmail.com>  <alpine.DEB.1.00.0902181118160.6274@intel-tinevez-2-302>  <76718490902180523l6df2067bxc1274a105756d16b@mail.gmail.com>  <alpine.DEB.1.00.0902181427030.6274@intel-tinevez-2-302>
 <76718490902180532l1de135ccyd4e58c713e6af2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmdA-0006PP-Vo
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZBRNhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZBRNhD
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:37:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:32789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752180AbZBRNhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:37:01 -0500
Received: (qmail invoked by alias); 18 Feb 2009 13:36:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp016) with SMTP; 18 Feb 2009 14:36:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/q3VpSVhPqHVIFfpAO1qxDoFvenzXh+qmPhDIgf/
	rpQDGV9ThQ5yFT
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718490902180532l1de135ccyd4e58c713e6af2c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110541>

Hi,

On Wed, 18 Feb 2009, Jay Soffian wrote:

> On Wed, Feb 18, 2009 at 8:28 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >> if test -z "$rebase_root"
> >> then
> >>       # The upstream head must be given.  Make sure it is valid.
> >>       upstream_name="$1"
> >>       shift
> >>       upstream=`git rev-parse --verify "${upstream_name}^0"` ||
> >>       die "invalid upstream $upstream_name"
> >>       unset root_flag
> >>       upstream_arg="$upstream_name"
> >> else
> >>       test -z "$newbase" && die "--root must be used with --onto"
> >>       unset upstream_name
> >>       unset upstream
> >>       root_flag="--root"
> >>       upstream_arg="$root_flag"
> >> fi
> >>
> >> will do the trick, yes?
> >
> > Nope.  Note the "shift" in the first arm?  It is so that the code below
> > can check for $#, and it indeed does, in a 'case' statement.
> 
> The case statement checks $# against 1 and *, not 1 and 0. And I don't
> see how > 1 is valid at that point. So I can modify the case statement
> to check against 1, 0, and have * emit usage, or I think moving the
> "test $# -gt 1 && usage" to where I suggested in the last message
> would do the trick. The only difference would be whether a pre-rebase
> hook runs in the case of invalid arguments (the case statement is
> after that hook runs).

Of course, you could also leave the test where it was, and just replace 
the 1 by a 2.

Ciao,
Dscho
