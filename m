From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] difftool: honor --trust-exit-code for builtin tools
Date: Sun, 16 Nov 2014 09:18:11 +0100
Message-ID: <m2a93ro8xo.fsf@linux-m68k.org>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Adri Farr <14farresa@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 09:18:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xpv2T-0004fZ-4U
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 09:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbaKPISY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 03:18:24 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38387 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaKPISX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 03:18:23 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jgRBM70PKz3hjQJ;
	Sun, 16 Nov 2014 09:18:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jgRBM4qSYzvh26;
	Sun, 16 Nov 2014 09:18:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 5vYL2b4df1_P; Sun, 16 Nov 2014 09:18:16 +0100 (CET)
X-Auth-Info: iqX8upsSpQKy2ZOCHlOUVTjMDFRl1ri0XPjjcTSzZnohF5SmdrIcvucDJE7Yd5yn
Received: from linux.local (ppp-188-174-153-251.dynamic.mnet-online.de [188.174.153.251])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 16 Nov 2014 09:18:16 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id A91C51E5778; Sun, 16 Nov 2014 09:18:12 +0100 (CET)
X-Yow: Sorry, wrong ZIP CODE!!
In-Reply-To: <1416000835-79274-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 14 Nov 2014 13:33:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> run_merge_tool() was not setting $status, which prevented the
> exit code for builtin tools from being forwarded to the caller.
>
> Capture the exit status and add a test to guarantee the behavior.
>
> Reported-by: Adria Farres <14farresa@gmail.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 1 +
>  t/t7800-difftool.sh   | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index a40d3df..2b66351 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -221,6 +221,7 @@ run_merge_tool () {
>  	else
>  		run_diff_cmd "$1"
>  	fi
> +	status=$?
>  	return $status

If you want to return the last exit status at the end of a function you
don't need any return at all.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
