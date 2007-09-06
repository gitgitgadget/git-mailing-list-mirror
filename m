From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 17:53:18 +0200
Message-ID: <85hcm7bxjl.fsf@lola.goethe.zz>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061506330.28586@racer.site>
	<20070906142155.GB3002@coredump.intra.peff.net>
	<857in3dfad.fsf@lola.goethe.zz>
	<20070906145035.GA3546@coredump.intra.peff.net>
	<85tzq7bzoz.fsf@lola.goethe.zz>
	<20070906153613.GA4008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITJfe-0007dC-Vx
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 17:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbXIFPx0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 11:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756216AbXIFPx0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 11:53:26 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:36063 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755764AbXIFPxZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 11:53:25 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 3A35F13E01;
	Thu,  6 Sep 2007 17:53:24 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 24EED13F2FC;
	Thu,  6 Sep 2007 17:53:24 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-071.pools.arcor-ip.net [84.61.55.71])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id CFCF413E17;
	Thu,  6 Sep 2007 17:53:19 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 16E051CAD71B; Thu,  6 Sep 2007 17:53:18 +0200 (CEST)
In-Reply-To: <20070906153613.GA4008@coredump.intra.peff.net> (Jeff King's message of "Thu\, 6 Sep 2007 11\:36\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57893>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 06, 2007 at 05:06:52PM +0200, David Kastrup wrote:
>
>> >   If an object that has automatic storage duration is not initialized
>> >   explicitly, its value is indeterminate. If an object that has static
>> >   storage duration is not initialized explicitly, then:
>> >
>> >   -- if it has pointer type, it is initialized to a null pointer;
>> 
>> That's actually a new one to me.  I don't think that it has been
>> always the case in ANSI C.
>
> I don't have the C89 standard, so it's hard to be authoritative.
> However, according to TCOR1 to the C89 standard, the original text of
> 6.5.7 contained:
>
>   If an object that has static storage duration is not initialized
>   explicitly, it is initialized implicitly as if every member that has
>   arithmetic type were assigned 0 and every member that has pointer type
>   were assigned a null pointer constant.

Maybe I am confusing this with the effects of calloc or memset(...,0).

> But for the case of pointer initializations, both have the same
> effect.  So I think it has always been the case. Pre-ANSI, who
> knows. :)

In the original K&R C, a null pointer likely could have been assumed
to have zero bits throughout.  The non-zero-bits NULL pointer concept
just reeks of standard committees...  So maybe this never had been an
issue, for different reasons.

> And now I must go get some real work done instead of snooping
> through standards. :)

Sorry for the diversion.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
