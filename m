From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] in rev-parse
Date: Wed, 14 Dec 2011 19:20:41 -0800
Message-ID: <7vk45yplkm.fsf@alter.siamese.dyndns.org>
References: <20111214184926.GB18335@llunet.cs.wisc.edu>
 <20111214210157.GA8990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nathan.panike@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 04:20:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb1sH-0001Xg-N3
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 04:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab1LODUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 22:20:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755809Ab1LODUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 22:20:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 054E67107;
	Wed, 14 Dec 2011 22:20:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zJ3R4mcTa5lhp23MEhGPss2l600=; b=tpKp6n
	doiIwdoKAJncHi7hrqQhaMupS+R2BZoAkG9mvd2ikuha/n4Y2x/sRPy4zIc+lw8d
	VBHdEwKTKarhBXNLo3kloHEoJ+6IctHGTEVtlc6DYwtG/HZVmmto19k8ol20j5U6
	8CSLy2nkZbD2TVzJwqgWJ7WYKN+NlINkO6SgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRwKnkrseN6pu9FjoTMk/oEDa+EgNSDf
	crAi5zRUOSiOp0q5OaXN9Ggr22BYiwyw5Ig6O/+xAsgAPdMvdDJ/Y1P+ptVyu69T
	xJjHLwln2cRnfOyj/L1fqVZduFzYrkDEkTpF/BUuQU+t8/5YF+kyw0WtSt/FRLtA
	bdXp6VlMruI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F11CF7106;
	Wed, 14 Dec 2011 22:20:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C25F7105; Wed, 14 Dec 2011
 22:20:42 -0500 (EST)
In-Reply-To: <20111214210157.GA8990@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Dec 2011 16:01:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C52924C2-26CB-11E1-99EE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187186>

Jeff King <peff@peff.net> writes:

> On the other hand, it has been like this since it was introduced in
> 2006, and I wonder if scripts rely on the --verify side effect.

It would have been nicer if it did not to imply --verify at all; a long
hexdigit that do not name an existing object at all will be shortened to
its prefix that still do not collide with an abbreviated object name of an
existing object, and even in such a case, the command should not error out
only because it was fed a non-existing object (of course, if "--verify" is
given at the same time, its "one input that names existing object only"
rule should also kick in).
