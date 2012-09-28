From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Sat, 29 Sep 2012 00:11:58 +0200
Message-ID: <m24nmh4x1t.fsf@igel.home>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
	<20120928202330.GA5770@sigill.intra.peff.net>
	<20120928205054.GA5985@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Batchelor <scott.batchelor@gmail.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THinA-0000Et-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 00:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180Ab2I1WMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 18:12:05 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59076 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642Ab2I1WMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 18:12:03 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XT6Yr1cTdz4KK2d;
	Sat, 29 Sep 2012 00:12:00 +0200 (CEST)
X-Auth-Info: IL8WjvnMQWHd/R50vUFJHNT5ESjzP8ZXoSKCE63ViqA=
Received: from igel.home (ppp-93-104-135-221.dynamic.mnet-online.de [93.104.135.221])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XT6Yr1DZzzbdqm;
	Sat, 29 Sep 2012 00:12:00 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 86ACDCA2A3; Sat, 29 Sep 2012 00:11:58 +0200 (CEST)
X-Yow: I'm MENTALLY here..  but PHYSICALLY I'm purchasing NAUGAHYDE furniture
 in the' SUBURBS of PHOENIX!!
In-Reply-To: <20120928205054.GA5985@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Sep 2012 16:50:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206613>

Jeff King <peff@peff.net> writes:

> +proc refresh_index {} {
> +    global need_index_refresh
> +    if { $need_index_refresh } {
> +	exec sh -c "git update-index --refresh >/dev/null 2>&1 || true"

I think the usual idiom for ignoring errors is to use catch around exec,
avoiding the extra shell wrapper:

        catch { exec git update-index --refresh }

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
