From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-completion: workaround zsh COMPREPLY bug
Date: Wed, 25 Jan 2012 08:41:48 +0100
Message-ID: <vpqwr8g8c03.fsf@bauges.imag.fr>
References: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 08:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpxUW-0004YL-30
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 08:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab2AYHlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 02:41:55 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54529 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752487Ab2AYHly (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 02:41:54 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0P7dbP1013331
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Jan 2012 08:39:37 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RpxUL-00063P-7u; Wed, 25 Jan 2012 08:41:49 +0100
In-Reply-To: <1327455422-22340-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 25 Jan 2012 03:37:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Jan 2012 08:39:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0P7dbP1013331
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1328081979.20276@NzgnONm3uvgqPTgMvavN3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189103>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The simplest and most generic solution is to hide all the changes we do
> to IFS, so that "foo \nbar " is recognized by zsh as "foo bar". This
> works on versions of git before and after the introduction of
> __gitcomp_nl (a31e626), and versions of zsh before and after 4.3.12.
[...]
> +
> +		# another workaround for zsh because it would quote spaces in
> +		# the COMPREPLY array if IFS doesn't contain spaces
> +		typeset -h IFS

No time to test right now, but is this not going to

1) leave IFS as hidden even outside the completion script, possibly
affecting unrelated scripts that would need to set IFS as local and keep
its special effect?

2) break cases where strings are to be split on \n only (e.g. see
"foo bar\nboz" as three possible completions "foo", "bar", "boz" instead
of "foo bar" and "boz"?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
