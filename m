From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Tue, 03 Feb 2009 00:01:43 -0800
Message-ID: <7vskmwc5js.fsf@gitster.siamese.dyndns.org>
References: <cover.1233275583u.git.johannes.schindelin@gmx.de>
 <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
 <20090202124148.GB8325@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUGFk-0005ck-LW
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 09:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZBCICB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 03:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbZBCICA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 03:02:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbZBCICA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 03:02:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF95596E78;
	Tue,  3 Feb 2009 03:01:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A989B96E75; Tue,
  3 Feb 2009 03:01:49 -0500 (EST)
In-Reply-To: <20090202124148.GB8325@sigio.peff.net> (Jeff King's message of
 "Mon, 2 Feb 2009 07:41:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED3CC24C-F1C8-11DD-ADF7-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108163>

Jeff King <peff@peff.net> writes:

> I think this is a definite improvement over the current behavior. As I
> said before, I am not sure what is the right path (though I think I am
> leaning towards leaving the warning longer based on the recent
> discussion), but if we are to leave the default to warn and not refuse,
> I think this should definitely be applied.
>
> A few comments on the specific message:

Thanks.

The commit was only in 'pu', so I'll be amending it instead of applying an
incremental, but here is the interdiff to incorporate your comments.

 builtin-receive-pack.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git c/builtin-receive-pack.c w/builtin-receive-pack.c
index f2c94fc..09c07d9 100644
--- c/builtin-receive-pack.c
+++ w/builtin-receive-pack.c
@@ -217,17 +217,18 @@ static int is_ref_checked_out(const char *ref)
 
 static char *warn_unconfigured_deny_msg[] = {
 	"Updating the currently checked out branch may cause confusion,",
-	"as the index and work tree do not reflect changes that are in HEAD."
+	"as the index and work tree do not reflect changes that are in HEAD.",
 	"As a result, you may see the changes you just pushed into it",
 	"reverted when you run 'git diff' over there, and you may want",
 	"to run 'git reset --hard' before starting to work to recover.",
 	"",
 	"You can set 'receive.denyCurrentBranch' configuration variable to",
-	"'refuse' in the repository to forbid pushing into the current branch",
-	"of it."
+	"'refuse' in the remote repository to forbid pushing into the",
+	"current branch of it."
 	"",
 	"To allow pushing into the current branch, you can set it to 'ignore';",
-	"but this is not recommended unless you really know what you are doing.",
+	"but this is not recommended unless you arranged its work tree to get",
+	"updated to match what you pushed in some other way.",
 	"",
 	"To squelch this message, you can set it to 'warn'.",
 	"",
