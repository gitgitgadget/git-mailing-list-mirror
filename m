From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git wrapper: execute git-shell when argv[1] is '-c'
Date: Tue, 26 Aug 2008 10:43:40 -0700
Message-ID: <7vod3facz7.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <48B29B2A.6000802@gnu.org>
 <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
 <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.DEB.1.00.0808252251450.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080825210345.GE14930@eagain.net>
 <alpine.DEB.1.00.0808260001390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080825222002.GF14930@eagain.net>
 <alpine.DEB.1.00.0808260249090.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <vpqy72ktgg7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tommi Virtanen <tv@eagain.net>,
	Mikael Magnusson <mikachu@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:45:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2bC-000088-AL
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756971AbYHZRny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbYHZRny
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:43:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbYHZRnx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:43:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C0F368B41;
	Tue, 26 Aug 2008 13:43:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A1BF468B3F; Tue, 26 Aug 2008 13:43:42 -0400 (EDT)
In-Reply-To: <vpqy72ktgg7.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue, 26 Aug 2008 08:53:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BA35CCC-7396-11DD-B438-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93784>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Tue, 26 Aug 2008, Tommi Virtanen wrote:
>>
>>> All I'm going to say is that that's not the way you build trustable 
>>> software. You take a minimal interface and restrict untrusted users to 
>>> that, you don't add a feature to the widest possible interface..
>>
>> I do not get your point.
>
> With your patch, AAUI, one would put /usr/bin/git as a shell in
> passwd....

Well, it was sheer stupidity of mine.

Let's stop this and apply this patch instead.  The patch text is obvious
so I won't quote.

-- * --
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 25 Aug 2008 22:39:17 -0700
Subject: [PATCH] Revert "Build-in "git-shell""

This reverts commit daa0cc9a92c9c2c714aa5f7da6d0ff65b93e0698.
It was a stupid idea to do this; when run as a log-in shell,
it is spawned with argv[0] set to "-git-shell", so the usual
name-based dispatch would not work to begin with.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

 Makefile        |    2 +-
 builtin-shell.c |   90 -------------------------------------------------------
 builtin.h       |    1 -
 git.c           |    1 -
 shell.c         |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 93 deletions(-)
-- 
1.6.0.1.113.g0a79b
