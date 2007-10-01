From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Mon, 01 Oct 2007 15:32:58 -0700
Message-ID: <7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Barry Fishman <barry_fishman@acm.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcTpC-0001UT-83
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 00:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbXJAWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbXJAWdE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 18:33:04 -0400
Received: from rune.pobox.com ([208.210.124.79]:60118 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbXJAWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 18:33:04 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id B148613FBFD;
	Mon,  1 Oct 2007 18:33:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0AE1613FBFC;
	Mon,  1 Oct 2007 18:33:21 -0400 (EDT)
In-Reply-To: <m3fy0u7bk3.fsf@barry_fishman.acm.org> (Barry Fishman's message
	of "Mon, 01 Oct 2007 17:46:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59642>

Barry Fishman <barry_fishman@acm.org> writes:

> $ git push --force /pub/git/foo.git master:master
> error: dst refspec master does not match any existing ref on the remote and does not start with refs/.
> fatal: The remote end hung up unexpectedly
> error: failed to push to '/pub/git/foo.git'

Read BOTH OF the error messages.  Especially the first one.

This error message is telling you that the dst side of the
refspec you supplied (that's the second 'master' in
"master:master") does not exist there, and we do not create it
unless you give a full refname that begins with refs/ (so that
push can tell if you want to create a tag or a branch).

$ git push /pub/git/foo.git master:refs/heads/master

would have worked, without --force.
