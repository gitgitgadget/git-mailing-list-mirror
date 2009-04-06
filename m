From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify .gitattributes search
Date: Sun, 05 Apr 2009 22:46:17 -0700
Message-ID: <7viqlicp1y.fsf@gitster.siamese.dyndns.org>
References: <49D96C63.9070200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jason Merrill <jason@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:48:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqhh8-0007iP-6R
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbZDFFq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZDFFq0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:46:26 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbZDFFqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:46:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 56465CBE6;
	Mon,  6 Apr 2009 01:46:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 886FDCBE2; Mon, 
 6 Apr 2009 01:46:18 -0400 (EDT)
In-Reply-To: <49D96C63.9070200@redhat.com> (Jason Merrill's message of "Sun,
 05 Apr 2009 22:43:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4266172A-226E-11DE-8BC9-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115766>

Jason Merrill <jason@redhat.com> writes:

> From 04b504dc0c174d697cc1b75829fe2f7473f193ce Mon Sep 17 00:00:00 2001
> From: Jason Merrill <jason@redhat.com>
> Date: Sun, 5 Apr 2009 21:54:37 -0400
> Subject: [PATCH] Documentation: clarify .gitattributes search

You do not want these four lines in the body of the message.

>  When deciding what attributes are assigned to a path, git
>  consults `$GIT_DIR/info/attributes` file (which has the highest
>  precedence), `.gitattributes` file in the same directory as the
> -path in question, and its parent directories (the further the
> -directory that contains `.gitattributes` is from the path in
> -question, the lower its precedence).
> +path in question, and its parent directories within the git repository
> +(the further the directory that contains `.gitattributes` is from the
> +path in question, the lower its precedence).

I initially:

 (1) thought this was in "it goes without saying" category (but I am at
     fault here---losing git virginity long time ago);

 (2) also wondered why you were confused to think if your home directory
     (for that matter, any higher directory, like /.gitattributes at the
     filesystem root level) that is clearly outside of the project could
     possibly affect what happens inside a project; and

 (3) was puzzled why you do not have any patch to description of ignore
     files (perhaps you do not even a similar confusion on them).

The last point was interesting, because the documentation of gitignore
uses this language:

 * Patterns read from a `.gitignore` file in the same directory
   as the path, or in any parent directory, with patterns in the
   higher level files (up to the root) being overridden by those in
   lower level files down to the directory containing the file.
   These patterns match relative to the location of the
   `.gitignore` file.

So "up to the root" might help.  It might not.

A few questions.

 (1) To a long-time git person, "up to the root" is obviously talking
     about the toplevel of the work tree, not "root of the filesystem",
     but is it clear to _you_ (or do you think it would be clear to
     somebody else without much previous exposure to git)?

 (2) If not, I think we should come up with a good wording and use that in
     both.  How does the "toplevel of the work tree" sound for that
     purpose?

I would want to avoid the word "directories within the git repository",
because people would misinterpret that to mean directories like .git/refs
and .git/objects/info, which is clearly not what you meant here.
