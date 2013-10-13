From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] mv: Fix spurious warning when moving a file in presence of submodules
Date: Sun, 13 Oct 2013 17:05:02 +0200
Message-ID: <vpqr4bp6wkh.fsf@anie.imag.fr>
References: <vpq38o7nao9.fsf@anie.imag.fr> <52583B00.8040700@web.de>
	<525A8965.3040407@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 13 17:05:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVNEQ-0008HE-K4
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 17:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab3JMPFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 11:05:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35913 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab3JMPFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 11:05:15 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r9DF56Zq016230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Oct 2013 17:05:06 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9DF52Sv010974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 13 Oct 2013 17:05:08 +0200
In-Reply-To: <525A8965.3040407@web.de> (Jens Lehmann's message of "Sun, 13 Oct
	2013 13:52:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 13 Oct 2013 17:05:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9DF56Zq016230
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382281507.86862@Bipka4W6DgP5SotcxGxXlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236077>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>  static struct lock_file lock_file;
> +#define SUBMODULE_WITH_GITDIR ((const char *)1)

I don't like very much hardcoded addresses like this. Are you 100% sure
address 1 will never be returned by xstrdup on any platform? The risk is
small if not negligible, but I'm unconfortable with this. Isn't there an
alternative (NULL, or empty string) that is guaranteed to never happen?

> +test_expect_success 'git mv moves a submodule with a .git directory and .gitmodules' '

This doesn't seem to test the problem I was having (move a file, not a
submodule). Is this intentional?

In any case, this fixes my problem, thanks!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
