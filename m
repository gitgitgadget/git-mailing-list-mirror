From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master' but should be
Date: Fri, 18 Jan 2008 03:09:21 -0800
Message-ID: <7vzlv3e6fy.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<8c5c35580801180215s2c980b4kbc66fbb05778ff67@mail.gmail.com>
	<7vwsq7fn2e.fsf@gitster.siamese.dyndns.org>
	<8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 12:10:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFp6j-0004ZL-Jn
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 12:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbYARLJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 06:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbYARLJ3
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 06:09:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbYARLJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 06:09:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D5EF36D12;
	Fri, 18 Jan 2008 06:09:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 535766D0F;
	Fri, 18 Jan 2008 06:09:24 -0500 (EST)
In-Reply-To: <8c5c35580801180253x9022e62qf1ec515e101fb294@mail.gmail.com>
	(Lars Hjemli's message of "Fri, 18 Jan 2008 11:53:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70999>

"Lars Hjemli" <hjemli@gmail.com> writes:

> Hmm, isn't a nonfunctional libgit considered breakage? Without
> something like this patch it is no longer possible to use
> write_tar_archive()/write_zip_archive() in libgit.a.

Sorry, but libgit.a is not part of what we deliver.  We do not
support linking random stuff against libgit.a.  We never did.
It is not a "library".

It has always been just an implementation detail for us to be
lax about our Makefile, so that we do not have to write down
exactly which *.o files git-foo command depended upon (and it is
ceasing to be useful for that as very many things have moved to
"the single git binary" these days).  Instead we let the linker
pick out the necessary pieces out of the archive.

So, no, there is no breakage.

The code movement you did _should_ not hurt so it may be a fine
material for post 1.5.4, but I haven't carefully compared what
other change might have accidentally snuck in that patch, and I
would rather not have to during the rc cycle.
