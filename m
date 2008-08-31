From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct documentation wording for diff options -S and
 --pickaxe-all
Date: Sun, 31 Aug 2008 16:21:43 -0700
Message-ID: <7v63pg3h4o.fsf@gitster.siamese.dyndns.org>
References: <20080831230304.GA30480@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Mon Sep 01 01:23:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZwG4-0003Vb-Tj
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 01:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYHaXVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 19:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYHaXVw
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 19:21:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36947 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbYHaXVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 19:21:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 90B5B6F954;
	Sun, 31 Aug 2008 19:21:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C071C6F953; Sun, 31 Aug 2008 19:21:47 -0400 (EDT)
In-Reply-To: <20080831230304.GA30480@zakalwe.fi> (Heikki Orsila's message of
 "Mon, 1 Sep 2008 02:03:04 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 96EB33D6-77B3-11DD-A9CB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94514>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
>  Documentation/diff-options.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 1759386..062a8ae 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -160,12 +160,12 @@ endif::git-format-patch[]
>  	number.
>  
>  -S<string>::
> -	Look for differences that contain the change in <string>.
> +	Look for differences that contain <string> in the change.
>  
>  --pickaxe-all::
>  	When -S finds a change, show all the changes in that
> -	changeset, not just the files that contain the change
> -	in <string>.
> +	changeset, not just the files that contain <string>
> +	in the change.


Thanks, but if we are doing this, we should reword it to something less
misleading.  The pickaxe search does not look for changes that contains
string in the sense people might expect (e.g. "diff -u0 | grep string").

The machinery looks at the old and new copy, and considers it a match if
they have different numbers of "string" in them.

So perhaps something like this

-S<string>::
	Look for differences that changes the number of <string> in the
	file.

--pickaxe-all::
	When -S finds a change, show all the changes in that changeset,
        not just the files for which the number of <string> in them
	changes.

but I am bad at writing, so I'll ask others to come up with a better
wording.
