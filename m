From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout does not warn about tags without corresponding
 commits
Date: Sat, 03 Jan 2009 03:53:28 -0800
Message-ID: <7vbpuo7ghz.fsf@gitster.siamese.dyndns.org>
References: <200901021325.58049.henrik@austad.us>
 <7v8wptcrhp.fsf@gitster.siamese.dyndns.org>
 <200901031200.01883.henrik@austad.us>
 <7vr63k8vvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Henrik Austad <henrik@austad.us>
X-From: git-owner@vger.kernel.org Sat Jan 03 12:55:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ56Q-0007WF-2U
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 12:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373AbZACLxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 06:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757048AbZACLxi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 06:53:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbZACLxh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 06:53:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 517741BAAA;
	Sat,  3 Jan 2009 06:53:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B6E9F1BAA0; Sat, 
 3 Jan 2009 06:53:30 -0500 (EST)
In-Reply-To: <7vr63k8vvf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 03 Jan 2009 03:36:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26A907E2-D98D-11DD-92FE-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104462>

Junio C Hamano <gitster@pobox.com> writes:

> I haven't looked at the code very closely, but I think this should fix
> it.  Thorough reviewing (not just running the test suite) is much
> appreciated.

Just for fun, this will apply to 782c2d6 (Build in checkout, 2008-02-07)
and seems to fix the issue ;-)

No, I am not going to issue a maintenance release for 1.5.5 just to
include this fix, even though I could.  I do not think this is a grave
enough regression to warrant a backport beyond 1.6.0 series.

 builtin-checkout.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git i/builtin-checkout.c w/builtin-checkout.c
index 59a0ef4..1d0de68 100644
--- i/builtin-checkout.c
+++ w/builtin-checkout.c
@@ -435,6 +435,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			argv++;
 			argc--;
 		} else if ((source_tree = parse_tree_indirect(rev))) {
+			new.name = arg;
 			argv++;
 			argc--;
 		}
