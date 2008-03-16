From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking repository
Date: Sun, 16 Mar 2008 13:38:33 -0700
Message-ID: <7vwso2ieuu.fsf@gitster.siamese.dyndns.org>
References: <frh8dg$t9j$1@ger.gmane.org>
 <7vabkzmltc.fsf@gitster.siamese.dyndns.org> <1205697779.12760.20.camel@duo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kenneth johansson <ken@kenjo.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jazdk-0005nq-O7
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 21:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYCPUix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYCPUiw
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 16:38:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbYCPUiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 16:38:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F17391C74;
	Sun, 16 Mar 2008 16:38:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C267D1C73; Sun, 16 Mar 2008 16:38:42 -0400 (EDT)
In-Reply-To: <1205697779.12760.20.camel@duo> (kenneth johansson's message of
 "Sun, 16 Mar 2008 21:02:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77379>

kenneth johansson <ken@kenjo.org> writes:

> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 	fetch = +refs/heads/*:refs/heads/*
> [remote "stable_2.6.12"]
> 	url =
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.12.y.git
> 	fetch = +refs/heads/*:refs/heads/stable_2.6.12_*

Daniel, I think we are looking at a regression.  The latter style, * at
the end but not immediately following a slash, should never have worked.
Wildcard expansion function should be erroring out when it sees something
like this.

Once we fix that regression, the above would stop working (in)correctly.
Rewrite it to something like this right now will make it keep working:

 	fetch = +refs/heads/*:refs/heads/stable_2.6.12/*
