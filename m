From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Coverage support revisited
Date: Tue, 14 May 2013 00:33:15 +0200
Message-ID: <51916A2B.3060001@web.de>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 14 00:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1J7-0005wm-Ef
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 00:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab3EMWdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 18:33:21 -0400
Received: from mout.web.de ([212.227.15.4]:65109 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755163Ab3EMWdU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 18:33:20 -0400
Received: from [192.168.178.41] ([91.3.169.183]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Lc8c5-1UCYVX1gCT-00jDQO; Tue, 14 May 2013 00:33:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <cover.1368479988.git.trast@inf.ethz.ch>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:A5BUW2nU1trDpryljUxmhz5kYphKLGhi2EYicRKG0Re
 HHAOhRy6L/gJvq2I0CdSMB+jgwy58xaC+JMBOGgO4W/szJP6OU
 xKys3GuEeSMAS5FUckNDhDUM09VPlwB5dmw+Ddr5PL+92kCsjo
 NznZEvA0P3jJtCsMFmv0zyL6VU9XYzkccIBVhhRDK8Xb82RqaB
 ldX2akN72NE6OC56Wz/2Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224216>

Am 13.05.2013 23:27, schrieb Thomas Rast:
> Jens asked me at git-merge if coverage support was still available.
> Turns out it is, but there were some weirdnesses.  So this should fix
> them.  It is reaaaally slow as you still have to run the tests one by
> one; despite claims in the wild that it is multiprocess- safe but
> thread-unsafe, I am in fact observing the opposite behavior pretty
> clearly.  (As before, it switches to sequential tests automatically,
> so you have to edit the Makefile if you want to try with parallel
> tests.)

Thx! That might explain why the coverage run I tried today didn't
work (I saw bogus test failures).

> Below is the coverage-untested-functions output; it seems submodule.c
> is covered, so there is nothing for Jens to do ;-)

Hehe, I kinda expected that part ;-)

> unpack-trees.c: verify_clean_submodule

This is the one I was after. While discussing my recursive update
code with Peff on Saturday we wondered if that function would ever
be called. I'll check if the tests are missing some relevant cases,
if that function can be removed or some refactoring is necessary.

Hmm, while function coverage is already extremely useful me thinks
lcov support would be really nice. We'd have line and branch coverage,
which help me a lot in finding dead code and missing tests at $DAYJOB
... will look into that when I have the recursive update ready.
