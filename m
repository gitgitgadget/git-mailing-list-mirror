From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: -L should show empty files
Date: Tue, 12 Jan 2010 00:32:34 -0800
Message-ID: <7vvdf73eql.fsf_-_@alter.siamese.dyndns.org>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain>
 <7v63774tfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 09:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUcBH-0008GW-TR
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 09:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab0ALIcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 03:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245Ab0ALIcs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 03:32:48 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0ALIcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 03:32:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41FAD8ECC4;
	Tue, 12 Jan 2010 03:32:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mJXkSatPlRBlArNkKkqr93QD5Ys=; b=ltYesN
	FUeeGXTPaaJ8gOL+dhZNhj9taeD9M04PubYwrTakj1+xulzoNsz5/8vbzXi5Ry5+
	Z4ItjTdUpDgUYrPf3l/f/nTeDLKjfBMaiAoF2jsF3PR+x81OtcdB/xQy7jUeC0dg
	JwQ1Td6mOxuYMYsfqFMvnL/DDd2LLtWXDFP08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URNRThS1BOk+j1X5FkX89fiEtmphf/NY
	98O/IvvAbILGao0isobJ8gPPMJG2Y/QZlS6QAXCXG5OkrENdyzqgu4MKe7FrJHS1
	1rluGmmKBdwejPBaq/uqvMALBRaB6zD4/xYL/voZrohS1t8X+Bu3svNIcvNV01hv
	2SbQ0HBLMMI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C8B8ECBE;
	Tue, 12 Jan 2010 03:32:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD9E28ECB7; Tue, 12 Jan
 2010 03:32:35 -0500 (EST)
In-Reply-To: <7v63774tfd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 12 Jan 2010 00\:29\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0CB7BCCC-FF55-11DE-B3F8-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136705>

The -L (--files-without-match) option is supposed to show paths that
produced no matches.  When running the internal grep on work tree files,
however, we had an optimization to just return on zero-sized files,
without doing anything.

This optimization doesn't matter too much in practice (a tracked empty
file must be rare, or there is something wrong with your project); to
produce results consistent with GNU grep, we should stop the optimization
and show empty files as not having the given pattern.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Fix for a longstanding bug meant for maint.

 builtin-grep.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index fd450bc..84a5af3 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -159,8 +159,6 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 			error("'%s': %s", filename, strerror(errno));
 		return 0;
 	}
-	if (!st.st_size)
-		return 0; /* empty file -- no grep hit */
 	if (!S_ISREG(st.st_mode))
 		return 0;
 	sz = xsize_t(st.st_size);
-- 
1.6.6.280.ge295b7.dirty
