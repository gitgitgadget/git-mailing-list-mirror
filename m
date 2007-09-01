From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svn: fix dcommit clobbering upstream when committing multiple changes
Date: Sat, 1 Sep 2007 07:43:21 +0200
Message-ID: <20070901054321.GA8021@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site> <20070831234854.GA6451@mimvista.com> <20070901002501.GA11591@mimvista.com> <20070901011612.GA3407@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 07:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRLmH-0007X8-Px
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 07:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbXIAFoJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Sep 2007 01:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbXIAFoI
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 01:44:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3273 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXIAFoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 01:44:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IRLlR-0002Bc-00; Sat, 01 Sep 2007 06:43:21 +0100
Content-Disposition: inline
In-Reply-To: <20070901011612.GA3407@untitled>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57255>

On 2007-08-31 18:16:12 -0700, Eric Wong wrote:

> Although dcommit could detect if the first commit in the series
> would conflict with the HEAD revision in SVN, it could not detect
> conflicts in further commits it made.
>
> Now we rebase each uncommitted change after each revision is
> committed to SVN to ensure that we are up-to-date. git-rebase will
> bail out on conflict errors if our next change cannot be applied and
> committed to SVN cleanly, preventing accidental clobbering of
> changes on the SVN-side.
>
> --no-rebase users will have trouble with this, and are thus warned
> if they are committing more than one commit. Fixing this for
> (hopefully uncommon) --no-rebase users would be more complex and
> will probably happen at a later date.

Shouldn't it be a simple matter of checking if the total diff over the
whole series would conflict with the SVN HEAD?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
