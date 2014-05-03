From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Sat, 3 May 2014 11:00:51 +0400
Message-ID: <20140503070050.GA8580@seldon>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
 <20140430114125.GA23046@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Sat May 03 09:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgTwQ-0006VQ-MC
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 09:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbaECHAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 03:00:55 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:60041 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaECHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 03:00:54 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WgTwJ-0002F9-9o; Sat, 03 May 2014 11:00:51 +0400
Content-Disposition: inline
In-Reply-To: <20140430114125.GA23046@camelia.ucw.cz>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248022>

On Wed, Apr 30, 2014 at 01:41:25PM +0200, Stepan Kasal wrote:
> Hello,
> 
> On Tue, Apr 29, 2014 at 01:12:04PM +0400, Marat Radchenko wrote:
> > On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.
> > 
> > Removal -DNOGDI=1 from config.mak.uname has an undesirable effect of
> > bringing in wingdi.h with weird #define ERROR 0 that conflicts with
> > internal Git enums. So, just #undef NOGDI in compat/poll/poll.c.
> 
> compat/poll/poll.c comes from Gnulib, so it would be better to submit
> the patch there and then backport so that the divergence of the two
> versions does not get worse.

That's why v1 of this patch [1] didn't touch poll.c at all.
I don't think it's gnulib problem that combination of two third-parties
(git and mingw-w64) set up such conditions where poll.c fails to compile.

If one wants to dig deeper, I'd say the problem is in MinGW-W64 headers
because their behavior of hiding MsgWaitForMultipleObjects doesn't
match behavior of MSVC headers.
