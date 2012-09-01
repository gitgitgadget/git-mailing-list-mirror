From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] fetch: use argv_array instead of hand-building arrays
Date: Sat, 01 Sep 2012 16:34:32 +0200
Message-ID: <50421CF8.60703@web.de>
References: <20120901112251.GA11445@sigill.intra.peff.net> <20120901112735.GB19163@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dan Johnson <computerdruid@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 01 16:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7onc-0003rs-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 16:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab2IAOeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 10:34:50 -0400
Received: from mout.web.de ([212.227.15.4]:57614 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136Ab2IAOet (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 10:34:49 -0400
Received: from [192.168.178.41] ([91.3.157.191]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0M24vT-1TRXeh1BVb-00tDO6; Sat, 01 Sep 2012 16:34:39
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <20120901112735.GB19163@sigill.intra.peff.net>
X-Provags-ID: V02:K0:IbRr5EtYUNeNJhnSIe2lZsV8mSLHd6gS1ltBcH/JT0L
 Xot8K31rTzmKOD9WOxDYsDE1ksZd9MF5efeQl7Og4hPKsUOxCK
 kvQXD9rNWcdnHCVgISUUKl8CTXllWNv9e1tU1b4dkKbeYIpN6e
 dNMEcpTjfEanzMscdbpaE7U9/Ppj72fahWUwi+8ljlTN/Ja7sv
 R1uQCmpMK/oUFmfaX0sFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204632>

Am 01.09.2012 13:27, schrieb Jeff King:
> Fetch invokes itself recursively when recursing into
> submodules or handling "fetch --multiple". In both cases, it
> builds the child's command line by pushing options onto a
> statically-sized array. In both cases, the array is
> currently just big enough to handle the largest possible
> case. However, this technique is brittle and error-prone, so
> let's replace it with a dynamic argv_array.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not very well tested by me, but hopefully it is simple enough that I
> managed not to screw it up.

This is definitely an improvement, and I can't spot any problems
either.

> It may be that fetch_populated_submodules would also benefit from
> conversion (here I just pass in the argc and argv separately), but I
> didn't look.

Yes, it does some similar brittle stuff and should be changed to use
the argv-array too. I'll look into that.
