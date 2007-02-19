From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: removal of "percent done" messages from git pull
Date: Mon, 19 Feb 2007 15:30:33 +0000
Message-ID: <1171899033.5129.13.camel@pc1117>
References: <45D5E06B.6020706@lightspeed.com> <tnxr6sm5m2u.fsf@arm.com>
	 <Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 16:31:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJATq-0004zd-E7
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 16:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXBSPa5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 10:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbXBSPa5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 10:30:57 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:65351 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932332AbXBSPa5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Feb 2007 10:30:57 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l1JFUYYo010394;
	Mon, 19 Feb 2007 15:30:34 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 19 Feb 2007 15:31:33 +0000
In-Reply-To: <Pine.LNX.4.63.0702191611410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 19 Feb 2007 15:31:33.0383 (UTC) FILETIME=[08FB2970:01C7543B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40133>

On Mon, 2007-02-19 at 16:12 +0100, Johannes Schindelin wrote:
> > Larry Streepy <larry@lightspeed.com> wrote:
> > > I run a nightly script to build and test our product.  I capture all
> > > the output and email it to interested parties.  One very annoying
> > > thing is the "percent done" messages that come out of git pull.  It
> > > results in log files that look like this:
> > [...]
> > > I have found no way to make these messages go away.  When running in a
> > > "batch" mode, IMHO, interactive messages like these should not be
> > > emitted. At least there should be a switch to suppress them.
> > 
> > Or (as done in StGIT for some messages), only print those interactive
> > messages when stdout is a tty, i.e. "if (isatty(1))".
> 
> You mean something like this?
[...]
> +	if (!verbose && !isatty(1))
> +		quiet = 1;

Well, you might not want this to be the equivalent of --quiet as you
already have an option for it. I'm not familiar to the GIT internals but
it seems a bit more complicated since those messages are sent by the
server. Maybe some modification to the sideband.c but both error
messages and progress percentage seem to be sent on the same band #2.

-- 
Catalin
