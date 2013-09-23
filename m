From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] git-remote-mediawiki: bugfix for pages w/ >500 revisions
Date: Mon, 23 Sep 2013 19:58:47 +0200
Message-ID: <vpqr4cf773c.fsf@anie.imag.fr>
References: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Benoit Person <benoit.person@gmail.fr>
To: Benoit Person <benoit.person@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:00:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOARM-0005y5-RM
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab3IWSAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:00:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49262 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab3IWSAw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:00:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8NHwjkV008120
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Sep 2013 19:58:45 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOAPH-0007mc-Ml; Mon, 23 Sep 2013 19:58:47 +0200
In-Reply-To: <1379957175-8606-1-git-send-email-benoit.person@gmail.fr> (Benoit
	Person's message of "Mon, 23 Sep 2013 19:26:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 23 Sep 2013 19:59:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8NHwjkV008120
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380563987.74494@iaI5ixtLseO8dx38Ve+nXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235210>

Benoit Person <benoit.person@gmail.com> writes:

> The latest API renamed and moved the "continuing" information in the
> response, necessary to build the next query. The code failed to retrieve
> that information but still detected that it was in a "continuing
> query". As a result, it launched the same query over and over again.

Good, that's much cleaner.

> +		if ($result->{'query-continue'}) { # For legacy APIs
> +			$query->{rvstartid} = $result->{'query-continue'}->{revisions}->{rvstartid};
> +		} elsif ($result->{continue}) { # For newer APIs

I'd rather have the comments say "# API version < X" and "# API version
>= X". Next time the API change, "new" Vs "old" will become meaningless.

(But that should not block the patch from inclusion)

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
