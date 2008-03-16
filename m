From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Sun, 16 Mar 2008 19:37:05 +0100
Message-ID: <200803161937.07082.jnareb@gmail.com>
References: <20080313231413.27966.3383.stgit@rover> <20080316114151.GZ10103@mail-vs.djpig.de> <1205686355.2758.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Mar 16 19:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jaxjr-0006Bi-Hz
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 19:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYCPShD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 14:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYCPShD
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 14:37:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:56536 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYCPShB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 14:37:01 -0400
Received: by ug-out-1314.google.com with SMTP id z38so443075ugc.16
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Pyva47NuRp7HVyxDDQBz3N/wuHYPsU1+PJF4KtQFJmE=;
        b=XitO0lsV8kTqHOoq5z3TJw04+b0eNEcKbyd5Wmva3HSEfp5QuXu07rd/MwtGo7FZLTtC/3+SilI+HRtLyatVdc+mH8NQNB/nN6m1vygZvLXH5o6JNVAd8dHCPbSz1pv/iGzDb1iHV4D5uRAybLzmVho5FbwoyFE0zEDQivLYcBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uisgH+7R3dhdV4FEigdoJtTjJjLjL/7I6PDN2q2dUkWJGUVjRN4HpBaVQxU8ImpIvTOBmBXTbNB5snF0KAp1KTnMrvHoeViQGVnHXa+596OASlsBkJhB1cxZ6zliLR2EdhQOpR4vHlmLz1a1iZ/19jIUdIKaWpl+suj7IzosHl0=
Received: by 10.67.24.18 with SMTP id b18mr2216326ugj.52.1205692618396;
        Sun, 16 Mar 2008 11:36:58 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.206.62])
        by mx.google.com with ESMTPS id e34sm9346026ugd.17.2008.03.16.11.36.55
        (version=SSLv3 cipher=OTHER);
        Sun, 16 Mar 2008 11:36:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1205686355.2758.31.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77370>

On Sun, 16 Mar 2008, J.H. wrote:
> On Sun, 2008-03-16 at 12:41 +0100, Frank Lichtenheld wrote:
>> On Sat, Mar 15, 2008 at 02:44:42PM -0700, Jakub Narebski wrote:
>>>  
>>> This could be much simplified with perl-cache (perl-Cache-Cache).
>>> Unfortunately this is non-standard module, not distributed (yet?)
>>> with Perl.
>> 
>> I think somebody who actually needs this can be bothered to install a
>> CPAN perl module. This should probably not enabled by default anyway.
> 
> The people who need the caching are also likely those who are most
> averse to using things that don't either come with their distribution or
> aren't easily and readily available in something like an extras
> repository or a very well trusted contrib repository.  I can at least
> vouch for one large site that needs this that doesn't install things via
> cpan for a lot of different reasons.

Actually Cache::FileCache, which is part of CacheCache distribution,
should be available in contrib or even extras repository. I have
installed it as perl-Cache-Cache RPM (1.05-1.fc4.rf) on my Aurox 11.1
(which is old Fedora Core 4 based distribution), from Dries RPM
repository (part of FreshRPM now, IIRC).

The problem is that at least according to what documentation of other,
never CPAN modules says Cache::FileCache is slow, as it always serialize
using Storable (Storable should be part of perl distribution).


We can always install local copy alongside gitweb...


P.S. When searching CPAN for existing modules for caching and CGI
caching I have found Cache::Adaptive::ByLoad which does what
caching-gitweb does, and some solutions in newer caching interfaces,
either CHI or Cache which try to avoid thundering horde problem.

P.P.S. Does kernel.org use memcached, or some kind of web cache
(reverse proxy cache) like Varnish or Squid?
-- 
Jakub Narebski
Poland
