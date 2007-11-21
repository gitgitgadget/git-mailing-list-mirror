From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: kernel versions in the history (feature request, probably)
Date: Wed, 21 Nov 2007 17:44:21 +0100
Organization: At home
Message-ID: <fi1n94$l8r$1@ger.gmane.org>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz> <47436E0F.6080003@o2.pl> <20071121032009.GB4175@fieldses.org> <20071121075217.GA1642@ff.dom.local> <20071121151831.GO1001@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755772AbXKURDy@vger.kernel.org Wed Nov 21 18:04:18 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755772AbXKURDy@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuszn-0006pd-Pg
	for glk-linux-kernel-3@gmane.org; Wed, 21 Nov 2007 18:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755772AbXKURDy (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 21 Nov 2007 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXKURDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Nov 2007 12:03:44 -0500
Received: from main.gmane.org ([80.91.229.2]:49672 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbXKURDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Nov 2007 12:03:43 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iusqs-0007lJ-FU
	for linux-kernel@vger.kernel.org; Wed, 21 Nov 2007 16:55:02 +0000
Received: from abxf19.neoplus.adsl.tpnet.pl ([83.8.255.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2007 16:55:02 +0000
Received: from jnareb by abxf19.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2007 16:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxf19.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65681>

Petr Baudis wrote:

> On Wed, Nov 21, 2007 at 08:52:17AM +0100, Jarek Poplawski wrote:
>> ...
>> tags
>> 4 days ago   v2.6.24-rc3     Linux 2.6.24-rc3
>> 2 weeks ago  v2.6.24-rc2     Linux 2.6.24-rc2
>> 4 weeks ago  v2.6.24-rc1     Linux 2.6.24-rc1
>> 6 weeks ago  v2.6.23         Linux 2.6.23
>> 
>> which drives me crazy, because, without looking at the calendar, and
>> calculator, I don't really know which month was 6 weeks ago, and 4
>> days ago, either!
> 
> I have myself never been sure if the relative times are a good idea or
> not. :-) Sometimes I hate them, sometimes they are more convenient...

Additionally if we want support caching in gitweb, and not need to rewrite
cached file, then we should use absolute time everywhere in gitweb (perhaps
rewriting to relative using JavaScript, or output filter,...).

There is some cutoff where gitweb stops displaying relative time and
displays date; gitweb should also always provide absolute date in tooltip
on mouseover (in title attribute), if it does not then it is a bug.

[...]
>> Of course, this problem doesn't look so hard if we forget about
>> git internals: I can imagine keeping a simple database, which
>> could simply retrieve commit numbers from these ChangeLogs, and
>> connecting this with gitweb's commit page as well... For
>> performance reasons, doing it only for stable and testing, so with
>> -rc 'precision' would be very helpful too.
> 
> It isn't too hard if we don't forget about git internals either. It's
> just that getting this information might not be cheap. But maybe I'm
> wrong and this won't be a problem for sane projects. Someone should post
> a patch. ;-)

Perhaps the following solution would be good idea:
 1. use git-describe to find nearest commit
 2. if it took long / if the distance from tag is large
    then make some special tag denoting calculated git-describe e.g.
    in tag name
 3. if found tag is helper tag created in previous step, recaulculate
    true git-describe from it, or just output closest contained tag.
This needs write access to repository, although can be done using simple
database... what do you think?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
