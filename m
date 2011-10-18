From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [GUILT] handle branches with slashes in guilt-graph
Date: Tue, 18 Oct 2011 20:35:46 +0200
Message-ID: <m2r52adu65.fsf@igel.home>
References: <4E9D57BB.2030707@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 20:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGEWC-00088J-3q
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 20:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab1JRSf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 14:35:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38107 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab1JRSf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 14:35:58 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ECB2188A16E;
	Tue, 18 Oct 2011 20:35:48 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id EE58D1C001A6;
	Tue, 18 Oct 2011 20:35:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 18Uor05D9OT7; Tue, 18 Oct 2011 20:35:48 +0200 (CEST)
Received: from igel.home (ppp-88-217-108-0.dynamic.mnet-online.de [88.217.108.0])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 18 Oct 2011 20:35:47 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id AFD5ECA29C; Tue, 18 Oct 2011 20:35:46 +0200 (CEST)
X-Yow: I'm mentally OVERDRAWN!  What's that SIGNPOST up ahead?
 Where's ROD STERLING when you really need him?
In-Reply-To: <4E9D57BB.2030707@opera.com> (Per Cederqvist's message of "Tue,
	18 Oct 2011 12:40:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183896>

Per Cederqvist <cederp@opera.com> writes:

> Avoid sed errors when the branch name contains a slash.
>
> Signed-off-by: Per Cederqvist <cederp@opera.com>
>
> --- /usr/bin/guilt-graph~	2011-01-25 20:15:50.000000000 +0100
> +++ /usr/bin/guilt-graph	2011-10-18 12:30:31.000000000 +0200
> @@ -37,9 +37,10 @@ disp "digraph G {"
>
>  current="$top"
>
> +safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
>  while [ "$current" != "$base" ]; do
>  	pname=`git show-ref | sed -n -e "
> -/^$current refs\/patches\/$branch/ {
> +/^$current refs\/patches\/$safebranch/ {

Alternatively, you could change the delimiter to `,':

  \,^$current refs/patches/$branch, {

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
