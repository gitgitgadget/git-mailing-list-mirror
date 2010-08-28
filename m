From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Add global and system-wide gitattributes
Date: Sat, 28 Aug 2010 20:35:42 +0200
Message-ID: <vpqy6bqr3ep.fsf@bauges.imag.fr>
References: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
	<1281977813-6528-1-git-send-email-gsvick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Henrik Grubbstrm <grubba@grubba.org>
To: Petr Onderka <gsvick@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 20:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpQGO-0002Ov-98
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 20:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab0H1SgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 14:36:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59622 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab0H1SgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 14:36:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o7SIWKGP018012
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 28 Aug 2010 20:32:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OpQFi-00087i-Ev; Sat, 28 Aug 2010 20:35:42 +0200
In-Reply-To: <1281977813-6528-1-git-send-email-gsvick@gmail.com> (Petr Onderka's message of "Mon\, 16 Aug 2010 16\:56\:53 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 28 Aug 2010 20:32:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o7SIWKGP018012
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1283625141.04847@OaurF0ZOtfDZe5rlssK5vQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154655>

Petr Onderka <gsvick@gmail.com> writes:

> Allow gitattributes to be set globally and system wide. This way, settings
> for particular file types can be set in one place and apply for all user's
> repositories.
>
> The location of system-wide attributes file is $(prefix)/etc/gitattributes.
> The location of the global file can be configured by setting
> core.attributesfile.

Good, I like this :-)

> Some parts of the code were copied from the implementation of the same
> functionality in config.c.

(maybe you could say quickly which ones and why)

> +		if (git_attr_global() && attributes_file) {

I tried this, and attributes_file was NULL here. I don't know how it
worked for you, but there should be a call to git_config here.

> +			char *user_attr = xstrdup(attributes_file);
> +
> +			elem = read_attr_from_file(user_attr, 1);
> +			free(user_attr);

Any reason for this xstrdup/free?

Patch follows for these two points + a test, to be squashed into
yours.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
