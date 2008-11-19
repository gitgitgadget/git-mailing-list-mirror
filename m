From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 15:07:33 -0800
Message-ID: <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org>
References: <20081118211237.234d8035@crow>
 <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
 <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
 <20081119095452.3018d2de@crow>
 <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811191247560.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Burton <markb@ordern.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2wAs-00089H-NG
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 00:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbYKSXIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbYKSXIP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 18:08:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbYKSXIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 18:08:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B81DA7FACC;
	Wed, 19 Nov 2008 18:08:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C48E27FAC2; Wed,
 19 Nov 2008 18:07:35 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0811191247560.19665@iabervon.org> (Daniel
 Barkalow's message of "Wed, 19 Nov 2008 13:01:04 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F07E8640-B68E-11DD-BFDE-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101381>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I don't think that's what Mark wants, in this case. He's looking for the 
> ability to have "git commit" act on a temporary index created by adding to 
> the parent commit explicitly named files which aren't in the non-temporary 
> index.

Ah, I think that it would not be an entirely unreasonable thing to do
(cf. Message-Id: <7vtza4trdp.fsf@gitster.siamese.dyndns.org>).

You can say "git add that/directory" and .gitignore mechanism protects you
from crufts in that/directory, so fearing "git commit that/directory" to
add random junk to the next commit is not a reason to fear it.

But that is a huge behaviour change.  For example, I have a handful test
scripts in my t/ directory (all named following the usual t????-*.sh
naming convention) that I do not want to commit.  Today, after making
changes to the tracked test scripts, I can rely on "git commit t/" not to
include them in the commit, and I've _learned_ to trust that behaviour.
I'd be surprised if others who have used git for more than a few months
haven't done so as well.

Allowing what Mark wants without any explicit user customization will be a
disaster to the end user experience.
