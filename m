From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off by one error in prep_exclude.
Date: Sun, 27 Jan 2008 18:52:54 -0800
Message-ID: <7vodb6wtix.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, j.sixt@viscovery.net
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJK85-0001P2-6N
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 03:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYA1CxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 21:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbYA1CxF
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 21:53:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbYA1CxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 21:53:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7534218A8;
	Sun, 27 Jan 2008 21:53:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D606918A5;
	Sun, 27 Jan 2008 21:52:56 -0500 (EST)
In-Reply-To: <20080128003404.GA18276@lintop> (Shawn Bohrer's message of "Sun,
	27 Jan 2008 18:34:04 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71846>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> Nope the problem Johannes Sixt was having was that he mistakenly ran
>
> git clean -n /*foo
>
> Now that isn't what he meant to do, but I figured it might be possible
> that someone has their whole filesystem in a git repository, or maybe
> is using some sort of chroot on their repository.  Your malformed
> paths guess is probably much more likely to occur.

That is not a user error from the syntax point of view (although
it might be from the semantics point of view).  I think the
caller of the excluded() function (that is probably somewhere in
builtin-clean.c -- I did not check) is responsible for not
supplying such a path to the called function.
