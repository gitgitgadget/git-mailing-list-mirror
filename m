From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] Add "partial commit" tests during a conflicted merge
Date: Fri, 23 Jan 2009 08:32:15 +0100
Message-ID: <4979727F.80007@viscovery.net>
References: <4978202C.3090703@viscovery.net> <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net> <49779521.9040208@drmicha.warpmail.net> <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com> <20090123094509.6117@nanako3.lavabit.com> <7viqo64kfo.fsf@gitster.siamese.dyndns.org> <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org> <49796D0C.5070408@viscovery.net> <7vab9i331g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 08:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGY0-0000cA-Ai
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 08:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZAWHcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 02:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbZAWHcW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 02:32:22 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57334 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbZAWHcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 02:32:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LQGWV-0008Q7-K7; Fri, 23 Jan 2009 08:32:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5D32F6EF; Fri, 23 Jan 2009 08:32:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vab9i331g.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106848>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>>> +test_expect_success 'reject --only during a merge' '
>>> +	git checkout HEAD^0 &&
>>> +	git reset --hard the-other-side-says-nitfol &&
>>> +	test_must_fail git merge one-side-says-frotz &&
>>> +	echo yomin-only >file &&
>>> +	test_must_fail git commit -m merge --only file &&
>> I don't see why this must fail: 'file' is the only file that is different
>> from HEAD. Yes, currently we fail; but if something is about to be
>> changed, then this can change as well.
> 
> Not at all.

Read again what I said: 'file' is the *ONLY* file that is different from
HEAD. Why should an explicit --only not work in this case?

> Avoiding --only is to prevent a much more dangerous glitch.
[...]

We are in total agreement about what you said in the rest of the message.

I'm proposing that, during a merge, if --only was given (or remains the
implicit choice), then we compare the index with HEAD, and if nothing
outside the given pathspec differs from HEAD, then allow the commit.

-- Hannes
