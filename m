From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum invocation.
Date: Wed, 14 Mar 2012 15:27:23 +0100
Message-ID: <m2k42nmf5g.fsf@igel.home>
References: <87399bpaq9.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 15:27:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7pAr-0000FS-3f
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 15:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030924Ab2CNO11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 10:27:27 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43268 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030694Ab2CNO10 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 10:27:26 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3V7Fd81ky3z4Kh0T;
	Wed, 14 Mar 2012 15:27:23 +0100 (CET)
X-Auth-Info: LZQfq3ANpOLNs2J+ctr5jSSDTi4vwoaxEiomriHvsvg=
Received: from igel.home (ppp-88-217-102-154.dynamic.mnet-online.de [88.217.102.154])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3V7Fd75rSXz4KK6N;
	Wed, 14 Mar 2012 15:27:23 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 77668CA2AA; Wed, 14 Mar 2012 15:27:23 +0100 (CET)
X-Yow: YOU'D cry too if it happened to YOU!!
In-Reply-To: <87399bpaq9.fsf@opera.com> (Per Cederqvist's message of "Wed, 14
	Mar 2012 14:34:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193112>

Per Cederqvist <cederp@opera.com> writes:

> -	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
> +	if [ $# = 1 ]
> +	then
> +		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
> +	else
> +		openssl dgst -sha1 | sed 's,$,  -,'

$ openssl dgst -sha1 </dev/null
(stdin)= da39a3ee5e6b4b0d3255bfef95601890afd80709

>  # usage: sha1 [file]
>  sha1()
>  {
> -	sha1sum "$1"
> +	if [ $# = 1 ]
> +	then
> +		sha1sum "$1"
> +	else
> +		sha1sum
> +	fi

        sha1sum "$@"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
