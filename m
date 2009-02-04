From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Wed, 04 Feb 2009 10:00:11 -0800
Message-ID: <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de>
 <7vvdrqunog.fsf@gitster.siamese.dyndns.org> <4989CF79.2070209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:01:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUm4I-0006qj-Ju
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbZBDSAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbZBDSAU
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:00:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbZBDSAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:00:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1103C96C7A;
	Wed,  4 Feb 2009 13:00:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2571B96C75; Wed,
  4 Feb 2009 13:00:12 -0500 (EST)
In-Reply-To: <4989CF79.2070209@viscovery.net> (Johannes Sixt's message of
 "Wed, 04 Feb 2009 18:25:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AE866AB2-F2E5-11DD-A0C5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108402>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Because if the repository is non-bare, then filter-branch updates the
> work-tree at the end of the run; we don't want to overwrite uncommitted
> work in this case.
>
> This behavior is a relic from cg-admin-rewritehist, I think. I've never
> found it useful.

Ok, I think "read-tree -m -u HEAD" at the end sort of makes sense, if you
filtered the branch you are currently sitting on.  Does that mean we do
not have to barf on dirtyness if we can tell if the filter-branch will not
touch the current branch at all?  Again, I am not suggesting it as an
improvement, but I am trying to see if I am talking a total nonsense.

Is the reason why you haven't found it is useful is because you never
filter the current branch?
