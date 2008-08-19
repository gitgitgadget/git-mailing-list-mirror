From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 00:02:58 -0700
Message-ID: <7viqtxh4gt.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org> <48AA4430.3060207@gmail.com>
 <7vmyj9h567.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <neoeinstein@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:04:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLGH-00040P-Cx
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYHSHDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYHSHDL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:03:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYHSHDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:03:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A13C35F216;
	Tue, 19 Aug 2008 03:03:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C80185F215; Tue, 19 Aug 2008 03:03:02 -0400 (EDT)
In-Reply-To: <7vmyj9h567.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Aug 2008 23:47:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E0494D5C-6DBC-11DD-96CD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92816>

Junio C Hamano <gitster@pobox.com> writes:

> What I did not bother in the patch is --no-index codepath, but with the
> recent refactoring of it to separate it out from the normal "index vs work
> tree" codepath, I would expect it to be trivial to use "1/" vs "2/" (or
> "old/" and "new/") prefixes for them.  I didn't actually look, though.

Ok, I looked.  It is indeed easy enough ;-)

---
 diff-no-index.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git i/diff-no-index.c w/diff-no-index.c
index 7d68b7f..126ff1c 100644
--- i/diff-no-index.c
+++ w/diff-no-index.c
@@ -252,6 +252,7 @@ void diff_no_index(struct rev_info *revs,
 	if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
 		       revs->diffopt.paths[1]))
 		exit(1);
+	diff_set_default_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 
