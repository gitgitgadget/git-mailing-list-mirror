From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] gitignore: root most patterns at the top-level directory
Date: Wed, 28 Oct 2009 08:21:00 +0100
Message-ID: <4AE7F0DC.6010508@viscovery.net>
References: <20091027011024.GA29361@sigio.peff.net> <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32qE-0000RK-Fg
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbZJ1HU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbZJ1HU7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:20:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:7270 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932580AbZJ1HU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:20:59 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N32q5-0004sS-3C; Wed, 28 Oct 2009 08:21:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D81F4BC81; Wed, 28 Oct 2009 08:21:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vmy3cys0f.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131428>

Junio C Hamano schrieb:
> How does .cvsignore and .svnignore work?  Don't they have the same issue,
> and perhaps worse as I do not recall seeing a way to anchor a pattern to a
> particular directory like we do in their .SCMignore files?  And judging
> from the fact that they can get away with the lack of that "feature", this
> perhaps is not an issue in real life?

.cvsignore and .svnignore do not apply recursively to subdirectories, do they?

> For example, it crossed my mind that perhaps we can change the ignore
> rules so that a non-globbing pattern is automatically anchored at the
> current directly but globbing ones are recursive as before.
> 
> If we do so, there is no need to change the current .gitignore entires.
> You need to spell a concrete filename as a glob pattern that matches only
> one path if you want the recursive behaviour.  E.g. if you have a Makefile
> per subdirectory, each of which generates and includes Makefile.depend
> file, you would write "Makefile.depen[d]" in the toplevel .gitignore file.

In one project that uses autotools, I have "Makefile" and "Makefile.in" in
the top-level .gitignore. I would be forced to use this ugliness instead.

Granted, to write "/git", "/git-add", etc in .gitignore is not exactly
pretty, either, but the reason that it is so extra-ugly in the git code
itself is only because there are so many build products in a single
directory that cannot be caught by a glob pattern. In practice, you
usually have only a hand-full non-glob ignored files per directory; it
doesn't hurt to anchor them using "/frotz" style.

> But that is a kind of incompatible change whose necessity is unproven and
> has to cook and wait.

I would be concerned by this change.

-- Hannes
