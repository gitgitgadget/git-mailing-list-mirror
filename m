From: Junio C Hamano <gitster@pobox.com>
Subject: Re: simple cvs-like git wrapper
Date: Wed, 30 Jan 2008 22:17:14 -0800
Message-ID: <7v63xafrit.fsf@gitster.siamese.dyndns.org>
References: <20080129204048.GA9612@venus>
	<m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus>
	<20080130040002.GM24004@spearce.org> <20080130225254.GC9612@venus>
	<20080131040839.GW24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ed S. Peschko" <esp5@pge.com>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:18:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKSkL-0002H2-Md
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 07:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYAaGR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 01:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYAaGR2
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 01:17:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbYAaGR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 01:17:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 54B56278C;
	Thu, 31 Jan 2008 01:17:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 962A02787;
	Thu, 31 Jan 2008 01:17:21 -0500 (EST)
In-Reply-To: <20080131040839.GW24004@spearce.org> (Shawn O. Pearce's message
	of "Wed, 30 Jan 2008 23:08:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72104>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This is going to be slow as you are running git-merge for each
> and every branch available to you.  You can do a lot better by
> loading the branch DAG into memory in Perl/C/Python and doing a
> graph coloring algorithm to see if a merge is necessary or not,
> as if you are merging everything all of the time almost everything
> is going to be always merged to everything else.  Which as I said
> earlier is nuts.

I guess you can ask "show-branch --independent" to cull branches
that are pure subset of other branches.

But no matter how you do this, the resulting history would be
less efficient to bisect if you make Octopus.

As you can ask "git log --no-merges" to omit merges from the
listing, I am not sure if it is worth it to avoid two-side
merges and insist on making an Octopus these days.
