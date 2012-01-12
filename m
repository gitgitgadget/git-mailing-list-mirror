From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: clone bug
Date: Thu, 12 Jan 2012 15:36:46 +0100
Message-ID: <m28vldj8ch.fsf@igel.home>
References: <CAO1Zr+pSLwRbsEZ_0LCeE2qLn+S=iMKVcMjqtYrmiBoQmjac_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 15:36:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlLlu-0001Lh-86
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 15:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab2ALOgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 09:36:49 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:53750 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2ALOgt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 09:36:49 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 78C4F1C030FD;
	Thu, 12 Jan 2012 15:36:47 +0100 (CET)
X-Auth-Info: 48nBabNPxD1ZA+gdT+zTgDZkNKmqQathTyzIbEkyXxo=
Received: from igel.home (ppp-93-104-158-65.dynamic.mnet-online.de [93.104.158.65])
	by mail.mnet-online.de (Postfix) with ESMTPA id 6CBDF1C00078;
	Thu, 12 Jan 2012 15:36:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id CA02ECA2A5; Thu, 12 Jan 2012 15:36:46 +0100 (CET)
X-Yow: ...PENGUINS are floating by...
In-Reply-To: <CAO1Zr+pSLwRbsEZ_0LCeE2qLn+S=iMKVcMjqtYrmiBoQmjac_A@mail.gmail.com>
	(Alexey Kuznetsov's message of "Thu, 12 Jan 2012 16:43:50 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188447>

Alexey Kuznetsov <kuznetsov.alexey@gmail.com> writes:

> axet-laptop:123 axet$ git branch
> * master
> # git remote add common https://github.com/axet/common-bin.git
> # git fetch common
> From https://github.com/axet/common-bin
>  * [new branch]      master     -> common/master
>
> ?? already strange master (local) to the remote common/master

The message means: the remote ref 'refs/heads/master' is stored locally
in 'refs/remotes/common/master'.

> axet-laptop:123 axet$ git push
> To https://github.com/axet/common-bin.git
>  ! [rejected]        master -> master (non-fast-forward)

"git push" is the same as "git push common" ('common' is the current
branch's remote).  Since branch.master.push is not defined this then
uses the push.default config option to determine the action.  The
default is 'matching', which means that local branch names are matched
against remote branch names.  Local branch master matches remote branch
master.  Note that this disregards the setting for
branch.master.upstream.  If you do not want that you should set
push.default to 'upstream'.

See the examples in git-push(1) for more details.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
