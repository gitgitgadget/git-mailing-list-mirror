From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Possibility to read both from ~/.gitconfig and from $XDG_CONFIG_HOME/git/config
Date: Thu, 31 May 2012 09:26:54 +0200
Message-ID: <vpqlik8q08x.fsf@bauges.imag.fr>
References: <1338400955-22991-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 09:32:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZzsB-0000pe-Ng
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 09:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab2EaH1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 03:27:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47486 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757127Ab2EaH1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 03:27:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4V7ITA5016287
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 09:18:29 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZzmZ-0003Ub-9A; Thu, 31 May 2012 09:26:55 +0200
In-Reply-To: <1338400955-22991-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
	(Huynh Khoi Nguyen NGUYEN's message of "Wed, 30 May 2012 20:02:35
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 May 2012 09:18:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V7ITA5016287
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339053513.90396@36fgRY6mZ4PNt6i0dcWJaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198870>

Huynh Khoi Nguyen NGUYEN <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> +$XDG_CONFIG_HOME/git/config::
> +	Second user-specific configuration file. ~/.gitconfig has priority.

You should mention the behavior if $XDG_CONFIG_HOME is not set.

> +		if (home) {
> +			const char *xdg_config_home = getenv("XDG_CONFIG_HOME");
> +			if (xdg_config_home)
> +				xdg_global = xstrdup(mkpath("%s/git/config", xdg_config_home));
> +			else
> +				xdg_global = xstrdup(mkpath("%s/.config/git/config", home));

Shouldn't there be a helper function to get the path ~/.config/git/
and then append config? You're already computing this path twice, and
we'll need more instances of it if we want to give default values to
core.excludesfile and core.attributesfile in this directory too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
