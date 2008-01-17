From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 11:52:23 +0100
Message-ID: <478F3367.8050307@viscovery.net>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 11:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFSMp-0007tv-87
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 11:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYAQKwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 05:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYAQKwe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 05:52:34 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20268 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbYAQKwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 05:52:34 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFSM6-0007ZR-6U; Thu, 17 Jan 2008 11:52:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 649A254D; Thu, 17 Jan 2008 11:52:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080117091558.GA8341@hashpling.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70844>

Charles Bailey schrieb:
> I'm assuming that this original patch and the test update turned into
> the following commit in master:
> 
> c3b0dec509fe136c5417422f31898b5a4e2d5e02 is first bad commit
> 
> I just thought I should warn you that this seems (git bisect tells me
> so) to have caused a failure in t9301-fast-export.sh on my Mac OS X
> 10.4.11 machine although I haven't yet had the time to investigate
> why.

I observed the same (on Windows). The reason is that above-mentioned
commit introduces a call to parse_objects(). But by the time that
fast-import calls write_ref_sha1() (and, hence, this new parse_objects())
it has not yet written a pack file, and parse_objects() fails. I don't
have a clue how to fix this short of reverting the commit.

-- Hannes
