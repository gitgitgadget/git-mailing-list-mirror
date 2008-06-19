From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git diff --cc bug
Date: Thu, 19 Jun 2008 10:11:35 +0200
Message-ID: <485A14B7.8080807@viscovery.net>
References: <48510CFA.3060101@viscovery.net> <48565311.9070407@viscovery.net> <7vhcbpx6bq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:12:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9FG1-0008A4-Ck
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 10:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754753AbYFSILm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 04:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756249AbYFSILl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 04:11:41 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:42967 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739AbYFSILj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 04:11:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9FF1-0000dV-RT; Thu, 19 Jun 2008 10:11:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 76AA8AFCC; Thu, 19 Jun 2008 10:11:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vhcbpx6bq.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85456>

Junio C Hamano schrieb:
> The problem is that the internal data structure hooks the deleted lines in
> front of the surviving line that follows it.  That means that showing the
> sline[] that holds "void CValuesView::" will show the unwanted "-LRESULT"
> deletion part as part of it.
> 
> You can view this in action by running "git diff -U2" in your tarball
> repository.  By reducing the context to 2, the leading edge context now
> begins at the opening brace after "void CValuesView::" line, which does
> not have deletion lines in front of it, so you will see what you expect.
> 
> This patch would fix it for the sample repository, but I am not sure if it
> has unintended side effects.

I can verify that it fixes the case in hands as well as a "symmetric" one
where the accidentally visible deletion is against the first parent, i.e.
it looks like "- delete_me" instead of the " -delete_me" above. I also did
some brief tests with various "normal" conflict diffs, and looked at a
number of merges in my repository, and I noticed nothing odd with this
patch. So:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
