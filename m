From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 00:55:58 -0700
Message-ID: <7v1vzvgjg1.fsf@gitster.siamese.dyndns.org>
References: <20080907103415.GA3139@cuci.nl>
 <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org> <48C4D631.3010604@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 09:57:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcbcc-0004J6-9J
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbYIHH4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYIHH4K
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:56:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbYIHH4J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:56:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A77A25E486;
	Mon,  8 Sep 2008 03:56:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EDE605E485; Mon,  8 Sep 2008 03:56:04 -0400 (EDT)
In-Reply-To: <48C4D631.3010604@gnu.org> (Paolo Bonzini's message of "Mon, 08
 Sep 2008 09:37:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98AA52BA-7D7B-11DD-BA61-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95226>

Paolo Bonzini <bonzini@gnu.org> writes:

> Question: how are topic branches managed in git.git?  In particular, how
> are "graduations to master" done?  Do you cherry-pick the merge commit
> that went into "next"?

Topics meant for master are always forked at the tip of master (or older)
and they are merged back to master when they prove Ok.

Topics that are fixes are forked at maint (or older) and if they are
trivial they are merged straight to maint and gets merged up to master.
Otherwise they are merged to next, cooked for a while, then merged to
master, cooked even more, and then finally merged to maint.

Of course, I am not perfect (I said I am not Linus, didn't I?) and do not
have perfect foresight, so sometimes I do a fix directly on 'master' and
realize it should also apply to 'maint' some time later.  They need to be
cherry-picked.
