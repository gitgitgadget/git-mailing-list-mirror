From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/5] run-command: optionally kill children on exit
Date: Sun, 8 Jan 2012 21:56:58 +0100
Message-ID: <20120108205657.GB3394@ecki.lan>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-2-git-send-email-drizzd@aon.at>
 <CABPQNSb57LA6dYJvT7xF_vFfBFqKhCMbrQYp49_Ko1WmbUnYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:05:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjzvw-0002qp-Ei
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab2AHVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:05:17 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:43877 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754383Ab2AHVFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:05:16 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id D77362C4003;
	Sun,  8 Jan 2012 22:06:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CABPQNSb57LA6dYJvT7xF_vFfBFqKhCMbrQYp49_Ko1WmbUnYPw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188135>

On Sat, Jan 07, 2012 at 01:45:03PM +0100, Erik Faye-Lund wrote:
> 
> Our Windows implementation of kill (mingw_kill in compat/mingw.c) only
> supports SIGKILL, so propagating other signals to child-processes will
> fail with EINVAL. That being said, Windows' support for signals is
> severely limited, but I'm not entirely sure which ones can be
> generated in this case.

On Linux at least, SIGKILL is not a viable alternative for SIGTERM,
since it does not give the child process to do any cleanup of its own
(such as signaling its own children, for example).

In any case, due this whole experience, and recently another one with
overzealous virus scanners, I have added a "get rid of dashed externals"
work item to my TODO list.
