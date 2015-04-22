From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is
 available
Date: Wed, 22 Apr 2015 20:00:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1504222000040.28561@s15462909.onlinehome-server.info>
References: <20150416084733.GA17811@peff.net> <20150416090138.GG17938@peff.net> <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Eric Sunshine <ericsunshine@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 20:01:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkyxX-0001zE-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 20:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbbDVSBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 14:01:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:60169 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932099AbbDVSBG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 14:01:06 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LyB6P-1ZMz3K1pkD-015YAc;
 Wed, 22 Apr 2015 20:00:55 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:p2cWJouK1u0+jRtI7encdTl4FNu2387yruEqpZ8rcHIaealWb2h
 G9CTZ8rVvjxn85soAfIM7WcWl4hcCz/bwfxurl0uLDDAuPvA+k2R23QQvhGeJB1YL/+A5+/
 378guED25KtP1fOlnfJteB3JrfjVFTaA5+V2KUqVN+eEGLyET0ALLeLuPsaO088XXblkQDT
 vLmQghFSks4ZGQrKFL1FA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267604>

Hi,

On 2015-04-17 12:16, Eric Sunshine wrote:
> On Thu, Apr 16, 2015 at 5:01 AM, Jeff King <peff@peff.net> wrote:
>> We spend a lot of time in strbuf_getwholeline in a tight
>> loop reading characters from a stdio handle into a buffer.
>> The libc getdelim() function can do this for us with less
>> overhead.

Just for the record: Git for Windows cannot lean on `getdelim()`, as it is not available on Windows. Do not let that stop you; if it turns out to impact performance, we will just have to come up with our own implementation of that function.

Ciao,
Dscho
