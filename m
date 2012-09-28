From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Sat, 29 Sep 2012 01:20:53 +0200
Message-ID: <m2zk493fai.fsf@igel.home>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
	<20120928202330.GA5770@sigill.intra.peff.net>
	<20120928205054.GA5985@sigill.intra.peff.net>
	<m24nmh4x1t.fsf@igel.home>
	<20120928223152.GA7906@sigill.intra.peff.net>
	<7vipaxkayf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 01:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THjsE-0007MY-U4
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 01:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759067Ab2I1XVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 19:21:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:54757 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897Ab2I1XU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 19:20:59 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XT85L3FvQz4KK4T;
	Sat, 29 Sep 2012 01:20:54 +0200 (CEST)
X-Auth-Info: +SNJq92l7o4TZaKCIuNRM/02R/bAggMecMG1wwjB7yg=
Received: from igel.home (ppp-93-104-135-221.dynamic.mnet-online.de [93.104.135.221])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XT85L2p4Nzbg13;
	Sat, 29 Sep 2012 01:20:54 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0186BCA2A3; Sat, 29 Sep 2012 01:20:53 +0200 (CEST)
X-Yow: Do you think the ``Monkees'' should get gas on odd or even days?
In-Reply-To: <7vipaxkayf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Sep 2012 16:02:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206618>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sat, Sep 29, 2012 at 12:11:58AM +0200, Andreas Schwab wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>> 
>>> > +proc refresh_index {} {
>>> > +    global need_index_refresh
>>> > +    if { $need_index_refresh } {
>>> > +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"
>>> 
>>> I think the usual idiom for ignoring errors is to use catch around exec,
>>> avoiding the extra shell wrapper:
>>> 
>>>         catch { exec git update-index --refresh }
>>
>> Thanks. I don't speak tcl at all, but your version makes much more
>> sense.
>
> But isn't the redirection still needed?  Otherwise the "Needs
> update" messages will go to the terminal, no?

The exec command captures both stdout and stderr and returns it as its
value, and catch ignores it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
