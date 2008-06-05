From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Keep committer and committer dates
Date: Wed, 04 Jun 2008 22:03:17 -0700
Message-ID: <7vy75k4goa.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.61.0806031647320.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806032115340.13507@racer.site.net>
 <Pine.LNX.4.61.0806041113520.1798@tm8103-a.perex-int.cz>
 <20080604102906.GA2126@diana.vm.bytemark.co.uk>
 <m3ej7dzc7y.fsf@localhost.localdomain>
 <Pine.LNX.4.61.0806041424140.1798@tm8103-a.perex-int.cz>
 <alpine.DEB.1.00.0806041641150.13507@racer.site.net>
 <20080605010330.GB24466@leksak.fem-net>
 <alpine.DEB.1.00.0806050523120.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, Jaroslav Kysela <perex@perex.cz>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 07:04:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K47eb-0000Mw-8C
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 07:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbYFEFDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 01:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYFEFDm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 01:03:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYFEFDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 01:03:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 219B21C93;
	Thu,  5 Jun 2008 01:03:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0EAE01C92; Thu,  5 Jun 2008 01:03:30 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806050523120.21190@racer> (Johannes
 Schindelin's message of "Thu, 5 Jun 2008 05:25:02 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C29C66A8-32BC-11DD-91B5-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83859>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course it is possible!  I even pointed to a method!
>
> The _point_ was that we do not want to recommend it.  And giving prominent 
> support for it, such as introducing a command line parameter, _would_ 
> have the effect of recommending it.

The world is no black and white, but here are some guidelines to think
about this issue:

 - We need to be able to lie when we are importing from a foreign SCM.  We
   want to get identical import if two different people imported from
   exactly the same foreign history at two different times.  Obviously
   recording the person as the committer who happened to run the import
   does not work here.

 - When we are mechanically filtering a history (e.g. filter-branch
   --subdirectory-filter), the point of the rewrite is not about
   reorganizing the commits but tidying up the history.  We would most
   likely want to keep the committer here, too.

 - We encourage private history to be tidied up before publishing by
   giving flexible ways to cherry-pick and rebase.  On the other hand, we
   very strongly discourage rebasing other people's commits.  If you are
   rebasing your own commits, there is no need to lie.
