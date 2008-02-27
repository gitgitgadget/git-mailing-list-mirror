From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use GIT_CONFIG in t5505-remote
Date: Wed, 27 Feb 2008 00:21:13 -0800
Message-ID: <7vd4qix11i.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802261713520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 09:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUHYA-0006zj-Tb
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 09:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbYB0IV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 03:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbYB0IV0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 03:21:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbYB0IV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 03:21:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A5D319A7;
	Wed, 27 Feb 2008 03:21:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9953119A5; Wed, 27 Feb 2008 03:21:20 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802261713520.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 26 Feb 2008 17:15:31 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75212>

Daniel Barkalow <barkalow@iabervon.org> writes:

> For some reason, t5505-remote was setting GIT_CONFIG to .git/config
> and exporting it. The sole effect of this was to cause the tests to
> fail if "git clone" obeyed it (which it presumably should).

Your patch is correct, as it was a no-op to set and export
GIT_CONFIG to .git/config there as Jeff pointed out.

But I think git-clone should explicitly ignore user-supplied
GIT_CONFIG in the environment if exists, when it wants to update
the configuration file for the new repository it created, as I
mentioned in the other message.

And I think scripted version has the same issue.  It would
update random places GIT_CONFIG points at, when it wants to
modify the configuration file for the new repository it just
built, which would be a bug.
