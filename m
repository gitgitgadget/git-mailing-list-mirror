From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for
 configuration variables
Date: Mon, 02 Feb 2015 12:31:26 +0100
Organization: gmx
Message-ID: <687227472e6697fadfa9c3237c9c7de0@www.dscho.org>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
 <1422484393-4414-4-git-send-email-gitster@pobox.com>
 <54CDB5C6.3020702@alum.mit.edu>
 <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
 <20150201215729.GA19692@peff.net>
 <xmqqwq418dmp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 12:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIFEE-0001c5-FE
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 12:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbbBBLbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 06:31:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:59143 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbbBBLbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 06:31:37 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MJXEd-1YFEPs2glH-0036uQ; Mon, 02 Feb 2015 12:31:27
 +0100
In-Reply-To: <xmqqwq418dmp.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:Wtw687IUSjxtl1CCS7uo3BUFsq1bp0jXlOhn0AfXu47PwMNn27j
 bxmAqiNzAghOg4qrdan9nDjOQTmYHJ5NHCKPzriQhJKfj6zOPZzq88OXkpbgQ83W+WAwCbB
 g0N8IhnA2iC5veRyRUnoA+ZzirkD4Bjn3FF+gVJQ98WNX4mOkS37RqlonYDvu4cnfPUq0Cx
 zA8lzAWED+TyMfrczTpuQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263256>

Hi,

On 2015-02-01 23:34, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>   1. I'm a user who has set my preferred core.whitespace in my
>>      ~/.gitconfig. A particular project I am working on uses an
>>      alternate tabwidth. How do I set that in the repo config without
>>      repeating my defaults?
> 
> Isn't it cumulative?  At least it should be (but I wouldn't be too
> surprised if the recent config reader caching broke it).

Please note that it is really, really difficult for a regular Git user to figure out which whitespace settings are in effect using just `git config` whether it is cumulative or not.

Also, please note it makes it hard on users that there are a bunch of config settings which *override* previous settings, and others that are *cumulative*.

The latter we cannot change, and the former we cannot change for the whitespace settings. However, when introducing new settings (such as the fsck severity levels), we should go out of our way to keep things as simple as possible. For example, if a *simple* `git config` can answer the question "Is feature XYZ turned on", I would consider the design superior to a design that requires additional code just to figure out whether feature XYZ is turned on, let alone to turn it on without affecting other settings.

In other words, I would like to caution against recommending the whitespace setting as an example to follow: anybody who is unfamiliar with the whitespace setting will find the cumulative last-setting-wins (per item inside the whitespace-separated list, not per config setting) strategy confusing.

On the other hand, if you offer `whitespace.tabWidth` and `whitespace.indentWithNoTab` separately, everything is really crystal clear to new users without having much explaining to do, let alone having to introduce new tooling.

Ciao,
Dscho

P.S.: Of course I know that it is too late for `whitespace`, but it offers itself as a good subject to demonstrate the merits of the different suggestions.
