From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [BUG] git rev-parse :/ "regex" syntax not really regex?
Date: Sun, 17 Apr 2016 16:10:28 +0200
Message-ID: <87inzgtjfv.fsf@linux-m68k.org>
References: <20160417133741.GA28931@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
X-From: git-owner@vger.kernel.org Sun Apr 17 16:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arnPP-0007pK-Rj
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 16:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbcDQOKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 10:10:34 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34584 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbcDQOKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 10:10:33 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qntTd5wt2z3hhwY;
	Sun, 17 Apr 2016 16:10:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qntTd5TmPzvh1r;
	Sun, 17 Apr 2016 16:10:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id JE0GZVh8A_sd; Sun, 17 Apr 2016 16:10:29 +0200 (CEST)
X-Auth-Info: 9E3M5N2/cSwz5NNCfusi3vEK/+ZQB2qIfAtUiW9vV8K2lLdErVBr+LJQMMglQyEr
Received: from igel.home (ppp-88-217-25-29.dynamic.mnet-online.de [88.217.25.29])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 17 Apr 2016 16:10:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 985D92C33D7; Sun, 17 Apr 2016 16:10:28 +0200 (CEST)
X-Yow: Not SENSUOUS...  only ``FROLICSOME''...
 and in need of DENTAL WORK...  in PAIN!!!
In-Reply-To: <20160417133741.GA28931@rhlx01.hs-esslingen.de> (Andreas Mohr's
	message of "Sun, 17 Apr 2016 15:37:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291760>

Andreas Mohr <andi@lisas.de> writes:

> Unless I happened to misunderstand git's regex flavour, or something else...
> (hmm, perhaps it's a try-match-single-line vs. multi-line content issue,
> which perhaps does not work by specifying the trailing $)

This is exactly the difference.  git log --grep matches individual lines
(like grep), whereas :/<regexp> matches against the whole commit message
including embedded (and trailing) newlines, and $ doesn't match an
embedded newline.  Thus to address the second commit in your example you
have to use $':/^My commit\n' (using bash's ANSI-C quoting feature).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
