From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clean: handle errors if removing files fails
Date: Wed, 20 Feb 2008 16:12:16 -0800
Message-ID: <7vodab182n.fsf@gitster.siamese.dyndns.org>
References: <20080220234154.GS31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRz3v-0004y3-6u
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbYBUAMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYBUAMn
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:12:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbYBUAMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:12:43 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4D6561ED;
	Wed, 20 Feb 2008 19:12:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1F24961EC; Wed, 20 Feb 2008 19:12:36 -0500 (EST)
In-Reply-To: <20080220234154.GS31441@genesis.frugalware.org> (Miklos Vajna's
 message of "Thu, 21 Feb 2008 00:41:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74578>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Consider the following case:
>
> $ sudo mkdir foo
> $ sudo touch foo/bar
>
> This is the old output:
>
> $ git clean -f -d
> Removing foo/
>
> No error message.
>
> This is the new output:
>
> $ ~/git/git/git clean -f -d
> Removing foo/
> fatal: failed to remove 'foo/'

That's quite different style from the other commit log messages
in the project, isn't it?

While I agree reporting an error is definitely an improvement, I
do not think dying in the middle is the right thing to do.

Shouldn't it note the error, remove other cruft, and then
finally signal the error by exiting non-zero?
