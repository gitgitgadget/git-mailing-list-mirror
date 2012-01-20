From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH] t/Makefile: Use $(sort ...) explicitly where needed
Date: Fri, 20 Jan 2012 10:34:50 +0400
Organization: St.Petersburg State University
Message-ID: <20120120063450.GA15371@mini.zxlink>
References: <1327004244-18892-1-git-send-email-kirr@navytux.spb.ru>
 <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@navytux.spb.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 07:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro898-0007j6-Tl
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 07:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab2ATGkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 01:40:18 -0500
Received: from forward2.mail.yandex.net ([77.88.46.7]:49329 "EHLO
	forward2.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab2ATGkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 01:40:17 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jan 2012 01:40:16 EST
Received: from smtp4.mail.yandex.net (smtp4.mail.yandex.net [77.88.46.104])
	by forward2.mail.yandex.net (Yandex) with ESMTP id 01CD512A3BB9;
	Fri, 20 Jan 2012 10:34:01 +0400 (MSK)
Received: from smtp4.mail.yandex.net (localhost [127.0.0.1])
	by smtp4.mail.yandex.net (Yandex) with ESMTP id D72A35C03A2;
	Fri, 20 Jan 2012 10:34:01 +0400 (MSK)
Received: from unknown (unknown [83.171.93.225])
	by smtp4.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Xn783V3V-Y17iJrC6;
	Fri, 20 Jan 2012 10:34:01 +0400
X-Yandex-Spam: 1
Received: from kirr by mini.zxlink with local (Exim 4.77)
	(envelope-from <kirr@mini.zxlink>)
	id 1Ro83m-0004KJ-J3; Fri, 20 Jan 2012 10:34:50 +0400
Content-Disposition: inline
In-Reply-To: <7v8vl3ic6o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188851>

On Thu, Jan 19, 2012 at 02:01:51PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@navytux.spb.ru> writes:
> 
> > Starting from GNU Make 3.82 $(wildcard ...) no longer sorts the result
> > (from NEWS):
> >
> >     * WARNING: Backward-incompatibility!
> >       Wildcards were not documented as returning sorted values, but the results
> >       have been sorted up until this release..  If your makefiles require sorted
> >       results from wildcard expansions, use the $(sort ...)  function to request
> >       it explicitly.
> >
> >     http://repo.or.cz/w/make.git/commitdiff/2a59dc32aaf0681dec569f32a9d7ab88a379d34f
> >
> > so we have to sort tests list or else they are executed in seemingly
> > random order even for -j1.
> 
> I do not necessarily buy your "so we HAVE TO, OR ELSE".
> 
> Even though I can understand "We can sort the list of tests _if_ we do not
> want them executed in seemingly random order when running 'make -j1'", I
> tend to think that *if* is a big one.  Aren't these tests designed not to
> depend on each other anyway?

Yes, they don't depend on each other, but what's the point in not
sorting them? I usually watch test progress visually, and if tests are
sorted, even with make -j4 they go more or less incrementally by their t
number.

On my netbook, adding $(sort ...) adds approximately 0.008s to make
startup, so imho there is no performance penalty to adding that sort.


Thanks,
Kirill
