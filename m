From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 14:19:35 -0800
Message-ID: <7vtywiqmbs.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <20091125203922.GA18487@coredump.intra.peff.net>
 <7viqcytjic.fsf@alter.siamese.dyndns.org>
 <20091125210034.GC18487@coredump.intra.peff.net>
 <7vmy2as319.fsf@alter.siamese.dyndns.org>
 <20091125214949.GA31473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 25 23:19:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDQDG-0003fF-Dr
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 23:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbZKYWTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 17:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbZKYWTi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 17:19:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964853AbZKYWTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 17:19:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D16282BC4;
	Wed, 25 Nov 2009 17:19:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAfri6eUHGHNno6rRRJRkby/4JM=; b=GiUrzc
	YMKcUTxMYtcbDmwYNpr37Op/Tcf2G6oaUos/gSizpRjfJyrrtp6BMftO8iwaEeIG
	jpg9MAPLHT7gWUROKRPDhVpPL82LbTqAFXJfjcK7aIPdcChaek34WUV4VgWc5N1V
	NCZvLZ7IHrYrc0U8YBRd2vUMefVRCn7GKHxaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xS7Ots65yhnPjMKMgbqR5AzvNOOAeMB7
	25DT1IKM1hQJQ2eGAeSNb42UEy3x/wTVHY7oLcoOfvbVCn6l2WfD+NEJ4NqleoDb
	fH3xQs4glPDs0I858XVlarc5XVwD9lGPgt2FJqYzAPC3al3SSNsxMNVp9/EwvFgT
	s6K52vp++8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1719582BC2;
	Wed, 25 Nov 2009 17:19:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CBE982BAC; Wed, 25 Nov
 2009 17:19:37 -0500 (EST)
In-Reply-To: <20091125214949.GA31473@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 25 Nov 2009 16\:49\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FA8149C-DA10-11DE-8CBC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133683>

Jeff King <peff@peff.net> writes:

> ... That is, I don't want to have to remember "git grep
> --full-tree" or "git grep /" every time

But that cuts both ways.  If you change the default to full-tree,
people will forget to put "." every time when asking to limit to the
current directory.

> If I am the one who sets the configuration variable to something more
> sensible for my workflow, who am I hurting?

Somebody more clueful in git than you who is called to help you in your
repository when you have trouble.  Obviously "you" in this sentence is not
Jeff King, but I think you get the point.

And re-read what I wrote in its entirety and notice I am not disagreeing
with you that the long term goal should be to have the default changed
consistently for all command to do the full tree.  The important first
step is to make sure we are capable of doing both full tree and limit to
current directory and "grep" is one example that cannot do both, and be it
the --full-tree option or new /rooted-pathspec, we need some change _now_
that is backward compatible to pave the way for later changes.  We give
people convenient way to choose between the two, and _train_ them to
express which way they want _without_ having to think.  After that is
achieved, the default does not matter much and we can safely change the
default.

Think of it as a way to force existing users _unlearn_ the command
specific default we currently have.  Because any change of default will
hurt them until that is done, we should start training them as early as
possible.
