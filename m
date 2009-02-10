From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: A little mystery - crash caused by empty commit message.
Date: Tue, 10 Feb 2009 12:46:38 +0100
Message-ID: <4991691E.6010808@viscovery.net>
References: <1a6be5fa0902100315q554dc457j8c8476d3f59a314f@mail.gmail.com> <20090210113234.GE12089@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWr63-0005Cf-DW
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZBJLqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbZBJLqo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:46:44 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50609 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZBJLqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:46:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LWr4Z-0008Te-B8; Tue, 10 Feb 2009 12:46:39 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E3E526D9; Tue, 10 Feb 2009 12:46:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090210113234.GE12089@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109214>

Jeff King schrieb:
> It _is_ generally hard to get an empty commit message using "git
> commit". But it's possible there is a bug in cherry-pick, rebase, or
> some ohter low-level tool that accidentally erased your message
> as the commit was moved.

Since this is on Windows, chances are that this is an encoding issue. If
you have non-ASCII in the commit message, but i18n.commitEncoding is
unset, then you can introduce invalid UTF8 sequences easily. This could
confuse one of the pipelines (rebase, am, cherry-pick, etc).

You should set

	git config i18n.commitencoding cp1252

(or whatever is appropriate for you locale). I even have

	git config i18n.logoutputencoding cp850

so that I see correct umlauts if I happen to run git log without a pager
in CMD ;) (I rarely do that, though.)

-- Hannes
