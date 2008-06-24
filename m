From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: create intermediate directories of destination
 repo
Date: Tue, 24 Jun 2008 00:39:40 -0700
Message-ID: <7v3an3e0xv.fsf@gitster.siamese.dyndns.org>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com>
 <alpine.LNX.1.00.0806231554380.19665@iabervon.org>
 <20080623203835.GA8105@sigill.intra.peff.net>
 <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil> <20080624055022.GC19224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Daniel Barkalow <barkalow@iabervon.org>, zuh@iki.fi,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:40:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB395-0000sT-6v
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 09:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbYFXHj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 03:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbYFXHj6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 03:39:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbYFXHj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 03:39:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 17A9612DE3;
	Tue, 24 Jun 2008 03:39:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3859E12DE2; Tue, 24 Jun 2008 03:39:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD90003A-41C0-11DD-BA61-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86003>

Jeff King <peff@peff.net> writes:

> The shell version used to use "mkdir -p" to create the repo path, but
> the C version just calls "mkdir". Let's replicate the old behavior. In
> this case we can simply create the directories leading up to the git
> dir. If it's a bare repo, then that is everything that init_db wants
> ahead of time. If it isn't bare, then the worktree contains the git dir,
> so we create the worktree.

Clever ;-)

> The big difference is that safe_create_leading_directories will do an
> adjust_shared_perm on the result. I don't think that should be a
> problem, but it is a difference.

This early in the code you would not have read anything that triggers
"shared" so it probably is not a problem, I would think.
