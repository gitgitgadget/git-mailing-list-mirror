From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: PATCH] Allow git-filter-branch to process large repositories with lots of branches.
Date: Sat, 07 Sep 2013 22:29:28 +0200
Message-ID: <87ppskgytz.fsf@igel.home>
References: <CE50D917.191A5%lee.carver@corp.service-now.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "gitster\@pobox.com" <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Lee Carver <leeca@pnambic.com>
To: Lee Carver <Lee.Carver@servicenow.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 22:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIP8Z-0002GJ-QU
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 22:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3IGU3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 16:29:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40116 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab3IGU3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 16:29:39 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cXS0r34RZz3hhY2;
	Sat,  7 Sep 2013 22:29:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cXS0r1P4yzbbg0;
	Sat,  7 Sep 2013 22:29:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 0fLWIypo_HJg; Sat,  7 Sep 2013 22:29:28 +0200 (CEST)
X-Auth-Info: cDrnjjkfFpFYJZIpAuPCqE7QjOyYrbsnVjMDOFpRPGI=
Received: from igel.home (ppp-88-217-97-230.dynamic.mnet-online.de [88.217.97.230])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat,  7 Sep 2013 22:29:28 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 3C3842C0FC6; Sat,  7 Sep 2013 22:29:28 +0200 (CEST)
X-Yow: If our behavior is strict, we do not need fun!
In-Reply-To: <CE50D917.191A5%lee.carver@corp.service-now.com> (Lee Carver's
	message of "Sat, 7 Sep 2013 20:22:33 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234144>

Lee Carver <Lee.Carver@servicenow.com> writes:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ac2a005..d7e0fae 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -255,8 +255,6 @@ else
>  	remap_to_ancestor=t
>  fi
>  
> -rev_args=$(git rev-parse --revs-only "$@")
> -
>  case "$filter_subdir" in
>  "")
>  	eval set -- "$(git rev-parse --sq --no-revs "$@")"

Here the arguments are reset.

> @@ -267,8 +265,9 @@ case "$filter_subdir" in
>  	;;
>  esac
>  
> +git rev-parse --revs-only "$@" | \

So this is using a different argument list than before.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
