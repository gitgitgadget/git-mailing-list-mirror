From: Jakub Narebski <jnareb@gmail.com>
Subject: Cross-compiling git (was: [PATCHv2] add Android support)
Date: Mon, 23 May 2011 00:04:44 -0700 (PDT)
Message-ID: <m3k4dhzynr.fsf_-_@localhost.localdomain>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
	<7vaaej9pt3.fsf@alter.siamese.dyndns.org>
	<2218C353-80FC-4540-A60E-608385384FB5@gieschke.de>
	<20110519122026.GA30240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Gieschke <rafael@gieschke.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 23 09:04:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOPCB-0004JR-J1
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 09:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab1EWHEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 03:04:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51983 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1EWHEq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 03:04:46 -0400
Received: by bwz15 with SMTP id 15so4455568bwz.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=b39l89B1e/Pd/6jTOInCdVzYgCJiQ0KlWvMVktMawKo=;
        b=el+LZO1+2Eu1gd1kCqwgK/tFSQntIqOAvdRuaQW0q39NPVh/FAPn/U+T2panET3u/Q
         T1k2c7AQZq+nvRLUN40ry5bAxX1iLPbDRwNc2dsdIv5spBW7fv+RRtV+T1jMHU+DHW89
         wM4c4FefElvBnfK2xs7h8AZv7upuROawoO7hk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vLdgF6hMtpSta2QojasqrEbWVdH80m1Tq+muwhzBBWwe/4A/mvNXnIq0uLp1wkCWYM
         +DGFLR8WelmmRjQIT/22SZv8yZ5Mt6QrRN5i3vVJMwMge0L08mukWg9gZxrxmZ1M5rB3
         DOZwvj/T8gL2n0Qax32GnJRHhomrLXvn36nfU=
Received: by 10.204.24.4 with SMTP id t4mr1892727bkb.109.1306134285326;
        Mon, 23 May 2011 00:04:45 -0700 (PDT)
Received: from localhost.localdomain (abvn87.neoplus.adsl.tpnet.pl [83.8.211.87])
        by mx.google.com with ESMTPS id l1sm3689043bkl.1.2011.05.23.00.04.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 00:04:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4N745xK031298;
	Mon, 23 May 2011 09:04:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4N73bJR031287;
	Mon, 23 May 2011 09:03:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110519122026.GA30240@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174226>

Jeff King <peff@peff.net> writes:
> On Thu, May 19, 2011 at 01:37:53PM +0200, Rafael Gieschke wrote:
> 
> > > (3) Add uname_S = Android (Makefile).
> > > 
> > > The first two would become much easier to justify if presented that
> > > way. At least you won't hear from anybody "we don't want that much code to
> > > not to run git on a phone!", as it is not entirely implausible to imagine
> > > environments without support for one or both of these two facilities.
> > 
> > So, you would prefer to leave out ANDROID and use something like "ifeq
> > ($(uname_S),Android)", so you will have to compile using make
> > uname_S=Android? I would be fine with that, too. But I would also be
> > fine with having to specify the build options on the command line or
> > using a config.mak if you want to keep Android out of the Makefile.
> 
> The point of uname_S is that it would be found automatically. Sadly,
> There is nothing helpful in uname to tell us that we are on android:
> 
>   $ uname -a
>   Linux localhost 2.6.37.4-cyanogenmod-01332-g7f230e8 #1 PREEMPT Tue Apr
>   12 12:54:14 EDT 2011 armv7l GNU/Linux
> 
> You could obviously guess from Linux on that architecture, but that
> seems flaky to me. You can also figure it out by looking around the
> filesystem, but that is not something I'm excited about having the
> Makefile do.
> 
> So I think we are probably stuck either with the user setting an ANDROID
> meta-flag that sets the other flags appropriately, or leaving it up to
> the user to provide a sane config.mak.

By the way, how well Git supports cross-compiling (which from the
thread is necessity to generate binaries for Android)?  `uname -a`
trick works only when compiling on same machine.

./configure supports --host and --build options, but I don't know if
it pass them down to make somehow.  ANDROID=YesPlease seems wasteful:
what about setting HOST or MACHINE, or even uname_* variables, or just
using Autoconf's `host` (in the form of CPU-VENDOR-OS)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
