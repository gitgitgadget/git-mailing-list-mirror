From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/diff-options.txt: unify options
Date: Mon, 29 Dec 2008 00:47:49 -0800
Message-ID: <7vabafe5ai.fsf@gitster.siamese.dyndns.org>
References: <7vvdt4aj0e.fsf@gitster.siamese.dyndns.org>
 <8763l331l6.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Dec 29 09:49:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHDoN-0007sn-5n
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbYL2Ir5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbYL2Ir5
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:47:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbYL2Ir4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:47:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 441BD1B489;
	Mon, 29 Dec 2008 03:47:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2FC641B488; Mon,
 29 Dec 2008 03:47:50 -0500 (EST)
In-Reply-To: <8763l331l6.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Mon, 29 Dec 2008 15:03:17 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62024AB2-D585-11DD-9C0E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104082>

Thanks.

jidanni@jidanni.org writes:

> (You were right about my previous patch being bad.
> At least git-am gives an error message when fed
> http://article.gmane.org/gmane.comp.version-control.git/104017/raw
> git-apply however does nothing and returns 0! Must be a bug.)
> OK, here's a better patch:
>
> Signed-off-by: jidanni <jidanni@jidanni.org>

> ---

That commentary above your S-o-b is not a proper commit log message, but
I'll come up with something and apply.

$ wget http://article.gmane.org/gmane.comp.version-control.git/104017/raw
$ git apply raw
error: diff-options.txt: No such file or directory
$ echo $?
1

Even if you hand munge the "raw" file to have proper prefix, it will
refuse to apply a context-free diff.

$ git apply raw-edited
error: patch failed: Documentation/diff-options.txt:26
error: Documentation/diff-options.txt: patch does not apply
$ echo $?
1     

This is to avoid applying the patch only by line number without context;
see the last paragraph of <7vvdt4aj0e.fsf@gitster.siamese.dyndns.org> for
the explanation.

Upon a very rare case where you are absolutely sure that your copy is what the
patch is based on and that it is safe to applying a context-free patch
only by line number, you can give --unidiff-zero option to git-apply to
countermand this safety measure, but a patch posted on the public mailing
list for open source development rarely falls into that category.
