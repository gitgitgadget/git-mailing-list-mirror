From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 20:41:59 +0200
Message-ID: <m2harwccjs.fsf@igel.home>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
	<20120821023033.GB20271@sigill.intra.peff.net>
	<CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
	<7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Conley Owens <cco3@android.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:42:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3tP0-0001EO-G6
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 20:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab2HUSmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 14:42:04 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:36327 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2HUSmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 14:42:01 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X1gj35Qblz4KK2x;
	Tue, 21 Aug 2012 20:41:59 +0200 (CEST)
X-Auth-Info: 5fJ29lZEBRFn+xQmoXYwVl/CdeUcS/vvWpBQm0rb12Q=
Received: from igel.home (ppp-93-104-136-7.dynamic.mnet-online.de [93.104.136.7])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X1gj353fjzbbgH;
	Tue, 21 Aug 2012 20:41:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 4E42CCA2A5; Tue, 21 Aug 2012 20:41:59 +0200 (CEST)
X-Yow: Disco oil bussing will create a throbbing naugahide pipeline running
 straight to the tropics from the rug producing regions
 and devalue the dollar!
In-Reply-To: <7vzk5ocdg7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 21 Aug 2012 11:22:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203981>

Junio C Hamano <gitster@pobox.com> writes:

> Where do shells (e.g. bash and dash) go when you say "cd" without
> parameter when $HOME is unset, for example?

$ bash -c 'unset HOME; cd'
bash: line 0: cd: HOME not set
$ dash -c 'unset HOME; cd'
[no output and cwd not changed]

POSIX says:

    If no directory operand is given and the HOME environment variable
    is empty or undefined, the default behavior is
    implementation-defined and no further steps shall be taken.

Another data point: bash falls back to getpwuid when expanding ~, dash
leaves it alone.  (POSIX makes it unspecified.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
