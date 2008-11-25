From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Extra pair of double quotes in "git commit" output?
Date: Tue, 25 Nov 2008 14:02:17 -0800
Message-ID: <7vej0zjwgm.fsf@gitster.siamese.dyndns.org>
References: <20081126064906.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 23:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5616-0007hv-Jj
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 23:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbYKYWDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbYKYWDD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 17:03:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbYKYWDC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 17:03:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F3B5177BF;
	Tue, 25 Nov 2008 17:02:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D8F6E177C0; Tue,
 25 Nov 2008 17:02:18 -0500 (EST)
In-Reply-To: <20081126064906.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed, 26 Nov 2008 06:49:06 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D276EFD6-BB3C-11DD-97E7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101688>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> While I think the way recent "git commit" displays the commit you just created is very helpful, I often find the double quotes around the message unnecessary and sometimes even confusing.  I just made a commit and saw this message:
>
>     [master]: created d9a5491: "Show "standard deviation" column in table 3"
>
> The colon after the shortened commit SHA1 is enough to signal that it will talk about a different piece of information on the rest of the line.  I think the extra double quotes can be dropped safely:
>
>     [master]: created d9a5491: Show "standard deviation" column in table 3
>
> and it will make the output shorter by two columns, more pretty, and does not lose the clarity.

[offtopic.  Please wrap your text at a reasonable width around 70 columns]

Like this?

It might break some existing tests (I didn't check), but I think that is a
sensible thing to do.



 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git c/builtin-commit.c w/builtin-commit.c
index 591d16b..654bfbe 100644
--- c/builtin-commit.c
+++ w/builtin-commit.c
@@ -881,7 +881,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 {
 	struct rev_info rev;
 	struct commit *commit;
-	static const char *format = "format:%h: \"%s\"";
+	static const char *format = "format:%h: %s";
 	unsigned char junk_sha1[20];
 	const char *head = resolve_ref("HEAD", junk_sha1, 0, NULL);
 
