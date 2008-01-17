From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Be more careful about updating refs
Date: Thu, 17 Jan 2008 13:41:00 +0100
Message-ID: <478F4CDC.2090703@viscovery.net>
References: <alpine.LFD.1.00.0801151546560.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801151600140.2806@woody.linux-foundation.org> <7vodblpmyc.fsf@gitster.siamese.dyndns.org> <20080117091558.GA8341@hashpling.org> <478F3367.8050307@viscovery.net> <20080117110132.GB12285@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 13:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFU3s-0008Bv-DA
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 13:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYAQMlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 07:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYAQMlH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 07:41:07 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14115 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYAQMlG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 07:41:06 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFU3D-0007b6-Dh; Thu, 17 Jan 2008 13:40:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AFEA354D; Thu, 17 Jan 2008 13:41:00 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080117110132.GB12285@hashpling.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70852>

Charles Bailey schrieb:
> On Thu, Jan 17, 2008 at 11:52:23AM +0100, Johannes Sixt wrote:
>> I observed the same (on Windows). The reason is that above-mentioned
>> commit introduces a call to parse_objects(). But by the time that
>> fast-import calls write_ref_sha1() (and, hence, this new parse_objects())
>> it has not yet written a pack file, and parse_objects() fails. I don't
>> have a clue how to fix this short of reverting the commit.
>>
> 
> OK, so it's not just Mac OS X, then.  From your description and my
> initial poke at the code,  I can't immediately see a good reason why
> the test should succeed on Linux, though.

My analysis is not correct. The pack file is present, but it seems to be
incomplete.

The reason is the NO_MMAP build flag. If you compile with
NO_MMAP=YesPlease on Linux, t9301 fails as well. Does this ring a bell?

-- Hannes
