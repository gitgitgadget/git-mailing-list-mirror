From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Wed, 20 May 2015 16:12:38 +0200
Message-ID: <20150520141238.GA13990@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <20150519233925.GA22748@peff.net> <20150520131359.GA7043@frolo.macqel> <20150520132534.GI10518@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 20 16:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv4jo-0002w6-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 16:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbbETOMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 10:12:43 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:57798 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753958AbbETOMl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 10:12:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 0525B130CDD;
	Wed, 20 May 2015 16:12:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4K352lBYrgF; Wed, 20 May 2015 16:12:38 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 62810130CBF;
	Wed, 20 May 2015 16:12:38 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id 46159DF06BF; Wed, 20 May 2015 16:12:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150520132534.GI10518@serenity.lan>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269468>

Hi John,

On Wed, May 20, 2015 at 02:25:34PM +0100, John Keeping wrote:
> On Wed, May 20, 2015 at 03:13:59PM +0200, Philippe De Muyter wrote:
> > My initial problem (still unresolved/unanswered) is that some commits
> > that appeared between v3.14-rc1 and v3.14-rc2 (specifically
> > 817c27a128e18aed840adc295f988e1656fed7d1) are present in v3.15, but not
> > in my branch.
> > 
> > I have just checked online the v3.14 version on 
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/arch/arm/boot/dts/imx6qdl.dtsi 
> > 
> > and I see also the same "problem": the commit removing 738 lines is in the log
> > 817c27a128e18aed840adc295f988e1656fed7d1
> > "ARM: dts: imx6qdl: make pinctrl nodes board specific",
> > but the v3.14 version of the file still contains the 738 removed line,
> > and I see no commit restoring those lines.
> > 
> > I do not understand why those 738 lines are still present in v3.14 although
> > they were removed between v3.14-rc1 and v3.14-rc2 :(
> 
> Commit 817c27a128e18aed840adc295f988e1656fed7d1 isn't in v3.14:
> 
> $ git describe --contains 817c27a128e18aed840adc295f988e1656fed7d1
> v3.15-rc1~77^2~40^2~57
> 
> $ git tag --contains 817c27a128e18aed840adc295f988e1656fed7d1
> v3.15
> v3.15-rc1
> v3.15-rc2
> v3.15-rc3
> v3.15-rc4
> v3.15-rc5
> v3.15-rc6
> v3.15-rc7
> v3.15-rc8
> v3.15.1
> v3.15.10
> v3.15.2
> [snip later tags]
> 
> However, the commit date of 817c27a128e18aed840adc295f988e1656fed7d1 is
> between the dates of v3.14-rc1 and v3.14-rc2 so the default commit
> ordering of `git log` will show it between those two tags.
> `--topo-order` may help but I suspect the history is too complex to
> infer the relationship between commits without `--graph`.

OK and Thanks.  You saved me.  I began to think I was going mad or there
was a bug in git.

After reading the man page of 'git log', should --topo-order not be the
default log order ?

Philippe
