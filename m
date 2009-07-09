From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 18:14:47 +0200
Message-ID: <4A561777.4080306@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <200907091642.05746.johan@herland.net> <4A560509.8060909@viscovery.net> <200907091732.49708.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 18:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwHJ-0006oK-AA
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760983AbZGIQOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760636AbZGIQOy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:14:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3239 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760610AbZGIQOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:14:53 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOwGl-0002Yp-MT; Thu, 09 Jul 2009 18:14:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 35F9F6B7; Thu,  9 Jul 2009 18:14:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091732.49708.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122987>

Johan Herland schrieb:
> On Thursday 09 July 2009, Johannes Sixt wrote:
>> But try this: Remove the signal(SIGPIPE, SIG_IGN)
>> and run the test suite. There is not a single failure.
> 
> That's not what I'm seeing. When I don't ignore the signal, the testsuite 
> fails intermittently for me (on Linux). I see the following tests fail:
> 
> - t3409-rebase-preserve-merges.sh (subtest #2)
> - t5503-tagfollow.sh (subtests #4, #6, #7)
> - t5505-remote.sh (subtests #10, #12, #14 - #20, #27)
> - t5510-fetch.sh (subtest #6 or #25)

I see. If I insert sched_yield() in the for loop, I see many failures (not
100% reproducible, but almost). On Windows, I have to insert Sleep(10) so
that the error exit is taken, and the error code is EINVAL :-/

-- Hannes
