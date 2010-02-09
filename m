From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5401-update-hooks test failure
Date: Tue, 09 Feb 2010 15:16:37 -0800
Message-ID: <7vljf2xane.fsf@alter.siamese.dyndns.org>
References: <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org> <20100208223107.GB21718@cthulhu>
 <7vpr4f9wey.fsf@alter.siamese.dyndns.org> <20100209045417.GA15210@cthulhu>
 <7v4olqlva7.fsf@alter.siamese.dyndns.org>
 <20100209175139.GA28936@spearce.org>
 <alpine.LFD.2.00.1002091337421.1681@xanadu.home>
 <20100209192628.GC28936@spearce.org>
 <7vpr4eyqok.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 00:17:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NezKX-0000WJ-2P
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 00:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab0BIXRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 18:17:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab0BIXRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 18:17:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1322A98791;
	Tue,  9 Feb 2010 18:16:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LC2UXA8wqn1vXkZfrV1Ls+q6Jto=; b=o6sNrW
	g0ZLxTwCBItAnfPUqLyZkr5uCeacur37RVRDhierPPKN5oaizhnjaYXghJ35KlSA
	1mGQ87CGcJOLmqwfricbALPdojR+NJ2J6zuOVA219BrxGs8YIkNAPguGjFaatNhn
	0EPeE55iD7sXkR8q1WJh+4eA2Y9wrvWLNyLqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U+pgeZOYgZcQR1Y1bDyzSiqO6b0GoW/f
	8eQo5kancSUj8YmR4loQgoqD9hYiOkqc/T/WI9xNi9vXSwqkp9oLqYDsz3/OUvtb
	JEhdafxi7/6IG5XXIXvRFbixYUExCpx1YUb7PKAbSHMTcWYHeSsuFuOwju8Y+kz5
	s8c1IveyAsg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B604A9878F;
	Tue,  9 Feb 2010 18:16:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3D639878E; Tue,  9 Feb
 2010 18:16:38 -0500 (EST)
In-Reply-To: <7vpr4eyqok.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 09 Feb 2010 14\:44\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 304DF416-15D1-11DF-B9A7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139458>

Oh, I hate myself ;-)

This seems to fix the test.  Could somebody please explain why?

I am guessing it has something to do with O_APPEND but I cannot come up
with a commit log message that clearly describes the fix.

 t/t5401-update-hooks.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index c3cf397..804431a 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -61,8 +61,9 @@ EOF
 chmod u+x victim/.git/hooks/post-update
 
 test_expect_success push '
+	rm -f send.out send.err &&
 	test_must_fail git send-pack --force ./victim/.git \
-		master tofail >send.out 2>send.err
+		master tofail >>send.out 2>>send.err
 '
 
 test_expect_success 'updated as expected' '
