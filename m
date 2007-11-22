From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 02:41:12 +0100
Message-ID: <A10705BB-3825-49A8-9766-58479237D04C@wincent.com>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 02:42:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv15L-000377-1R
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbXKVBmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 20:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbXKVBmN
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:42:13 -0500
Received: from wincent.com ([72.3.236.74]:56293 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbXKVBmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 20:42:12 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM1fDh7032308;
	Wed, 21 Nov 2007 19:41:14 -0600
In-Reply-To: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65732>

El 22/11/2007, a las 1:18, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> - Junio, do you mean to suggest with your comment that when passing
>> untracked files either directly or indirectly (ie. when passing a di=
r
>> containing untracked files) that they should be added (ie. invoked =20
>> the
>> "add untracked" subcommand) in addition to running the "patch"
>> subcommand on the changed files?
>
> What I meant was that if "git add -i" (unrestricted) shows paths
> from a set A, "git add -i paths..." should show paths from a
> subset of the set A and that subset should be defined with the
> existing ls-files pathspec semantics.
>
> For example, if "(a)dd untracked" subcommand shows all untracked
> files when "add -i" was invoked without paths limitation, the
> restricted form "add -i paths..." would show only untracked paths
> that match the given set of patterns.  If "(p)atch" subcommand
> shows all modified tracked files when "add -i" was invoked
> without paths limitation, the restricted form "add -i paths..."
> would show only such modified tracked files whose names match
> the given set of patterns.

Ok, I've just posted a patch that implements this. This is now going =20
somewhat beyond my knowledge of git-diff-index, git-diff-files, and =20
git-diff-ls, so I am hoping someone more familiar with the plumbing =20
can review this. Basically I'm mostly a porcelain user and have hardly =
=20
touched the plumbing at all during these initial months using Git.

There may be more efficient ways of doing this, but for now I am =20
running git-ls-files once for each path parameter to determine whether =
=20
it corresponds to any tracked file(s). This is necessary to weed out =20
the untracked paths because passing these to git-diff-index or git-=20
diff-files otherwise spits out errors to the stderr.

Cheers,
Wincent
