From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Document 'git bisect fix'.
Date: Wed, 16 Mar 2011 12:47:07 +0100
Message-ID: <4D80A33B.8020006@drmicha.warpmail.net>
References: <20110311165802.GA3508@intel.com>	<4D7A64670200007800035F4C@vpn.id2.novell.com>	<AANLkTikG8wa1Em0bEUddbYpYs2TzFFTDb95qWFJ3xSbv@mail.gmail.com>	<4D7DE39302000078000362E6@vpn.id2.novell.com>	<20110314095534.GB18058@elte.hu>	<20110314104131.GG6275@bubble.grove.modra.org>	<20110314122342.GA26825@elte.hu>	<20110314131623.119020@gmx.net>	<20110314210001.GE4586@gmx.de> <AANLkTimAaL-C_oH9X3QFUc+JOaSi7xVe93KYJuL0VEyR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzpFW-0007rU-TW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063Ab1CPLum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:50:42 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59840 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751437Ab1CPLul (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 07:50:41 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 973ED20A64;
	Wed, 16 Mar 2011 07:50:40 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 16 Mar 2011 07:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nuWJAyfRUwGVnHdTOfnPBmHGAec=; b=ipJ/qxb59FpRC/C69fB9gNIsv6oQIq/cg3pXzaigrutmDew3bl/R7w/S0cxfngNgQPHL42XOh6Ht1Pam7QpP/RswmIs3F9oCfV+TUNG8TmCx8y7+hXWsOjgyxtydgXaQIzOVOD+S6drEDb5qjkibnhUjIGWNw+58N6/aBZtsrHU=
X-Sasl-enc: gB+dbTy2Zhg7H8zjMwl7ctjWOfY1E5UdUe8yVm4dPJqW 1300276240
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 25ADF440452;
	Wed, 16 Mar 2011 07:50:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTimAaL-C_oH9X3QFUc+JOaSi7xVe93KYJuL0VEyR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169149>

Christian Couder venit, vidit, dixit 16.03.2011 10:52:
> Hi,
> 
> On Mon, Mar 14, 2011 at 10:00 PM, Ralf Wildenhues
> <Ralf.Wildenhues@gmx.de> wrote:
>> git bisect is sometimes less effective than it could be in projects
>> with long-lived but simple bugs (e.g., little-tested configurations).
>> Rather than skipping vast revision ranges, it might be easier to fix
>> them up from known bugfix branches.
> 
> It's already possible to deal with this problem by creating a new
> branch where the bug is fixed, and then using "git replace", so that
> the new branch is used instead of the old one.
> Please search for "git replace" in this doc:
> 
> http://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html
> 
>> 'git bisect fix' teaches bisect about when some known bug was
>> introduced and when it was fixed, so that bisect can merge in
>> the fix when needed into new test candidates.
> 
> Perhaps some people would find it easier to use what you suggest but
> using git replace may be nicer because you have to create the new
> branch once, so you need to fix merge or rebase problems only once.
> And the new branch may be useful not only for bisecting, for example
> to recreate old versions.

I'd say the replace method is perfect for transporting an existing fix
"back in time" when the range of non-bisectable commits is limited. But
since you have to replace the right (most recent) commit in that range
it is less convenient when you have a fix due to a changed/exotic build
environment or such which you do not want in your mainline.

Also, you have to rebase the whole history back to the commit which
introduced the problem - and that could be the root commit if the bisect
problems arise from a changed toolchain, like here.

Michael
P.S.: Did you cull cc on purpose or did gmane mess up? Readding AM, LT, TG
