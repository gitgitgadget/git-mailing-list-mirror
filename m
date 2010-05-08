From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Date: Sat, 8 May 2010 00:53:20 -0400
Message-ID: <20100508045319.GD14998@coredump.intra.peff.net>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Sat May 08 06:54:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAc3q-0004Xj-NS
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 06:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab0EHExW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 00:53:22 -0400
Received: from peff.net ([208.65.91.99]:37064 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab0EHExW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 00:53:22 -0400
Received: (qmail 2693 invoked by uid 107); 8 May 2010 04:53:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 00:53:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 00:53:20 -0400
Content-Disposition: inline
In-Reply-To: <1273250247-20762-1-git-send-email-pkj@axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146636>

On Fri, May 07, 2010 at 06:37:27PM +0200, Peter Kjellerstedt wrote:

> Instead of specifying the SHA1 for the empty tree (i.e.,
> 4b825dc642cb6eb9a060e54bf8d69288fbee4904) one can now say [], e.g.,
> 'git diff [] v1.7.1' would give all the changes between the empty tree
> and the tag v1.7.1.

FWIW, I like the idea of a special namespace that indicates "this is not
a regular ref, but you can resolve it to some object". It seems to come
up once in a while, but I don't recall anybody ever actually making a
patch.

> The rationale for selecting [] as the alias for the empty tree was that
> it looks empty, the brackets are not used for anything related to
> references (AFAIK), they are not allowed in references according to
> 'man git-check-ref-format', and the syntax can easily be extended to
> allow other types of references by adding information between the
> brackets.

I am a little iffy on brackets, as they can invoke shell wildcarding
behavior. But the fact that they don't cause a syntactic conflict does
make them appealing.

Based on past discussions, I suspect other people would be interested
in:

  $ git diff [index] HEAD
  $ git diff HEAD [index]
  $ git diff [working-tree] [index]

etc. I don't think I would want to type those all the time, but they
conceptually are quite clear about what is happening, so they may be
nice for showing new users what is happening with each diff invocation
(as opposed to, say, "git diff --cached" versus "git diff", which is
somewhat unintuitive, even though it is more handy in practice).

-Peff
