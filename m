From: David Kastrup <dak@gnu.org>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 15:29:36 +0200
Message-ID: <85bqdcq3sv.fsf@lola.goethe.zz>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
	<46BED5AA.7050900@lsrfire.ath.cx>
	<24332.88.10.191.55.1186917895.squirrel@secure.wincent.com>
	<85643lq99h.fsf@lola.goethe.zz> <46BF04F0.5020304@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 15:29:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKDVs-0008Iw-0O
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 15:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763414AbXHLN3p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761310AbXHLN3p
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 09:29:45 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:43525 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760856AbXHLN3o (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 09:29:44 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id B20E71F5BE0;
	Sun, 12 Aug 2007 15:29:42 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 97D15100C0;
	Sun, 12 Aug 2007 15:29:37 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 48D7019B32A;
	Sun, 12 Aug 2007 15:29:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id CA8EE1C3C79D; Sun, 12 Aug 2007 15:29:36 +0200 (CEST)
In-Reply-To: <46BF04F0.5020304@midwinter.com> (Steven Grimm's message of "Sun\, 12 Aug 2007 21\:02\:40 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3934/Sun Aug 12 03:59:08 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55683>

Steven Grimm <koreth@midwinter.com> writes:

> David Kastrup wrote:
>> I think I would call that a mistake.  However, I don't see that fixing
>> it would actually be useful: if a pager gets called, this means that
>> git-diff might die with SIGPIPE (when the user quits the pager), and
>> that in turn has pretty much no meaning.  So one really needs to
>> redirect the output, anyway.
>>   
>
> It does sort of make one wonder, though, if there's much point ever
> launching a pager when git-diff is run with --quiet -- it will never
> produce any output to page, so running a pager is guaranteed to always
> be a waste of cycles.
>
> Unfortunately the pager is launched before the option processing code
> knows whether --quiet is being used or not; I'm not sure it's worth
> refactoring the pager launch code just to handle this one special
> case. (Or are there other cases where programs would want to be able
> to control the use of the pager?)

I think it is reasonable not to start the pager at all when there is
no bulk material, but just a fixed amount of output such as a summary
lines.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
